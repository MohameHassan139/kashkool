import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kashkool/core/constants/app_colors.dart';
import 'package:kashkool/features/cash_drawer/data/cash_drawer_repository.dart';
import 'package:kashkool/l10n/app_localizations.dart';
import 'widgets/drawer_flow_card.dart';
import 'widgets/drawer_history_tab.dart';
import 'widgets/drawer_live_card.dart';
import 'widgets/expenses_list_card.dart';

/// Primary Screen for Cash Drawer Closing and Expense Management.
class CashDrawerScreen extends ConsumerStatefulWidget {
  const CashDrawerScreen({super.key});

  @override
  ConsumerState<CashDrawerScreen> createState() => _CashDrawerScreenState();
}

class _CashDrawerScreenState extends ConsumerState<CashDrawerScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final todaySummaryAsync = ref.watch(todayDrawerSummaryProvider);

    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        title: Text(
          l10n.drawerTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryBlue,
          unselectedLabelColor: AppColors.neutralGrey,
          indicatorColor: AppColors.primaryBlue,
          indicatorWeight: 3,
          tabs: [
            Tab(
              icon: const Icon(Icons.point_of_sale_rounded),
              text: l10n.todayTab,
            ),
            Tab(
              icon: const Icon(Icons.history_rounded),
              text: l10n.historyTab,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. Today's Live Drawer Tab
          todaySummaryAsync.when(
            data: (summary) {
              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(todayDrawerSummaryProvider);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      DrawerLiveCard(summary: summary),
                      const SizedBox(height: 16),
                      DrawerFlowCard(summary: summary),
                      const SizedBox(height: 16),
                      ExpensesListCard(summary: summary),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('حدث خطأ في تحميل بيانات الدرج: $err'),
              ),
            ),
          ),

          // 2. Drawer History Tab
          const DrawerHistoryTab(),
        ],
      ),
    );
  }
}
