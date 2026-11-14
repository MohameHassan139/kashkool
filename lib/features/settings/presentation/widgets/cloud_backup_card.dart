import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/cloud/auto_backup_coordinator.dart';
import '../../../../core/cloud/cloud_api.dart';
import '../../../../core/cloud/cloud_backup_service.dart';
import '../../../../core/cloud/cloud_config.dart';
import '../../../../core/cloud/cloud_providers.dart';
import '../../../../core/cloud/cloud_session_store.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/glass_toast.dart';
import '../../../../l10n/l10n.dart';

/// Settings section: sign in with Google, back up to the cloud, restore on this phone.
class CloudBackupCard extends ConsumerStatefulWidget {
  const CloudBackupCard({super.key});

  @override
  ConsumerState<CloudBackupCard> createState() => _CloudBackupCardState();
}

class _CloudBackupCardState extends ConsumerState<CloudBackupCard> {
  bool _busy = false;

  CloudBackupService get _service => ref.read(cloudBackupServiceProvider);

  void _snack(String message, {Color? color}) {
    if (!mounted) return;
    if (color == AppColors.debtRed) {
      AppGlassToast.showError(context, message);
    } else {
      AppGlassToast.showSuccess(context, message);
    }
  }

  /// Runs [task] with a blocking progress dialog and shows errors as snackbars.
  Future<T?> _run<T>(Future<T> Function(CloudProgress onProgress) task) async {
    if (_busy) return null;
    setState(() => _busy = true);
    final progress = ValueNotifier<String>(L10n.t.cloudBackupCard1);
    unawaited(showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            children: [
              const SizedBox(width: 28, height: 28, child: CircularProgressIndicator(strokeWidth: 3)),
              const SizedBox(width: 16),
              Expanded(
                child: ValueListenableBuilder<String>(
                  valueListenable: progress,
                  builder: (_, value, _) => Text(value),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
    try {
      return await task((message, _) => progress.value = message);
    } on CloudApiException catch (e) {
      if (e.code != 'canceled') _snack(e.message, color: AppColors.debtRed);
      return null;
    } catch (e, st) {
      debugPrint('CloudBackupCard error: $e\n$st');
      _snack(L10n.t.cloudBackupCard2, color: AppColors.debtRed);
      return null;
    } finally {
      if (mounted) Navigator.of(context, rootNavigator: true).pop();
      progress.dispose();
      ref.invalidate(cloudSessionProvider);
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _signIn() async {
    final session = await _run((p) {
      p(L10n.t.cloudBackupCard3, null);
      return _service.signIn();
    });
    if (session == null || !mounted) return;
    _snack(L10n.t.cloudBackupCard4(session.email), color: AppColors.paymentGreen);
    await _backup();
  }

  Future<void> _backup() async {
    final result = await _run((p) => _service.syncWithCloud(onProgress: p));
    if (result == null || !mounted) return;
    if (result.rejected > 0) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(L10n.t.cloudBackupCard5),
          content: Text(
            L10n.t.cloudBackupCard6(result.uploaded, result.rejected, result.rejectReasons.join('\n')),
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: Text(L10n.t.settingsScreen53))],
        ),
      );
    } else {
      _snack(
        result.uploaded == 0 ? L10n.t.cloudBackupCard7 : L10n.t.cloudBackupCard8(result.uploaded),
        color: AppColors.paymentGreen,
      );
    }
  }

  Future<void> _restore() async {
    final shops = await _run((p) {
      p(L10n.t.cloudBackupCard9, null);
      return _service.listCloudShops();
    });
    if (shops == null || !mounted) return;
    if (shops.isEmpty) {
      _snack(L10n.t.cloudBackupCard10);
      return;
    }

    final shop = shops.first;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(L10n.t.cloudBackupCard13),
        content: Text(
          '${L10n.t.cloudBackupCard14(shop['name'])}${L10n.t.cloudBackupCard15}',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(L10n.t.installmentPlanDetailsScreen11)),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(L10n.t.cloudBackupCard16),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final result = await _run((p) => _service.restore(shop, onProgress: p));
    if (result == null || !mounted) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(L10n.t.cloudBackupCard17),
        content: Text(
          '${L10n.t.cloudBackupCard19(result.records, result.keptLocal > 0 ? L10n.t.cloudBackupCard18(result.keptLocal) : '')}\n\n${L10n.t.cloudBackupCard20}',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              SystemNavigator.pop();
            },
            child: Text(L10n.t.cloudBackupCard21),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(L10n.t.cloudBackupCard22),
        content: Text(L10n.t.cloudBackupCard23),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(L10n.t.installmentPlanDetailsScreen11)),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(L10n.t.cloudBackupCard24)),
        ],
      ),
    );
    if (ok != true) return;
    await _run((p) => _service.signOut());
  }

  Future<void> _deleteAccount() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(L10n.t.cloudDeleteAccountConfirmTitle),
        content: Text(L10n.t.cloudDeleteAccountConfirmBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(L10n.t.installmentPlanDetailsScreen11)),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.debtRed),
            child: Text(L10n.t.cloudDeleteAccountConfirmButton),
          ),
        ],
      ),
    );
    if (ok != true) return;
    final done = await _run((p) async {
      await _service.deleteAccount();
      return true;
    });
    if (done == true && mounted) AppGlassToast.showSuccess(context, L10n.t.cloudDeleteAccountDone);
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(cloudSessionProvider).valueOrNull;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: CloudConfig.isConfigured
              ? (session == null ? _signedOutTiles() : _signedInTiles(session))
              : [
                  ListTile(
                    leading: const Icon(Icons.cloud_off_rounded, color: AppColors.neutralGrey),
                    title: Text(L10n.t.cloudAccountButton2, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    subtitle: Text(L10n.t.cloudBackupCard25, style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey)),
                  ),
                ],
        ),
      ),
    );
  }

  List<Widget> _signedOutTiles() => [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.12),
            child: const Icon(Icons.cloud_upload_rounded, color: AppColors.primaryBlue),
          ),
          title: Text(L10n.t.cloudBackupCard26, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          subtitle: Text(
            L10n.t.cloudBackupCard27,
            style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _busy ? null : _signIn,
              icon: const Icon(Icons.account_circle_rounded, size: 22),
              label: Text(L10n.t.authSignInWithGoogle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
      ];

  List<Widget> _signedInTiles(CloudSession session) {
    final last = session.lastBackupAt;
    final lastText = last == null ? L10n.t.cloudBackupCard28 : L10n.t.cloudBackupCard29(DateFormat('yyyy/MM/dd - hh:mm a').format(last));
    final auto = ref.watch(autoBackupStatusProvider);
    final (autoText, autoColor) = switch (auto.state) {
      AutoBackupState.uploading => (L10n.t.cloudBackupCard30, AppColors.primaryBlue),
      AutoBackupState.waitingForInternet => (L10n.t.cloudBackupCard31, AppColors.warningAmber),
      AutoBackupState.failed => (auto.message ?? L10n.t.cloudBackupCard32, AppColors.debtRed),
      AutoBackupState.upToDate => (auto.message ?? L10n.t.cloudBackupCard33, AppColors.paymentGreen),
      AutoBackupState.idle => (L10n.t.cloudBackupCard34, AppColors.neutralGrey),
    };
    return [
      ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.paymentGreenLight,
          child: Icon(Icons.cloud_done_rounded, color: AppColors.paymentGreen),
        ),
        title: Text(session.email, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text.rich(
          TextSpan(children: [
            TextSpan(text: '$lastText\n'),
            TextSpan(text: autoText, style: TextStyle(color: autoColor, fontWeight: FontWeight.w600)),
          ]),
          style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey, height: 1.5),
        ),
        isThreeLine: true,
      ),
      const Divider(height: 1),
      ListTile(
        enabled: !_busy,
        leading: const Icon(Icons.cloud_upload_rounded, color: AppColors.primaryBlue),
        title: Text(L10n.t.cloudBackupCard35, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        trailing: const Icon(Icons.chevron_left_rounded),
        onTap: _backup,
      ),
      const Divider(height: 1),
      ListTile(
        enabled: !_busy,
        leading: const Icon(Icons.cloud_download_rounded, color: AppColors.warningAmber),
        title: Text(L10n.t.cloudBackupCard36, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(L10n.t.cloudBackupCard37, style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey)),
        trailing: const Icon(Icons.chevron_left_rounded),
        onTap: _restore,
      ),
      const Divider(height: 1),
      ListTile(
        enabled: !_busy,
        leading: const Icon(Icons.logout_rounded, color: AppColors.neutralGrey),
        title: Text(L10n.t.cloudBackupCard38, style: const TextStyle(fontSize: 14)),
        onTap: _signOut,
      ),
      const Divider(height: 1),
      ListTile(
        enabled: !_busy,
        leading: const Icon(Icons.delete_forever_rounded, color: AppColors.debtRed),
        title: Text(L10n.t.cloudDeleteAccountTitle, style: const TextStyle(fontSize: 14, color: AppColors.debtRed)),
        subtitle: Text(L10n.t.cloudDeleteAccountSubtitle, style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey)),
        onTap: _deleteAccount,
      ),
    ];
  }
}
