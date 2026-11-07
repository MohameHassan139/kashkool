import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/backup/backup_service.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/settings_repository.dart';

/// Warning banner displayed when >= 7 days have passed since the last backup.
class BackupReminderBanner extends ConsumerStatefulWidget {
  const BackupReminderBanner({super.key});

  @override
  ConsumerState<BackupReminderBanner> createState() => _BackupReminderBannerState();
}

class _BackupReminderBannerState extends ConsumerState<BackupReminderBanner> {
  bool _dismissed = false;
  bool _isExporting = false;

  Future<void> _handleBackupNow() async {
    setState(() => _isExporting = true);
    try {
      final backupService = ref.read(backupServiceProvider);
      await backupService.shareBackup();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم تصدير النسخة الاحتياطية بنجاح 👍'),
          backgroundColor: AppColors.paymentGreen,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء النسخ: $e'),
          backgroundColor: AppColors.debtRed,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();

    final isDueAsync = ref.watch(isBackupDueProvider);

    return isDueAsync.maybeWhen(
      data: (isDue) {
        if (!isDue) return const SizedBox.shrink();

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.warningAmberLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.warningAmber, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: AppColors.warningAmber,
                    size: 26,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تنبيه: محتاج تعمل نسخة احتياطية ⚠️',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'فات أكثر من 7 أيام من آخر نسخة. احفظ بياناتك عشان لو التليفون ضاع أو اتغير مفيش أي حساب يضيع.',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textDark,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 20, color: AppColors.neutralGrey),
                    onPressed: () => setState(() => _dismissed = true),
                    tooltip: 'تجاهل مؤقتاً',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: _isExporting ? null : _handleBackupNow,
                  icon: _isExporting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.backup_rounded, size: 18),
                  label: Text(_isExporting ? 'جاري الحفظ...' : 'نسخ احتياطي الآن'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.warningAmber,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}
