import 'package:google_sign_in/google_sign_in.dart';
import 'cloud_api.dart';
import 'cloud_config.dart';
import '../../l10n/l10n.dart';

/// Gets a Google ID token for the Kashkool backend (google_sign_in v7).
class GoogleAuthService {
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await GoogleSignIn.instance.initialize(
      serverClientId: CloudConfig.googleServerClientId,
    );
    _initialized = true;
  }

  /// Shows the Google account picker and returns an ID token.
  Future<String> getIdToken() async {
    if (!CloudConfig.googleSignInConfigured) {
      throw CloudApiException('not_configured', L10n.t.googleAuthService1);
    }
    await _ensureInitialized();
    try {
      final account = await GoogleSignIn.instance.authenticate(
        scopeHint: const ['email'],
      );
      final idToken = account.authentication.idToken;
      if (idToken == null || idToken.isEmpty) {
        throw CloudApiException('google_no_token', L10n.t.googleAuthService2);
      }
      return idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw CloudApiException('canceled', L10n.t.googleAuthService3);
      }
      throw CloudApiException(
        'google_error',
        L10n.t.googleAuthService4(e.code.name),
      );
    }
  }

  Future<void> signOut() async {
    if (!_initialized) return;
    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
  }
}
