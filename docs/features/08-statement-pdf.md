# 08 — Customer Statement PDF (كشف حساب)

**Phase:** 1 · **Tier:** Free · **Depends on:** 03, 11, 12

## User story
As a shop owner, I want to send a customer a clean statement of all his
transactions, so there's no argument about the amount.

## Content
- Header: shop name, phone, (logo optional from settings), date generated.
- Customer name + phone.
- Period selector: all time (default) · this month · custom range.
- Table: date · description/note · عليه · دفع · الرصيد (running).
- Footer: final balance (large), payment info, growth footer (11).

## Technical
- `pdf` package with bundled Cairo font (Arabic shaping + RTL `TextDirection.rtl`).
- A4 + optional 80mm receipt width variant (thermal printers).
- Share via `share_plus` (user picks WhatsApp/other) or print via `printing`.
- File name: `كشف_حساب_{name}_{yyyy-MM-dd}.pdf`.

## Acceptance Criteria
- [ ] Arabic renders correctly (connected letters, RTL, numbers readable).
- [ ] Running balance matches app balance.
- [ ] Works fully offline; 500 transactions generate in < 3 s on a mid device.
- [ ] Share sheet opens with the PDF attached.
