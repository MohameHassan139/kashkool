# 10 — Home Screen Widget

**Phase:** 1 · **Tier:** Free · **Depends on:** 02, 03, 07

## User story
As a shop owner, I want to see my totals on my phone's home screen without
opening the app.

## Content (Android first)
- Small (2×1): total receivables.
- Medium (4×2): total receivables · collected today · customers due today + button "تحصيل".
- Tap widget → open app; tap "تحصيل" → Collection tab.
- Respects privacy mode (12): show `•••` instead of amounts.

## Technical
- `home_widget` package; native Android layout (XML / Glance) with RTL support.
- Update widget data after every transaction save and on daily workmanager run.

## Acceptance Criteria
- [ ] Widget shows correct numbers within seconds of a new transaction.
- [ ] Deep links open the right tab.
- [ ] Privacy mode hides amounts.
- [ ] Looks correct in light/dark launcher themes.
