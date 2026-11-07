# 14 — Installments System (نظام الأقساط) ⭐

**Phase:** 2 · **Tier:** Paid (headline feature) — Free users get **1 active plan** as a trial
**Depends on:** 02 Customers, 03 Transactions, 05 Rating, 07 Collection, 08 PDF, 09 Cash drawer, 16 Paywall
**Works offline:** Yes. Fully local-first; cloud sync (13) is a bonus, not a requirement.

---

## 1. Why this feature matters
Mobile phone, electronics, home appliance, and furniture shops in Egypt sell a large share
of their goods on installments ("بالتقسيط"). Today they track this in a notebook, plus
signed promissory receipts ("إيصالات أمانة"). They lose money because they:
- forget who is due this week,
- don't notice late customers until it's too late,
- can't quickly answer "فاضل عليّا كام؟" for the customer,
- don't know how much money is expected to come in this month.

These shops have higher margins than groceries and **will pay** for a tool that fixes this.
That makes installments the main reason to subscribe.

## 2. Glossary
| Arabic | English | Meaning |
|---|---|---|
| سعر الكاش | Cash price | Price if paid in full today |
| زيادة التقسيط | Installment markup | Extra added for selling on installments (fixed amount or %) |
| السعر بالتقسيط | Total installment price | Cash price + markup |
| المقدّم | Down payment | Paid at signing |
| المتبقي | Financed amount | Total price − down payment |
| القسط | Installment | One scheduled payment |
| الضامن | Guarantor | Person who guarantees the customer |
| إيصال أمانة | Promissory receipt | Signed paper the shop keeps as security |
| تأجيل | Postpone | Move one installment to a later date |
| إعادة جدولة | Reschedule | Rebuild the remaining schedule |
| سداد مبكر | Early settlement | Pay everything remaining now (optionally with a discount) |

## 3. User stories
1. As a shop owner, I can create an installment plan in under a minute while the customer is in the shop.
2. As a shop owner, I can show the customer the full schedule and send it on WhatsApp or as a PDF.
3. As a shop owner, every morning I see who is **due today** and who is **late**.
4. As a shop owner, I can record a full or partial installment payment in 2 taps.
5. As a shop owner, I can remind a customer on WhatsApp with exact details (item, installment number, amount, remaining).
6. As a shop owner, I can postpone an installment or reschedule a plan when a customer is struggling.
7. As a shop owner, I can settle a plan early with a discount, or cancel it if the item is returned.
8. As a shop owner, I know how much money to expect this month and how much is overdue.
9. As a shop owner, I keep photos of the customer's ID, the contract, and the signed receipts in the plan.

## 4. Data model

### 4.1 `installment_plans`
| Field | Type | Notes |
|---|---|---|
| id | text | UUID v4 (Primary Key) |
| shopId | text | FK → shops.id |
| deviceId | text | Originating device hardware UUID |
| createdBy | text | User/device identifier |
| createdAt, updatedAt, deletedAt | datetime | Standard UTC audit timestamps |
| planNumber | text | Unambiguous human-friendly number. Offline generation uses device prefix: e.g. `A-0042` or `DEV1-0042` to guarantee zero collisions across multiple offline devices. Synced cloud records may assign a canonical sequential alias `#0042`. |
| customerId | text | FK → customers |
| itemDescription | text | Required. e.g. "Samsung A15 128GB" |
| itemSerial | text? | IMEI / serial number (critical for phones and electronics) |
| cashPricePiasters | int | سعر الكاش (Piasters) |
| markupType | enum | `none` · `fixed` · `percent` |
| markupValue | int | Piasters if fixed; basis points if percent (e.g. 2000 = 20%) |
| totalPricePiasters | int | Computed and stored at creation (cash + markup) |
| downPaymentPiasters | int | ≥ 0 and < total |
| installmentCount | int | 1 – 60 |
| frequency | enum | `monthly` · `weekly` · `biweekly` · `custom` |
| firstDueDate | date | First installment due date |
| dueDayOfMonth | int? | Monthly only: preferred day (1–31), clamped to month length |
| guarantorName | text? | Optional guarantor name |
| guarantorPhone | text? | Optional guarantor phone |
| guarantorNationalId | text? | **Optional** (اختياري) — compliant with Egypt Law 151/2020 |
| customerNationalId | text? | **Optional** (اختياري) — compliant with Egypt Law 151/2020 |
| lateFeeType | enum | `none` (default) · `fixed_per_installment` |
| lateFeePiasters | int? | Only if lateFeeType ≠ none |
| graceDays | int | Default 3. Days after due date before marked late |
| status | enum | `active` · `completed` · `settled_early` · `cancelled` · `defaulted` |
| completedAt | datetime? | Set when plan reaches final settlement |
| notes | text? | |

