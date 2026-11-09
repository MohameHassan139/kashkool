import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/cloud/cloud_config.dart';
import '../../../../core/cloud/cloud_providers.dart';
import '../../../../core/constants/app_colors.dart';
import 'cloud_backup_card.dart';

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
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'حسابك والنسخ على السحابة ☁️',
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
    final signedIn = ref.watch(cloudSessionProvider).valueOrNull != null;
    return IconButton(
      tooltip: signedIn ? 'النسخ على السحابة' : 'سجّل دخول بحساب جوجل',
      onPressed: () => showSheet(context),
      icon: Badge(
        isLabelVisible: !signedIn,
        smallSize: 8,
        backgroundColor: AppColors.debtRed,
        child: Icon(
          signedIn ? Icons.cloud_done_rounded : Icons.cloud_off_rounded,
          color: signedIn ? AppColors.paymentGreen : null,
        ),
      ),
    );
  }
}
