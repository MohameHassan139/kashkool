# 17 — Notebook Import via Camera (AI)

**Phase:** 3 · **Tier:** Paid (first 5 pages free) · **Depends on:** 02, 03, 13, 16

## User story
As a shop owner with a full paper notebook, I want to photograph its pages and
have customers and amounts entered for me.

## Flow
1. "استورد من الكشكول" → camera with page-edge detection (or gallery).
2. Upload image to backend (Supabase Edge Function) → vision LLM extracts rows:
   `{ name, amount, type (debt/payment), date?, confidence }`.
3. **Review screen** (mandatory): editable table, low-confidence cells highlighted,
   name matching to existing customers ("ده نفس أحمد محمود؟"), remove/add rows.
4. Confirm → creates customers & transactions (note: "مستورد من الكشكول").

## Rules
- Never save without user review.
- Handle Egyptian handwriting, Arabic & Hindi numerals (٠١٢٣).
- Quota tracked server-side per shop; show remaining pages.
- Images deleted from server after processing (privacy).

## Acceptance Criteria
- [ ] Clear photo of a typical page extracts ≥ 80% rows correctly in tests.
- [ ] Review screen allows full correction before saving.
- [ ] Quota enforced; free 5 pages work without subscription.
