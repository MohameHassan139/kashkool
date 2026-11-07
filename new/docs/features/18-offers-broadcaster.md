# 18 — Offers & Greetings Broadcaster (رسائل العروض)

**Phase:** 3 · **Tier:** Paid · **Depends on:** 02, 07

## User story
As a shop owner, I want to send my customers an offer or a Ramadan/Eid greeting
quickly, from my own WhatsApp, for free.

## Flow
1. Choose template: Ramadan · Eid · back-to-school · new offer · custom.
2. Choose audience: all with phone · good-rating only · active in last 30 days · manual pick.
3. Edit message (placeholders `{customer_name}` `{shop_name}`), optional image (shared separately).
4. **Send queue screen**: one customer at a time, big "ابعت" button → opens `wa.me` →
   on return marks sent and shows next. Progress "12 / 40".
5. Campaign saved with sent list (can resume later).

## Rules
- Uses the same URL-launcher approach as 07 (no API, no cost, no ban risk).
- Recommend ≤ 50 messages per session (tip shown) to avoid looking like spam.
- Growth footer (11) appended unless removed (Pro).

## Acceptance Criteria
- [ ] Queue resumes where it stopped after app restart.
- [ ] Audience filters return correct customers.
- [ ] Each message personalized correctly.
