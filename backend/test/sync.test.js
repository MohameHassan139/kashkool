import { test, beforeEach, afterEach, after } from 'node:test';
import assert from 'node:assert/strict';
import { api, auth, closeAll, closeDb, createShop, freshDb, login, pull, push, tx } from './helpers/setup.js';

let db;
let owner;
beforeEach(async () => {
  db = await freshDb();
  owner = await login('owner@test.com');
  await createShop(owner.token, 'shop-1');
});
afterEach(async () => { await closeDb(db); });
after(closeAll);

test('push then pull round-trips records with server sequence numbers', async () => {
  const res = await push(owner.token, 'shop-1', [
    { collection: 'customers', record: { id: 'cust-1', name: 'أحمد', phone: '01012345678', updatedAt: '2026-11-01T10:00:00Z' } },
    { collection: 'transactions', record: tx('t-1') },
  ]);
  assert.equal(res.status, 200);
  assert.deepEqual(res.body.results.map((r) => r.status), ['inserted', 'inserted']);
  assert.equal(res.body.serverSeq, 2);

  const p = await pull(owner.token, 'shop-1', 0);
  assert.equal(p.status, 200);
  assert.equal(p.body.changes.length, 2);
  assert.equal(p.body.cursor, 2);
  assert.equal(p.body.hasMore, false);
  const t = p.body.changes.find((c) => c.collection === 'transactions').record;
  assert.equal(t.shopId, 'shop-1');
  assert.equal(t.createdBy, owner.user.id);
  assert.equal(t.deviceId, 'device-a');
  assert.equal(t._id, undefined);

  const none = await pull(owner.token, 'shop-1', 2);
  assert.equal(none.body.changes.length, 0);
  assert.equal(none.body.cursor, 2);
});

test('transactions are append-only: amounts never change; trash and restore work', async () => {
  await push(owner.token, 'shop-1', [{ collection: 'transactions', record: tx('t-1') }]);

  const edit = await push(owner.token, 'shop-1', [{ collection: 'transactions', record: tx('t-1', { amountPiasters: 999999 }) }]);
  assert.equal(edit.body.results[0].status, 'unchanged');

  const del = await push(owner.token, 'shop-1', [
    { collection: 'transactions', record: tx('t-1', { deletedAt: '2026-11-02T10:00:00Z', supersededById: 't-2' }) },
    { collection: 'transactions', record: tx('t-2', { amountPiasters: 12000 }) },
  ]);
  assert.deepEqual(del.body.results.map((r) => r.status), ['updated', 'inserted']);

  let stored = await db.collection('transactions').findOne({ shopId: 'shop-1', id: 't-1' });
  assert.equal(stored.deletedAt, '2026-11-02T10:00:00Z');
  assert.equal(stored.supersededById, 't-2');

  // Restore from trash: deletedAt cleared, amount still can't change, edit link stays.
  const restore = await push(owner.token, 'shop-1', [
    { collection: 'transactions', record: tx('t-1', { deletedAt: null, supersededById: null, amountPiasters: 1 }) },
  ]);
  assert.equal(restore.body.results[0].status, 'updated');
  stored = await db.collection('transactions').findOne({ shopId: 'shop-1', id: 't-1' });
  assert.equal(stored.deletedAt, null);
  assert.equal(stored.amountPiasters, 10000);
  assert.equal(stored.supersededById, 't-2');
});

test('invalid records are rejected individually, valid ones still saved', async () => {
  const res = await push(owner.token, 'shop-1', [
    { collection: 'transactions', record: tx('t-ok') },
    { collection: 'transactions', record: tx('t-float', { amountPiasters: 10.5 }) },
    { collection: 'transactions', record: tx('t-neg', { amountPiasters: -5 }) },
    { collection: 'transactions', record: tx('t-type', { type: 'gift' }) },
    { collection: 'transactions', record: tx('t-date', { occurredAt: 'yesterday' }) },
    { collection: 'transactions', record: tx('bad id!') },
    { collection: 'customers', record: { id: 'c-x', 'name.$evil': 'x' } },
    { collection: 'customers', record: { id: 'c-y', nested: { a: 1 } } },
  ]);
  const statuses = res.body.results.map((r) => r.status);
  assert.deepEqual(statuses, ['inserted', 'rejected', 'rejected', 'rejected', 'rejected', 'rejected', 'rejected', 'rejected']);
  assert.match(res.body.results[1].reason, /money_must_be_integer/);
  assert.equal(await db.collection('transactions').countDocuments({ shopId: 'shop-1' }), 1);
});

