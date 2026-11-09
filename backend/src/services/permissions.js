/** Default permissions (spec 15). Owners can do everything. */
export const EMPLOYEE_DEFAULT_PERMISSIONS = Object.freeze({
  delete: false,
  editOwnRecentTransactions: true,
  suppliers: false,
  viewReports: false,
  settings: false,
  installmentsCreate: true,
  installmentsCollect: true,
  installmentsReschedule: false,
  installmentsCancel: false,
  viewProfit: false,
  viewSensitive: false,
});

export const PERMISSION_KEYS = Object.keys(EMPLOYEE_DEFAULT_PERMISSIONS);

export function can(member, permission) {
  if (!member || member.active === false) return false;
  if (member.role === 'owner') return true;
  return Boolean(member.permissions?.[permission]);
}

const TEN_MINUTES = 10 * 60 * 1000;

/**
 * Decides whether `member` may write `incoming` (and `existing`, if any) into `collection`.
 * Returns null when allowed, or an error code string.
 */
export function checkWritePermission({ collection, def, member, incoming, existing, userId, now = Date.now() }) {
  if (member.role === 'owner') return null;

  // Supplier money is guarded by the "suppliers" permission too.
  if (collection === 'transactions' && (incoming.partyType ?? existing?.partyType) === 'supplier' && !can(member, 'suppliers')) {
    return 'permission_denied:suppliers';
  }
  if (def.writePermission && !existing && !can(member, def.writePermission)) {
    // Rescheduling creates new schedule rows too.
    const altOk = collection === 'installments' && can(member, 'installmentsReschedule');
    if (!altOk) return `permission_denied:${def.writePermission}`;
  }
  if (existing) {
    const perm = def.updatePermission || def.writePermission;
    const isCancel = collection === 'installment_plans' && ['cancelled', 'defaulted'].includes(incoming.status) && incoming.status !== existing.status;
    if (isCancel && !can(member, 'installmentsCancel')) return 'permission_denied:installmentsCancel';
    if (!isCancel && perm && def.mode === 'mutable' && !can(member, perm)) return `permission_denied:${perm}`;
  }

  const deleting = incoming.deletedAt && !(existing?.deletedAt);
  const restoring = existing?.deletedAt && 'deletedAt' in incoming && incoming.deletedAt === null;
  if (restoring && !can(member, 'delete')) return 'permission_denied:delete';
  if (deleting && !can(member, 'delete')) {
    // An employee may correct (soft-delete + replace) their own transaction within 10 minutes.
    const ownRecent =
      collection === 'transactions' &&
      existing &&
      existing.pushedBy === userId &&
      existing.serverCreatedAt &&
      now - new Date(existing.serverCreatedAt).getTime() <= TEN_MINUTES &&
      can(member, 'editOwnRecentTransactions');
    if (!ownRecent) return 'permission_denied:delete';
  }
  return null;
}

/** Collections an employee can read. */
export function canRead(member, def) {
  if (!def.readPermission) return true;
  return can(member, def.readPermission);
}
