import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/money.dart';
import '../../../shared/widgets/glass_toast.dart';
import '../data/trash_repository.dart';
import '../../../l10n/l10n.dart';

/// "سلة المحذوفات": everything that was deleted, with a button to bring it back.
class TrashScreen extends ConsumerStatefulWidget {
  const TrashScreen({super.key});

  static Future<void> open(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const TrashScreen()));

  @override
  ConsumerState<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends ConsumerState<TrashScreen> {
  TrashKind? _filter;
  final Set<String> _restoring = {};

  // A getter (not const) so the labels follow the current app language.
  static Map<TrashKind?, String> get _filters => <TrashKind?, String>{
    null: L10n.t.installmentsScreen6,
    TrashKind.customer: L10n.t.trashScreen1,
    TrashKind.transaction: L10n.t.trashScreen2,
    TrashKind.supplier: L10n.t.trashScreen3,
    TrashKind.expense: L10n.t.trashScreen4,
    TrashKind.installmentPlan: L10n.t.trashScreen5,
  };

  static IconData _icon(TrashKind kind) => switch (kind) {
        TrashKind.customer => Icons.person_rounded,
        TrashKind.supplier => Icons.local_shipping_rounded,
        TrashKind.transaction => Icons.receipt_rounded,
        TrashKind.expense => Icons.payments_rounded,
        TrashKind.installmentPlan => Icons.event_repeat_rounded,
      };

  Future<void> _restore(TrashItem item) async {
    setState(() => _restoring.add(item.id));
    try {
      await ref.read(trashRepositoryProvider).restore(item);
      if (!mounted) return;
      AppGlassToast.showSuccess(context, L10n.t.trashScreen6(item.title));
    } catch (_) {
      if (!mounted) return;
      AppGlassToast.showError(context, L10n.t.trashScreen7);
    } finally {
      if (mounted) setState(() => _restoring.remove(item.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(trashItemsProvider);
    final dateFormat = DateFormat('yyyy/MM/dd - hh:mm a');

    return Scaffold(
      appBar: AppBar(title: Text(L10n.t.trashScreen8)),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              L10n.t.trashScreen9,
              style: TextStyle(fontSize: 13, height: 1.5),
            ),
          ),
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                for (final entry in _filters.entries)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(entry.value),
                      selected: _filter == entry.key,
                      onSelected: (_) => setState(() => _filter = entry.key),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: itemsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => Center(child: Text(L10n.t.trashScreen10)),
              data: (all) {
                final items = _filter == null ? all : all.where((i) => i.kind == _filter).toList();
                if (items.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Text(
                        L10n.t.trashScreen11,
                        style: TextStyle(fontSize: 16, color: AppColors.neutralGrey),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final busy = _restoring.contains(item.id);
                    final details = [
                      if (item.amountPiasters != null) MoneyUtils.formatMoney(item.amountPiasters!),
                      if (item.subtitle != null && item.subtitle!.trim().isNotEmpty) item.subtitle!,
                    ].join(' · ');
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        child: Icon(_icon(item.kind), color: AppColors.neutralGrey),
                      ),
                      title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        [if (details.isNotEmpty) details, L10n.t.trashScreen12(dateFormat.format(item.deletedAt))].join('\n'),
                        style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey, height: 1.4),
                      ),
                      isThreeLine: details.isNotEmpty,
                      trailing: busy
                          ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                          : TextButton.icon(
                              onPressed: () => _restore(item),
                              icon: const Icon(Icons.restore_rounded),
                              label: Text(L10n.t.trashScreen13),
                            ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Settings entry that opens the trash.
class TrashEntryTile extends ConsumerWidget {
  const TrashEntryTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(trashItemsProvider).valueOrNull?.length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.delete_outline_rounded, color: AppColors.neutralGrey),
          ),
          title: Text(L10n.t.trashScreen14, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          subtitle: Text(
            count == null || count == 0 ? L10n.t.trashScreen15 : L10n.t.trashScreen16(count),
            style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
          ),
          trailing: const Icon(Icons.chevron_left_rounded),
          onTap: () => TrashScreen.open(context),
        ),
      ),
    );
  }
}
