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
import '../../../../shared/widgets/glass_toast.dart';
import '../../onboarding/data/shop_repository.dart';
import '../data/settings_repository.dart';
import 'widgets/backup_reminder_banner.dart';
import 'widgets/battery_guide_bottom_sheet.dart';
import '../../trash/presentation/trash_screen.dart';
import 'widgets/cloud_backup_card.dart';
import 'widgets/home_widget_settings_card.dart';
import 'widgets/message_template_editor_bottom_sheet.dart';
import 'widgets/shop_profile_bottom_sheet.dart';
import '../../../l10n/l10n.dart';

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
          _buildSectionHeader(context, L10n.t.settingsScreen1),
          _buildShopInfoCard(context, ref),

          // 2. الحماية والخصوصية (Security & Privacy)
          _buildSectionHeader(context, L10n.t.settingsScreen2),
          _buildSecurityCard(
            context,
            ref,
            privacyModeAsync.valueOrNull ?? false,
            hasPinAsync.valueOrNull ?? false,
            bioEnabledAsync.valueOrNull ?? false,
          ),

          // 2b. ويدجت الشاشة الرئيسية (Home Screen Widget)
          _buildSectionHeader(context, L10n.t.settingsScreen3),
          const HomeWidgetSettingsCard(),

          // 3. التذكيرات ورسائل الواتساب (Reminders)
          _buildSectionHeader(context, L10n.t.settingsScreen4),
          _buildRemindersCard(context, ref),

          // 4. النسخ الاحتياطي والبيانات (Backup & Data)
          _buildSectionHeader(context, L10n.t.settingsScreen5),
          _buildBackupCard(context, ref, lastBackupAsync.valueOrNull),
          const CloudBackupCard(),
          const TrashEntryTile(),

          // 5. مشاركة التطبيق (Growth)
          _buildSectionHeader(context, L10n.t.settingsScreen6),
          _buildShareCard(context, ref, l10n, shopCodeAsync.valueOrNull),

          // 6. عام والمظهر (General)
          _buildSectionHeader(context, L10n.t.settingsScreen7),
          _buildGeneralCard(context, ref, themeModeAsync.valueOrNull ?? ThemeMode.system),

          const SizedBox(height: 16),
          // App Version footer
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    L10n.t.settingsScreen8,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    L10n.t.settingsScreen9,
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

    String tradeName = L10n.t.settingsScreen10;
    if (shop != null) {
      switch (shop.shopType) {
        case 'grocery':
          tradeName = L10n.t.settingsScreen11;
          break;
        case 'mobile':
          tradeName = L10n.t.settingsScreen12;
          break;
        case 'electronics':
          tradeName = L10n.t.settingsScreen13;
          break;
        case 'pharmacy':
          tradeName = L10n.t.settingsScreen14;
          break;
        default:
          tradeName = L10n.t.settingsScreen15;
          break;
      }
    }

    final shopName = shop?.name.isNotEmpty == true ? shop!.name : L10n.t.main1;

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
            L10n.t.settingsScreen16(tradeName),
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
              title: Text(
                L10n.t.customersScreen2,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                L10n.t.settingsScreen17,
                style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
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
              title: Text(
                L10n.t.settingsScreen18,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                hasPin ? L10n.t.settingsScreen19 : L10n.t.settingsScreen20,
                style: TextStyle(
                  fontSize: 12,
                  color: hasPin ? AppColors.paymentGreen : AppColors.neutralGrey,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    hasPin ? L10n.t.settingsScreen21 : L10n.t.settingsScreen22,
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
                            AppGlassToast.showSuccess(context, L10n.t.settingsScreen23);
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
                          AppGlassToast.showSuccess(context, L10n.t.settingsScreen24);
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
                title: Text(
                  L10n.t.settingsScreen25,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                subtitle: Text(
                  L10n.t.settingsScreen26,
                  style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
                ),
                value: isBioEnabled,
                onChanged: (val) async {
                  if (val) {
                    final canBio = await securityService.isBiometricsAvailable();
                    if (!canBio) {
                      if (context.mounted) {
                        AppGlassToast.showInfo(context, L10n.t.settingsScreen27);
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
                    1 => L10n.t.settingsScreen28,
                    5 => L10n.t.settingsScreen29,
                    15 => L10n.t.settingsScreen30,
                    _ => L10n.t.settingsScreen31,
                  };
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.timer_outlined, color: Colors.white),
                    ),
                    title: Text(
                      L10n.t.settingsScreen32,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    subtitle: Text(
                      timeout == 0 ? L10n.t.settingsScreen33 : L10n.t.settingsScreen34(timeout),
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
        title: Text(L10n.t.settingsScreen32, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [
          for (final option in [
            (0, L10n.t.settingsScreen35),
            (1, L10n.t.settingsScreen36),
            (5, L10n.t.settingsScreen37),
            (15, L10n.t.settingsScreen38),
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
              title: Text(
                L10n.t.settingsScreen39,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                L10n.t.settingsScreen40,
                style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
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
              title: Text(
                L10n.t.settingsScreen41,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                L10n.t.settingsScreen42,
                style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
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
        : L10n.t.settingsScreen43;

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
              title: Text(
                L10n.t.settingsScreen44,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
              title: Text(
                L10n.t.settingsScreen45,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                L10n.t.settingsScreen46,
                style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
              ),
              trailing: const Icon(Icons.share_rounded),
              onTap: () async {
                try {
                  final backupService = ref.read(backupServiceProvider);
                  await backupService.shareBackup();
                  if (context.mounted) {
                    AppGlassToast.showSuccess(context, L10n.t.settingsScreen47);
                  }
                } catch (e) {
                  if (context.mounted) {
                    AppGlassToast.showError(context, L10n.t.settingsScreen48(e));
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
              title: Text(
                L10n.t.settingsScreen49,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                L10n.t.settingsScreen50,
                style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
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
              title: Text(L10n.t.settingsScreen51),
              content: Text(validation.errorMessage ?? L10n.t.settingsScreen52),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx), child: Text(L10n.t.settingsScreen53)),
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
            title: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: AppColors.debtRed),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    L10n.t.settingsScreen54,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  L10n.t.settingsScreen55,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.debtRed),
                ),
                const SizedBox(height: 12),
                if (validation.exportedAt != null)
                  Text(L10n.t.settingsScreen56(DateFormat('yyyy/MM/dd hh:mm a').format(validation.exportedAt!))),
                Text(L10n.t.settingsScreen57(validation.photosCount)),
                Text(L10n.t.settingsScreen58((validation.fileSizeBytes / 1024).toStringAsFixed(1))),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(L10n.t.installmentPlanDetailsScreen11)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.debtRed),
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(L10n.t.settingsScreen59),
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
                title: Text(L10n.t.settingsScreen60),
                content: Text(
                  L10n.t.settingsScreen61,
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      SystemNavigator.pop();
                    },
                    child: Text(L10n.t.settingsScreen62),
                  ),
                ],
              ),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        AppGlassToast.showError(context, L10n.t.settingsScreen63(e));
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
                  AppGlassToast.showSuccess(context, l10n.codeCopied);
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
      ThemeMode.dark => L10n.t.settingsScreen64,
      ThemeMode.light => L10n.t.settingsScreen65,
      _ => L10n.t.settingsScreen66,
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
              title: Text(
                L10n.t.settingsScreen67,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                currentTheme == ThemeMode.system
                    ? L10n.t.settingsScreen68
                    : (currentTheme == ThemeMode.dark ? L10n.t.settingsScreen64 : L10n.t.settingsScreen65),
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

            // App language
            Consumer(
              builder: (context, ref, _) {
                final code = ref.watch(languageCodeProvider).valueOrNull ?? L10n.systemCode;
                final current = L10n.languages.where((l) => l.code == code).firstOrNull;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                    child: Icon(Icons.translate_rounded, color: Theme.of(context).colorScheme.primary),
                  ),
                  title: Text(
                    L10n.t.settingsLanguageTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  subtitle: Text(
                    current?.nativeName ?? L10n.t.settingsLanguageSystem,
                    style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
                  ),
                  trailing: const Icon(Icons.chevron_left_rounded),
                  onTap: () => _showLanguageDialog(context, ref, code),
                );
              },
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
                    final limitStr = limitPiasters != null ? MoneyUtils.formatMoney(limitPiasters) : L10n.t.settingsScreen69;
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.credit_card_rounded,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      title: Text(
                        L10n.t.settingsScreen70,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
              title: Text(
                L10n.t.settingsScreen71,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                L10n.t.settingsScreen72,
                style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
              ),
              trailing: const Icon(Icons.open_in_new_rounded),
              onTap: () async {
                final uri = Uri.parse(L10n.t.settingsScreen73);
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
              title: Text(
                L10n.t.settingsScreen74,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                L10n.t.settingsScreen75,
                style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(L10n.t.settingsScreen76),
                    content: SingleChildScrollView(
                      child: Text(
                        L10n.t.settingsScreen77,
                        style: const TextStyle(height: 1.5),
                      ),
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: Text(L10n.t.ratingExplanationBottomSheet12)),
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

  void _showLanguageDialog(BuildContext context, WidgetRef ref, String currentCode) {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final theme = Theme.of(context);
    final options = <(String, String)>[
      (L10n.systemCode, L10n.t.settingsLanguageSystem),
      for (final l in L10n.languages) (l.code, l.nativeName),
    ];
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(L10n.t.settingsLanguageTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [
          for (final option in options)
            ListTile(
              leading: Icon(
                currentCode == option.$1 ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: currentCode == option.$1 ? theme.colorScheme.primary : null,
              ),
              title: Text(option.$2),
              onTap: () async {
                await settingsRepo.setLanguageCode(option.$1);
                if (ctx.mounted) Navigator.pop(ctx);
              },
            ),
        ],
      ),
    );
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref, ThemeMode currentTheme) {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(L10n.t.settingsScreen67, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [
          for (final option in [
            (ThemeMode.system, L10n.t.settingsScreen78),
            (ThemeMode.light, L10n.t.settingsScreen65),
            (ThemeMode.dark, L10n.t.settingsScreen64),
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
        title: Text(L10n.t.settingsScreen79),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: L10n.t.settingsScreen80,
            hintText: L10n.t.settingsScreen81,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(L10n.t.installmentPlanDetailsScreen11)),
          ElevatedButton(
            onPressed: () async {
              final text = controller.text.trim();
              final pounds = int.tryParse(text);
              final piasters = (pounds != null && pounds > 0) ? pounds * 100 : null;
              final repo = ref.read(settingsRepositoryProvider);
              await repo.setDefaultCreditLimitPiasters(piasters);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: Text(L10n.t.settingsScreen82),
          ),
        ],
      ),
    );
  }
}
