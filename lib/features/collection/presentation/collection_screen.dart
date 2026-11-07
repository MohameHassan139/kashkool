import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/whatsapp_template.dart';
import '../../../l10n/app_localizations.dart';
import '../../customers/presentation/customer_details_screen.dart';
import '../../settings/data/settings_repository.dart';
import '../../transactions/presentation/add_transaction_bottom_sheet.dart';
import '../data/collection_repository.dart';
import '../domain/due_customer.dart';
import 'collection_providers.dart';
import 'widgets/collection_header_card.dart';
import 'widgets/collection_list_item.dart';

/// Screen for daily collection reminders, listing customers due for payment with one-tap WhatsApp.
class CollectionScreen extends ConsumerStatefulWidget {
  const CollectionScreen({super.key});

  @override
  ConsumerState<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends ConsumerState<CollectionScreen>
    with WidgetsBindingObserver {
  bool _isPrompting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPendingWhatsAppConfirmation();
    }
  }

  Future<void> _checkPendingWhatsAppConfirmation() async {
    final pending = ref.read(pendingWhatsAppCustomerProvider);
    if (pending == null || _isPrompting || !mounted) return;

    _isPrompting = true;
    final l10n = AppLocalizations.of(context)!;
    final repo = ref.read(collectionRepositoryProvider);

    final sent = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.didSendMessage),
        content: Text(l10n.didSendMessageDesc(pending.customer.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.notSent),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.paymentGreen,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.yesSent),
          ),
        ],
      ),
    );

    if (sent == true && mounted) {
      await repo.markReminderSent(pending.customer.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.reminderMarkedSent),
            backgroundColor: AppColors.paymentGreen,
          ),
        );
      }
    }

    ref.read(pendingWhatsAppCustomerProvider.notifier).state = null;
    _isPrompting = false;
  }

  Future<void> _launchWhatsApp(DueCustomer item) async {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.read(settingsRepositoryProvider);

    final template = await settings.getMessageTemplate();
    final shopName = await settings.getShopName();
    final paymentInfo = await settings.getPaymentInfo();

    final message = WhatsAppTemplateUtils.render(
      template: template,
      customerName: item.customer.name,
      shopName: shopName,
      balancePiasters: item.balancePiasters,
      lastTransaction: item.lastTransaction,
      paymentInfo: paymentInfo,
    );

    ref.read(pendingWhatsAppCustomerProvider.notifier).state = item;

    final launched = await WhatsAppTemplateUtils.launchWhatsApp(
      phone: item.customer.phone!,
      message: message,
    );

    if (!launched && mounted) {
      ref.read(pendingWhatsAppCustomerProvider.notifier).state = null;

      // Offer SMS fallback
      final sendSms = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.whatsAppNotInstalled),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(l10n.openSms),
            ),
          ],
        ),
      );

      if (sendSms == true) {
        await WhatsAppTemplateUtils.launchSms(
          phone: item.customer.phone!,
          message: message,
        );
      }
    }
  }

  Future<void> _launchSms(DueCustomer item) async {
    final settings = ref.read(settingsRepositoryProvider);
    final template = await settings.getMessageTemplate();
    final shopName = await settings.getShopName();
    final paymentInfo = await settings.getPaymentInfo();

    final message = WhatsAppTemplateUtils.render(
      template: template,
      customerName: item.customer.name,
      shopName: shopName,
      balancePiasters: item.balancePiasters,
      lastTransaction: item.lastTransaction,
      paymentInfo: paymentInfo,
    );

    await WhatsAppTemplateUtils.launchSms(
      phone: item.customer.phone!,
      message: message,
    );
  }

  Future<void> _callCustomer(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _handleMenuAction(String action, DueCustomer item) async {
    final l10n = AppLocalizations.of(context)!;
    final repo = ref.read(collectionRepositoryProvider);

    switch (action) {
      case 'snooze_3':
        await repo.snoozeCustomer(item.customer.id, const Duration(days: 3));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.snoozedSuccess),
              backgroundColor: AppColors.warningAmber,
            ),
          );
        }
        break;

      case 'snooze_7':
        await repo.snoozeCustomer(item.customer.id, const Duration(days: 7));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.snoozedSuccess),
              backgroundColor: AppColors.warningAmber,
            ),
          );
        }
        break;

      case 'record_payment':
        if (mounted) {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (ctx) => AddTransactionBottomSheet(
              partyType: PartyType.customer,
              partyId: item.customer.id,
              partyName: item.customer.name,
              currentBalancePiasters: item.balancePiasters,
              creditLimitPiasters: item.customer.creditLimitPiasters,
              initialType: TransactionType.payment,
            ),
          );
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final dueListAsync = ref.watch(dueCustomersStreamProvider);
    final summaryAsync = ref.watch(dueSummaryStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navCollection),
      ),
      body: dueListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(err.toString())),
        data: (dueList) {
          if (dueList.isEmpty) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.paymentGreen.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.celebration_rounded,
                        size: 64,
                        color: AppColors.paymentGreen,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l10n.noDueCustomersTitle,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.noDueCustomersSubtitle,
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

          return Column(
            children: [
              // Summary Header Card
              summaryAsync.when(
                data: (summary) => CollectionHeaderCard(
                  count: summary.count,
                  totalPiasters: summary.totalPiasters,
                ),
                loading: () => const SizedBox.shrink(),
                error: (e, s) => const SizedBox.shrink(),
              ),

              // Due Customers List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 4, bottom: 88),
                  itemCount: dueList.length,
                  itemBuilder: (ctx, idx) {
                    final item = dueList[idx];
                    return CollectionListItem(
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
                      onWhatsApp: () => _launchWhatsApp(item),
                      onSms: () => _launchSms(item),
                      onCall: () => _callCustomer(item.customer.phone!),
                      onActionSelected: (action) => _handleMenuAction(action, item),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
