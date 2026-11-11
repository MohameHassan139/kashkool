import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/cloud/auto_backup_coordinator.dart';
import '../../../../core/cloud/cloud_api.dart';
import '../../../../core/cloud/cloud_backup_service.dart';
import '../../../../core/cloud/cloud_config.dart';
import '../../../../core/cloud/cloud_providers.dart';
import '../../../../core/cloud/cloud_session_store.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../onboarding/data/shop_repository.dart';
import '../../../../shared/widgets/glass_toast.dart';
import '../../../../l10n/l10n.dart';
import 'email_auth_dialog.dart';

/// Settings section: manage a cloud account, back up, and restore on this phone.
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
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            children: [
              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ValueListenableBuilder<String>(
                  valueListenable: progress,
                  builder: (_, value, __) => Text(value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    try {
      return await task((message, _) => progress.value = message);
    } on CloudApiException catch (e) {
      if (e.code != 'canceled') _snack(e.message, color: AppColors.debtRed);
      return null;
    } catch (error, stackTrace) {
      debugPrint('Cloud operation failed: $error\n$stackTrace');
      _snack(L10n.t.cloudBackupCard2, color: AppColors.debtRed);
      return null;
    } finally {
      if (mounted) Navigator.of(context, rootNavigator: true).pop();
      progress.dispose();
      ref.invalidate(cloudSessionProvider);
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _signInWithGoogle({bool switching = false}) async {
    ref.read(cloudAuthStateProvider.notifier).setLoading();
    await _service.beginAccountTransition();
    final previousSession = await ref.read(cloudSessionStoreProvider).read();
    final session = await _run((p) {
      p(L10n.t.emailAuthSigningIn, null);
      return _service.signIn();
    });
    if (session == null) {
      await _service.endAccountTransition();
      ref.read(cloudAuthStateProvider.notifier).setUnauthenticated();
      return;
    }
    if (!mounted) {
      await _restorePreviousSession(previousSession);
      return;
    }
    await _finishSignIn(session, previousSession, switching: switching);
  }

  Future<void> _signInWithEmail({bool switching = false}) async {
    final request = await showEmailAuthScreen(
      context,
      onGoogleSignIn: () => _signInWithGoogle(switching: switching),
    );
    if (request == null || !mounted) return;
    ref.read(cloudAuthStateProvider.notifier).setLoading();
    await _service.beginAccountTransition();
    final previousSession = await ref.read(cloudSessionStoreProvider).read();
    final session = await _run((p) {
      p(L10n.t.emailAuthSigningIn, null);
      return _service.signInWithEmail(
        request.email,
        request.password,
        register: request.register,
        name: request.name,
      );
    });
    if (session == null) {
      await _service.endAccountTransition();
      ref
          .read(cloudAuthStateProvider.notifier)
          .setError(L10n.t.cloudBackupCard2);
      return;
    }
    if (!mounted) {
      await _restorePreviousSession(previousSession);
      return;
    }
    await _finishSignIn(session, previousSession, switching: switching);
  }

  Future<void> _finishSignIn(
    CloudSession session,
    CloudSession? previousSession, {
    required bool switching,
  }) async {
    final previousUserId =
        previousSession?.userId ?? await _service.localAccountUserId();
    var accountChanged = previousUserId == null
        ? false
        : previousUserId != session.userId;

    if (accountChanged && !switching && !await _confirmAccountSwitch()) {
      await _restorePreviousSession(previousSession);
      return;
    }

    final shops = await _run((p) {
      p(L10n.t.cloudBackupCard9, null);
      return _service.listCloudShops();
    });
    if (shops == null || !mounted) {
      await _restorePreviousSession(previousSession);
      return;
    }

    if (!accountChanged &&
        previousUserId == null &&
        shops.isNotEmpty &&
        await _service.hasLocalShopData()) {
      accountChanged = true;
      if (!switching && !await _confirmAccountSwitch()) {
        await _restorePreviousSession(previousSession);
        return;
      }
    }

    if (accountChanged && shops.isEmpty) {
      final filesNotDeleted = await _run(
        (_) => _service.clearLocalAccountData(),
      );
      if (filesNotDeleted == null || !mounted) {
        await _restorePreviousSession(previousSession);
        return;
      }
      await _service.rememberAccount(session);
      ref.read(cloudAuthStateProvider.notifier).setAuthenticated();
      if (filesNotDeleted > 0) {
        _snack(
          L10n.t.accountSwitchFileCleanupWarning,
          color: AppColors.debtRed,
        );
      }
      ref.invalidate(isOnboardingCompletedStreamProvider);
      context.go('/onboarding');
      return;
    }

    Map<String, dynamic>? shop;
    var filesNotDeleted = 0;
    if (shops.isNotEmpty) {
      shop = await _chooseCloudShop(shops);
      if (shop == null || !mounted) {
        await _restorePreviousSession(previousSession);
        return;
      }
      final result = await _run(
        (p) => _service.restore(
          shop!,
          onProgress: p,
          replaceLocalData: accountChanged,
        ),
      );
      if (result == null || !mounted) {
        await _restorePreviousSession(previousSession);
        return;
      }
      filesNotDeleted = result.filesNotDeleted;
    } else {
      await _service.endAccountTransition();
      final result = await _run((p) => _service.backupNow(onProgress: p));
      if (result == null || !mounted) {
        await _restorePreviousSession(previousSession);
        return;
      }
    }

    await _service.rememberAccount(session);
    ref.read(cloudAuthStateProvider.notifier).setAuthenticated();
    ref.invalidate(cloudSessionProvider);
    _snack(
      L10n.t.cloudBackupCard4(session.email),
      color: AppColors.paymentGreen,
    );
    if (filesNotDeleted > 0) {
      _snack(L10n.t.accountSwitchFileCleanupWarning, color: AppColors.debtRed);
    }
    if (mounted) {
      Navigator.of(context).maybePop();
      context.go('/');
    }
  }

  Future<bool> _confirmAccountSwitch() async {
    final hasChanges = await _service.hasUnbackedChanges();
    if (!mounted) return false;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(L10n.t.accountSwitchTitle),
        content: Text(
          hasChanges
              ? L10n.t.accountSwitchUnbackedWarning
              : L10n.t.accountSwitchWarning,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(L10n.t.accountSwitchCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(L10n.t.accountSwitchContinue),
          ),
        ],
      ),
    );
    return confirmed == true;
  }

  Future<void> _restorePreviousSession(CloudSession? previousSession) async {
    final store = ref.read(cloudSessionStoreProvider);
    if (previousSession == null) {
      await store.clear();
    } else {
      await store.write(previousSession);
    }
    await _service.endAccountTransition();
    if (previousSession == null) {
      ref.read(cloudAuthStateProvider.notifier).setUnauthenticated();
    } else {
      ref.read(cloudAuthStateProvider.notifier).setAuthenticated();
    }
    ref.invalidate(cloudSessionProvider);
  }

  Future<Map<String, dynamic>?> _chooseCloudShop(
    List<Map<String, dynamic>> shops,
  ) {
    if (shops.length == 1) return Future.value(shops.first);
    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(L10n.t.cloudBackupCard11),
        children: [
          for (final shop in shops)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, shop),
              child: Text(
                '${shop['name']}${shop['role'] == 'employee' ? L10n.t.cloudBackupCard12 : ''}',
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _switchAccount() async {
    if (!await _confirmAccountSwitch() || !mounted) return;
    final method = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(L10n.t.accountSwitchChooseMethod),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'email'),
            child: Text(L10n.t.emailAuthLogin),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(ctx, 'google'),
            icon: const Icon(Icons.g_mobiledata_rounded),
            label: Text(L10n.t.cloudAccountButton3),
          ),
        ],
      ),
    );
    if (method == 'google') {
      await _signInWithGoogle(switching: true);
    } else if (method == 'email') {
      await _signInWithEmail(switching: true);
    }
  }

  Future<void> _backup() async {
    final result = await _run((p) => _service.backupNow(onProgress: p));
    if (result == null || !mounted) return;
    if (result.rejected > 0) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(L10n.t.cloudBackupCard5),
          content: Text(
            L10n.t.cloudBackupCard6(
              result.uploaded,
              result.rejected,
              result.rejectReasons.join('\n'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(L10n.t.settingsScreen53),
            ),
          ],
        ),
      );
    } else {
      _snack(
        result.uploaded == 0
            ? L10n.t.cloudBackupCard7
            : L10n.t.cloudBackupCard8(result.uploaded),
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

    Map<String, dynamic>? shop = shops.first;
    if (shops.length > 1) {
      shop = await _chooseCloudShop(shops);
      if (shop == null || !mounted) return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(L10n.t.cloudBackupCard13),
        content: Text(
          '${L10n.t.cloudBackupCard14(shop!['name'])}${L10n.t.cloudBackupCard15}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(L10n.t.installmentPlanDetailsScreen11),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(L10n.t.cloudBackupCard16),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final result = await _run((p) => _service.restore(shop!, onProgress: p));
    if (result == null || !mounted) return;
    _snack(
      L10n.t.cloudBackupCard19(
        result.records,
        result.keptLocal > 0 ? L10n.t.cloudBackupCard18(result.keptLocal) : '',
      ),
      color: AppColors.paymentGreen,
    );
    if (mounted) context.go('/');
  }

  Future<void> _signOut() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(L10n.t.cloudBackupCard22),
        content: Text(L10n.t.cloudBackupCard23),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(L10n.t.installmentPlanDetailsScreen11),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(L10n.t.cloudBackupCard24),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await _run((p) => _service.signOut());
    if (await ref.read(cloudSessionStoreProvider).read() == null) {
      ref.read(cloudAuthStateProvider.notifier).setUnauthenticated();
    }
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
                    leading: Icon(
                      Icons.cloud_off_rounded,
                      color: AppColors.neutralGrey,
                    ),
                    title: Text(
                      L10n.t.cloudAccountButton2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      L10n.t.cloudBackupCard25,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.neutralGrey,
                      ),
                    ),
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
        child: const Icon(
          Icons.cloud_upload_rounded,
          color: AppColors.primaryBlue,
        ),
      ),
      title: Text(
        L10n.t.cloudBackupCard26,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text(
        L10n.t.cloudBackupCard27,
        style: TextStyle(fontSize: 12, color: AppColors.neutralGrey),
      ),
    ),
    Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: _busy ? null : _signInWithGoogle,
          icon: const Icon(Icons.account_circle_rounded),
          label: Text(
            L10n.t.cloudAccountButton3,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
          ),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          onPressed: _busy ? null : _signInWithEmail,
          icon: const Icon(Icons.email_outlined),
          label: Text(
            L10n.t.emailAuthLogin,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          style: TextButton.styleFrom(minimumSize: const Size.fromHeight(52)),
        ),
      ),
    ),
  ];

  List<Widget> _signedInTiles(CloudSession session) {
    final last = session.lastBackupAt;
    final lastText = last == null
        ? L10n.t.cloudBackupCard28
        : L10n.t.cloudBackupCard29(
            DateFormat('yyyy/MM/dd - hh:mm a').format(last),
          );
    final auto = ref.watch(autoBackupStatusProvider);
    final (autoText, autoColor) = switch (auto.state) {
      AutoBackupState.syncing => (
        L10n.t.cloudSyncRunning,
        AppColors.primaryBlue,
      ),
      AutoBackupState.uploading => (
        L10n.t.cloudBackupCard30,
        AppColors.primaryBlue,
      ),
      AutoBackupState.waitingForInternet => (
        L10n.t.cloudBackupCard31,
        AppColors.warningAmber,
      ),
      AutoBackupState.failed => (
        auto.message ?? L10n.t.cloudBackupCard32,
        AppColors.debtRed,
      ),
      AutoBackupState.upToDate => (
        auto.message ?? L10n.t.cloudBackupCard33,
        AppColors.paymentGreen,
      ),
      AutoBackupState.idle => (L10n.t.cloudBackupCard34, AppColors.neutralGrey),
    };
    return [
      ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.paymentGreenLight,
          child: Icon(Icons.cloud_done_rounded, color: AppColors.paymentGreen),
        ),
        title: Text(
          session.email,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '$lastText\n'),
              TextSpan(
                text: autoText,
                style: TextStyle(color: autoColor, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.neutralGrey,
            height: 1.5,
          ),
        ),
        isThreeLine: true,
      ),
      const Divider(height: 1),
      ListTile(
        enabled: !_busy,
        leading: const Icon(
          Icons.switch_account_rounded,
          color: AppColors.primaryBlue,
        ),
        title: Text(
          L10n.t.accountSwitchTitle,
          style: const TextStyle(fontSize: 14),
        ),
        onTap: _busy ? null : _switchAccount,
      ),
      const Divider(height: 1),
      ListTile(
        enabled: !_busy,
        leading: const Icon(
          Icons.cloud_upload_rounded,
          color: AppColors.primaryBlue,
        ),
        title: Text(
          L10n.t.cloudBackupCard35,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        trailing: const Icon(Icons.chevron_left_rounded),
        onTap: _backup,
      ),
      const Divider(height: 1),
      ListTile(
        enabled: !_busy,
        leading: const Icon(
          Icons.cloud_download_rounded,
          color: AppColors.warningAmber,
        ),
        title: Text(
          L10n.t.cloudBackupCard36,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(
          L10n.t.cloudBackupCard37,
          style: TextStyle(fontSize: 12, color: AppColors.neutralGrey),
        ),
        trailing: const Icon(Icons.chevron_left_rounded),
        onTap: _restore,
      ),
      const Divider(height: 1),
      ListTile(
        enabled: !_busy,
        leading: const Icon(Icons.logout_rounded, color: AppColors.neutralGrey),
        title: Text(L10n.t.cloudBackupCard38, style: TextStyle(fontSize: 14)),
        onTap: _signOut,
      ),
    ];
  }
}
