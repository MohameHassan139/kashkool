import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/home_widget_service.dart';
import '../../data/settings_repository.dart';

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
              title: const Text(
                'عرض حساباتك على الشاشة الرئيسية',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                enabled
                    ? 'الويدجت بتعرض ليك عند الناس والمحصّل النهارده من غير ما تفتح التطبيق'
                    : 'الويدجت متوقفة ومش بتعرض أي أرقام',
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
              title: 'ضيف الويدجت الصغيرة',
              subtitle: 'ليك عند الناس بس',
            ),
            const Divider(height: 1),
            _AddWidgetTile(
              enabled: enabled,
              medium: true,
              icon: Icons.dashboard_rounded,
              title: 'ضيف ويدجت ملخص اليوم',
              subtitle: 'ليك عند الناس + المحصّل النهارده + المستحقين + زرار تحصيل',
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
    final messenger = ScaffoldMessenger.of(context);

    final supported = await service.isPinSupported();
    final requested = supported && await service.requestPinWidget(medium: medium);

    if (requested) {
      messenger.showSnackBar(
        const SnackBar(content: Text('وافق على الرسالة اللي ظهرت عشان الويدجت تتضاف للشاشة 👍')),
      );
      return;
    }

    if (!context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('ضيف الويدجت بإيدك 📱'),
        content: const Text(
          'موبايلك مش بيسمح للتطبيق يضيفها لوحده. اعمل كده:\n\n'
          '1. اضغط ضغطة طويلة على مكان فاضي في الشاشة الرئيسية\n'
          '2. اختار "الأدوات" أو "Widgets"\n'
          '3. دوّر على "كشكول" واسحب الويدجت للشاشة',
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('فهمت')),
        ],
      ),
    );
  }
}
