// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'كشكول';

  @override
  String get navCustomers => 'العملاء';

  @override
  String get navCollection => 'التحصيل';

  @override
  String get navSuppliers => 'الموردين';

  @override
  String get navCashDrawer => 'الدرج';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get debt => 'عليه';

  @override
  String get payment => 'دفع';

  @override
  String get settled => 'خالصين';

  @override
  String get currency => 'جنيه';

  @override
  String get piaster => 'قرش';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get search => 'بحث...';

  @override
  String placeholderScreen(Object screenName) {
    return 'شاشة $screenName';
  }

  @override
  String get comingSoon => 'هتتوفر في الخطوة القادمة إن شاء الله';

  @override
  String get totalReceivablesTitle => 'ليك عند الناس';

  @override
  String get searchCustomersHint => 'ابحث بالاسم أو رقم التليفون...';

  @override
  String get filterAll => 'الكل';

  @override
  String get filterHasDebt => 'عليهم فلوس';

  @override
  String get filterSettled => 'خالصين';

  @override
  String get filterLate => 'متأخرين';

  @override
  String get sortHighestDebt => 'أعلى دين';

  @override
  String get sortName => 'الاسم';

  @override
  String get sortLastActivity => 'آخر نشاط';

  @override
  String get addNewCustomer => 'عميل جديد';

  @override
  String get addCustomer => 'إضافة عميل';

  @override
  String get editCustomer => 'تعديل العميل';

  @override
  String get customerName => 'اسم العميل';

  @override
  String get customerNameHint => 'مثلاً: عم محمد البقال';

  @override
  String get customerNameRequired => 'اسم العميل مطلوب';

  @override
  String get customerNameTooShort => 'الاسم يجب ألا يقل عن حرفين';

  @override
  String get customerPhone => 'رقم الموبايل';

  @override
  String get customerPhoneHint => '010xxxxxxxx';

  @override
  String get customerPhoneInvalid =>
      'رقم الموبايل غير صحيح (010, 011, 012, 015)';

  @override
  String get customerNotes => 'ملاحظات';

  @override
  String get customerNotesHint => 'مثلاً: جار الدور التاني';

  @override
  String get creditLimit => 'حد الدين (اختياري)';

  @override
  String get creditLimitHint => 'مثلاً: 1000';

  @override
  String get noCustomersTitle => 'دفترك فاضي!';

  @override
  String get noCustomersSubtitle =>
      'اضغط على الزرار تحت وضيف أول عميل عشان تبدأ تتابع حساباته بسهولة';

  @override
  String get noSearchResults => 'مفيش عملاء بالاسم أو الرقم ده';

  @override
  String get duplicateCustomerWarning =>
      'تنبيه: يوجد عميل مسجل بالفعل بنفس الاسم أو رقم التليفون';

  @override
  String get customerDetails => 'بيانات العميل';

  @override
  String get callCustomer => 'اتصال';

  @override
  String get deleteCustomer => 'حذف العميل';

  @override
  String get deleteCustomerConfirm => 'تأكيد حذف العميل';

  @override
  String deleteCustomerWarningDebt(String amount) {
    return 'انتبه! العميل ده لسه عليه حساب قدره $amount. متأكد إنك عاوز تحذفه؟';
  }

  @override
  String deleteCustomerSafeConfirm(String name) {
    return 'هل أنت متأكد من حذف العميل $name؟';
  }

  @override
  String get customerDeleted => 'تم حذف العميل بنجاح';

  @override
  String get customerSaved => 'تم حفظ بيانات العميل بنجاح';

  @override
  String get lastActivityNever => 'مفيش حركات سابقة';

  @override
  String lastActivityDate(String date) {
    return 'آخر حركة: $date';
  }

  @override
  String creditLimitLabel(String amount) {
    return 'حد الدين: $amount';
  }

  @override
  String get creditLimitExceeded => 'تعدى حد الدين!';

  @override
  String get heOwes => 'عليه';

  @override
  String get hePaid => 'له (دافع زيادة)';

  @override
  String get currentBalance => 'الرصيد الحالي';

  @override
  String get noTransactionsYet => 'لا توجد معاملات مسجلة حتى الآن';

  @override
  String get addDebtTitle => 'تسجيل دين جديد (عليه)';

  @override
  String get addPaymentTitle => 'تسجيل سداد (دفع)';

  @override
  String get amountLabel => 'المبلغ';

  @override
  String get amountRequired => 'يرجى إدخال مبلغ صحيح أكبر من صفر';

  @override
  String get today => 'النهارده';

  @override
  String get yesterday => 'إمبارح';

  @override
  String get date => 'التاريخ';

  @override
  String get pickDate => 'تحديد التاريخ';

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get methodCash => 'كاش';

  @override
  String get methodInstapay => 'إنستاباي';

  @override
  String get methodWallet => 'محفظة';

  @override
  String get methodOther => 'أخرى';

  @override
  String get noteOptional => 'ملاحظة (اختياري: سكر، زيت، شحن...)';

  @override
  String get voiceDictation => 'إملاء صوتي';

  @override
  String get listening => 'جاري الاستماع... تكلّم الآن';

  @override
  String get speechNotAvailable => 'الإملاء الصوتي غير متاح في هذا الجهاز';

  @override
  String get attachPhoto => 'إرفاق صورة';

  @override
  String get camera => 'الكاميرا';

  @override
  String get gallery => 'المعرض';

  @override
  String get removePhoto => 'حذف الصورة';

  @override
  String get overpaymentTitle => 'المبلغ أكبر من اللي عليه!';

  @override
  String overpaymentMessage(
    String paidAmount,
    String dueAmount,
    String creditAmount,
  ) {
    return 'المبلغ المدفوع ($paidAmount) أكبر من اللي عليه ($dueAmount). هل تسجل الزيادة ($creditAmount) كرصيد له في حسابه؟';
  }

  @override
  String get overpaymentConfirm => 'نعم، سجّل رصيد له';

  @override
  String get transactionSaved => 'تم تسجيل الحركة بنجاح';

  @override
  String get undo => 'تراجع';

  @override
  String get transactionUndone => 'تم التراجع عن تسجيل الحركة';

  @override
  String get transactionDetails => 'تفاصيل المعاملة';

  @override
  String get editTransaction => 'تعديل المعاملة';

  @override
  String get deleteTransaction => 'حذف المعاملة';

  @override
  String get deleteTransactionConfirm => 'هل أنت متأكد من حذف هذه المعاملة؟';

  @override
  String get transactionDeleted => 'تم حذف المعاملة بنجاح';

  @override
  String get viewPhoto => 'عرض الصورة';

  @override
  String get creditLimitWarningTitle => 'تنبيه حد الدين';

  @override
  String creditLimitExceededDialog(
    String customerName,
    String newTotal,
    String limit,
  ) {
    return '$customerName كده هيبقى عليه $newTotal — مع إن الحد بتاعه $limit';
  }

  @override
  String get saveAnyway => 'سجّل برضه';

  @override
  String get changeLimit => 'غيّر الحد';

  @override
  String get newCreditLimit => 'حد الدين الجديد';

  @override
  String get limitUpdated => 'تم تعديل حد الدين بنجاح';

  @override
  String get totalPayablesTitle => 'عليك للموردين';

  @override
  String get netMarketPosition => 'صافي الموقف المالي';

  @override
  String netReceivables(String amount) {
    return 'صافي ليك في السوق: $amount';
  }

  @override
  String netPayables(String amount) {
    return 'عليك عجز إجمالي: $amount';
  }

  @override
  String get netSettled => 'الحسابات متوازنة (0 جنيه)';

  @override
  String get addNewSupplier => 'مورد جديد';

  @override
  String get addSupplier => 'إضافة مورد';

  @override
  String get editSupplier => 'تعديل المورد';

  @override
  String get supplierName => 'اسم المندوب / المورد';

  @override
  String get supplierNameHint => 'مثلاً: عماد مندوب جهينة';

  @override
  String get supplierNameRequired => 'اسم المورد مطلوب';

  @override
  String get company => 'اسم الشركة / التوكيل';

  @override
  String get companyHint => 'مثلاً: جهينة، شيبسي، الأهرام';

  @override
  String get visitDay => 'يوم الزيارة الأسبوعي';

  @override
  String get noSpecificDay => 'بدون يوم محدد';

  @override
  String get supplierNotes => 'ملاحظات';

  @override
  String get supplierNotesHint => 'مثلاً: بيعدي الساعة 10 الصبح';

  @override
  String get noSuppliersTitle => 'دفتر الموردين فاضي!';

  @override
  String get noSuppliersSubtitle =>
      'اضغط على الزرار تحت وضيف أول مورد أو شركة بتتعامل معاها';

  @override
  String get noSupplierSearchResults => 'مفيش موردين بالاسم أو الشركة دي';

  @override
  String get searchSuppliersHint => 'ابحث باسم المندوب أو الشركة أو الرقم...';

  @override
  String get supplierDetails => 'بيانات المورد';

  @override
  String get iOweHim => 'عليّا';

  @override
  String get iPaidHim => 'دفعتله';

  @override
  String get deleteSupplier => 'حذف المورد';

  @override
  String get deleteSupplierConfirm => 'تأكيد حذف المورد';

  @override
  String deleteSupplierWarningDebt(String amount) {
    return 'انتبه! المورد ده لسه ليه حساب عندك قدره $amount. متأكد إنك عاوز تحذفه؟';
  }

  @override
  String deleteSupplierSafeConfirm(String name) {
    return 'هل أنت متأكد من حذف المورد $name؟';
  }

  @override
  String get supplierDeleted => 'تم حذف المورد بنجاح';

  @override
  String get supplierSaved => 'تم حفظ بيانات المورد بنجاح';

  @override
  String visitDayPrefix(String day) {
    return 'يوم الزيارة: $day';
  }

  @override
  String get sortCompany => 'الشركة';

  @override
  String get sortVisitDay => 'يوم الزيارة';

  @override
  String get dueCustomersTitle => 'عملاء مستحقين تحصيل';

  @override
  String get totalDueTitle => 'إجمالي المستحق';

  @override
  String dueCustomersCount(int count) {
    return '$count عميل';
  }

  @override
  String dueHeaderSummary(int count, String amount) {
    return 'عندك $count عملاء عليهم $amount';
  }

  @override
  String oldestDebtDays(int days) {
    return 'أقدم دين من $days يوم';
  }

  @override
  String get oldestDebtToday => 'الدين مسجل اليوم';

  @override
  String lastReminderDays(int days) {
    return 'آخر تذكير: من $days يوم';
  }

  @override
  String get lastReminderToday => 'آخر تذكير: اليوم';

  @override
  String get neverReminded => 'لم يتم التذكير بعد';

  @override
  String snoozedUntilDate(String date) {
    return 'مؤجل حتى $date';
  }

  @override
  String get sendWhatsApp => 'واتساب';

  @override
  String get sendSms => 'رسالة SMS';

  @override
  String get moreActions => 'المزيد';

  @override
  String get snooze3Days => 'تأجيل 3 أيام';

  @override
  String get snooze7Days => 'تأجيل أسبوع';

  @override
  String get cancelSnooze => 'إلغاء التأجيل';

  @override
  String get recordCollectionPayment => 'تسجيل سداد';

  @override
  String get didSendMessage => 'هل اتبعتت الرسالة؟';

  @override
  String didSendMessageDesc(String name) {
    return 'هل قمت بإرسال رسالة التذكير للعميل $name عبر واتساب؟';
  }

  @override
  String get yesSent => 'أيوة اتبعتت';

  @override
  String get notSent => 'لأ، متبعتتش';

  @override
  String get reminderMarkedSent => 'تم تسجيل التذكير بنجاح';

  @override
  String get snoozedSuccess => 'تم تأجيل التذكير';

  @override
  String get noDueCustomersTitle => 'مفيش تحصيلات مستحقة النهاردة 🎉';

  @override
  String get noDueCustomersSubtitle =>
      'كل الزباين حساباتهم مظبوطة أو تم تذكيرهم قريباً.';

  @override
  String get whatsAppNotInstalled =>
      'تطبيق واتساب غير مثبت. هل تريد إرسال رسالة SMS بدلاً منه؟';

  @override
  String get openSms => 'إرسال SMS';

  @override
  String get growthFooter => '\nتم الإرسال عبر تطبيق كشكول 📒';

  @override
  String get statementTitle => 'كشف حساب';

  @override
  String get generateStatement => 'استخراج كشف حساب';

  @override
  String get statementAllTime => 'كل المعاملات';

  @override
  String get statementThisMonth => 'هذا الشهر';

  @override
  String get statementCustomRange => 'فترة مخصصة';

  @override
  String get statementFormatA4 => 'ورقة A4';

  @override
  String get statementFormatReceipt => 'إيصال حراري (80mm)';

  @override
  String get dateCol => 'التاريخ';

  @override
  String get descriptionCol => 'البيان';

  @override
  String get debtCol => 'عليه';

  @override
  String get paymentCol => 'دفع';

  @override
  String get balanceCol => 'الرصيد';

  @override
  String get startingBalance => 'رصيد ما قبل الفترة';

  @override
  String get finalBalance => 'الرصيد النهائي';

  @override
  String periodLabel(String period) {
    return 'الفترة: $period';
  }

  @override
  String statementGeneratedAt(String date) {
    return 'تاريخ الاستخراج: $date';
  }

  @override
  String get shareStatement => 'مشاركة كشف الحساب';

  @override
  String get printStatement => 'طباعة';

  @override
  String statementShareSubject(String name) {
    return 'كشف حساب - $name';
  }

  @override
  String get totalDebits => 'إجمالي المشتريات / السلف';

  @override
  String get totalCredits => 'إجمالي المسدد';

  @override
  String get drawerTitle => 'تقفيل الدرج والخزينة';

  @override
  String get todayDrawer => 'درج اليوم';

  @override
  String get expectedInDrawer => 'المفروض في الدرج';

  @override
  String get openingCash => 'رصيد الافتتاح';

  @override
  String get openingCashHint => 'المبلغ اللي بدأت بيه اليوم';

  @override
  String get editOpeningCash => 'تعديل رصيد الافتتاح';

  @override
  String get cashSales => 'مبيعات كاش';

  @override
  String get addCashSales => 'تسجيل مبيعات كاش';

  @override
  String get cashIn => 'داخل الدرج (كاش)';

  @override
  String get digitalIn => 'داخل إلكتروني';

  @override
  String get cashOut => 'خارج من الدرج (كاش)';

  @override
  String get customerPaymentsCash => 'تحصيلات عملاء (كاش)';

  @override
  String get customerPaymentsDigital => 'تحصيلات عملاء (إلكتروني)';

  @override
  String get supplierPaymentsCash => 'دفعات موردين (كاش)';

  @override
  String get expensesCash => 'مصاريف المحل (كاش)';

  @override
  String get addExpense => 'تسجيل مصروف';

  @override
  String get editExpense => 'تعديل المصروف';

  @override
  String get deleteExpense => 'حذف المصروف';

  @override
  String get deleteExpenseConfirm => 'هل أنت متأكد من حذف هذا المصروف؟';

  @override
  String get expenseCategory => 'بند المصروف';

  @override
  String get catRent => 'إيجار';

  @override
  String get catElectricity => 'كهرباء ومرافق';

  @override
  String get catSalary => 'يوميات ومرتبات';

  @override
  String get catSupplies => 'بضاعة ومستلزمات';

  @override
  String get catSupplierPayment => 'دفعة مورد';

  @override
  String get catOther => 'أخرى';

  @override
  String get closeDay => 'قفّل اليوم';

  @override
  String get reopenDay => 'إعادة فتح اليوم';

  @override
  String get reopenDayConfirm => 'هل تريد إعادة فتح هذا اليوم للتعديل عليه؟';

  @override
  String get dayClosedSuccess => 'تم تقفيل اليوم بنجاح';

  @override
  String get dayReopenedSuccess => 'تم إعادة فتح اليوم بنجاح';

  @override
  String get dayIsClosed => 'اليوم مقفول';

  @override
  String get dayIsOpen => 'اليوم مفتوح';

  @override
  String get actualCountLabel => 'المبلغ الفعلي في الدرج';

  @override
  String get actualCountHint => 'اكتب المبلغ اللي عديته في الدرج';

  @override
  String get drawerBalanced => 'الدرج مظبوط تمام 🎉';

  @override
  String get drawerShortage => 'عجز في الدرج';

  @override
  String get drawerSurplus => 'زيادة في الدرج';

  @override
  String differenceAmount(String amount) {
    return 'الفرق: $amount';
  }

  @override
  String get closeDaySummary => 'ملخص تقفيل اليوم';

  @override
  String get confirmCloseDay => 'تأكيد التقفيل';

  @override
  String get historyTab => 'سجل الأيام';

  @override
  String get todayTab => 'الدرج اليوم';

  @override
  String get monthlyTotals => 'إجمالي الشهر';

  @override
  String get monthlySales => 'مبيعات كاش';

  @override
  String get monthlyExpenses => 'مصاريف كاش';

  @override
  String get monthlyNet => 'صافي الدرج';

  @override
  String get drawerNotes => 'ملاحظات التقفيل (اختياري)';

  @override
  String get noExpensesYet => 'مفيش مصاريف متسجلة النهاردة';

  @override
  String get noHistoryYet => 'مفيش أيام سابقة مسجلة';

  @override
  String get expenseAddedSuccess => 'تم تسجيل المصروف بنجاح';

  @override
  String get cashSalesAddedSuccess => 'تم تسجيل المبيعات الكاش بنجاح';

  @override
  String get openingCashUpdatedSuccess => 'تم تعديل رصيد الافتتاح بنجاح';

  @override
  String get dayDetails => 'تفاصيل اليوم';

  @override
  String closedAtTime(String time) {
    return 'تم التقفيل في: $time';
  }

  @override
  String get readOnlyDayNotice =>
      'هذا اليوم مقفول. لإجراء تعديلات اضغط على إعادة فتح اليوم.';

  @override
  String get privacyModeTitle => 'وضع الخصوصية';

  @override
  String get privacyModeSubtitle =>
      'إخفاء مبالغ الفلوس في الشاشة والودجت (••••••)';

  @override
  String get shareAppTitle => 'شارك التطبيق';

  @override
  String get shareAppSubtitle => 'ابعت كشكول لصحابك أصحاب المحلات';

  @override
  String shopCodeLabel(String code) {
    return 'كود المحل: $code';
  }

  @override
  String get growthFooterToggleTitle => 'إخفاء توقيع كشكول من الرسائل';

  @override
  String get growthFooterToggleSubtitle => 'متاح في الباقة المدفوعة 🔒';

  @override
  String get codeCopied => 'تم نسخ الكود';
}
