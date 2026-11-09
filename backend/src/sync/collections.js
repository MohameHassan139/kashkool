/**
 * Rules for every table the app syncs. Mirrors the local Drift tables.
 *
 * mode:
 *  - "mutable": profile-like rows; later pushes overwrite fields (last write wins, server order).
 *  - "append":  financial rows; insert once. After that only `appendMutable` fields may change
 *               (soft delete / restore from trash, superseded link). Amounts are never edited in place.
 *
 * Nothing is ever hard-deleted: `deletedAt` hides a row, clearing it restores the row.
 *
 * derived:   values the app computes locally (balances, paid amounts, statuses). Never stored/synced.
 * immutable: fields fixed after the first insert (e.g. installment plan prices).
 * sensitive: hidden from employees without the `viewSensitive` permission.
 * ownerOnlyRead: hidden from employees without the `viewProfit` permission.
 */
export const SYNC_COLLECTIONS = {
  customers: {
    mode: 'mutable',
    sensitive: ['nationalId'],
  },
  suppliers: {
    mode: 'mutable',
    readPermission: 'suppliers',
    writePermission: 'suppliers',
  },
  transactions: {
    mode: 'append',
    appendMutable: ['deletedAt', 'supersededById', 'updatedAt'],
    required: ['partyType', 'partyId', 'type', 'amountPiasters'],
    enums: {
      partyType: ['customer', 'supplier'],
      type: ['debt', 'payment'],
      method: ['cash', 'instapay', 'wallet', 'other', null],
    },
    positive: ['amountPiasters'],
  },
  installment_plans: {
    mode: 'mutable',
    writePermission: 'installmentsCreate',
    updatePermission: 'installmentsReschedule',
    immutable: [
      'customerId',
      'planNumber',
      'cashPricePiasters',
      'markupType',
      'markupValue',
      'totalPricePiasters',
      'downPaymentPiasters',
    ],
    sensitive: ['customerNationalId', 'guarantorNationalId'],
    ownerOnlyRead: ['cashPricePiasters', 'markupType', 'markupValue'],
    required: ['customerId', 'totalPricePiasters', 'installmentCount'],
  },
  installments: {
    mode: 'mutable',
    writePermission: 'installmentsCreate',
    updatePermission: 'installmentsReschedule',
    // TEMPORARY: the app still stores paid amounts/status on schedule rows (fix F6 not done yet),
    // so they must be backed up. After F6, set: derived: ['paidPiasters', 'status', 'fullyPaidAt', 'paidAt'].
    derived: [],
    required: ['planId', 'amountPiasters'],
  },
  installment_events: {
    mode: 'append',
    appendMutable: ['deletedAt', 'updatedAt'],
    required: ['planId', 'type'],
  },
  installment_attachments: {
    mode: 'append',
    appendMutable: ['deletedAt', 'updatedAt', 'returnedAt', 'storageKey'],
    sensitive: ['photoPath', 'storageKey'],
    required: ['planId', 'kind'],
  },
  cash_days: {
    mode: 'mutable',
    readPermission: 'viewReports',
    writePermission: 'viewReports',
  },
  expenses: {
    // The app edits expenses in place, so they sync like profile rows (last write wins).
    mode: 'mutable',
    readPermission: 'viewReports',
    writePermission: 'viewReports',
    required: ['amountPiasters'],
    positive: ['amountPiasters'],
  },
  settings: {
    mode: 'mutable',
    writePermission: 'settings',
    required: ['key'],
  },
};

export const SYNC_COLLECTION_NAMES = Object.keys(SYNC_COLLECTIONS);

/** Fields the server owns; clients can never set them. */
export const SERVER_FIELDS = ['_id', 'shopId', 'serverSeq', 'serverUpdatedAt', 'serverCreatedAt', 'pushedBy'];

const ID_RE = /^[A-Za-z0-9_\-:.]{1,64}$/;
const KEY_RE = /^[A-Za-z][A-Za-z0-9_]{0,63}$/;
const MAX_FIELDS = 60;
const MAX_STRING = 4000;

/** `occurredAt`, `dueDate`, `createdAt`… must be ISO-8601 strings (or null). */
const isDateField = (key) => /(At|Date)$/.test(key);
const isMoneyField = (key) => key.endsWith('Piasters');

