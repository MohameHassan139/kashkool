import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../data/settings_repository.dart';

/// Settings screen allowing configuration of shop profile, privacy mode, and defaults.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final privacyModeAsync = ref.watch(privacyModeProvider);
    final settingsRepo = ref.watch(settingsRepositoryProvider);

    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        title: Text(l10n.navSettings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Privacy Mode Card
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white,
            child: SwitchListTile(
              secondary: const CircleAvatar(
                backgroundColor: AppColors.warningAmberLight,
                child: Icon(Icons.visibility_off_rounded, color: AppColors.warningAmber),
              ),
              title: Text(
                l10n.privacyModeTitle,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                l10n.privacyModeSubtitle,
                style: const TextStyle(fontSize: 13, color: AppColors.neutralGrey),
              ),
              value: privacyModeAsync.value ?? false,
              onChanged: (val) async {
                await settingsRepo.setPrivacyMode(val);
              },
            ),
          ),
          const SizedBox(height: 16),

          // App Info
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text('كشكول 📒', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                  const SizedBox(height: 4),
                  Text('الإصدار 1.0.0 (Offline-First)', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
