import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/phone.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../customers/presentation/customers_providers.dart';
import '../../../customers/presentation/widgets/rating_badge.dart';

/// Modal dialog for manually selecting specific customers to receive the broadcast.
class ManualCustomerPickerDialog extends ConsumerStatefulWidget {
  final Set<String> initialSelectedIds;

  const ManualCustomerPickerDialog({
    super.key,
    required this.initialSelectedIds,
  });

  @override
  ConsumerState<ManualCustomerPickerDialog> createState() => _ManualCustomerPickerDialogState();
}

class _ManualCustomerPickerDialogState extends ConsumerState<ManualCustomerPickerDialog> {
  late Set<String> _selectedIds;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedIds = Set.from(widget.initialSelectedIds);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final customersAsync = ref.watch(customersListStreamProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 650),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title + Selected Count
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.offersSelectManualCustomers(_selectedIds.length),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final customers = customersAsync.valueOrNull ?? [];
                      final valid = customers.where((c) => c.customer.phone?.trim().isNotEmpty == true).toList();
                      setState(() {
                        if (_selectedIds.length == valid.length) {
                          _selectedIds.clear();
                        } else {
                          _selectedIds = valid.map((c) => c.customer.id).toSet();
                        }
                      });
                    },
                    child: Text(_selectedIds.isEmpty ? l10n.filterAll : l10n.cancel),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Search field
              TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val.trim()),
                decoration: InputDecoration(
                  hintText: l10n.searchCustomersHint,
                  prefixIcon: const Icon(Icons.search),
                  isDense: true,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Customer list
              Expanded(
                child: customersAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text(e.toString())),
                  data: (customers) {
                    final valid = customers.where((c) {
                      final hasPhone = c.customer.phone?.trim().isNotEmpty == true;
                      if (!hasPhone) return false;
                      if (_searchQuery.isEmpty) return true;
                      final nameMatch = c.customer.name.toLowerCase().contains(_searchQuery.toLowerCase());
                      final phoneMatch = c.customer.phone?.contains(_searchQuery) == true;
                      return nameMatch || phoneMatch;
                    }).toList();

                    if (valid.isEmpty) {
                      return Center(
                        child: Text(
                          l10n.noSearchResults,
                          style: theme.textTheme.bodyMedium?.copyWith(color: theme.disabledColor),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: valid.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final item = valid[index];
                        final isSelected = _selectedIds.contains(item.customer.id);

                        return CheckboxListTile(
                          value: isSelected,
                          onChanged: (checked) {
                            setState(() {
                              if (checked == true) {
                                _selectedIds.add(item.customer.id);
                              } else {
                                _selectedIds.remove(item.customer.id);
                              }
                            });
                          },
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.customer.name,
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              CustomerRatingBadge(
                                customerName: item.customer.name,
                                rating: item.rating,
                              ),
                            ],
                          ),
                          subtitle: Text(
                            PhoneUtils.formatDisplay(item.customer.phone),
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.disabledColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                          activeColor: AppColors.paymentGreen,
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Confirm button
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.paymentGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => Navigator.of(context).pop(_selectedIds),
                  child: Text(
                    l10n.save,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
