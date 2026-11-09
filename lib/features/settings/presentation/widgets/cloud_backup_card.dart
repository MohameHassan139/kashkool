import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/cloud/cloud_api.dart';
import '../../../../core/cloud/cloud_backup_service.dart';
import '../../../../core/cloud/cloud_config.dart';
import '../../../../core/cloud/cloud_providers.dart';
import '../../../../core/cloud/cloud_session_store.dart';
import '../../../../core/constants/app_colors.dart';

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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  /// Runs [task] with a blocking progress dialog and shows errors as snackbars.
  Future<T?> _run<T>(Future<T> Function(CloudProgress onProgress) task) async {
    if (_busy) return null;
    setState(() => _busy = true);
    final progress = ValueNotifier<String>('لحظة…');
    showDialog<void>(
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
    } catch (_) {
      _snack('حصلت مشكلة غير متوقعة، جرّب تاني', color: AppColors.debtRed);
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
      p('بنفتح حسابات جوجل…', null);
      return _service.signIn();
    });
    if (session == null || !mounted) return;
    _snack('اتسجّل الدخول بـ ${session.email} ✓', color: AppColors.paymentGreen);
    await _backup();
  }

  Future<void> _backup() async {
    final result = await _run((p) => _service.backupNow(onProgress: p));
    if (result == null || !mounted) return;
    if (result.rejected > 0) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('النسخة اترفعت مع ملاحظات ⚠️'),
          content: Text(
            'اترفع ${result.uploaded} سجل، و ${result.rejected} سجل اترفض:\n\n${result.rejectReasons.join('\n')}',
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('حسناً'))],
        ),
      );
    } else {
      _snack(
        result.uploaded == 0 ? 'كل بياناتك متخزنة على السحابة بالفعل ✓' : 'اترفع ${result.uploaded} سجل على السحابة ✓',
        color: AppColors.paymentGreen,
      );
    }
  }

  Future<void> _restore() async {
    final shops = await _run((p) {
      p('بنجيب المحلات اللي على حسابك…', null);
      return _service.listCloudShops();
    });
    if (shops == null || !mounted) return;
    if (shops.isEmpty) {
      _snack('مفيش نسخة على السحابة للحساب ده لسه');
      return;
    }

    Map<String, dynamic>? shop = shops.first;
    if (shops.length > 1) {
      shop = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (ctx) => SimpleDialog(
          title: const Text('اختار المحل'),
          children: [
            for (final s in shops)
              SimpleDialogOption(
                onPressed: () => Navigator.pop(ctx, s),
                child: Text('${s['name']}${s['role'] == 'employee' ? ' (عامل)' : ''}'),
              ),
          ],
        ),
      );
      if (shop == null || !mounted) return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('استرجاع من السحابة؟'),
        content: Text(
          'هنستبدل كل البيانات اللي على الموبايل ده بنسخة "${shop!['name']}" اللي على السحابة.\n\n'
          'لو فيه بيانات على الموبايل ده مش مرفوعة، هتضيع. قفل التطبيق (PIN والبصمة) هيفضل زي ما هو.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.debtRed, foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('أيوه، استرجع'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final result = await _run((p) => _service.restore(shop!, onProgress: p));
    if (result == null || !mounted) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('تم الاسترجاع 🎉'),
        content: Text('اترجع ${result.records} سجل. اقفل التطبيق وافتحه تاني عشان كل الشاشات تتحدث.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              SystemNavigator.pop();
            },
            child: const Text('اقفل التطبيق'),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تسجيل خروج؟'),
        content: const Text('بياناتك هتفضل على الموبايل وعلى السحابة. بس النسخ هيقف لحد ما تسجّل دخول تاني.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('خروج')),
        ],
      ),
    );
    if (ok != true) return;
    await _run((p) => _service.signOut());
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
              : const [
                  ListTile(
                    leading: Icon(Icons.cloud_off_rounded, color: AppColors.neutralGrey),
                    title: Text('النسخ على السحابة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    subtitle: Text('مش متاح في النسخة دي من التطبيق', style: TextStyle(fontSize: 12, color: AppColors.neutralGrey)),
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
          title: const Text('النسخ الاحتياطي على السحابة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          subtitle: const Text(
            'سجّل بحساب جوجل وبياناتك تتحفظ أونلاين. لو الموبايل ضاع، ترجّعها على أي موبايل تاني.',
            style: TextStyle(fontSize: 12, color: AppColors.neutralGrey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _busy ? null : _signIn,
              icon: const Icon(Icons.account_circle_rounded),
              label: const Text('سجّل دخول بحساب جوجل', style: TextStyle(fontWeight: FontWeight.bold)),
              style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
            ),
          ),
        ),
      ];

  List<Widget> _signedInTiles(CloudSession session) {
    final last = session.lastBackupAt;
    final lastText = last == null ? 'لسه مفيش نسخة' : 'آخر نسخة: ${DateFormat('yyyy/MM/dd - hh:mm a').format(last)}';
    return [
      ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.paymentGreenLight,
          child: Icon(Icons.cloud_done_rounded, color: AppColors.paymentGreen),
        ),
        title: Text(session.email, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(lastText, style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey)),
      ),
      const Divider(height: 1),
      ListTile(
        enabled: !_busy,
        leading: const Icon(Icons.cloud_upload_rounded, color: AppColors.primaryBlue),
        title: const Text('ارفع نسخة احتياطية دلوقتي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        trailing: const Icon(Icons.chevron_left_rounded),
        onTap: _backup,
      ),
      const Divider(height: 1),
      ListTile(
        enabled: !_busy,
        leading: const Icon(Icons.cloud_download_rounded, color: AppColors.warningAmber),
        title: const Text('استرجع بياناتك على الموبايل ده', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: const Text('لموبايل جديد أو بعد مسح التطبيق', style: TextStyle(fontSize: 12, color: AppColors.neutralGrey)),
        trailing: const Icon(Icons.chevron_left_rounded),
        onTap: _restore,
      ),
      const Divider(height: 1),
      ListTile(
        enabled: !_busy,
        leading: const Icon(Icons.logout_rounded, color: AppColors.neutralGrey),
        title: const Text('تسجيل خروج', style: TextStyle(fontSize: 14)),
        onTap: _signOut,
      ),
    ];
  }
}
