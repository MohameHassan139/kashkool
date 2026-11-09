import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/app_database.dart';
import 'cloud_api.dart';
import 'cloud_backup_service.dart';
import 'cloud_session_store.dart';
import 'google_auth_service.dart';

final cloudSessionStoreProvider = Provider<CloudSessionStore>((ref) => CloudSessionStore());

final cloudApiProvider = Provider<CloudApi>((ref) => CloudApi(ref.watch(cloudSessionStoreProvider)));

final googleAuthServiceProvider = Provider<GoogleAuthService>((ref) => GoogleAuthService());

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