/**
 * Validates and cleans one pushed record.
 * Returns `{ record }` or `{ error }` (never throws).
 */
export function sanitizeRecord(collectionName, raw) {
  const def = SYNC_COLLECTIONS[collectionName];
  if (!def) return { error: 'unknown_collection' };
  if (!raw || typeof raw !== 'object' || Array.isArray(raw)) return { error: 'record_must_be_object' };
  if (typeof raw.id !== 'string' || !ID_RE.test(raw.id)) return { error: 'invalid_id' };

  const keys = Object.keys(raw);
  if (keys.length > MAX_FIELDS) return { error: 'too_many_fields' };

  const record = {};
  for (const key of keys) {
    if (SERVER_FIELDS.includes(key)) continue;
    if (def.derived?.includes(key)) continue;
    if (!KEY_RE.test(key)) return { error: `invalid_field_name:${key}` };

    const value = raw[key];
    if (value === null || value === undefined) {
      record[key] = null;
      continue;
    }
    if (typeof value === 'string') {
      if (value.length > MAX_STRING) return { error: `field_too_long:${key}` };
      if (isDateField(key) && Number.isNaN(Date.parse(value))) return { error: `invalid_date:${key}` };
    } else if (typeof value === 'number') {
      if (!Number.isFinite(value)) return { error: `invalid_number:${key}` };
      if (isMoneyField(key) && !Number.isSafeInteger(value)) return { error: `money_must_be_integer:${key}` };
      if (isDateField(key)) return { error: `date_must_be_iso_string:${key}` };
    } else if (typeof value !== 'boolean') {
      return { error: `unsupported_value_type:${key}` };
    }
    record[key] = value;
  }

  for (const field of def.required || []) {
    if (record[field] === undefined || record[field] === null || record[field] === '') {
      return { error: `missing_field:${field}` };
    }
  }
  for (const [field, allowed] of Object.entries(def.enums || {})) {
    if (record[field] !== undefined && !allowed.includes(record[field])) {
      return { error: `invalid_value:${field}` };
    }
  }
  for (const field of def.positive || []) {
    if (record[field] !== undefined && !(Number.isSafeInteger(record[field]) && record[field] > 0)) {
      return { error: `must_be_positive_integer:${field}` };
    }
  }
  return { record };
}

/**
 * Computes what to write for an incoming record given the stored one.
 * Returns `{ op: 'insert', doc } | { op: 'update', set } | { op: 'unchanged' }`.
 */
export function planWrite(collectionName, incoming, existing) {
  const def = SYNC_COLLECTIONS[collectionName];
  if (!existing) return { op: 'insert', doc: incoming };

  const set = {};
  if (def.mode === 'append') {
    for (const field of def.appendMutable || []) {
      if (!(field in incoming)) continue;
      if (field === 'updatedAt') continue; // only follows a real change
      const next = incoming[field];
      const prev = existing[field] ?? null;
      if (field === 'supersededById') {
        // An edit link is set once and never cleared.
        if (prev === null && next !== null) set[field] = next;
      } else if (next !== prev) {
        // deletedAt can be set (moved to trash) and cleared (restored from trash).
        set[field] = next;
      }
    }
  } else {
    for (const [field, next] of Object.entries(incoming)) {
      if (field === 'id' || field === 'createdBy' || field === 'deviceId') continue;
      if (def.immutable?.includes(field) && existing[field] !== undefined && existing[field] !== null) continue;
      if (next !== (existing[field] ?? null)) set[field] = next;
    }
    delete set.updatedAt;
  }

  if (Object.keys(set).length === 0) return { op: 'unchanged' };
  if (incoming.updatedAt) set.updatedAt = incoming.updatedAt;
  return { op: 'update', set };
}

/** Removes fields a member is not allowed to see. */
export function filterForReader(collectionName, doc, member) {
  const def = SYNC_COLLECTIONS[collectionName];
  const { _id, ...rest } = doc;
  if (member.role === 'owner') return rest;
  const p = member.permissions || {};
  if (!p.viewSensitive) for (const f of def.sensitive || []) delete rest[f];
  if (!p.viewProfit) for (const f of def.ownerOnlyRead || []) delete rest[f];
  return rest;
}