test('unknown collections fail validation', async () => {
  const res = await push(owner.token, 'shop-1', [{ collection: 'users', record: { id: 'x' } }]);
  assert.equal(res.status, 400);
});

test('client cannot set server-owned fields or another shop', async () => {
  await push(owner.token, 'shop-1', [
    { collection: 'customers', record: { id: 'c-1', name: 'x', shopId: 'shop-evil', serverSeq: 999999, _id: 'hack' } },
  ]);
  const stored = await db.collection('customers').findOne({ id: 'c-1' });
  assert.equal(stored.shopId, 'shop-1');
  assert.equal(stored.serverSeq, 1);
  assert.notEqual(stored._id, 'hack');
});

test('installment paid amounts are backed up (until F6); plan prices are immutable', async () => {
  await push(owner.token, 'shop-1', [
    {
      collection: 'installment_plans',
      record: { id: 'p-1', customerId: 'cust-1', totalPricePiasters: 1200000, downPaymentPiasters: 200000, installmentCount: 10, status: 'active' },
    },
    { collection: 'installments', record: { id: 'i-1', planId: 'p-1', amountPiasters: 100000, paidPiasters: 100000, status: 'paid', dueDate: '2026-12-01' } },
  ]);
  const inst = await db.collection('installments').findOne({ id: 'i-1' });
  assert.equal(inst.paidPiasters, 100000);
  assert.equal(inst.status, 'paid');

  await push(owner.token, 'shop-1', [
    { collection: 'installment_plans', record: { id: 'p-1', customerId: 'cust-1', totalPricePiasters: 1, installmentCount: 12, status: 'active' } },
  ]);
  const plan = await db.collection('installment_plans').findOne({ id: 'p-1' });
  assert.equal(plan.totalPricePiasters, 1200000);
  assert.equal(plan.installmentCount, 12); // reschedule may change the count
});

test('pull pages across collections without gaps', async () => {
  const changes = [];
  for (let i = 1; i <= 7; i++) {
    changes.push({ collection: i % 2 ? 'customers' : 'transactions', record: i % 2 ? { id: `c-${i}`, name: `n${i}` } : tx(`t-${i}`) });
  }
  await push(owner.token, 'shop-1', changes);

  const seen = [];
  let cursor = 0;
  for (let guard = 0; guard < 10; guard++) {
    const page = await pull(owner.token, 'shop-1', cursor, 3);
    seen.push(...page.body.changes.map((c) => c.record.serverSeq));
    cursor = page.body.cursor;
    if (!page.body.hasMore) break;
  }
  assert.deepEqual(seen, [1, 2, 3, 4, 5, 6, 7]);
});

test('updates move a row to the end of the change feed', async () => {
  await push(owner.token, 'shop-1', [{ collection: 'customers', record: { id: 'c-1', name: 'أحمد' } }]);
  await push(owner.token, 'shop-1', [{ collection: 'customers', record: { id: 'c-2', name: 'محمود' } }]);
  const p1 = await pull(owner.token, 'shop-1', 0);
  await push(owner.token, 'shop-1', [{ collection: 'customers', record: { id: 'c-1', name: 'أحمد علي' } }]);
  const p2 = await pull(owner.token, 'shop-1', p1.body.cursor);
  assert.equal(p2.body.changes.length, 1);
  assert.equal(p2.body.changes[0].record.name, 'أحمد علي');
});

test('expenses can be edited (they are not append-only)', async () => {
  await push(owner.token, 'shop-1', [{ collection: 'expenses', record: { id: 'e-1', amountPiasters: 5000, category: 'rent' } }]);
  const res = await push(owner.token, 'shop-1', [{ collection: 'expenses', record: { id: 'e-1', amountPiasters: 7000, category: 'rent' } }]);
  assert.equal(res.body.results[0].status, 'updated');
  assert.equal((await db.collection('expenses').findOne({ id: 'e-1' })).amountPiasters, 7000);
});

test('a deleted customer is kept and can be restored', async () => {
  await push(owner.token, 'shop-1', [{ collection: 'customers', record: { id: 'c-1', name: 'x', deletedAt: '2026-11-02T00:00:00Z' } }]);
  let c = await db.collection('customers').findOne({ id: 'c-1' });
  assert.equal(c.deletedAt, '2026-11-02T00:00:00Z');
  await push(owner.token, 'shop-1', [{ collection: 'customers', record: { id: 'c-1', name: 'x', deletedAt: null } }]);
  c = await db.collection('customers').findOne({ id: 'c-1' });
  assert.equal(c.deletedAt, null);
});

