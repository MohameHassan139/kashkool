import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../db/app_database.dart';
import '../growth/growth_footer.dart';
import 'money.dart';
import 'phone.dart';
import '../../l10n/l10n.dart';

/// Utilities for rendering and launching WhatsApp and SMS reminder templates.
abstract final class WhatsAppTemplateUtils {
  static String get defaultFriendlyTemplate =>
      L10n.t.whatsappTemplate1;

  static String get defaultFormalTemplate =>
      L10n.t.whatsappTemplate2;

  static String get defaultInstallmentTemplate =>
      L10n.t.whatsappTemplate3;

  /// Builds the growth footer (with referral link) appended to messages.
  static String growthFooter([String? shopCode]) =>
      '\n\n${GrowthFooter.footerText(shopCode)}';

  /// Renders template string with dynamic values and appends Kashkool growth footer.
  static String render({
    String? template,
    required String customerName,
    String? shopName,
    required int balancePiasters,
    Transaction? lastTransaction,
    String? paymentInfo,
    bool includeGrowthFooter = true,
    String? shopCode,
  }) {
    template ??= defaultFriendlyTemplate;
    shopName ??= L10n.t.main1;
    final balanceStr = MoneyUtils.formatMoney(balancePiasters);
    final dateFmt = DateFormat('yyyy/MM/dd');

    final lastDateStr = lastTransaction != null
        ? dateFmt.format(lastTransaction.occurredAt)
        : '—';

    final lastAmountStr = lastTransaction != null
        ? MoneyUtils.formatMoney(lastTransaction.amountPiasters)
        : '—';

    final payInfoStr = (paymentInfo != null && paymentInfo.trim().isNotEmpty)
        ? paymentInfo.trim()
        : L10n.t.whatsappTemplate4;

    var result = template
        .replaceAll('{customer_name}', customerName)
        .replaceAll('{shop_name}', shopName.trim().isEmpty ? L10n.t.main1 : shopName.trim())
        .replaceAll('{balance}', balanceStr)
        .replaceAll('{last_transaction_date}', lastDateStr)
        .replaceAll('{last_transaction_amount}', lastAmountStr)
        .replaceAll('{payment_info}', payInfoStr);

    if (includeGrowthFooter) {
      result += growthFooter(shopCode);
    }

    return result;
  }

  /// Renders installment reminder template string with dynamic values.
  static String renderInstallmentReminder({
    String? template,
    required String customerName,
    String? shopName,
    required String itemDescription,
    required int installmentNumber,
    required int installmentCount,
    required int amountPiasters,
    required DateTime dueDate,
    required int remainingTotalPiasters,
    String? paymentInfo,
    bool includeGrowthFooter = true,
    String? shopCode,
  }) {
    template ??= defaultInstallmentTemplate;
    shopName ??= L10n.t.main1;
    final dateFmt = DateFormat('yyyy/MM/dd');
    final amountStr = MoneyUtils.formatMoney(amountPiasters);
    final remainingStr = MoneyUtils.formatMoney(remainingTotalPiasters);
    final dueDateStr = dateFmt.format(dueDate);
    final payInfoStr = (paymentInfo != null && paymentInfo.trim().isNotEmpty)
        ? paymentInfo.trim()
        : L10n.t.whatsappTemplate4;

    var result = template
        .replaceAll('{customer_name}', customerName)
        .replaceAll('{shop_name}', shopName.trim().isEmpty ? L10n.t.main1 : shopName.trim())
        .replaceAll('{item}', itemDescription)
        .replaceAll('{installment_number}', installmentNumber.toString())
        .replaceAll('{installment_count}', installmentCount.toString())
        .replaceAll('{amount}', amountStr)
        .replaceAll('{due_date}', dueDateStr)
        .replaceAll('{remaining_total}', remainingStr)
        .replaceAll('{payment_info}', payInfoStr);

    if (includeGrowthFooter) {
      result += growthFooter(shopCode);
    }

    return result;
  }

  /// Builds a valid WhatsApp click-to-chat URL.
  static String? buildWhatsAppUrl({
    required String phone,
    required String message,
  }) {
    final waPhone = PhoneUtils.toWhatsAppFormat(phone);
    if (waPhone == null) return null;

    final encodedMessage = Uri.encodeComponent(message);
    return 'https://wa.me/$waPhone?text=$encodedMessage';
  }

  /// Builds an SMS URI.
  static Uri buildSmsUri({
    required String phone,
    required String message,
  }) {
    final cleanPhone = phone.replaceAll(RegExp(r'\s+'), '');
    return Uri(
      scheme: 'sms',
      path: cleanPhone,
      queryParameters: <String, String>{
        'body': message,
      },
    );
  }

  /// Launches WhatsApp via external application.
  /// Returns `true` if launched successfully, `false` otherwise.
  static Future<bool> launchWhatsApp({
    required String phone,
    required String message,
  }) async {
    final urlStr = buildWhatsAppUrl(phone: phone, message: message);
    if (urlStr == null) return false;

    final uri = Uri.parse(urlStr);
    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (launched) return true;
      return await launchUrl(uri);
    } catch (_) {
      return false;
    }
  }

  /// Launches SMS app with pre-filled message.
  static Future<bool> launchSms({
    required String phone,
    required String message,
  }) async {
    final uri = buildSmsUri(phone: phone, message: message);
    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (launched) return true;
      return await launchUrl(uri);
    } catch (_) {
      return false;
    }
  }
}
