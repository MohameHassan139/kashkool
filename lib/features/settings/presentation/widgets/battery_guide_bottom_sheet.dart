import 'package:flutter/material.dart';
import '../../../../core/utils/battery_optimization_helper.dart';

class BatteryGuideBottomSheet extends StatefulWidget {
  const BatteryGuideBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const BatteryGuideBottomSheet(),
    );
  }

  @override
  State<BatteryGuideBottomSheet> createState() => _BatteryGuideBottomSheetState();
}

class _BatteryGuideBottomSheetState extends State<BatteryGuideBottomSheet> {
  BrandBatteryGuide? _guide;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final guide = await BatteryOptimizationHelper.getDeviceGuide();
    if (mounted) {
      setState(() {
        _guide = guide;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final guide = _guide;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 48,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.battery_alert_rounded, color: Colors.indigo),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        guide != null
                            ? 'دليل حماية الإشعارات (${guide.brandName})'
                            : 'دليل حماية التنبيهات من الإغلاق',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      if (guide != null)
                        Text(
                          guide.osName,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? const Color(0xFF818CF8) : Colors.indigo[800],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              'تقوم بعض الهواتف (مثل شاومي، ريلمي، إنفينيكس، وهواوي) بإيقاف التطبيقات في الخلفية لتوفير البطارية. لضمان وصول تذكير التحصيل اليومي ومواعيد الأقساط بدقة، يُرجى تطبيق الخطوات التالية:',
              style: TextStyle(
                fontSize: 13,
                color: isDark ? const Color(0xFF9CA3AF) : Colors.grey[700],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            if (_loading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (guide != null)
              ...guide.steps.asMap().entries.map((entry) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF111827) : Colors.grey[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isDark ? const Color(0xFF374151) : Colors.grey.shade200,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 11,
                        backgroundColor: Colors.indigo.withValues(alpha: 0.15),
                        child: Text(
                          '${entry.key + 1}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: const TextStyle(fontSize: 13, height: 1.35),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => BatteryOptimizationHelper.openBatterySettings(),
              icon: const Icon(Icons.tune_rounded, size: 18),
              label: const Text('فتح إعدادات بطارية الهاتف الآن'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