test('employees without the delete permission cannot restore from trash', async () => {
  await push(owner.token, 'shop-1', [{ collection: 'customers', record: { id: 'c-1', name: 'x', deletedAt: '2026-11-02T00:00:00Z' } }]);
  const emp = await addEmployee();
  const res = await push(emp.token, 'shop-1', [{ collection: 'customers', record: { id: 'c-1', name: 'x', deletedAt: null } }]);
  assert.equal(res.body.results[0].status, 'rejected');
});

async function addEmployee(permissions) {
  const emp = await login('emp@test.com');
  const inv = await api().post('/v1/shops/shop-1/invites').set(auth(owner.token)).send({ permissions }).expect(201);
  await api().post('/v1/invites/accept').set(auth(emp.token)).send({ code: inv.body.code }).expect(200);
  return emp;
}

test('employee permissions are enforced on push and pull', async () => {
  await push(owner.token, 'shop-1', [
    { collection: 'customers', record: { id: 'c-1', name: 'أحمد', nationalId: '29001011234567' } },
    { collection: 'suppliers', record: { id: 's-1', name: 'جهينة' } },
    { collection: 'transactions', record: tx('t-sup', { partyType: 'supplier', partyId: 's-1' }) },
    { collection: 'transactions', record: tx('t-owner') },
    { collection: 'expenses', record: { id: 'e-1', amountPiasters: 5000, category: 'rent' } },
    { collection: 'installment_plans', record: { id: 'p-1', customerId: 'c-1', totalPricePiasters: 500000, installmentCount: 5, cashPricePiasters: 400000 } },
  ]);
  const emp = await addEmployee();

  const p = await pull(emp.token, 'shop-1', 0);
  const cols = p.body.changes.map((c) => `${c.collection}:${c.record.id}`);
  assert.ok(cols.includes('customers:c-1'));
  assert.ok(!cols.includes('suppliers:s-1'));
  assert.ok(!cols.includes('transactions:t-sup'));
  assert.ok(!cols.includes('expenses:e-1'));
  const cust = p.body.changes.find((c) => c.record.id === 'c-1').record;
  assert.equal(cust.nationalId, undefined);
  const plan = p.body.changes.find((c) => c.record.id === 'p-1').record;
  assert.equal(plan.cashPricePiasters, undefined);

  const res = await push(emp.token, 'shop-1', [
    { collection: 'transactions', record: tx('t-emp') },
    { collection: 'transactions', record: tx('t-owner', { deletedAt: '2026-11-03T00:00:00Z' }) },
    { collection: 'suppliers', record: { id: 's-2', name: 'x' } },
    { collection: 'settings', record: { id: 'set-1', key: 'k', value: 'v' } },
  ]);
  assert.deepEqual(res.body.results.map((r) => r.status), ['inserted', 'rejected', 'rejected', 'rejected']);

  // Employee can correct their own transaction within 10 minutes.
  const own = await push(emp.token, 'shop-1', [{ collection: 'transactions', record: tx('t-emp', { deletedAt: '2026-11-03T00:00:00Z' }) }]);
  assert.equal(own.body.results[0].status, 'updated');
});

test('employee with the delete permission can delete', async () => {
  await push(owner.token, 'shop-1', [{ collection: 'transactions', record: tx('t-owner') }]);
  const emp = await addEmployee({ delete: true });
  const res = await push(emp.token, 'shop-1', [{ collection: 'transactions', record: tx('t-owner', { deletedAt: '2026-11-03T00:00:00Z' }) }]);
  assert.equal(res.body.results[0].status, 'updated');
});

test('subscription gate blocks sync only when REQUIRE_SUBSCRIPTION is on', async () => {
  const { config } = await import('../src/config.js');
  config.requireSubscription = true;
  try {
    const blocked = await push(owner.token, 'shop-1', [{ collection: 'transactions', record: tx('t-1') }]);
    assert.equal(blocked.status, 402);
    await api().post('/v1/shops/shop-1/trial').set(auth(owner.token)).expect(200);
    const ok = await push(owner.token, 'shop-1', [{ collection: 'transactions', record: tx('t-1') }]);
    assert.equal(ok.status, 200);
  } finally {
    config.requireSubscription = false;
  }
});
