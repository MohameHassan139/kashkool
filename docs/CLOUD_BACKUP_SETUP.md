# Cloud Backup with Google Sign-In — Setup

The app's **Settings → النسخ الاحتياطي والبيانات** section has a cloud backup card:
sign in with Google → upload backup → restore on another phone.
Code: `lib/core/cloud/` and `lib/features/settings/presentation/widgets/cloud_backup_card.dart`.

## 1. Google Cloud Console (one time)
1. https://console.cloud.google.com → create a project (e.g. "Kashkool").
2. **APIs & Services → OAuth consent screen** → External → app name "كشكول", your email →
   add scopes `email`, `profile`, `openid` → add yourself (and testers) as **Test users** while in testing.
3. **APIs & Services → Credentials → Create credentials → OAuth client ID**:
   - **Web application** → name "Kashkool backend" → create. Copy its **Client ID**
     (this is `GOOGLE_SERVER_CLIENT_ID` in the app and `GOOGLE_CLIENT_IDS` on the server).
   - **Android** → package name `app.kashkool` → SHA-1 of your signing key:
     ```
     cd android
     ./gradlew signingReport
     ```
     (on Windows: `gradlew signingReport`). Use the SHA-1 of `debug` for testing; add another
     Android client with the **release** SHA-1 (and later the Play App Signing SHA-1) before publishing.
   - No `google-services.json` is needed.

## 2. Backend (Vercel)
Add the environment variable and redeploy:
```
GOOGLE_CLIENT_IDS=<Web client ID>
```

## 3. Run the app with cloud enabled
```
flutter pub get
flutter run --dart-define=KASHKOOL_API_URL=https://<your-backend>.vercel.app --dart-define=GOOGLE_SERVER_CLIENT_ID=<Web client ID>
```
For local backend testing on a real phone use your PC's LAN IP, e.g. `http://192.168.1.10:3000`
(an emulator uses `http://10.0.2.2:3000`). Android blocks plain `http` by default, so test against
the Vercel `https` URL, or temporarily allow cleartext in a debug-only manifest.

Without these two `--dart-define` values the card shows "مش متاح في النسخة دي" and nothing else changes.

## How it works
- **Sign in:** Google account picker → ID token → `POST /v1/auth/google` → Kashkool tokens saved in
  secure storage (never in the app database, never in `.kashkool` files).
- **Backup:** registers the local shop (`POST /v1/shops` with the local shop id), then pushes rows in
  batches of 400 via `/sync/push`. The first backup sends everything; later ones send only rows whose
  `updatedAt` changed since the previous backup. PIN/fingerprint settings are never uploaded.
- **Restore:** pulls all pages and **replaces** the data on the phone in one database transaction
  (security settings on that phone are kept), then asks the user to reopen the app.
- Photos are not uploaded yet (they stay on the phone).

## Known limits until the review fixes are done
- **F6:** the server temporarily stores installment `paidPiasters`/`status` because the app still keeps
  them on schedule rows. After F6 these become derived values again (see backend/README.md).
- Backup is manual (button). Automatic background backup can be added with the daily job from F7.
