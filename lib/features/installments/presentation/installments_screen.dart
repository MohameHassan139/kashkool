import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/money.dart';
import 'add_installment_plan_screen.dart';
import 'installment_plan_details_screen.dart';
import 'installments_providers.dart';
import 'widgets/installment_plan_card.dart';

/// Primary Installments Management Screen (الأقساط).
class InstallmentsScreen extends ConsumerStatefulWidget {
  const InstallmentsScreen({super.key});

  @override
  ConsumerState<InstallmentsScreen> createState() => _InstallmentsScreenState();
}

class _InstallmentsScreenState extends ConsumerState<InstallmentsScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String val) {
    ref.read(installmentSearchQueryProvider.notifier).state = val;
  }

  void _clearSearch() {
    _searchController.clear();
    ref.read(installmentSearchQueryProvider.notifier).state = '';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final plansAsync = ref.watch(allInstallmentsStreamProvider);
    final statsAsync = ref.watch(installmentSummaryStatsStreamProvider);
    final selectedFilter = ref.watch(installmentStatusFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('نظام الأقساط 📋', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // 1. Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'ابحث باسم العميل، السلعة، الموبايل، أو الضامن...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearSearch,
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),

          // 2. Summary Header Card
          statsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
            data: (stats) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      // Total Remaining Debt
                      Expanded(
                        child: Column(
                          children: [
                            Text('إجمالي الأقساط', style: theme.textTheme.bodySmall, maxLines: 1),
                            const SizedBox(height: 4),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                MoneyUtils.formatMoney(stats.totalRemainingDebtPiasters),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.debtRed),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 32, color: theme.colorScheme.outlineVariant),

                      // Overdue Count
                      Expanded(
                        child: Column(
                          children: [
                            Text('أقساط متأخرة', style: theme.textTheme.bodySmall, maxLines: 1),
                            const SizedBox(height: 4),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${stats.totalOverdueInstallmentsCount}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: stats.totalOverdueInstallmentsCount > 0 ? AppColors.debtRed : AppColors.primaryGreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 32, color: theme.colorScheme.outlineVariant),

                      // Active Plans
                      Expanded(
                        child: Column(
                          children: [
                            Text('خطط نشطة', style: theme.textTheme.bodySmall, maxLines: 1),
                            const SizedBox(height: 4),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${stats.totalActivePlans}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // 3. Status Filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text('الكل'),
                    selected: selectedFilter == null,
                    onSelected: (val) {
                      if (val) ref.read(installmentStatusFilterProvider.notifier).state = null;
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('النشطة ⏳'),
                    selected: selectedFilter == PlanStatus.active,
                    onSelected: (val) {
                      if (val) ref.read(installmentStatusFilterProvider.notifier).state = PlanStatus.active;
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('المكتملة ✓'),
                    selected: selectedFilter == PlanStatus.completed,
                    onSelected: (val) {
                      if (val) ref.read(installmentStatusFilterProvider.notifier).state = PlanStatus.completed;
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('الملغية'),
                    selected: selectedFilter == PlanStatus.cancelled,
                    onSelected: (val) {
                      if (val) ref.read(installmentStatusFilterProvider.notifier).state = PlanStatus.cancelled;
                    },
                  ),
                ],
              ),
            ),
          ),

          // 4. Plans List
          Expanded(
            child: plansAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('خطأ في تحميل الأقساط: $e')),
              data: (plans) {
                if (plans.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 64,
                            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchController.text.isNotEmpty
                                ? 'مفيش أقساط مطابقة للبحث'
                                : 'مفيش خطط أقساط حالياً',
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'اضغط على زرار (+ خطة قسط جديدة) لإنشاء وجدولة أول قسط لعميل.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                    final item = plans[index];
                    return InstallmentPlanCard(
                      item: item,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => InstallmentPlanDetailsScreen(planId: item.plan.id),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('خطة قسط جديدة', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const AddInstallmentPlanScreen(),
            ),
          );
        },
      ),
    );
  }
}
