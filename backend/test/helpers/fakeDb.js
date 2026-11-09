/**
 * Minimal in-memory stand-in for the MongoDB driver, used when no real MongoDB is available.
 * Query matching uses `mingo` (MongoDB query semantics). Supports only what the app uses.
 * Set MONGODB_TEST_URI to run the same tests against a real database instead.
 */
import { Query } from 'mingo';

const clone = (v) => structuredClone(v);

function getPath(obj, path) {
  return path.split('.').reduce((o, k) => (o == null ? undefined : o[k]), obj);
}

function compare(a, b) {
  if (a === b) return 0;
  if (a === undefined || a === null) return -1;
  if (b === undefined || b === null) return 1;
  if (a instanceof Date) a = a.getTime();
  if (b instanceof Date) b = b.getTime();
  return a < b ? -1 : a > b ? 1 : 0;
}

function applyUpdate(doc, update, isInsert) {
  for (const [op, fields] of Object.entries(update)) {
    for (const [key, value] of Object.entries(fields)) {
      if (op === '$set') doc[key] = clone(value);
      else if (op === '$setOnInsert') { if (isInsert) doc[key] = clone(value); }
      else if (op === '$inc') doc[key] = (doc[key] || 0) + value;
      else if (op === '$push') (doc[key] ||= []).push(clone(value));
      else if (op === '$unset') delete doc[key];
      else throw new Error(`fakeDb: unsupported update operator ${op}`);
    }
  }
}

function seedFromFilter(filter) {
  const doc = {};
  for (const [k, v] of Object.entries(filter)) {
    if (!k.startsWith('$') && (v === null || typeof v !== 'object' || v instanceof Date)) doc[k] = v;
  }
  return doc;
}

class Cursor {
  constructor(docs) { this.docs = docs; }
  sort(spec) {
    const entries = Object.entries(spec);
    this.docs.sort((x, y) => {
      for (const [k, dir] of entries) {
        const c = compare(getPath(x, k), getPath(y, k));
        if (c !== 0) return c * dir;
      }
      return 0;
    });
    return this;
  }
  limit(n) { this.docs = this.docs.slice(0, n); return this; }
  async toArray() { return this.docs.map(clone); }
}

class Collection {
  constructor() { this.docs = []; this.uniques = []; this.nextId = 1; }

  async createIndex(spec, opts = {}) {
    if (opts.unique) {
      this.uniques.push({
        keys: Object.keys(spec),
        sparse: !!opts.sparse,
        partial: opts.partialFilterExpression ? new Query(opts.partialFilterExpression) : null,
      });
    }
    return 'ok';
  }

  checkUnique(candidate, ignore) {
    for (const u of this.uniques) {
      const vals = u.keys.map((k) => getPath(candidate, k));
      // Like MongoDB: sparse skips only *missing* fields (null still counts); partial indexes use their filter.
      if (u.sparse && vals.some((v) => v === undefined)) continue;
      if (u.partial && !u.partial.test(candidate)) continue;
      const inIndex = (d) => (!u.partial || u.partial.test(d)) && !(u.sparse && u.keys.some((k) => getPath(d, k) === undefined));
      const clash = this.docs.some((d) => d !== ignore && inIndex(d) && u.keys.every((k, i) => compare(getPath(d, k), vals[i]) === 0));
      if (clash) { const e = new Error('E11000 duplicate key'); e.code = 11000; throw e; }
    }
  }

  match(filter) { const q = new Query(filter || {}); return this.docs.filter((d) => q.test(d)); }

  find(filter, opts = {}) {
    let docs = this.match(filter);
    if (opts.projection) {
      const keys = Object.keys(opts.projection);
      docs = docs.map((d) => Object.fromEntries([['_id', d._id], ...keys.map((k) => [k, d[k]])]));
    }
    return new Cursor(docs.slice());
  }
  async findOne(filter, opts = {}) { const [d] = await this.find(filter, opts).limit(1).toArray(); return d ?? null; }
  async countDocuments(filter) { return this.match(filter).length; }

  async insertOne(doc) {
    const d = clone(doc);
    d._id ??= `fake_${this.nextId++}`;
    this.checkUnique(d);
    this.docs.push(d);
    return { insertedId: d._id, acknowledged: true };
  }

  async updateOne(filter, update, opts = {}) {
    const [target] = this.match(filter);
    if (!target) {
      if (!opts.upsert) return { matchedCount: 0, modifiedCount: 0 };
      const d = seedFromFilter(filter);
      applyUpdate(d, update, true);
      await this.insertOne(d);
      return { matchedCount: 0, modifiedCount: 0, upsertedCount: 1 };
    }
    const next = clone(target);
    applyUpdate(next, update, false);
    this.checkUnique(next, target);
    Object.keys(target).forEach((k) => delete target[k]);
    Object.assign(target, next);
    return { matchedCount: 1, modifiedCount: 1 };
  }

  async updateMany(filter, update) {
    const targets = this.match(filter);
    for (const t of targets) applyUpdate(t, update, false);
    return { matchedCount: targets.length, modifiedCount: targets.length };
  }

  async findOneAndUpdate(filter, update, opts = {}) {
    const [target] = this.match(filter);
    if (!target) {
      if (!opts.upsert) return null;
      const d = seedFromFilter(filter);
      applyUpdate(d, update, true);
      await this.insertOne(d);
      return clone(this.docs[this.docs.length - 1]);
    }
    const before = clone(target);
    await this.updateOne({ _id: target._id }, update);
    return opts.returnDocument === 'after' ? clone(target) : before;
  }

  async findOneAndDelete(filter) {
    const [target] = this.match(filter);
    if (!target) return null;
    this.docs = this.docs.filter((d) => d !== target);
    return clone(target);
  }
  async deleteOne(filter) {
    const [target] = this.match(filter);
    if (target) this.docs = this.docs.filter((d) => d !== target);
    return { deletedCount: target ? 1 : 0 };
  }
  async deleteMany(filter) {
    const targets = new Set(this.match(filter));
    this.docs = this.docs.filter((d) => !targets.has(d));
    return { deletedCount: targets.size };
  }
}

export function createFakeDb() {
  const collections = new Map();
  return {
    collection(name) {
      if (!collections.has(name)) collections.set(name, new Collection());
      return collections.get(name);
    },
    async command() { return { ok: 1 }; },
  };
}