### 4.2 `installments` (the schedule)
| Field | Type | Notes |
|---|---|---|
| id | text | UUID v4 |
| shopId | text | FK → shops.id |
| deviceId | text | Device identifier |
| createdBy | text | User identifier |
| createdAt, updatedAt, deletedAt | datetime | Standard UTC timestamps |
| planId | text | FK → installment_plans.id |
| index | int | 1-based installment sequence number |
| dueDate | date | Current due date (after any postponement) |
| originalDueDate | date | Never changes. Used for reports, metrics, and customer rating |
| amountPiasters | int | Scheduled amount in piasters |
| lateFeePiasters | int | Applied late fee (0 by default) |
| waivedPiasters | int | Amount forgiven (discount, early settlement) |
| fullyPaidAt | datetime? | Timestamp when this installment was cleared |
| postponeCount | int | How many times it was postponed |

> [!IMPORTANT]
> **Derived Installment Values (Local Only, Never Synced Directly)**:
> - `paidPiasters`: Calculated dynamically from the linked payments in the Customer Ledger for this plan.
> - **Status per installment** (computed on the fly, not stored as a sync column):
>   - `paid` → paid + waived ≥ amount + lateFee
>   - `partial` → 0 < paid < amount + lateFee
>   - `upcoming` → dueDate > today
>   - `due_today` → dueDate == today
>   - `in_grace` → dueDate < today ≤ dueDate + graceDays
>   - `late` → today > dueDate + graceDays and not paid

### 4.3 `installment_attachments`
| Field | Type | Notes |
|---|---|---|
| id | text | UUID v4 |
| shopId | text | FK → shops.id |
| deviceId | text | Device identifier |
| createdBy | text | User identifier |
| createdAt, updatedAt, deletedAt | datetime | Standard UTC timestamps |
| planId | text | FK → installment_plans.id |
| kind | enum | `customer_id` · `guarantor_id` · `contract` · `receipt` · `item_photo` · `other` |
| photoPath | text | Local path, compressed ≤ 400KB |
| receiptNumber | text? | For promissory receipts |
| receiptAmountPiasters | int? | |
| returnedAt | datetime? | When the receipt was handed back to the customer |

### 4.4 Link to `transactions`
Add nullable `installmentPlanId` to `transactions`.
- The down payment and every installment payment are saved as `type = payment` with `installmentPlanId` set.
- The plan's financed amount is **not** saved as a `debt` transaction. This avoids double counting.
- The regular credit balance (feature 03) **excludes** transactions that have `installmentPlanId`.
- The cash drawer (09) **includes** them, using their `method`.
- On the customer details screen, show the two figures separately:
  "رصيد الشُكُك: 350 ج.م" and "متبقي أقساط: 6,400 ج.م".

### 4.5 `installment_events` (audit trail)
| Field | Type | Notes |
|---|---|---|
| planId | text | |
| type | enum | `created` · `payment` · `postponed` · `rescheduled` · `fee_applied` · `fee_waived` · `settled_early` · `cancelled` · `defaulted` · `reactivated` |
| payload | json | Before/after values |
| createdAt, createdBy | — | |

The owner needs this history if a customer disputes something.

## 5. Calculations

### 5.1 Price
```
markup   = none    → 0
           fixed   → markupValue
           percent → round(cashPrice × markupValue / 10000)
total    = cashPrice + markup
financed = total − downPayment
```
Validation: `0 ≤ downPayment < total`, `installmentCount ≥ 1`.

Show a live summary while creating:
"السعر بالتقسيط 12,000 — مقدّم 2,000 — الباقي 10,000 على 10 شهور = 1,000 شهرياً".

### 5.2 Schedule generation
```
base      = floor(financed / count)        // in piasters
remainder = financed − base × count
amounts   = [base] × count, then add remainder to the LAST installment
```
**Rounding option** (setting, default ON): round each installment down to the nearest
**5 EGP**, and put the difference in the last installment. Shops prefer round numbers.

