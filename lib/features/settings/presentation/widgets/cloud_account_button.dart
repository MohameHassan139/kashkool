import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/cloud/auto_backup_coordinator.dart';
import '../../../../core/cloud/cloud_config.dart';
import '../../../../core/cloud/cloud_providers.dart';
import '../../../../core/constants/app_colors.dart';
import 'cloud_backup_card.dart';
import '../../../../l10n/l10n.dart';

/// Cloud icon for app bars: shows whether the user is signed in, and opens the
/// Google sign-in / backup card in a bottom sheet.
class CloudAccountButton extends ConsumerWidget {
  const CloudAccountButton({super.key});

  static Future<void> showSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  L10n.t.cloudAccountButton1,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              CloudBackupCard(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!CloudConfig.isConfigured) return const SizedBox.shrink();
    ref.listen(cloudSessionProvider, (_, next) {
      if (next.isLoading) return;
      if (ref.read(cloudAuthStateProvider).status == CloudAuthStatus.loading) {
        return;
      }
      final auth = ref.read(cloudAuthStateProvider.notifier);
      if (next.hasError) {
        auth.setError(next.error.toString());
      } else if (next.valueOrNull == null) {
        auth.setUnauthenticated();
      } else {
        auth.setAuthenticated();
      }
    });
    final signedIn = ref.watch(cloudSessionProvider).valueOrNull != null;
    final syncState = ref.watch(autoBackupStatusProvider).state;
    final (icon, color, tooltip) = switch ((signedIn, syncState)) {
      (false, _) => (
        Icons.cloud_off_rounded,
        AppColors.debtRed,
        L10n.t.cloudAccountButton3,
      ),
      (true, AutoBackupState.syncing || AutoBackupState.uploading) => (
        Icons.cloud_sync_rounded,
        AppColors.warningAmber,
        L10n.t.cloudSyncRunning,
      ),
      (true, AutoBackupState.waitingForInternet) => (
        Icons.cloud_off_rounded,
        AppColors.warningAmber,
        L10n.t.cloudBackupCard31,
      ),
      (true, AutoBackupState.failed) => (
        Icons.cloud_off_rounded,
        AppColors.debtRed,
        L10n.t.cloudBackupCard32,
      ),
      (true, AutoBackupState.upToDate) => (
        Icons.cloud_done_rounded,
        AppColors.paymentGreen,
        L10n.t.cloudBackupCard33,
      ),
      _ => (
        Icons.cloud_queue_rounded,
        AppColors.neutralGrey,
        L10n.t.cloudBackupCard34,
      ),
    };
    return IconButton(
      tooltip: tooltip,
      onPressed: () => showSheet(context),
      icon: Badge(
        isLabelVisible: !signedIn,
        smallSize: 8,
        backgroundColor: color,
        child: Icon(icon, color: color),
      ),
    );
  }
}
