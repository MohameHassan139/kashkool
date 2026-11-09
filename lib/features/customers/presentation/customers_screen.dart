import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../onboarding/data/shop_repository.dart';
import '../../settings/data/settings_repository.dart';
import '../../suppliers/presentation/suppliers_providers.dart';
import '../domain/customer_filter_sort.dart';
import 'add_edit_customer_screen.dart';
import 'customer_details_screen.dart';
import 'customers_providers.dart';
import 'widgets/customer_list_item.dart';
import 'widgets/receivables_header_card.dart';

/// Primary Customers Ledger Screen.
class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String val) {
    ref.read(customerSearchQueryProvider.notifier).state = val;
  }

  void _clearSearch() {
    _searchController.clear();
    ref.read(customerSearchQueryProvider.notifier).state = '';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final customersAsync = ref.watch(customersListStreamProvider);
    final totalReceivablesAsync = ref.watch(totalReceivablesStreamProvider);
    final netPositionAsync = ref.watch(netMarketPositionStreamProvider);
    final activeFilter = ref.watch(customerFilterProvider);
    final activeSort = ref.watch(customerSortProvider);
    final privacyMode = ref.watch(privacyModeProvider).valueOrNull ?? false;
    final installmentsEnabled = ref.watch(installmentsEnabledProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navCustomers),
        actions: [
          // Installments Quick Entry (visible when enabled for shop)
          if (installmentsEnabled)
            IconButton(
              icon: const Icon(Icons.receipt_long_rounded),
              tooltip: 'نظام الأقساط',
              onPressed: () {
                context.push('/installments');
              },
            ),
          // Quick Privacy Mode Toggle
          IconButton(
            icon: Icon(
              privacyMode ? Icons.visibility_off_rounded : Icons.visibility_rounded,
              color: privacyMode ? AppColors.warningAmber : null,
            ),
            tooltip: 'وضع الخصوصية',
            onPressed: () async {
              await ref.read(settingsRepositoryProvider).setPrivacyMode(!privacyMode);
            },
          ),
          // Sort Options Menu
          PopupMenuButton<CustomerSort>(
            icon: const Icon(Icons.sort_rounded),
            tooltip: 'الترتيب',
            initialValue: activeSort,
            onSelected: (sort) {
              ref.read(customerSortProvider.notifier).state = sort;
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: CustomerSort.highestBalance,
                child: Row(
                  children: [
                    Icon(
                      Icons.trending_down_rounded,
                      color: activeSort == CustomerSort.highestBalance ? theme.colorScheme.primary : null,
                    ),
                    const SizedBox(width: 8),
                    Text(l10n.sortHighestDebt),
                  ],
                ),
              ),
              PopupMenuItem(
                value: CustomerSort.name,
                child: Row(
                  children: [
                    Icon(
                      Icons.sort_by_alpha_rounded,
                      color: activeSort == CustomerSort.name ? theme.colorScheme.primary : null,
                    ),
                    const SizedBox(width: 8),
                    Text(l10n.sortName),
                  ],
                ),
              ),
              PopupMenuItem(
                value: CustomerSort.lastActivity,
                child: Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      color: activeSort == CustomerSort.lastActivity ? theme.colorScheme.primary : null,
                    ),
                    const SizedBox(width: 8),
                    Text(l10n.sortLastActivity),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Receivables Card ("ليك عند الناس")
          totalReceivablesAsync.when(
            data: (total) => ReceivablesHeaderCard(
              totalPiasters: total,
              netPositionPiasters: netPositionAsync.valueOrNull,
            ),
            loading: () => const SizedBox.shrink(),
            error: (err, stack) => const SizedBox.shrink(),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: l10n.searchCustomersHint,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: _clearSearch,
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),

          // Filter Chips Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                FilterChip(
                  label: Text(l10n.filterAll),
                  selected: activeFilter == CustomerFilter.all,
                  onSelected: (_) {
                    ref.read(customerFilterProvider.notifier).state = CustomerFilter.all;
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.filterHasDebt),
                  selected: activeFilter == CustomerFilter.hasDebt,
                  onSelected: (_) {
                    ref.read(customerFilterProvider.notifier).state = CustomerFilter.hasDebt;
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.filterSettled),
                  selected: activeFilter == CustomerFilter.settled,
                  onSelected: (_) {
                    ref.read(customerFilterProvider.notifier).state = CustomerFilter.settled;
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.filterLate),
                  selected: activeFilter == CustomerFilter.late,
                  onSelected: (_) {
                    ref.read(customerFilterProvider.notifier).state = CustomerFilter.late;
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          // Customers List
          Expanded(
            child: customersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text(err.toString())),
              data: (customers) {
                if (customers.isEmpty) {
                  final isSearching = _searchController.text.trim().isNotEmpty ||
                      activeFilter != CustomerFilter.all;

                  return Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isSearching ? Icons.person_search_rounded : Icons.menu_book_rounded,
                            size: 56,
                            color: theme.disabledColor,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            isSearching ? l10n.noSearchResults : l10n.noCustomersTitle,
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          if (!isSearching)
                            Text(
                              l10n.noCustomersSubtitle,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: customers.length,
                  padding: const EdgeInsets.only(bottom: 88, top: 4),
                  itemBuilder: (ctx, index) {
                    final item = customers[index];
                    return CustomerListItem(
                      item: item,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => CustomerDetailsScreen(
                              customerId: item.customer.id,
                            ),
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
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: Text(
          l10n.addNewCustomer,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const AddEditCustomerScreen(),
            ),
          );
        },
      ),
    );
  }
}