**Due dates:**
- `monthly`: same day each month starting from `firstDueDate`. If `dueDayOfMonth` > days in the
  month, clamp to the last day (31 Jan → 28/29 Feb → 31 Mar). Always derive the date from the
  **original day**, not from the previous date. This prevents drift (31 → 28 → 28 …).
- `weekly`: +7 days. `biweekly`: +14 days.
- `custom`: the user edits each date and amount manually in the preview. The sum must equal `financed`.

### 5.3 Payment allocation
When the owner records an amount `P` for a plan:
1. Apply it to the **oldest unpaid installment first** (lowest index), covering its late fee first, then its amount.
2. Carry any leftover to the next installment, and so on.
3. If `P` is more than the total remaining, ask: "المبلغ أكبر من المتبقي — تسجّل الزيادة رصيد للعميل؟"
4. Create **one** `transactions` row for `P`, and update `paidPiasters` on the affected installments.
5. When every installment is paid → set `status = completed`, show a celebration screen, and offer
   a WhatsApp "خالصين" message to the customer.

Editing or deleting a payment must **re-run allocation from scratch** for the plan, which keeps the
logic deterministic.

### 5.4 Remaining and progress
```
remainingTotal = Σ (amount + lateFee − paid − waived) over all installments
paidCount      = count of installments with status paid
overdueAmount  = Σ remaining of installments with status late
nextDue        = first unpaid installment by dueDate
```

### 5.5 Late fees (optional, OFF by default)
- Many shop owners and customers prefer **no late fees**, so the default is `none`.
- If enabled: when an installment becomes `late`, apply `lateFeePiasters` **once** to that installment
  and log a `fee_applied` event.
- The owner can always waive a fee (`fee_waived` event).
- Never use compounding or daily interest.

### 5.6 Early settlement (سداد مبكر)
- Show the remaining total, plus an optional discount (amount or %), and the final amount to pay.
- On confirm: record the payment, put the discount in `waivedPiasters` on the remaining installments
  (allocated from the last installment backwards), set `status = settled_early`, and log the event.

## 6. Plan lifecycle (state machine)
```
            ┌──────────────── reactivate ───────────────┐
            ▼                                           │
 [active] ──all paid──▶ [completed]                     │
    │ ├──early settlement──▶ [settled_early]            │
    │ ├──item returned / cancelled──▶ [cancelled]       │
    │ └──owner marks unrecoverable──▶ [defaulted] ──────┘
```
- **Cancel:** ask whether money is refunded to the customer (record a refund transaction)
  or kept. Remaining installments get zeroed via `waived`. This needs a confirmation step.
- **Defaulted:** excluded from "expected this month", but kept in the overdue reports.
  Shows a strong red badge on the customer.
- Only `active` plans appear in reminders and in the collection screen.

## 7. Postpone and reschedule
- **Postpone one installment (تأجيل قسط):** move it to a new date. Later installments stay the same.
  `postponeCount++`, `originalDueDate` is unchanged. Warn on the 3rd postponement of the same installment.
- **Reschedule (إعادة جدولة):** take the current remaining total and re-split it over a new count,
  frequency, and start date. Paid installments stay unchanged. Old unpaid rows are soft-deleted,
  new rows are generated, and both versions are logged.
- **Change amount of one installment:** allowed in custom mode, as long as the total still balances
  (the difference goes to the last installment).

## 8. Screens

### 8.1 Installments tab / section
Reached from the bottom nav (shown when the shop type chosen in onboarding is electronics,
mobile, or furniture) or from the Customers tab.
- **Top summary cards:**
  - "مستحق النهارده": count + amount
  - "متأخر": count + amount (red)
  - "متوقع الشهر ده": expected vs collected so far (progress bar)
- **Filter chips:** نشطة · مستحقة النهارده · متأخرة · خالصة · ملغية
- **Search:** customer name, item, IMEI, plan number.
- **List row:** customer name · item · progress "4 / 10" with bar · next due date and amount ·
  status badge.
- **FAB:** "+ تقسيط جديد"

### 8.2 New plan wizard (4 steps, each one screen)
1. **Customer:** pick an existing customer or create one quickly (name + phone). Optional national ID.
2. **Item and price:** description, IMEI/serial (barcode scan button), cash price, markup
   (none / fixed / %), down payment, and the down payment method (cash / InstaPay / wallet).
