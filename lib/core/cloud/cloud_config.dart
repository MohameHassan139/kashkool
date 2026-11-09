/// Cloud backup settings. Both have built-in defaults, so a plain `flutter run` works.
/// They can still be overridden at build time:
///
/// flutter run \
///   --dart-define=KASHKOOL_API_URL=https://your-backend.vercel.app \
///   --dart-define=GOOGLE_SERVER_CLIENT_ID=1234-abc.apps.googleusercontent.com
///
/// GOOGLE_SERVER_CLIENT_ID (optional, has a default) is the **Web** OAuth client ID from Google Cloud Console
/// (the same value as GOOGLE_CLIENT_IDS on the server).
abstract final class CloudConfig {
  /// Kashkool backend on Vercel. Override with --dart-define=KASHKOOL_API_URL=... (e.g. a local server).
  static const String apiBaseUrl = String.fromEnvironment(
    'KASHKOOL_API_URL',
    defaultValue: 'https://backend-gamma-ten-87.vercel.app',
  );
  /// Web OAuth client ID (Google Cloud project "whatsapp-b25d2"). Client IDs are public, not secrets.
  static const String googleServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
    defaultValue: '614449752265-j63irue74mr2n73ingedj9ps3j9nm6p7.apps.googleusercontent.com',
  );

  static bool get isConfigured => apiBaseUrl.isNotEmpty && googleServerClientId.isNotEmpty;

  /// Base URL without a trailing slash.
  static String get baseUrl => apiBaseUrl.endsWith('/') ? apiBaseUrl.substring(0, apiBaseUrl.length - 1) : apiBaseUrl;
}
