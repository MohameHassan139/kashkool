# 11 — Growth Footer & Share Link

**Phase:** 1 · **Tier:** Free (removable in Paid) · **Depends on:** 07, 08

## Goal
Every message and document the shop sends advertises the app for free.
Each shop talks to dozens of customers — some of them are shop owners too.

## Behavior
- Append to every WhatsApp/SMS message, PDF statement and invoice:
  ```
  —
  اتعمل بكشكول 📒 جرّبه ببلاش: {link}
  ```
- `{link}` = Play Store link with referral param:
  `https://play.google.com/store/apps/details?id=com.kashkool&referrer=ref%3D{shopCode}`
  - `shopCode` = short random code (6 chars) generated on first launch, stored in settings.
  - (Later: replace with own short domain `kashkool.app/r/{shopCode}`.)
- Settings → "شارك التطبيق" button: share a ready message to any app.
- Footer cannot be disabled in Free tier; toggle appears (locked 🔒) and unlocks in Paid (16).

## Acceptance Criteria
- [ ] Footer present on all outgoing messages and PDFs.
- [ ] Referral code stable across restarts.
- [ ] Toggle hidden/locked until paid tier exists.