3. **Schedule:** count (quick chips 3 · 6 · 10 · 12 · 18 · 24), frequency, first due date
   (default: same day next month), rounding toggle. Live **preview table**, with every row
   editable in custom mode.
4. **Guarantor and documents (optional, skippable):** guarantor info, photos (customer ID,
   guarantor ID, contract, receipts with numbers), notes, late fee settings.

Final summary → **حفظ**. Then offer: "ابعت الجدول للعميل واتساب" · "اطبع / PDF".

Target: a simple plan created in **under 60 seconds** with only steps 1–3.

### 8.3 Plan details
- **Header:** plan #, customer (tap → customer details), item and IMEI, status badge.
- **Big numbers:** total · paid · remaining · overdue (if any).
- **Progress bar:** "دفع 4 من 10 أقساط".
- **Primary button:** **"سجّل دفع"**, prefilled with the next due amount (+ any overdue).
  Quick chips: "القسط الجاي" · "كل المتأخر" · "مبلغ تاني".
- **Secondary actions:** WhatsApp reminder · Call customer · Call guarantor · PDF · Postpone ·
  Reschedule · Early settlement · Cancel · Edit info.
- **Schedule list:** each row shows # · due date · amount · paid · status chip
  (✓ مدفوع / جزئي / النهارده / مهلة / متأخر X يوم / جاي).
  Tap a row → details for that installment, its payments, and a postpone action.
- **Tabs:** الجدول · المدفوعات · المستندات · السجل (events).

### 8.4 Record payment sheet
Same big keypad as feature 03. It shows how the amount will be allocated before saving:
"هيتسدد: قسط 5 كامل + 300 من قسط 6". Method selector. Save → snackbar with Undo.

### 8.5 Collection integration (feature 07)
The Collection tab gets a section **"أقساط"** above the regular credit list:
- Due today, then in grace, then late (sorted by days late, descending).
- Each row: WhatsApp · Call · "اتدفع" (opens the payment sheet) · Postpone.

## 9. Reminders and notifications

### 9.1 Owner notification (daily, same job as 07)
"النهارده: 4 أقساط مستحقة (5,200 ج.م) · 3 متأخرين (2,900 ج.م)". Tap → Collection, installments section.

### 9.2 Customer reminders (via WhatsApp URL launcher, owner taps send)
| When | Template |
|---|---|
| 1 day before due (optional setting) | Friendly heads-up |
| Due day | Due today |
| Late (after grace) | Polite late notice |
| Fully paid | "خالصين" thank-you |
| Plan created | Full schedule summary |

**Placeholders:** `{customer_name}` `{shop_name}` `{item}` `{installment_number}`
`{installment_count}` `{due_date}` `{amount}` `{overdue_amount}` `{remaining_total}`
`{paid_count}` `{payment_info}` `{plan_number}`.

Default "due today" message:
```
السلام عليكم أ/ {customer_name} 👋
معاك {shop_name}.
النهارده ميعاد القسط رقم {installment_number} من {installment_count}
لـ {item}: {amount}
المتبقي بعده: {remaining_total}
للدفع: {payment_info}
شكراً ليك 🙏
```
Default "late" message:
```
السلام عليكم أ/ {customer_name}
بنفكّرك إن القسط رقم {installment_number} لـ {item}
كان ميعاده {due_date} بمبلغ {overdue_amount}.
ياريت تتواصل معانا. شكراً لتفهمك 🙏
```
- The growth footer (11) is appended unless the shop is Pro and has turned it off.
- The guarantor reminder is a separate button and is **never** automatic. Show a confirmation:
  "هتبعت للضامن؟"

## 10. Documents (PDF, feature 08 engine)
1. **Installment schedule / contract summary:** shop info, customer and guarantor, item and IMEI,
   prices, the full schedule table, signature lines (customer, guarantor, shop). A4.
2. **Plan statement:** all payments made, remaining amount, overdue amount.
3. **Payment receipt (إيصال استلام):** for a single payment, 80mm thermal or A4, numbered.
   Can be shared on WhatsApp immediately after recording a payment.

**Disclaimer** in the app and in the PDF footer: the document is for record-keeping and does not
replace a legal contract.

## 11. Reports
- **This month:** expected · collected · remaining · collection rate %.
- **Next 30 / 60 / 90 days:** expected inflow (bar chart by week or month).
- **Overdue aging:** 1–7 · 8–30 · 31–60 · 60+ days (amount + count), tap → list.
- **Top late customers.**
- **Profit from markup:** Σ markup on completed plans (owner only, hidden from employees per feature 15).
- **Export** any report as PDF, or as CSV in Pro.

