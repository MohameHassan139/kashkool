import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/home_widget_service.dart';
import '../../../../shared/widgets/glass_toast.dart';
import '../../data/settings_repository.dart';
import '../../../../l10n/l10n.dart';

/// Settings section for the home screen widget (Feature 10):
/// an on/off switch plus buttons that add the small or medium widget to the home screen.
class HomeWidgetSettingsCard extends ConsumerWidget {
  const HomeWidgetSettingsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(homeWidgetEnabledProvider).valueOrNull ?? true;
    final settingsRepo = ref.read(settingsRepositoryProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            SwitchListTile(
              secondary: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                child: Icon(Icons.widgets_rounded, color: Theme.of(context).colorScheme.primary),
              ),
              title: Text(
                L10n.t.homeWidgetSettingsCard1,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                enabled
                    ? L10n.t.homeWidgetSettingsCard2
                    : L10n.t.homeWidgetSettingsCard3,
                style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
              ),
              value: enabled,
              onChanged: (val) => settingsRepo.setHomeWidgetEnabled(val),
            ),
            const Divider(height: 1),
            _AddWidgetTile(
              enabled: enabled,
              medium: false,
              icon: Icons.crop_7_5_rounded,
              title: L10n.t.homeWidgetSettingsCard4,
              subtitle: L10n.t.homeWidgetSettingsCard5,
            ),
            const Divider(height: 1),
            _AddWidgetTile(
              enabled: enabled,
              medium: true,
              icon: Icons.dashboard_rounded,
              title: L10n.t.homeWidgetSettingsCard6,
              subtitle: L10n.t.homeWidgetSettingsCard7,
            ),
          ],
        ),
      ),
    );
  }
}

class _AddWidgetTile extends ConsumerWidget {
  final bool enabled;
  final bool medium;
  final IconData icon;
  final String title;
  final String subtitle;

  const _AddWidgetTile({
    required this.enabled,
    required this.medium,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      enabled: enabled,
      leading: CircleAvatar(
        backgroundColor: enabled ? AppColors.paymentGreenLight : Colors.grey.shade100,
        child: Icon(icon, color: enabled ? AppColors.paymentGreen : AppColors.neutralGrey),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey)),
      trailing: const Icon(Icons.add_to_home_screen_rounded),
      onTap: () => _addWidget(context, ref),
    );
  }

  Future<void> _addWidget(BuildContext context, WidgetRef ref) async {
    final service = ref.read(homeWidgetServiceProvider);

    final supported = await service.isPinSupported();
    final requested = supported && await service.requestPinWidget(medium: medium);

    if (requested) {
      if (context.mounted) {
        AppGlassToast.showSuccess(
          context,
          L10n.t.homeWidgetSettingsCard8,
        );
      }
      return;
    }

    if (!context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(L10n.t.homeWidgetSettingsCard9),
        content: Text(
          L10n.t.homeWidgetSettingsCard10,
          style: const TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(L10n.t.ratingExplanationBottomSheet12)),
        ],
      ),
    );
  }
}
