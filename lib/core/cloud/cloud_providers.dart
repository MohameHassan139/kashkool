import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/app_database.dart';
import 'cloud_api.dart';
import 'cloud_backup_service.dart';
import 'cloud_session_store.dart';
import 'google_auth_service.dart';

enum CloudAuthStatus { initial, loading, authenticated, unauthenticated, error }

class CloudAuthState {
  final CloudAuthStatus status;
  final String? message;

  const CloudAuthState(this.status, [this.message]);
}

class CloudAuthController extends StateNotifier<CloudAuthState> {
  CloudAuthController() : super(const CloudAuthState(CloudAuthStatus.initial));

  void setLoading() => state = const CloudAuthState(CloudAuthStatus.loading);
  void setAuthenticated() =>
      state = const CloudAuthState(CloudAuthStatus.authenticated);
  void setUnauthenticated() =>
      state = const CloudAuthState(CloudAuthStatus.unauthenticated);
  void setError(String message) =>
      state = CloudAuthState(CloudAuthStatus.error, message);
}

final cloudAuthStateProvider =
    StateNotifierProvider<CloudAuthController, CloudAuthState>(
      (ref) => CloudAuthController(),
    );

final cloudSessionStoreProvider = Provider<CloudSessionStore>(
  (ref) => CloudSessionStore(),
);

final cloudApiProvider = Provider<CloudApi>(
  (ref) => CloudApi(ref.watch(cloudSessionStoreProvider)),
);

final googleAuthServiceProvider = Provider<GoogleAuthService>(
  (ref) => GoogleAuthService(),
);

final cloudBackupServiceProvider = Provider<CloudBackupService>((ref) {
  return CloudBackupService(
    ref.watch(databaseProvider),
    ref.watch(cloudApiProvider),
    ref.watch(cloudSessionStoreProvider),
    ref.watch(googleAuthServiceProvider),
  );
});

/// Current cloud account (null when signed out). Invalidate after sign-in/out/backup.
final cloudSessionProvider = FutureProvider<CloudSession?>((ref) {
  return ref.watch(cloudSessionStoreProvider).read();
});