## 12. Effect on other features
- **Rating (05):** a customer with a `late` installment older than 15 days gets at least 🟡;
  older than 45 days, or any `defaulted` plan → 🔴. On-time history improves the rating.
- **Credit limit (04):** optionally include the installments remaining in the exposure check
  (setting, default OFF).
- **Customer details (02):** add an "الأقساط" card with active plans and a "+ تقسيط" button.
- **Cash drawer (09):** installment payments counted by method.
- **Widget (10):** in the medium widget, add the line "أقساط النهارده: X".
- **Employees (15):** permissions `installments.create`, `installments.collect`,
  `installments.reschedule`, `installments.cancel`, `installments.viewProfit`.
  The defaults for employees are create + collect only.

## 13. Free vs Paid
| | Free | Pro |
|---|---|---|
| Active plans | 1 (trial) | Unlimited |
| Schedule, payments, reminders | ✅ | ✅ |
| Postpone / reschedule / early settlement | ✅ (on the 1 plan) | ✅ |
| Attachments (photos) | 2 per plan | Unlimited |
| PDF contract and receipts | With footer | Footer removable |
| Reports and forecasts | Summary only | Full + export |
| Cloud backup of plans and photos | ❌ | ✅ |

When a free user tries to create a 2nd plan, show the paywall (16) with this message:
"عندك تقسيط شغال. اشترك عشان تضيف أقساط بلا حدود وماتنساش أي قسط تاني".

## 14. Edge cases (must be handled and tested)
- First due date at the end of the month (29/30/31) and February in leap and non-leap years.
- Down payment = 0, or a single installment (count = 1).
- The financed amount doesn't divide evenly, plus the rounding option.
- A partial payment that spans 3 installments.
- Overpayment beyond the remaining total.
- Editing or deleting a past payment → allocation is recomputed correctly.
- Postponing an installment past the next installment's date (allowed, with a warning; sort by dueDate).
- Rescheduling after partial payments.
- Early settlement with a discount larger than the remaining amount (block this).
- Cancelling a plan with payments made (refund vs keep).
- Customer deleted while plans are active → block the delete and explain why.
- Device date or timezone changes → use date-only comparisons in local time.
- 500 active plans → list and summary still load in under 1 s on a mid-range device.

## 15. Implementation milestones (one task each)
1. **14a:** DB tables + migration, and the `installmentPlanId` link on transactions.
2. **14b:** Pure Dart calculation service (`InstallmentCalculator`): price, schedule, allocation,
   statuses, remaining, early settlement. **100% unit tested, no UI.**
3. **14c:** New plan wizard + plan details (read-only schedule).
4. **14d:** Record payment, undo, and edit/delete with re-allocation.
5. **14e:** Collection integration, daily notification, WhatsApp templates.
6. **14f:** Postpone, reschedule, early settlement, cancel, default, and the events log.
7. **14g:** Attachments + PDFs (schedule, statement, receipt).
8. **14h:** Reports.
9. **14i:** Paywall gating + employee permissions.

## 16. Acceptance criteria
- [ ] A 10-month plan with down payment is created in under 60 seconds, and the preview matches the saved schedule.
- [ ] Schedules handle end-of-month dates without drift (unit tests for Jan 31 and Feb 29 starts).
- [ ] Σ installments always equals the financed amount exactly (property-based test with random inputs).
- [ ] Payment allocation is FIFO, handles partial and multi-installment payments, and is recomputed correctly after edit/delete.
- [ ] Statuses (upcoming / due_today / in_grace / late / partial / paid) are correct for any "today" (injectable clock in tests).
- [ ] The regular credit balance excludes installment payments, while the cash drawer includes them.
- [ ] Owner daily notification and Collection section list due and late installments correctly.
- [ ] WhatsApp messages contain correct placeholders in Arabic with emojis intact.
- [ ] Postpone, reschedule, early settlement, cancel, and default each work and are logged in events.
- [ ] PDFs render Arabic correctly, and their totals match the app.
- [ ] The free tier is limited to 1 active plan, and Pro unlocks everything.
- [ ] Works fully offline.
- [ ] `flutter analyze` is clean and all tests pass.
