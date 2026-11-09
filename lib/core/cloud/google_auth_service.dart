import 'package:google_sign_in/google_sign_in.dart';
import 'cloud_api.dart';
import 'cloud_config.dart';

/// Gets a Google ID token for the Kashkool backend (google_sign_in v7).
class GoogleAuthService {
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await GoogleSignIn.instance.initialize(serverClientId: CloudConfig.googleServerClientId);
    _initialized = true;
  }

  /// Shows the Google account picker and returns an ID token.
  Future<String> getIdToken() async {
    if (!CloudConfig.isConfigured) {
      throw const CloudApiException('not_configured', 'النسخ على السحابة مش متظبط في النسخة دي من التطبيق');
    }
    await _ensureInitialized();
    try {
      final account = await GoogleSignIn.instance.authenticate(scopeHint: const ['email']);
      final idToken = account.authentication.idToken;
      if (idToken == null || idToken.isEmpty) {
        throw const CloudApiException('google_no_token', 'جوجل مارجعش بيانات الدخول، جرّب تاني');
      }
      return idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw const CloudApiException('canceled', 'تم إلغاء تسجيل الدخول');
      }
      throw CloudApiException('google_error', 'مقدرناش نسجّل دخول بجوجل (${e.code.name})');
    }
  }

  Future<void> signOut() async {
    if (!_initialized) return;
    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
  }
}
