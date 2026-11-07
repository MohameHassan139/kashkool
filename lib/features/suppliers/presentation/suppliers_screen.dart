import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/supplier_filter_sort.dart';
import 'add_edit_supplier_screen.dart';
import 'supplier_details_screen.dart';
import 'suppliers_providers.dart';
import 'widgets/payables_header_card.dart';
import 'widgets/supplier_list_item.dart';

/// Primary Suppliers & Distributors Ledger Screen.
class SuppliersScreen extends ConsumerStatefulWidget {
  const SuppliersScreen({super.key});

  @override
  ConsumerState<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends ConsumerState<SuppliersScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String val) {
    ref.read(supplierSearchQueryProvider.notifier).state = val;
  }

  void _clearSearch() {
    _searchController.clear();
    ref.read(supplierSearchQueryProvider.notifier).state = '';
  }

  Future<void> _callPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    try {
      await launchUrl(uri);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final suppliersAsync = ref.watch(suppliersListStreamProvider);
    final totalPayablesAsync = ref.watch(totalPayablesStreamProvider);
    final netPositionAsync = ref.watch(netMarketPositionStreamProvider);
    final activeFilter = ref.watch(supplierFilterProvider);
    final activeSort = ref.watch(supplierSortProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navSuppliers),
        actions: [
          // Sort Options Menu
          PopupMenuButton<SupplierSort>(
            icon: const Icon(Icons.sort_rounded),
            tooltip: 'الترتيب',
            initialValue: activeSort,
            onSelected: (sort) {
              ref.read(supplierSortProvider.notifier).state = sort;
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: SupplierSort.highestBalance,
                child: Row(
                  children: [
                    Icon(
                      Icons.trending_down_rounded,
                      color: activeSort == SupplierSort.highestBalance
                          ? AppColors.primaryBlue
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(l10n.sortHighestDebt),
                  ],
                ),
              ),
              PopupMenuItem(
                value: SupplierSort.name,
                child: Row(
                  children: [
                    Icon(
                      Icons.sort_by_alpha_rounded,
                      color: activeSort == SupplierSort.name ? AppColors.primaryBlue : null,
                    ),
                    const SizedBox(width: 8),
                    Text(l10n.sortName),
                  ],
                ),
              ),
              PopupMenuItem(
                value: SupplierSort.company,
                child: Row(
                  children: [
                    Icon(
                      Icons.business_rounded,
                      color: activeSort == SupplierSort.company ? AppColors.primaryBlue : null,
                    ),
                    const SizedBox(width: 8),
                    Text(l10n.sortCompany),
                  ],
                ),
              ),
              PopupMenuItem(
                value: SupplierSort.visitDay,
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: activeSort == SupplierSort.visitDay ? AppColors.primaryBlue : null,
                    ),
                    const SizedBox(width: 8),
                    Text(l10n.sortVisitDay),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Payables Summary Card ("عليك للموردين") with Net Market Position
          totalPayablesAsync.when(
            data: (total) => PayablesHeaderCard(
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
                hintText: l10n.searchSuppliersHint,
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
                  selected: activeFilter == SupplierFilter.all,
                  onSelected: (_) {
                    ref.read(supplierFilterProvider.notifier).state = SupplierFilter.all;
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.filterHasDebt),
                  selected: activeFilter == SupplierFilter.hasDebt,
                  onSelected: (_) {
                    ref.read(supplierFilterProvider.notifier).state = SupplierFilter.hasDebt;
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.filterSettled),
                  selected: activeFilter == SupplierFilter.settled,
                  onSelected: (_) {
                    ref.read(supplierFilterProvider.notifier).state = SupplierFilter.settled;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),

          // Suppliers List
          Expanded(
            child: suppliersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text(err.toString())),
              data: (suppliers) {
                if (suppliers.isEmpty) {
                  final isSearching = _searchController.text.trim().isNotEmpty;
                  return Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isSearching
                                ? Icons.search_off_rounded
                                : Icons.local_shipping_outlined,
                            size: 56,
                            color: theme.disabledColor,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            isSearching
                                ? l10n.noSupplierSearchResults
                                : l10n.noSuppliersTitle,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isSearching ? null : AppColors.debtRed,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            isSearching ? '' : l10n.noSuppliersSubtitle,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.disabledColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 4, bottom: 88),
                  itemCount: suppliers.length,
                  itemBuilder: (ctx, idx) {
                    final item = suppliers[idx];
                    return SupplierListItem(
                      item: item,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => SupplierDetailsScreen(
                              supplierId: item.supplier.id,
                            ),
                          ),
                        );
                      },
                      onCallPhone: (phone) => _callPhone(phone),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.person_add_rounded),
        label: Text(
          l10n.addNewSupplier,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const AddEditSupplierScreen(),
            ),
          );
        },
      ),
    );
  }
}
