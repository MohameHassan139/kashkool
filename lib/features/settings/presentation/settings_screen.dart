import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/backup/backup_service.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/growth/growth_footer.dart';
import '../../../../core/security/pin_lock_screen.dart';
import '../../../../core/security/security_service.dart';
import '../../../../core/utils/money.dart';
import '../../../../l10n/app_localizations.dart';
import '../../onboarding/data/shop_repository.dart';
import '../data/settings_repository.dart';
import 'widgets/backup_reminder_banner.dart';
import 'widgets/battery_guide_bottom_sheet.dart';
import '../../trash/presentation/trash_screen.dart';
import 'widgets/cloud_backup_card.dart';
import 'widgets/home_widget_settings_card.dart';
import 'widgets/message_template_editor_bottom_sheet.dart';
import 'widgets/shop_profile_bottom_sheet.dart';

/// Full Settings screen managing shop profile, security (PIN/biometrics),
/// data backup/restore, reminder templates, theme, and growth sharing.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final privacyModeAsync = ref.watch(privacyModeProvider);
    final shopCodeAsync = ref.watch(shopCodeProvider);
    final hasPinAsync = ref.watch(hasPinProvider);
    final bioEnabledAsync = ref.watch(biometricEnabledProvider);
    final lastBackupAsync = ref.watch(lastBackupAtProvider);
    final themeModeAsync = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navSettings),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // 0. Backup Warning Banner (if >= 7 days)
          const BackupReminderBanner(),

          // 1. بيانات المحل (Shop Info)
          _buildSectionHeader(context, 'بيانات المحل 🏪'),
          _buildShopInfoCard(context, ref),

          // 2. الحماية والخصوصية (Security & Privacy)
          _buildSectionHeader(context, 'الحماية والخصوصية 🔒'),
          _buildSecurityCard(
            context,
            ref,
            privacyModeAsync.valueOrNull ?? false,
            hasPinAsync.valueOrNull ?? false,
            bioEnabledAsync.valueOrNull ?? false,
          ),

          // 2b. ويدجت الشاشة الرئيسية (Home Screen Widget)
          _buildSectionHeader(context, 'ويدجت الشاشة الرئيسية 📱'),
          const HomeWidgetSettingsCard(),

          // 3. التذكيرات ورسائل الواتساب (Reminders)
          _buildSectionHeader(context, 'رسائل التذكير والتحصيل 💬'),
          _buildRemindersCard(context, ref),

          // 4. النسخ الاحتياطي والبيانات (Backup & Data)
          _buildSectionHeader(context, 'النسخ الاحتياطي والبيانات 💾'),
          _buildBackupCard(context, ref, lastBackupAsync.valueOrNull),
          const CloudBackupCard(),
          const TrashEntryTile(),

          // 5. مشاركة التطبيق (Growth)
          _buildSectionHeader(context, 'مشاركة التطبيق 🚀'),
          _buildShareCard(context, ref, l10n, shopCodeAsync.valueOrNull),

          // 6. عام والمظهر (General)
          _buildSectionHeader(context, 'عام ⚙️'),
          _buildGeneralCard(context, ref, themeModeAsync.valueOrNull ?? ThemeMode.system),

          const SizedBox(height: 16),
          // App Version footer
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'كشكول 📒',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'دفتر حسابات المحل بدون نت (Offline-First)\nالإصدار 1.0.0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.brightness == Brightness.dark
                          ? const Color(0xFF9CA3AF)
                          : Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  // --- 1. Shop Info Card ---
  Widget _buildShopInfoCard(BuildContext context, WidgetRef ref) {
    final activeShopAsync = ref.watch(activeShopStreamProvider);
    final shop = activeShopAsync.value;

    String tradeName = 'متجر عام';
    if (shop != null) {
      switch (shop.shopType) {
        case 'grocery':
          tradeName = 'بقالة وسوبرماركت 🛒';
          break;
        case 'mobile':
          tradeName = 'موبايلات وإكسسوارات 📱';
          break;
        case 'electronics':
          tradeName = 'أجهزة كهربائية ومنزلية ⚡';
          break;
        case 'pharmacy':
          tradeName = 'صيدلية ومستحضرات 💊';
          break;
        default:
          tradeName = 'أنشطة وتجارة حرة 🏪';
          break;
      }
    }

    final shopName = shop?.name.isNotEmpty == true ? shop!.name : 'كشكول';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
            child: Icon(Icons.storefront_rounded, color: Theme.of(context).colorScheme.primary),
          ),
          title: Text(
            shopName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(
            '$tradeName • تعديل النشاط وبيانات الدفع',
            style: const TextStyle(fontSize: 13, color: AppColors.neutralGrey),
          ),
          trailing: const Icon(Icons.chevron_left_rounded),
          onTap: () => ShopProfileBottomSheet.show(context),
        ),
      ),
    );
  }

  // --- 2. Security Card ---
  Widget _buildSecurityCard(
    BuildContext context,
    WidgetRef ref,
    bool isPrivacy,
    bool hasPin,
    bool isBioEnabled,
  ) {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final securityService = ref.read(securityServiceProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            // Privacy Mode
            SwitchListTile(
              secondary: CircleAvatar(
                backgroundColor: AppColors.warningAmber.withValues(alpha: 0.15),
                child: const Icon(Icons.visibility_off_rounded, color: AppColors.warningAmber),
              ),
              title: const Text(
                'وضع الخصوصية',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: const Text(
                'إخفاء مبالغ الفلوس في الشاشة والودجت (••••••)',
                style: TextStyle(fontSize: 12, color: AppColors.neutralGrey),
              ),
              value: isPrivacy,
              onChanged: (val) async {
                await settingsRepo.setPrivacyMode(val);
              },
            ),
            const Divider(height: 1),

            // PIN Lock ListTile with clean badge + chevron
            ListTile(
              leading: CircleAvatar(
                backgroundColor: hasPin
                    ? AppColors.paymentGreen.withValues(alpha: 0.15)
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.lock_rounded,
                  color: hasPin
                      ? AppColors.paymentGreen
                      : AppColors.secondaryText(Theme.of(context).brightness == Brightness.dark),
                ),
              ),
              title: const Text(
                'قفل التطبيق برمز PIN (4 أرقام)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                hasPin ? 'مفعّل ومحمي (اضغط للإلغاء)' : 'غير مفعّل (اضغط للتعيين)',
                style: TextStyle(
                  fontSize: 12,
                  color: hasPin ? AppColors.paymentGreen : AppColors.neutralGrey,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    hasPin ? 'مفعّل 🔒' : 'إعداد',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: hasPin ? AppColors.paymentGreen : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.chevron_left_rounded),
                ],
              ),
              onTap: () async {
                if (hasPin) {
                  // Confirm current PIN before removing
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PinLockScreen(
                        mode: PinLockMode.unlock,
                        onSuccess: () async {
                          Navigator.of(context).pop();
                          await securityService.removePin();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم إلغاء قفل التطبيق بنجاح')),
                            );
                          }
                        },
                        onCancel: () => Navigator.of(context).pop(),
                      ),
                    ),
                  );
                } else {
                  // Setup PIN
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PinLockScreen(
                        mode: PinLockMode.setup,
                        onSuccess: () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('تم تعيين رمز الدخول بنجاح 🔒'),
                              backgroundColor: AppColors.paymentGreen,
                            ),
                          );
                        },
                        onCancel: () => Navigator.of(context).pop(),
                      ),
                    ),
                  );
                }
              },
            ),

            if (hasPin) ...[
              const Divider(height: 1),
              // Biometric Lock
              SwitchListTile(
                secondary: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                  child: Icon(Icons.fingerprint_rounded, color: Theme.of(context).colorScheme.primary),
                ),
                title: const Text(
                  'فتح بالبصمة / Face ID',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                subtitle: const Text(
                  'استخدام البصمة بدلاً من كتابة الرمز كل مرة',
                  style: TextStyle(fontSize: 12, color: AppColors.neutralGrey),
                ),
                value: isBioEnabled,
                onChanged: (val) async {
                  if (val) {
                    final canBio = await securityService.isBiometricsAvailable();
                    if (!canBio) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('جهازك لا يدعم التحقق بالبصمة حالياً')),
                        );
                      }
                      return;
                    }
                  }
                  await securityService.setBiometricEnabled(val);
                },
              ),
              const Divider(height: 1),
              // Lock Timeout Selection
              FutureBuilder<int>(
                future: settingsRepo.getLockTimeoutMinutes(),
                builder: (context, snapshot) {
                  final timeout = snapshot.data ?? 0;
                  final timeoutLabel = switch (timeout) {
                    1 => 'دقيقة واحدة',
                    5 => '5 دقائق',
                    15 => '15 دقيقة',
                    _ => 'فوراً',
                  };
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.timer_outlined, color: Colors.white),
                    ),
                    title: const Text(
                      'مدة القفل التلقائي',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    subtitle: Text(
                      timeout == 0 ? 'فور الخروج من التطبيق' : 'بعد $timeout دقيقة من الخروج',
                      style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(timeoutLabel, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_left_rounded),
                      ],
                    ),
                    onTap: () => _showLockTimeoutDialog(context, ref, timeout),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showLockTimeoutDialog(BuildContext context, WidgetRef ref, int currentTimeout) {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('مدة القفل التلقائي', style: TextStyle(fontWeight: FontWeight.bold)),
        children: [
          for (final option in [
            (0, 'فوراً عند الخروج'),
            (1, 'بعد دقيقة واحدة'),
            (5, 'بعد 5 دقائق'),
            (15, 'بعد 15 دقيقة'),
          ])
            ListTile(
              leading: Icon(
                currentTimeout == option.$1 ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: currentTimeout == option.$1 ? theme.colorScheme.primary : null,
              ),
              title: Text(option.$2),
              onTap: () async {
                await settingsRepo.setLockTimeoutMinutes(option.$1);
                if (ctx.mounted) Navigator.pop(ctx);
              },
            ),
        ],
      ),
    );
  }

  // --- 3. Reminders Card ---
  Widget _buildRemindersCard(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                child: Icon(Icons.edit_note_rounded, color: Theme.of(context).colorScheme.primary),
              ),
              title: const Text(
                'صيغة رسالة التذكير',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: const Text(
                'تعديل نص الرسالة التلقائية للعملاء والمعاينة الحية',
                style: TextStyle(fontSize: 12, color: AppColors.neutralGrey),
              ),
              trailing: const Icon(Icons.chevron_left_rounded),
              onTap: () => MessageTemplateEditorBottomSheet.show(context),
            ),
            const Divider(height: 1),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.indigo.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.battery_alert_rounded, color: Colors.indigo, size: 22),
              ),
              title: const Text(
                'حماية التنبيهات من الإغلاق في الخلفية',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: const Text(
                'دليل عملي لضمان وصول التذكيرات لأجهزة شاومي، ريلمي، وإنفينيكس',
                style: TextStyle(fontSize: 12, color: AppColors.neutralGrey),
              ),
              trailing: const Icon(Icons.chevron_left_rounded),
              onTap: () => BatteryGuideBottomSheet.show(context),
            ),
          ],
        ),
      ),
    );
  }

  // --- 4. Backup Card ---
  Widget _buildBackupCard(BuildContext context, WidgetRef ref, DateTime? lastBackup) {
    final dateStr = lastBackup != null
        ? DateFormat('yyyy/MM/dd - hh:mm a').format(lastBackup)
        : 'لم يتم تصدير نسخة حتى الآن';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            // Status row
            ListTile(
              leading: CircleAvatar(
                backgroundColor: lastBackup != null
                    ? AppColors.paymentGreen.withValues(alpha: 0.15)
                    : AppColors.warningAmber.withValues(alpha: 0.15),
                child: Icon(
                  Icons.history_rounded,
                  color: lastBackup != null ? AppColors.paymentGreen : AppColors.warningAmber,
                ),
              ),
              title: const Text(
                'آخر نسخة احتياطية',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                dateStr,
                style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
              ),
            ),
            const Divider(height: 1),

            // Export button
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                child: Icon(Icons.upload_file_rounded, color: Theme.of(context).colorScheme.primary),
              ),
              title: const Text(
                'تصدير نسخة احتياطية (.kashkool)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: const Text(
                'حفظ نسخة من الدفتر والصور وإرسالها على الواتساب أو درايف',
                style: TextStyle(fontSize: 12, color: AppColors.neutralGrey),
              ),
              trailing: const Icon(Icons.share_rounded),
              onTap: () async {
                try {
                  final backupService = ref.read(backupServiceProvider);
                  await backupService.shareBackup();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم تصدير النسخة بنجاح 👍'),
                        backgroundColor: AppColors.paymentGreen,
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('فشل التصدير: $e'), backgroundColor: AppColors.debtRed),
                    );
                  }
                }
              },
            ),
            const Divider(height: 1),

            // Import button
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.warningAmber.withValues(alpha: 0.15),
                child: const Icon(Icons.download_rounded, color: AppColors.warningAmber),
              ),
              title: const Text(
                'استعادة نسخة احتياطية',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: const Text(
                'استرجاع الحسابات والصور من ملف .kashkool تم حفظه مسبقاً',
                style: TextStyle(fontSize: 12, color: AppColors.neutralGrey),
              ),
              trailing: const Icon(Icons.folder_open_rounded),
              onTap: () => _handleRestoreBackup(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRestoreBackup(BuildContext context, WidgetRef ref) async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.any,
      );

      if (result.isEmpty || result.first.path == null) return;
      final file = File(result.first.path!);

      final backupService = ref.read(backupServiceProvider);
      final validation = await backupService.validateBackup(file);

      if (!validation.isValid) {
        if (context.mounted) {
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('الملف غير صالح ❌'),
              content: Text(validation.errorMessage ?? 'الملف المحدد ليس نسخة صالحة لتطبيق كشكول.'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('حسناً')),
              ],
            ),
          );
        }
        return;
      }

      // Valid backup: confirm overwrite
      if (context.mounted) {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: AppColors.debtRed),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'تأكيد استعادة النسخة',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'انتبه: الاستعادة ستستبدل كل البيانات الحالية المسجلة في التطبيق بالبيانات الموجودة في الملف.',
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.debtRed),
                ),
                const SizedBox(height: 12),
                if (validation.exportedAt != null)
                  Text('تاريخ النسخة: ${DateFormat('yyyy/MM/dd hh:mm a').format(validation.exportedAt!)}'),
                Text('عدد الصور المرفقة: ${validation.photosCount}'),
                Text('حجم الملف: ${(validation.fileSizeBytes / 1024).toStringAsFixed(1)} ك.ب'),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.debtRed),
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('نعم، استبدل واسترجع البيانات'),
              ),
            ],
          ),
        );

        if (confirmed == true) {
          await backupService.importBackup(file);
          if (context.mounted) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => AlertDialog(
                title: const Text('تمت الاستعادة بنجاح 🎉'),
                content: const Text(
                  'تم استرجاع جميع الحسابات والمعاملات والصور بنجاح. يرجى إعادة تشغيل التطبيق لتحديث كل الشاشات.',
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      SystemNavigator.pop();
                    },
                    child: const Text('إعادة التشغيل الآن'),
                  ),
                ],
              ),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في الاستعادة: $e'), backgroundColor: AppColors.debtRed),
        );
      }
    }
  }

  // --- 5. Share Card ---
  Widget _buildShareCard(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    String? shopCode,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            ListTile(
              minVerticalPadding: 14,
              leading: CircleAvatar(
                backgroundColor: AppColors.paymentGreen.withValues(alpha: 0.15),
                child: const Icon(Icons.share_rounded, color: AppColors.paymentGreen),
              ),
              title: Text(
                l10n.shareAppTitle,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                shopCode != null
                    ? '${l10n.shareAppSubtitle}\n${l10n.shopCodeLabel(shopCode)}'
                    : l10n.shareAppSubtitle,
                style: const TextStyle(fontSize: 13, color: AppColors.neutralGrey),
              ),
              trailing: const Icon(Icons.chevron_left_rounded),
              onTap: () async {
                final code = await ref.read(shopCodeProvider.future);
                await SharePlus.instance.share(
                  ShareParams(text: GrowthFooter.shareMessage(code)),
                );
              },
              onLongPress: () async {
                if (shopCode == null) return;
                await Clipboard.setData(ClipboardData(text: shopCode));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.codeCopied)),
                  );
                }
              },
            ),
            const Divider(height: 1),
            // Locked in Free tier
            SwitchListTile(
              secondary: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.lock_rounded,
                  color: AppColors.secondaryText(Theme.of(context).brightness == Brightness.dark),
                ),
              ),
              title: Text(
                l10n.growthFooterToggleTitle,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                l10n.growthFooterToggleSubtitle,
                style: const TextStyle(fontSize: 13, color: AppColors.neutralGrey),
              ),
              value: false,
              onChanged: null,
            ),
          ],
        ),
      ),
    );
  }

  // --- 6. General Card ---
  Widget _buildGeneralCard(BuildContext context, WidgetRef ref, ThemeMode currentTheme) {
    final themeLabel = switch (currentTheme) {
      ThemeMode.dark => 'داكن 🌙',
      ThemeMode.light => 'فاتح ☀️',
      _ => 'تلقائي',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            // Theme selector with dialog
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                child: Icon(Icons.palette_outlined, color: Theme.of(context).colorScheme.primary),
              ),
              title: const Text(
                'مظهر التطبيق',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                currentTheme == ThemeMode.system
                    ? 'تلقائي (حسب نظام الجهاز)'
                    : (currentTheme == ThemeMode.dark ? 'داكن 🌙' : 'فاتح ☀️'),
                style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(themeLabel, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(width: 4),
                  const Icon(Icons.chevron_left_rounded),
                ],
              ),
              onTap: () => _showThemeDialog(context, ref, currentTheme),
            ),
            const Divider(height: 1),

            // Default credit limit
            Consumer(
              builder: (context, ref, _) {
                final settingsRepo = ref.watch(settingsRepositoryProvider);
                return FutureBuilder<int?>(
                  future: settingsRepo.getDefaultCreditLimitPiasters(),
                  builder: (context, snapshot) {
                    final limitPiasters = snapshot.data;
                    final limitStr = limitPiasters != null ? MoneyUtils.formatMoney(limitPiasters) : 'غير محدد';
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.credit_card_rounded,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      title: const Text(
                        'حد الدين الافتراضي للعميل الجديد',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      subtitle: Text(
                        limitStr,
                        style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
                      ),
                      trailing: const Icon(Icons.edit_outlined),
                      onTap: () => _showEditCreditLimitDialog(context, ref, limitPiasters),
                    );
                  },
                );
              },
            ),
            const Divider(height: 1),

            // Contact us on WhatsApp
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.paymentGreen.withValues(alpha: 0.15),
                child: const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.paymentGreen),
              ),
              title: const Text(
                'تواصل معنا عبر واتساب',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: const Text(
                'للاقتراحات والمساعدة الفنية المباشرة',
                style: TextStyle(fontSize: 12, color: AppColors.neutralGrey),
              ),
              trailing: const Icon(Icons.open_in_new_rounded),
              onTap: () async {
                final uri = Uri.parse('https://wa.me/201000000000?text=السلام%20عليكم%20عندي%20استفسار%20عن%20تطبيق%20كشكول');
                try {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } catch (_) {}
              },
            ),
            const Divider(height: 1),

            // Privacy Policy & Terms
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.privacy_tip_outlined,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              title: const Text(
                'سياسة الخصوصية وشروط الاستخدام',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: const Text(
                'بياناتك ملكك بالكامل ومتخزنة على تليفونك فقط بدون إنترنت',
                style: TextStyle(fontSize: 12, color: AppColors.neutralGrey),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('سياسة الخصوصية في كشكول 🔒'),
                    content: const SingleChildScrollView(
                      child: Text(
                        '1. تطبيق كشكول هو تطبيق يعمل بالكامل بدون اتصال بالإنترنت (Offline-First).\n\n'
                        '2. جميع الحسابات والأسماء وأرقام الهواتف وصور الفواتير والمعاملات مخزنة محلياً على جهازك فقط، ولا يتم إرسال أي بيانات لأي خادم خارجي.\n\n'
                        '3. أنت المسؤول الأول عن عمل نسخة احتياطية بشكل دوري عبر خيار (تصدير نسخة احتياطية) لحفظ بياناتك في حال تغيير أو فقدان الهاتف.\n\n'
                        '4. كشكول صُمم لخدمة أصحاب المحلات والتجار لحفظ حقوقهم وتسهيل متابعة ديونهم بكل أمان.',
                        style: TextStyle(height: 1.5),
                      ),
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('فهمت')),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref, ThemeMode currentTheme) {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('مظهر التطبيق', style: TextStyle(fontWeight: FontWeight.bold)),
        children: [
          for (final option in [
            (ThemeMode.system, 'نظام الجهاز (تلقائي)'),
            (ThemeMode.light, 'فاتح ☀️'),
            (ThemeMode.dark, 'داكن 🌙'),
          ])
            ListTile(
              leading: Icon(
                currentTheme == option.$1 ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: currentTheme == option.$1 ? theme.colorScheme.primary : null,
              ),
              title: Text(option.$2),
              onTap: () async {
                await settingsRepo.setThemeMode(option.$1);
                if (ctx.mounted) Navigator.pop(ctx);
              },
            ),
        ],
      ),
    );
  }

  void _showEditCreditLimitDialog(BuildContext context, WidgetRef ref, int? currentPiasters) {
    final controller = TextEditingController(
      text: currentPiasters != null ? (currentPiasters / 100).toStringAsFixed(0) : '',
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حد الدين الافتراضي (جنيه)'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'المبلغ بالجنيه',
            hintText: 'اتركه فارغاً لجعله غير محدد',
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () async {
              final text = controller.text.trim();
              final pounds = int.tryParse(text);
              final piasters = (pounds != null && pounds > 0) ? pounds * 100 : null;
              final repo = ref.read(settingsRepositoryProvider);
              await repo.setDefaultCreditLimitPiasters(piasters);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}
