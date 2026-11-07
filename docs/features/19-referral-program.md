# 19 — Referral Program (برنامج الترشيح)

**Phase:** 3 · **Tier:** Free users earn Pro time · **Depends on:** 11, 13, 16

## User story
As a shop owner, if I bring another shop owner to the app, I get a free Pro month.

## Mechanics
- Each shop has `shopCode` (from 11). Install referrer captured via Play Install Referrer API
  (`play_install_referrer` package) or code entered manually at onboarding ("حد رشّحلك؟").
- **Qualified referral** = referred shop has ≥ 10 transactions on ≥ 3 different days (anti-fraud).
- Reward: referrer gets +30 days Pro; referred shop gets +14 days extra trial.
- Max rewards per shop per year (e.g. 12 months).

## Screens
- "اكسب شهر ببلاش" screen: share button, own code, list of referrals with status
  (installed / qualified / rewarded), total months earned.

## Acceptance Criteria
- [ ] Referrer attribution works from Play link and manual code.
- [ ] Reward granted only after qualification; once per referred shop.
- [ ] Server-side validation (cannot self-refer from same device/account).
