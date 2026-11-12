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
  String get navSuppliers => 'الموردون';

  @override
  String get navCashDrawer => 'الصندوق';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get debt => 'عليه';

  @override
  String get payment => 'دفع';

  @override
  String get settled => 'مُسدَّد';

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
  String placeholderScreen(String screenName) {
    return 'شاشة $screenName';
  }

  @override
  String get comingSoon => 'ستتوفر قريبًا بإذن الله';

  @override
  String get totalReceivablesTitle => 'مستحقاتك لدى العملاء';

  @override
  String get searchCustomersHint => 'ابحث بالاسم أو رقم الهاتف...';

  @override
  String get filterAll => 'الكل';

  @override
  String get filterHasDebt => 'عليهم ديون';

  @override
  String get filterSettled => 'مُسدَّدون';

  @override
  String get filterLate => 'متأخرون';

  @override
  String get sortHighestDebt => 'الأعلى دينًا';

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
  String get customerNameHint => 'مثلًا: محمد البقال';

  @override
  String get customerNameRequired => 'اسم العميل مطلوب';

  @override
  String get customerNameTooShort => 'يجب ألا يقل الاسم عن حرفين';

  @override
  String get customerPhone => 'رقم الهاتف المحمول';

  @override
  String get customerPhoneHint => '010xxxxxxxx';

  @override
  String get customerPhoneInvalid => 'رقم الهاتف غير صحيح';

  @override
  String get customerNotes => 'ملاحظات';

  @override
  String get customerNotesHint => 'مثلًا: جار الطابق الثاني';

  @override
  String get creditLimit => 'حد الدين (اختياري)';

  @override
  String get creditLimitHint => 'مثلًا: 1000';

  @override
  String get noCustomersTitle => 'دفترك فارغ!';

  @override
  String get noCustomersSubtitle =>
      'اضغط على الزر بالأسفل وأضف أول عميل لتبدأ متابعة حساباته بسهولة';

  @override
  String get noSearchResults => 'لا يوجد عملاء بهذا الاسم أو الرقم';

  @override
  String get duplicateCustomerWarning =>
      'تنبيه: يوجد عميل مسجل بالفعل بنفس الاسم أو رقم الهاتف';

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
    return 'تنبيه! ما زال على هذا العميل مبلغ قدره $amount. هل أنت متأكد من حذفه؟';
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
  String get lastActivityNever => 'لا توجد حركات سابقة';

  @override
  String lastActivityDate(String date) {
    return 'آخر حركة: $date';
  }

  @override
  String creditLimitLabel(String amount) {
    return 'حد الدين: $amount';
  }

  @override
  String get creditLimitExceeded => 'تجاوز حد الدين!';

  @override
  String get heOwes => 'عليه';

  @override
  String get hePaid => 'له (دفع زيادة)';

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
  String get today => 'اليوم';

  @override
  String get yesterday => 'أمس';

  @override
  String get date => 'التاريخ';

  @override
  String get pickDate => 'تحديد التاريخ';

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get methodCash => 'نقدًا';

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
  String get listening => 'جارٍ الاستماع... تكلّم الآن';

  @override
  String get speechNotAvailable => 'الإملاء الصوتي غير متاح على هذا الجهاز';

  @override
  String get attachPhoto => 'إرفاق صورة';

  @override
  String get camera => 'الكاميرا';

  @override
  String get gallery => 'المعرض';

  @override
  String get removePhoto => 'حذف الصورة';

  @override
  String get overpaymentTitle => 'المبلغ أكبر من الدين!';

  @override
  String overpaymentMessage(
    String paidAmount,
    String dueAmount,
    String creditAmount,
  ) {
    return 'المبلغ المدفوع ($paidAmount) أكبر من الدين ($dueAmount). هل تسجّل الزيادة ($creditAmount) رصيدًا له في حسابه؟';
  }

  @override
  String get overpaymentConfirm => 'نعم، سجّل رصيدًا له';

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
    return 'سيصبح على $customerName مبلغ $newTotal، مع أن حده $limit';
  }

  @override
  String get saveAnyway => 'سجّل على أي حال';

  @override
  String get changeLimit => 'تغيير الحد';

  @override
  String get newCreditLimit => 'حد الدين الجديد';

  @override
  String get limitUpdated => 'تم تعديل حد الدين بنجاح';

  @override
  String get totalPayablesTitle => 'المستحق عليك للموردين';

  @override
  String get netMarketPosition => 'صافي الموقف المالي';

  @override
  String netReceivables(String amount) {
    return 'صافي مستحقاتك في السوق: $amount';
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
  String get supplierNameHint => 'مثلًا: عماد مندوب جهينة';

  @override
  String get supplierNameRequired => 'اسم المورد مطلوب';

  @override
  String get company => 'اسم الشركة / التوكيل';

  @override
  String get companyHint => 'مثلًا: جهينة، شيبسي، الأهرام';

  @override
  String get visitDay => 'يوم الزيارة الأسبوعي';

  @override
  String get noSpecificDay => 'بدون يوم محدد';

  @override
  String get supplierNotes => 'ملاحظات';

  @override
  String get supplierNotesHint => 'مثلًا: يمر الساعة 10 صباحًا';

  @override
  String get noSuppliersTitle => 'دفتر الموردين فارغ!';

  @override
  String get noSuppliersSubtitle =>
      'اضغط على الزر بالأسفل وأضف أول مورد أو شركة تتعامل معها';

  @override
  String get noSupplierSearchResults => 'لا يوجد موردون بهذا الاسم أو الشركة';

  @override
  String get searchSuppliersHint => 'ابحث باسم المندوب أو الشركة أو الرقم...';

  @override
  String get supplierDetails => 'بيانات المورد';

  @override
  String get iOweHim => 'عليّ';

  @override
  String get iPaidHim => 'دفعتُ له';

  @override
  String get deleteSupplier => 'حذف المورد';

  @override
  String get deleteSupplierConfirm => 'تأكيد حذف المورد';

  @override
  String deleteSupplierWarningDebt(String amount) {
    return 'تنبيه! ما زال لهذا المورد عندك مبلغ قدره $amount. هل أنت متأكد من حذفه؟';
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
  String get dueCustomersTitle => 'عملاء مستحق تحصيلهم';

  @override
  String get totalDueTitle => 'إجمالي المستحق';

  @override
  String dueCustomersCount(int count) {
    return '$count عميل';
  }

  @override
  String dueHeaderSummary(int count, String amount) {
    return 'لديك $count عملاء عليهم $amount';
  }

  @override
  String oldestDebtDays(int days) {
    return 'أقدم دين منذ $days يوم';
  }

  @override
  String get oldestDebtToday => 'الدين مسجل اليوم';

  @override
  String lastReminderDays(int days) {
    return 'آخر تذكير: منذ $days يوم';
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
  String get didSendMessage => 'هل أُرسلت الرسالة؟';

  @override
  String didSendMessageDesc(String name) {
    return 'هل أرسلت رسالة التذكير للعميل $name عبر واتساب؟';
  }

  @override
  String get yesSent => 'نعم، أُرسلت';

  @override
  String get notSent => 'لا، لم تُرسل';

  @override
  String get reminderMarkedSent => 'تم تسجيل التذكير بنجاح';

  @override
  String get snoozedSuccess => 'تم تأجيل التذكير';

  @override
  String get noDueCustomersTitle => 'لا توجد تحصيلات مستحقة اليوم 🎉';

  @override
  String get noDueCustomersSubtitle =>
      'جميع العملاء حساباتهم سليمة أو تم تذكيرهم مؤخرًا.';

  @override
  String get whatsAppNotInstalled =>
      'تطبيق واتساب غير مثبت. هل تريد إرسال رسالة SMS بدلًا منه؟';

  @override
  String get openSms => 'إرسال SMS';

  @override
  String get growthFooter => '\nأُرسلت عبر تطبيق كشكول 📒';

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
  String get totalCredits => 'إجمالي المسدَّد';

  @override
  String get drawerTitle => 'إغلاق الصندوق والخزينة';

  @override
  String get todayDrawer => 'صندوق اليوم';

  @override
  String get expectedInDrawer => 'المفترض في الصندوق';

  @override
  String get openingCash => 'رصيد الافتتاح';

  @override
  String get openingCashHint => 'المبلغ الذي بدأت به اليوم';

  @override
  String get editOpeningCash => 'تعديل رصيد الافتتاح';

  @override
  String get cashSales => 'مبيعات نقدية';

  @override
  String get addCashSales => 'تسجيل مبيعات نقدية';

  @override
  String get cashIn => 'داخل الصندوق (نقدًا)';

  @override
  String get digitalIn => 'وارد إلكتروني';

  @override
  String get cashOut => 'خارج من الصندوق (نقدًا)';

  @override
  String get customerPaymentsCash => 'تحصيلات العملاء (نقدًا)';

  @override
  String get customerPaymentsDigital => 'تحصيلات العملاء (إلكتروني)';

  @override
  String get supplierPaymentsCash => 'دفعات الموردين (نقدًا)';

  @override
  String get expensesCash => 'مصروفات المحل (نقدًا)';

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
  String get catSalary => 'يوميات ورواتب';

  @override
  String get catSupplies => 'بضاعة ومستلزمات';

  @override
  String get catSupplierPayment => 'دفعة مورد';

  @override
  String get catOther => 'أخرى';

  @override
  String get closeDay => 'إغلاق اليوم';

  @override
  String get reopenDay => 'إعادة فتح اليوم';

  @override
  String get reopenDayConfirm => 'هل تريد إعادة فتح هذا اليوم للتعديل عليه؟';

  @override
  String get dayClosedSuccess => 'تم إغلاق اليوم بنجاح';

  @override
  String get dayReopenedSuccess => 'تمت إعادة فتح اليوم بنجاح';

  @override
  String get dayIsClosed => 'اليوم مغلق';

  @override
  String get dayIsOpen => 'اليوم مفتوح';

  @override
  String get actualCountLabel => 'المبلغ الفعلي في الصندوق';

  @override
  String get actualCountHint => 'اكتب المبلغ الذي عددته في الصندوق';

  @override
  String get drawerBalanced => 'الصندوق مضبوط تمامًا 🎉';

  @override
  String get drawerShortage => 'عجز في الصندوق';

  @override
  String get drawerSurplus => 'زيادة في الصندوق';

  @override
  String differenceAmount(String amount) {
    return 'الفرق: $amount';
  }

  @override
  String get closeDaySummary => 'ملخص إغلاق اليوم';

  @override
  String get confirmCloseDay => 'تأكيد الإغلاق';

  @override
  String get historyTab => 'سجل الأيام';

  @override
  String get todayTab => 'صندوق اليوم';

  @override
  String get monthlyTotals => 'إجمالي الشهر';

  @override
  String get monthlySales => 'مبيعات نقدية';

  @override
  String get monthlyExpenses => 'مصروفات نقدية';

  @override
  String get monthlyNet => 'صافي الصندوق';

  @override
  String get drawerNotes => 'ملاحظات الإغلاق (اختياري)';

  @override
  String get noExpensesYet => 'لا توجد مصروفات مسجلة اليوم';

  @override
  String get noHistoryYet => 'لا توجد أيام سابقة مسجلة';

  @override
  String get expenseAddedSuccess => 'تم تسجيل المصروف بنجاح';

  @override
  String get cashSalesAddedSuccess => 'تم تسجيل المبيعات النقدية بنجاح';

  @override
  String get openingCashUpdatedSuccess => 'تم تعديل رصيد الافتتاح بنجاح';

  @override
  String get dayDetails => 'تفاصيل اليوم';

  @override
  String closedAtTime(String time) {
    return 'تم الإغلاق في: $time';
  }

  @override
  String get readOnlyDayNotice =>
      'هذا اليوم مغلق. للتعديل اضغط على إعادة فتح اليوم.';

  @override
  String get privacyModeTitle => 'وضع الخصوصية';

  @override
  String get privacyModeSubtitle => 'إخفاء المبالغ في الشاشة والأداة (••••••)';

  @override
  String get shareAppTitle => 'شارك التطبيق';

  @override
  String get shareAppSubtitle => 'أرسل كشكول لأصدقائك من أصحاب المحلات';

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

  @override
  String get main1 => 'كشكول';

  @override
  String get notebookImportButton1 => 'انقل حساباتك من الدفتر 📒';

  @override
  String get notebookImportButton2 =>
      'لا داعي لنقل كل حركة قديمة: يكفي اسم العميل والمبلغ المستحق عليه الآن.';

  @override
  String get notebookImportButton3 => 'العملاء وحساباتهم';

  @override
  String get notebookImportButton4 =>
      'سطر لكل عميل: الاسم والهاتف والمبلغ المستحق';

  @override
  String get notebookImportButton5 => 'قسط قديم';

  @override
  String get notebookImportButton6 =>
      'السعر، والمدفوع، والأقساط المتبقية وموعد القسط القادم';

  @override
  String get notebookImportButton7 => 'انقل من الدفتر';

  @override
  String get oldInstallmentImportScreen1 => 'موعد القسط القادم';

  @override
  String get oldInstallmentImportScreen2 => 'تم حفظ القسط ✓';

  @override
  String oldInstallmentImportScreen3(
    Object remaining,
    Object countValue,
    Object nextDue,
  ) {
    return 'المتبقي $remaining على $countValue قسط، أولها يوم $nextDue.';
  }

  @override
  String get oldInstallmentImportScreen4 => 'انتهيت';

  @override
  String get oldInstallmentImportScreen5 => 'قسط آخر';

  @override
  String get oldInstallmentImportScreen6 =>
      'حدثت مشكلة في الحفظ، ولم يُحفظ شيء';

  @override
  String get oldInstallmentImportScreen7 => ' شهريًا';

  @override
  String get oldInstallmentImportScreen8 => ' أسبوعيًا';

  @override
  String oldInstallmentImportScreen9(
    Object remaining,
    Object count,
    Object count2,
    Object monthly,
  ) {
    return 'المتبقي $remaining — $count قسط × حوالي $count2$monthly';
  }

  @override
  String get oldInstallmentImportScreen10 => 'قسط قديم من الدفتر';

  @override
  String oldInstallmentImportScreen11(Object savedCount) {
    return 'قسط قديم ($savedCount)';
  }

  @override
  String get oldInstallmentImportScreen12 =>
      'للأقساط التي بدأت قبل التطبيق: اكتب السعر، والمدفوع حتى الآن، وعدد الأقساط المتبقية. سينشئ التطبيق جدول المتبقي فقط، ولن يحسب المدفوع سابقًا في صندوق اليوم.';

  @override
  String get oldInstallmentImportScreen13 => 'العميل';

  @override
  String get oldInstallmentImportScreen14 => 'اسم العميل';

  @override
  String get oldInstallmentImportScreen15 => 'اكتب اسم عميل موجود أو جديد';

  @override
  String get oldInstallmentImportScreen16 => 'اكتب اسم العميل';

  @override
  String get oldInstallmentImportScreen17 =>
      'هاتف العميل (إن كان جديدًا — اختياري)';

  @override
  String get oldInstallmentImportScreen18 => 'رقم الهاتف غير صحيح';

  @override
  String get oldInstallmentImportScreen19 => 'القسط';

  @override
  String get oldInstallmentImportScreen20 => 'السلعة';

  @override
  String get oldInstallmentImportScreen21 => 'مثلًا: ثلاجة توشيبا';

  @override
  String get oldInstallmentImportScreen22 => 'اكتب اسم السلعة';

  @override
  String get oldInstallmentImportScreen23 => 'السعر الإجمالي';

  @override
  String get oldInstallmentImportScreen24 => 'ج';

  @override
  String get oldInstallmentImportScreen25 => 'مطلوب';

  @override
  String get oldInstallmentImportScreen26 => 'غير صحيح';

  @override
  String get oldInstallmentImportScreen27 => 'المدفوع حتى الآن';

  @override
  String get oldInstallmentImportScreen28 => 'يجب أن يكون أقل من السعر';

  @override
  String get oldInstallmentImportScreen29 => 'عدد الأقساط المتبقية';

  @override
  String get oldInstallmentImportScreen30 => 'من 1 إلى 120';

  @override
  String oldInstallmentImportScreen31(Object nextDue) {
    return 'القادم: $nextDue';
  }

  @override
  String get oldInstallmentImportScreen32 => 'شهري';

  @override
  String get oldInstallmentImportScreen33 => 'أسبوعي';

  @override
  String get oldInstallmentImportScreen34 => 'الضامن (اختياري)';

  @override
  String get oldInstallmentImportScreen35 => 'اسم الضامن';

  @override
  String get oldInstallmentImportScreen36 => 'هاتف الضامن';

  @override
  String get oldInstallmentImportScreen37 =>
      'صور من الدفتر أو العقد (اختياري — تبقى على الهاتف)';

  @override
  String get oldInstallmentImportScreen38 =>
      'يمكنك إضافة عدة صور: صفحات الدفتر، والعقد، وبطاقة الضامن…';

  @override
  String oldInstallmentImportScreen39(Object photosLength) {
    return '$photosLength صورة — ستُحفظ في صور العميل';
  }

  @override
  String get oldInstallmentImportScreen40 => 'جارٍ الحفظ…';

  @override
  String get oldInstallmentImportScreen41 => 'احفظ القسط';

  @override
  String get notebookImportScreen1 => 'هذه الحسابات حتى يوم';

  @override
  String notebookImportScreen2(Object firstError, Object error) {
    return 'سطر $firstError: $error';
  }

  @override
  String get notebookImportScreen3 => 'اكتب اسم عميل واحد على الأقل';

  @override
  String get notebookImportScreen4 => 'تم الحفظ ✓';

  @override
  String notebookImportScreen5(Object newCustomers) {
    return '$newCustomers عميل جديد';
  }

  @override
  String notebookImportScreen6(Object existingCustomers) {
    return '$existingCustomers عميل موجود أُضيف المبلغ إلى حسابه';
  }

  @override
  String notebookImportScreen7(Object totalPiasters) {
    return 'الإجمالي: $totalPiasters';
  }

  @override
  String get notebookImportScreen8 => 'صفحة أخرى';

  @override
  String get notebookImportScreen9 => 'الخروج بدون حفظ؟';

  @override
  String get notebookImportScreen10 => 'ما كتبته في هذه الصفحة لن يُحفظ.';

  @override
  String get notebookImportScreen11 => 'متابعة';

  @override
  String get notebookImportScreen12 => 'خروج';

  @override
  String get notebookImportScreen13 => 'انقل الدفتر 📒';

  @override
  String notebookImportScreen14(Object savedPages) {
    return 'انقل الدفتر — صفحة $savedPages';
  }

  @override
  String get notebookImportScreen15 => 'سطر جديد';

  @override
  String notebookImportScreen16(Object validLength) {
    return '$validLength عميل';
  }

  @override
  String get notebookImportScreen17 => 'احفظ';

  @override
  String get notebookImportScreen18 =>
      'اكتب كل عميل في سطر: الاسم، والهاتف إن وُجد، والمبلغ المستحق عليه. اضغط \"التالي\" في لوحة المفاتيح للانتقال بسرعة.';

  @override
  String get notebookImportScreen19 => 'الحساب حتى اليوم';

  @override
  String notebookImportScreen20(Object asOf) {
    return 'حتى $asOf';
  }

  @override
  String get notebookImportScreen21 =>
      'صور صفحة الدفتر (اختياري): تُحفظ مع كل العملاء في الصفحة';

  @override
  String notebookImportScreen22(Object pagePhotosLength) {
    return '$pagePhotosLength صورة للصفحة — ستُحفظ مع كل العملاء في الصفحة';
  }

  @override
  String get notebookImportScreen23 => 'الصفحة';

  @override
  String get notebookImportScreen24 => 'صور لهذا العميل';

  @override
  String get notebookImportScreen25 => 'احذف السطر';

  @override
  String get notebookImportScreen26 => 'الهاتف (اختياري)';

  @override
  String get notebookImportScreen27 => 'المبلغ';

  @override
  String get notebookImportScreen28 => 'جارٍ البحث…';

  @override
  String notebookImportScreen29(Object name) {
    return '\"$name\" موجود لديك — سيُضاف المبلغ إلى حسابه';
  }

  @override
  String get notebookImportScreen30 => 'المبلغ عليه (العميل مدين)';

  @override
  String get notebookImportScreen31 => 'المبلغ له (أنت مدين للعميل)';

  @override
  String get notebookImportScreen32 => 'عليه';

  @override
  String get notebookImportScreen33 => 'له';

  @override
  String get notebookImportService1 => 'رصيد سابق من الدفتر';

  @override
  String get notebookImportService2 => 'صفحة من الدفتر';

  @override
  String get notebookImportService3 => 'الاسم ناقص';

  @override
  String get notebookImportService4 => 'الاسم طويل جدًا';

  @override
  String get notebookImportService5 => 'المبلغ غير صحيح';

  @override
  String get notebookImportService6 => 'لا يمكن أن يكون المدفوع سالبًا';

  @override
  String get notebookImportService7 =>
      'يجب أن يكون المدفوع أقل من السعر الإجمالي';

  @override
  String get notebookImportService8 =>
      'يجب أن يكون عدد الأقساط المتبقية 1 على الأقل';

  @override
  String notebookImportService9(Object paidPiasters) {
    return 'مستورد من الدفتر — مدفوع سابقًا $paidPiasters';
  }

  @override
  String notebookImportService10(Object trim, Object totalPricePiasters) {
    return 'قسط قديم: $trim (المتبقي من $totalPricePiasters)';
  }

  @override
  String notebookImportService11(Object trim) {
    return 'قسط: $trim';
  }

  @override
  String get installmentsScreen1 => 'نظام الأقساط 📋';

  @override
  String get installmentsScreen2 =>
      'ابحث باسم العميل، أو السلعة، أو الهاتف، أو الضامن...';

  @override
  String get installmentsScreen3 => 'إجمالي الأقساط';

  @override
  String get installmentsScreen4 => 'أقساط متأخرة';

  @override
  String get installmentsScreen5 => 'خطط نشطة';

  @override
  String get installmentsScreen6 => 'الكل';

  @override
  String get installmentsScreen7 => 'النشطة ⏳';

  @override
  String get installmentsScreen8 => 'المكتملة ✓';

  @override
  String get installmentsScreen9 => 'الملغاة';

  @override
  String installmentsScreen10(Object e) {
    return 'خطأ في تحميل الأقساط: $e';
  }

  @override
  String get installmentsScreen11 => 'لا توجد أقساط مطابقة للبحث';

  @override
  String get installmentsScreen12 => 'لا توجد خطط أقساط حاليًا';

  @override
  String get installmentsScreen13 =>
      'اضغط زر (+ خطة قسط جديدة) لإنشاء وجدولة أول قسط لعميل.';

  @override
  String get installmentsScreen14 => 'خطة قسط جديدة';

  @override
  String installmentPlanDetailsScreen1(Object instapay) {
    return 'إنستاباي: $instapay';
  }

  @override
  String installmentPlanDetailsScreen2(Object wallet) {
    return 'محفظة/فودافون كاش: $wallet';
  }

  @override
  String installmentPlanDetailsScreen3(Object phoneNum) {
    return 'هاتف: $phoneNum';
  }

  @override
  String get installmentPlanDetailsScreen4 => 'إلغاء خطة القسط';

  @override
  String get installmentPlanDetailsScreen5 =>
      'هل أنت متأكد من إلغاء هذه الخطة؟ ستتوقف التنبيهات مع الاحتفاظ بسجل المدفوعات.';

  @override
  String get installmentPlanDetailsScreen6 => 'رجوع';

  @override
  String get installmentPlanDetailsScreen7 => 'إلغاء الخطة';

  @override
  String get installmentPlanDetailsScreen8 => 'تم إلغاء خطة القسط';

  @override
  String get installmentPlanDetailsScreen9 => 'حذف خطة القسط';

  @override
  String get installmentPlanDetailsScreen10 =>
      'هل أنت متأكد من حذف خطة القسط نهائيًا؟';

  @override
  String get installmentPlanDetailsScreen11 => 'إلغاء';

  @override
  String get installmentPlanDetailsScreen12 => 'حذف';

  @override
  String get installmentPlanDetailsScreen13 => 'تم حذف خطة القسط';

  @override
  String get installmentPlanDetailsScreen14 => 'تفاصيل القسط';

  @override
  String installmentPlanDetailsScreen15(Object e) {
    return 'خطأ: $e';
  }

  @override
  String get installmentPlanDetailsScreen16 => 'خطة القسط غير موجودة أو حُذفت';

  @override
  String get installmentPlanDetailsScreen17 => 'حذف الخطة';

  @override
  String get installmentPlanDetailsScreen18 => 'السعر الإجمالي:';

  @override
  String get installmentPlanDetailsScreen19 => 'المقدم:';

  @override
  String get installmentPlanDetailsScreen20 => 'إجمالي المدفوع:';

  @override
  String get installmentPlanDetailsScreen21 => 'المتبقي:';

  @override
  String get installmentPlanDetailsScreen22 => 'سداد مبكر وتصفية كاملة';

  @override
  String installmentPlanDetailsScreen23(Object guarantorName) {
    return 'الضامن: $guarantorName';
  }

  @override
  String get installmentPlanDetailsScreen24 => 'صورة العقد / إيصال الأمانة';

  @override
  String get installmentPlanDetailsScreen25 =>
      'اضغط لعرض المستند بالحجم الكامل';

  @override
  String get installmentPlanDetailsScreen26 => 'مستند القسط';

  @override
  String installmentPlanDetailsScreen27(Object installmentsLength) {
    return 'جدول الأقساط ($installmentsLength)';
  }

  @override
  String get installmentPlanDetailsScreen28 => 'سداد دفعة حرة';

  @override
  String installmentPlanDetailsScreen29(
    Object installmentIndex,
    Object dueDate,
  ) {
    return 'القسط رقم $installmentIndex • $dueDate';
  }

  @override
  String installmentPlanDetailsScreen30(Object paidPiasters) {
    return 'تم السداد بالكامل ✓ ($paidPiasters)';
  }

  @override
  String installmentPlanDetailsScreen31(
    Object paidPiasters,
    Object amountPiasters,
  ) {
    return 'مدفوع $paidPiasters من $amountPiasters';
  }

  @override
  String get installmentPlanDetailsScreen32 => 'متأخر عن موعده ⚠️';

  @override
  String get installmentPlanDetailsScreen33 => 'مستحق السداد اليوم 🔔';

  @override
  String installmentPlanDetailsScreen34(Object amountPiasters) {
    return 'قادم • $amountPiasters';
  }

  @override
  String get installmentPlanDetailsScreen35 => 'تذكير واتساب';

  @override
  String get installmentPlanDetailsScreen36 => 'سداد';

  @override
  String get addInstallmentPlanScreen1 => 'هاتف محمول';

  @override
  String get addInstallmentPlanScreen2 => 'شاشة تلفاز';

  @override
  String get addInstallmentPlanScreen3 => 'غسالة';

  @override
  String get addInstallmentPlanScreen4 => 'ثلاجة';

  @override
  String get addInstallmentPlanScreen5 => 'موقد غاز';

  @override
  String get addInstallmentPlanScreen6 => 'حاسوب محمول';

  @override
  String get addInstallmentPlanScreen7 => 'دراجة نارية';

  @override
  String get addInstallmentPlanScreen8 => 'أثاث / مفروشات';

  @override
  String get addInstallmentPlanScreen9 => 'يرجى اختيار العميل أولًا';

  @override
  String get addInstallmentPlanScreen10 =>
      'يجب أن يكون المقدم أقل من إجمالي السعر';

  @override
  String get addInstallmentPlanScreen11 =>
      'تم إنشاء خطة القسط وجدولة الأقساط بنجاح ✓';

  @override
  String addInstallmentPlanScreen12(Object e) {
    return 'حدث خطأ: $e';
  }

  @override
  String addInstallmentPlanScreen13(Object e) {
    return 'خطأ في تحميل العملاء: $e';
  }

  @override
  String get addInstallmentPlanScreen14 => 'اختر العميل';

  @override
  String get addInstallmentPlanScreen15 => 'يرجى اختيار العميل';

  @override
  String get addInstallmentPlanScreen16 => 'بيانات السلعة والمبالغ';

  @override
  String get addInstallmentPlanScreen17 => 'اسم السلعة أو المنتج *';

  @override
  String get addInstallmentPlanScreen18 => 'مثلًا: سامسونج A15 128GB';

  @override
  String get addInstallmentPlanScreen19 => 'يجب ألا يقل اسم السلعة عن حرفين';

  @override
  String get addInstallmentPlanScreen20 => 'السعر الإجمالي (جنيه) *';

  @override
  String get addInstallmentPlanScreen21 => 'مثلًا: 12000';

  @override
  String get addInstallmentPlanScreen22 => 'مبلغ غير صحيح';

  @override
  String get addInstallmentPlanScreen23 => 'المقدم (جنيه)';

  @override
  String get addInstallmentPlanScreen24 => 'المبلغ المتبقي للتقسيط:';

  @override
  String get addInstallmentPlanScreen25 => 'المدة ودورية السداد';

  @override
  String addInstallmentPlanScreen26(Object count) {
    return '$count قسط';
  }

  @override
  String get addInstallmentPlanScreen27 => 'عدد الأقساط *';

  @override
  String get addInstallmentPlanScreen28 => 'أدخل عددًا صحيحًا';

  @override
  String get addInstallmentPlanScreen29 => 'الدورية';

  @override
  String get addInstallmentPlanScreen30 => 'تاريخ استحقاق أول قسط';

  @override
  String get addInstallmentPlanScreen31 => 'تغيير التاريخ';

  @override
  String get addInstallmentPlanScreen32 => 'الضامن والمستندات (اختياري)';

  @override
  String get addInstallmentPlanScreen33 => 'مثلًا: محمد السيد إبراهيم';

  @override
  String get addInstallmentPlanScreen34 => 'رقم هاتف الضامن';

  @override
  String get addInstallmentPlanScreen35 => 'رقم الهاتف غير صحيح';

  @override
  String get addInstallmentPlanScreen36 => 'تم التقاط صورة المستند ✓';

  @override
  String get addInstallmentPlanScreen37 =>
      'تصوير العقد / إيصال الأمانة / البطاقة';

  @override
  String get addInstallmentPlanScreen38 => 'اضغط لتغيير الصورة';

  @override
  String get addInstallmentPlanScreen39 =>
      'احفظ صورة العقد للرجوع إليها في أي وقت';

  @override
  String get addInstallmentPlanScreen40 => 'تصوير';

  @override
  String get addInstallmentPlanScreen41 => 'ملاحظات إضافية';

  @override
  String get addInstallmentPlanScreen42 => 'الربط بحساب العميل تلقائيًا';

  @override
  String get addInstallmentPlanScreen43 =>
      'تسجيل السعر الإجمالي دينًا والمقدم دفعةً في حساب العميل العام';

  @override
  String addInstallmentPlanScreen44(Object scheduleLength) {
    return 'معاينة جدول الأقساط ($scheduleLength أقساط)';
  }

  @override
  String addInstallmentPlanScreen45(Object amountPiasters) {
    return 'قيمة القسط: ~$amountPiasters';
  }

  @override
  String get addInstallmentPlanScreen46 => 'حفظ خطة القسط والجدولة';

  @override
  String installmentProgressBar1(
    Object paidCount,
    Object totalCount,
    Object percentInt,
  ) {
    return 'تم سداد $paidCount من $totalCount قسط ($percentInt%)';
  }

  @override
  String installmentProgressBar2(Object remainingPiasters) {
    return 'المتبقي: $remainingPiasters';
  }

  @override
  String get installmentProgressBar3 => 'مُسدَّد بالكامل ✓';

  @override
  String get payInstallmentDialog1 => 'يرجى كتابة مبلغ سداد صحيح أكبر من صفر';

  @override
  String payInstallmentDialog2(Object amountPiasters) {
    return 'تم تسجيل سداد $amountPiasters بنجاح ✓';
  }

  @override
  String payInstallmentDialog3(Object e) {
    return 'حدث خطأ أثناء السداد: $e';
  }

  @override
  String payInstallmentDialog4(Object installmentIndex) {
    return 'سداد القسط رقم $installmentIndex';
  }

  @override
  String payInstallmentDialog5(Object itemDescription) {
    return 'سداد قسط ($itemDescription)';
  }

  @override
  String get payInstallmentDialog6 => 'المبلغ المطلوب للقسط:';

  @override
  String get payInstallmentDialog7 => 'المبلغ المدفوع (جنيه)';

  @override
  String get payInstallmentDialog8 => 'طريقة الدفع';

  @override
  String get payInstallmentDialog9 => 'نقدًا 💵';

  @override
  String get payInstallmentDialog10 => 'إنستاباي ⚡';

  @override
  String get payInstallmentDialog11 => 'محفظة 📱';

  @override
  String get payInstallmentDialog12 => 'تاريخ السداد';

  @override
  String get payInstallmentDialog13 => 'تغيير';

  @override
  String get payInstallmentDialog14 => 'ملاحظة (اختياري)';

  @override
  String get payInstallmentDialog15 => 'مثلًا: تحويل مع فلان';

  @override
  String get payInstallmentDialog16 => 'التسجيل في كشف حساب العميل';

  @override
  String get payInstallmentDialog17 =>
      'يُخصم المبلغ تلقائيًا من رصيد العميل العام';

  @override
  String get payInstallmentDialog18 => 'تأكيد السداد';

  @override
  String earlySettlementDialog1(Object itemDescription) {
    return 'تمت تسوية قسط ($itemDescription) بالكامل بنجاح ✓';
  }

  @override
  String earlySettlementDialog2(Object e) {
    return 'حدث خطأ أثناء التسوية: $e';
  }

  @override
  String get earlySettlementDialog3 => 'سداد مبكر وتصفية القسط';

  @override
  String get earlySettlementDialog4 => 'إجمالي باقي الأقساط:';

  @override
  String get earlySettlementDialog5 => 'المبلغ المطلوب تحصيله:';

  @override
  String get earlySettlementDialog6 => 'خصم تعجيل السداد (جنيه)';

  @override
  String get earlySettlementDialog7 => 'تصفية القسط الآن';

  @override
  String installmentPlanCard1(Object overdueCount) {
    return 'متأخر ($overdueCount)';
  }

  @override
  String get installmentPlanCard2 => 'مكتمل ✓';

  @override
  String get installmentPlanCard3 => 'ملغى';

  @override
  String installmentPlanCard4(Object dueDate, Object paidPiasters) {
    return 'القسط القادم: $dueDate ($paidPiasters)';
  }

  @override
  String installmentPlanCard5(Object totalPricePiasters) {
    return 'الإجمالي: $totalPricePiasters';
  }

  @override
  String get installmentRepository1 => 'يجب ألا يقل وصف السلعة عن حرفين';

  @override
  String get installmentRepository2 => 'يجب أن يكون السعر الإجمالي أكبر من صفر';

  @override
  String get installmentRepository3 => 'لا يمكن أن يكون المقدم سالبًا';

  @override
  String get installmentRepository4 =>
      'يجب أن يكون المقدم أقل من السعر الإجمالي';

  @override
  String get installmentRepository5 => 'يجب أن يكون عدد الأقساط أكبر من صفر';

  @override
  String installmentRepository6(Object trim, Object installmentCount) {
    return 'قسط: $trim ($installmentCount أقساط)';
  }

  @override
  String installmentRepository7(Object trim) {
    return 'مقدم قسط: $trim';
  }

  @override
  String get installmentRepository8 => 'يجب أن يكون مبلغ السداد أكبر من صفر';

  @override
  String installmentRepository9(Object itemDescription, Object notes) {
    return 'سداد قسط: $itemDescription$notes';
  }

  @override
  String get installmentRepository10 => 'خطة القسط غير موجودة';

  @override
  String installmentRepository11(Object itemDescription) {
    return 'سداد مبكر لقسط: $itemDescription';
  }

  @override
  String installmentRepository12(Object itemDescription) {
    return 'خصم تعجيل سداد: $itemDescription';
  }

  @override
  String get collectionScreen1 => 'أقساط مستحقة';

  @override
  String get dueInstallmentsTab1 => 'لا يوجد رقم هاتف مسجل للعميل';

  @override
  String get dueInstallmentsTab2 => 'لا توجد أقساط مستحقة أو متأخرة اليوم 🎉';

  @override
  String get dueInstallmentsTab3 =>
      'جميع عملاء الأقساط منتظمون في السداد حتى الآن.';

  @override
  String dueInstallmentsTab4(Object dueListLength) {
    return 'مطلوب تحصيل ($dueListLength) قسط:';
  }

  @override
  String dueInstallmentsTab5(
    Object itemDescription,
    Object installmentIndex,
    Object installmentCount,
  ) {
    return '$itemDescription • القسط ($installmentIndex من $installmentCount)';
  }

  @override
  String dueInstallmentsTab6(Object daysOverdue) {
    return 'متأخر $daysOverdue يوم';
  }

  @override
  String get dueInstallmentsTab7 => 'مستحق اليوم 🔔';

  @override
  String get dueInstallmentsTab8 => 'اتصال';

  @override
  String get dueInstallmentsTab9 => 'واتساب';

  @override
  String cashDrawerScreen1(Object err) {
    return 'حدث خطأ في تحميل بيانات الصندوق: $err';
  }

  @override
  String drawerLiveCard1(Object notes) {
    return 'ملاحظة: $notes';
  }

  @override
  String expensesListCard1(Object expensesLength) {
    return '$expensesLength مصروف';
  }

  @override
  String get expensesListCard2 => 'إنستاباي';

  @override
  String get expensesListCard3 => 'محفظة';

  @override
  String get drawerFlowCard1 => '(إنستاباي / محفظة)';

  @override
  String addCashSalesBottomSheet1(Object currentSalesPiasters) {
    return 'المبيعات المسجلة حتى الآن: $currentSalesPiasters';
  }

  @override
  String get addCashSalesBottomSheet2 => 'إضافة إلى المبيعات (+)';

  @override
  String get addCashSalesBottomSheet3 => 'تعديل الإجمالي (=)';

  @override
  String get addCashSalesBottomSheet4 => 'المبلغ المراد إضافته';

  @override
  String get addCashSalesBottomSheet5 => 'إجمالي المبيعات الجديد';

  @override
  String addCashSalesBottomSheet6(Object val) {
    return '+$val جنيه';
  }

  @override
  String drawerHistoryTab1(
    Object cashSalesPiasters,
    Object openingCashPiasters,
  ) {
    return 'مبيعات نقدية: $cashSalesPiasters · افتتاح: $openingCashPiasters';
  }

  @override
  String drawerHistoryTab2(Object date) {
    return 'تفاصيل يوم $date';
  }

  @override
  String get drawerHistoryTab3 => 'الفرق';

  @override
  String get customersScreen1 => 'نظام الأقساط';

  @override
  String get customersScreen2 => 'وضع الخصوصية';

  @override
  String get customersScreen3 => 'الترتيب';

  @override
  String get customerPhotosScreen1 => 'تمت إضافة الصورة';

  @override
  String customerPhotosScreen2(Object pathsLength) {
    return 'تمت إضافة $pathsLength صور';
  }

  @override
  String get customerPhotosScreen3 => 'تمت إزالة الصورة';

  @override
  String get customerPhotosScreen4 => 'استرجاع';

  @override
  String customerPhotosScreen5(Object customerName) {
    return 'صور $customerName';
  }

  @override
  String get customerPhotosScreen6 => 'أضف صورًا';

  @override
  String get customerPhotosScreen7 => 'حدثت مشكلة في تحميل الصور';

  @override
  String get customerPhotosScreen8 =>
      'لا توجد صور لهذا العميل بعد.\nصوّر صفحاته من الدفتر أو أي ورقة تخصه — تبقى الصور على الهاتف فقط.';

  @override
  String get customerPhotosScreen9 => 'إزالة الصورة';

  @override
  String customerDetailsScreen1(
    Object activePlansLength,
    Object remainingPiasters,
  ) {
    return 'أقساط نشطة ($activePlansLength) • المتبقي: $remainingPiasters';
  }

  @override
  String get customerDetailsScreen2 => 'البيع بالتقسيط للعميل';

  @override
  String get customerDetailsScreen3 => 'عرض';

  @override
  String get customerDetailsScreen4 => 'إضافة قسط جديد';

  @override
  String get customerDetailsScreen5 => 'صور العميل';

  @override
  String get photoStrip1 => 'التقاط بالكاميرا';

  @override
  String get photoStrip2 => 'اختيار من المعرض';

  @override
  String get photoStrip3 => 'يمكنك اختيار عدة صور مرة واحدة';

  @override
  String get photoStrip4 => 'صورة';

  @override
  String get photoStrip5 => 'المزيد';

  @override
  String get photoStrip6 => 'أضف صورة';

  @override
  String get photoStrip7 => 'الصور';

  @override
  String photoStrip8(Object title, Object index, Object count) {
    return '$title ($index من $count)';
  }

  @override
  String get photoStrip9 => 'الصورة';

  @override
  String get photoStrip10 => 'الصورة غير موجودة على الهاتف';

  @override
  String creditLimitProgressBar1(Object limitPiasters) {
    return 'حد الدين: $limitPiasters';
  }

  @override
  String ratingExplanationBottomSheet1(Object customerName) {
    return 'تقييم العميل: $customerName';
  }

  @override
  String get ratingExplanationBottomSheet2 => 'سبب التقييم الحالي:';

  @override
  String get ratingExplanationBottomSheet3 => 'كيف يعمل نظام التقييم؟';

  @override
  String get ratingExplanationBottomSheet4 => 'ممتاز';

  @override
  String get ratingExplanationBottomSheet5 =>
      'حسابه مُسدَّد أو أقدم دين عليه لم يتجاوز 14 يومًا.';

  @override
  String get ratingExplanationBottomSheet6 => 'متابعة';

  @override
  String get ratingExplanationBottomSheet7 =>
      'أقدم دين عليه بين 15 و45 يومًا (يُستحسن تذكيره بالدفع).';

  @override
  String get ratingExplanationBottomSheet8 => 'متأخر';

  @override
  String get ratingExplanationBottomSheet9 =>
      'أقدم دين عليه تجاوز 45 يومًا أو تجاوز حد الدين المحدد له.';

  @override
  String get ratingExplanationBottomSheet10 => 'جديد';

  @override
  String get ratingExplanationBottomSheet11 =>
      'عميل لديه أقل من 3 معاملات مسجلة.';

  @override
  String get ratingExplanationBottomSheet12 => 'فهمت';

  @override
  String get customerWithBalance1 => 'عميل جديد';

  @override
  String get settingsScreen1 => 'بيانات المحل 🏪';

  @override
  String get settingsScreen2 => 'الحماية والخصوصية 🔒';

  @override
  String get settingsScreen3 => 'أداة الشاشة الرئيسية 📱';

  @override
  String get settingsScreen4 => 'رسائل التذكير والتحصيل 💬';

  @override
  String get settingsScreen5 => 'النسخ الاحتياطي والبيانات 💾';

  @override
  String get settingsScreen6 => 'مشاركة التطبيق 🚀';

  @override
  String get settingsScreen7 => 'عام ⚙️';

  @override
  String get settingsScreen8 => 'كشكول 📒';

  @override
  String get settingsScreen9 =>
      'دفتر حسابات المحل بدون إنترنت (Offline-First)\nالإصدار 1.0.0';

  @override
  String get settingsScreen10 => 'متجر عام';

  @override
  String get settingsScreen11 => 'بقالة وسوبرماركت 🛒';

  @override
  String get settingsScreen12 => 'هواتف وإكسسوارات 📱';

  @override
  String get settingsScreen13 => 'أجهزة كهربائية ومنزلية ⚡';

  @override
  String get settingsScreen14 => 'صيدلية ومستحضرات 💊';

  @override
  String get settingsScreen15 => 'أنشطة وتجارة حرة 🏪';

  @override
  String settingsScreen16(Object tradeName) {
    return '$tradeName • تعديل النشاط وبيانات الدفع';
  }

  @override
  String get settingsScreen17 => 'إخفاء المبالغ في الشاشة والأداة (••••••)';

  @override
  String get settingsScreen18 => 'قفل التطبيق برمز PIN (4 أرقام)';

  @override
  String get settingsScreen19 => 'مفعّل ومحمي (اضغط للإلغاء)';

  @override
  String get settingsScreen20 => 'غير مفعّل (اضغط للتعيين)';

  @override
  String get settingsScreen21 => 'مفعّل 🔒';

  @override
  String get settingsScreen22 => 'إعداد';

  @override
  String get settingsScreen23 => 'تم إلغاء قفل التطبيق بنجاح';

  @override
  String get settingsScreen24 => 'تم تعيين رمز الدخول بنجاح 🔒';

  @override
  String get settingsScreen25 => 'فتح بالبصمة / Face ID';

  @override
  String get settingsScreen26 => 'استخدام البصمة بدلًا من كتابة الرمز كل مرة';

  @override
  String get settingsScreen27 => 'جهازك لا يدعم التحقق بالبصمة حاليًا';

  @override
  String get settingsScreen28 => 'دقيقة واحدة';

  @override
  String get settingsScreen29 => '5 دقائق';

  @override
  String get settingsScreen30 => '15 دقيقة';

  @override
  String get settingsScreen31 => 'فورًا';

  @override
  String get settingsScreen32 => 'مدة القفل التلقائي';

  @override
  String get settingsScreen33 => 'فور الخروج من التطبيق';

  @override
  String settingsScreen34(Object timeout) {
    return 'بعد $timeout دقيقة من الخروج';
  }

  @override
  String get settingsScreen35 => 'فورًا عند الخروج';

  @override
  String get settingsScreen36 => 'بعد دقيقة واحدة';

  @override
  String get settingsScreen37 => 'بعد 5 دقائق';

  @override
  String get settingsScreen38 => 'بعد 15 دقيقة';

  @override
  String get settingsScreen39 => 'صيغة رسالة التذكير';

  @override
  String get settingsScreen40 =>
      'تعديل نص الرسالة التلقائية للعملاء مع معاينة مباشرة';

  @override
  String get settingsScreen41 => 'حماية التنبيهات من الإغلاق في الخلفية';

  @override
  String get settingsScreen42 =>
      'دليل عملي لضمان وصول التذكيرات على أجهزة شاومي وريلمي وإنفينيكس';

  @override
  String get settingsScreen43 => 'لم تُصدَّر أي نسخة حتى الآن';

  @override
  String get settingsScreen44 => 'آخر نسخة احتياطية';

  @override
  String get settingsScreen45 => 'تصدير نسخة احتياطية (.kashkool)';

  @override
  String get settingsScreen46 =>
      'احفظ نسخة من الدفتر والصور وأرسلها عبر واتساب أو درايف';

  @override
  String get settingsScreen47 => 'تم تصدير النسخة بنجاح 👍';

  @override
  String settingsScreen48(Object e) {
    return 'فشل التصدير: $e';
  }

  @override
  String get settingsScreen49 => 'استعادة نسخة احتياطية';

  @override
  String get settingsScreen50 =>
      'استرجاع الحسابات والصور من ملف .kashkool محفوظ سابقًا';

  @override
  String get settingsScreen51 => 'الملف غير صالح ❌';

  @override
  String get settingsScreen52 => 'الملف المحدد ليس نسخة صالحة لتطبيق كشكول.';

  @override
  String get settingsScreen53 => 'حسنًا';

  @override
  String get settingsScreen54 => 'تأكيد استعادة النسخة';

  @override
  String get settingsScreen55 =>
      'تنبيه: ستستبدل الاستعادة كل البيانات الحالية في التطبيق بالبيانات الموجودة في الملف.';

  @override
  String settingsScreen56(Object exportedAt) {
    return 'تاريخ النسخة: $exportedAt';
  }

  @override
  String settingsScreen57(Object photosCount) {
    return 'عدد الصور المرفقة: $photosCount';
  }

  @override
  String settingsScreen58(Object fileSizeBytes) {
    return 'حجم الملف: $fileSizeBytes ك.ب';
  }

  @override
  String get settingsScreen59 => 'نعم، استبدل واسترجع البيانات';

  @override
  String get settingsScreen60 => 'تمت الاستعادة بنجاح 🎉';

  @override
  String get settingsScreen61 =>
      'تمت استعادة جميع الحسابات والمعاملات والصور بنجاح. يرجى إعادة تشغيل التطبيق لتحديث كل الشاشات.';

  @override
  String get settingsScreen62 => 'إعادة التشغيل الآن';

  @override
  String settingsScreen63(Object e) {
    return 'خطأ في الاستعادة: $e';
  }

  @override
  String get settingsScreen64 => 'داكن 🌙';

  @override
  String get settingsScreen65 => 'فاتح ☀️';

  @override
  String get settingsScreen66 => 'تلقائي';

  @override
  String get settingsScreen67 => 'مظهر التطبيق';

  @override
  String get settingsScreen68 => 'تلقائي (حسب نظام الجهاز)';

  @override
  String get settingsScreen69 => 'غير محدد';

  @override
  String get settingsScreen70 => 'حد الدين الافتراضي للعميل الجديد';

  @override
  String get settingsScreen71 => 'تواصل معنا عبر واتساب';

  @override
  String get settingsScreen72 => 'للاقتراحات والمساعدة الفنية المباشرة';

  @override
  String get settingsScreen73 =>
      'https://wa.me/201000000000?text=السلام%20عليكم%20لدي%20استفسار%20عن%20تطبيق%20كشكول';

  @override
  String get settingsScreen74 => 'سياسة الخصوصية وشروط الاستخدام';

  @override
  String get settingsScreen75 =>
      'بياناتك ملكك بالكامل ومخزنة على هاتفك فقط دون إنترنت';

  @override
  String get settingsScreen76 => 'سياسة الخصوصية في كشكول 🔒';

  @override
  String get settingsScreen77 =>
      '1. كشكول تطبيق يعمل بالكامل دون اتصال بالإنترنت (Offline-First).\n\n2. جميع الحسابات والأسماء وأرقام الهواتف وصور الفواتير والمعاملات مخزنة محليًا على جهازك فقط، ولا تُرسل أي بيانات إلى أي خادم خارجي.\n\n3. أنت المسؤول عن عمل نسخة احتياطية دورية عبر خيار (تصدير نسخة احتياطية) لحفظ بياناتك عند تغيير الهاتف أو فقدانه.\n\n4. صُمم كشكول لخدمة أصحاب المحلات والتجار لحفظ حقوقهم وتسهيل متابعة ديونهم بأمان.';

  @override
  String get settingsScreen78 => 'نظام الجهاز (تلقائي)';

  @override
  String get settingsScreen79 => 'حد الدين الافتراضي (جنيه)';

  @override
  String get settingsScreen80 => 'المبلغ بالجنيه';

  @override
  String get settingsScreen81 => 'اتركه فارغًا ليصبح غير محدد';

  @override
  String get settingsScreen82 => 'حفظ';

  @override
  String batteryGuideBottomSheet1(Object brandName) {
    return 'دليل حماية الإشعارات ($brandName)';
  }

  @override
  String get batteryGuideBottomSheet2 => 'دليل حماية التنبيهات من الإغلاق';

  @override
  String get batteryGuideBottomSheet3 =>
      'توقف بعض الهواتف (مثل شاومي وريلمي وإنفينيكس وهواوي) التطبيقات في الخلفية لتوفير البطارية. لضمان وصول تذكير التحصيل اليومي ومواعيد الأقساط بدقة، يرجى تطبيق الخطوات التالية:';

  @override
  String get batteryGuideBottomSheet4 => 'افتح إعدادات بطارية الهاتف الآن';

  @override
  String get backupReminderBanner1 => 'تم تصدير النسخة الاحتياطية بنجاح 👍';

  @override
  String backupReminderBanner2(Object e) {
    return 'حدث خطأ أثناء النسخ: $e';
  }

  @override
  String get backupReminderBanner3 => 'تنبيه: تحتاج إلى عمل نسخة احتياطية ⚠️';

  @override
  String get backupReminderBanner4 =>
      'مرّ أكثر من 7 أيام على آخر نسخة. احفظ بياناتك حتى لا يضيع أي حساب إن ضاع الهاتف أو تغيّر.';

  @override
  String get backupReminderBanner5 => 'تجاهل مؤقتًا';

  @override
  String get backupReminderBanner6 => 'جارٍ الحفظ...';

  @override
  String get backupReminderBanner7 => 'نسخ احتياطي الآن';

  @override
  String get homeWidgetSettingsCard1 => 'عرض حساباتك على الشاشة الرئيسية';

  @override
  String get homeWidgetSettingsCard2 =>
      'تعرض الأداة مستحقاتك لدى العملاء والمحصَّل اليوم دون فتح التطبيق';

  @override
  String get homeWidgetSettingsCard3 => 'الأداة متوقفة ولا تعرض أي أرقام';

  @override
  String get homeWidgetSettingsCard4 => 'أضف الأداة الصغيرة';

  @override
  String get homeWidgetSettingsCard5 => 'مستحقاتك لدى العملاء فقط';

  @override
  String get homeWidgetSettingsCard6 => 'أضف أداة ملخص اليوم';

  @override
  String get homeWidgetSettingsCard7 =>
      'المستحقات + المحصَّل اليوم + المستحق تحصيلهم + زر تحصيل';

  @override
  String get homeWidgetSettingsCard8 =>
      'وافق على الرسالة الظاهرة لتُضاف الأداة إلى الشاشة 👍';

  @override
  String get homeWidgetSettingsCard9 => 'أضف الأداة يدويًا 📱';

  @override
  String get homeWidgetSettingsCard10 =>
      'هاتفك لا يسمح للتطبيق بإضافتها تلقائيًا. اتبع الآتي:\n\n1. اضغط مطولًا على مكان فارغ في الشاشة الرئيسية\n2. اختر \"الأدوات\" أو \"Widgets\"\n3. ابحث عن \"كشكول\" واسحب الأداة إلى الشاشة';

  @override
  String get messageTemplateEditorBottomSheet1 => 'بقالة الأمانة';

  @override
  String get messageTemplateEditorBottomSheet2 => 'فودافون كاش: 01012345678';

  @override
  String get messageTemplateEditorBottomSheet3 => 'محمد أحمد';

  @override
  String get messageTemplateEditorBottomSheet4 =>
      'تم حفظ نموذج الرسالة بنجاح 👍';

  @override
  String get messageTemplateEditorBottomSheet5 => 'تعديل رسالة التذكير 💬';

  @override
  String get messageTemplateEditorBottomSheet6 => 'نماذج جاهزة: ';

  @override
  String get messageTemplateEditorBottomSheet7 => 'ودّي 😊';

  @override
  String get messageTemplateEditorBottomSheet8 => 'رسمي 👔';

  @override
  String get messageTemplateEditorBottomSheet9 => 'اسم المحل';

  @override
  String get messageTemplateEditorBottomSheet10 => 'بيانات الدفع';

  @override
  String get messageTemplateEditorBottomSheet11 => 'تاريخ آخر حركة';

  @override
  String get messageTemplateEditorBottomSheet12 =>
      'اكتب نص رسالة التذكير هنا...';

  @override
  String get messageTemplateEditorBottomSheet13 =>
      'معاينة الرسالة كما ستصل للعميل:';

  @override
  String get messageTemplateEditorBottomSheet14 => 'حفظ النموذج';

  @override
  String shopProfileBottomSheet1(Object trim) {
    return 'محفظة نقدية: $trim';
  }

  @override
  String get shopProfileBottomSheet2 => 'تم حفظ بيانات المحل بنجاح 👍';

  @override
  String get shopProfileBottomSheet3 => 'اسم المحل *';

  @override
  String get shopProfileBottomSheet4 => 'مثلًا: بقالة الأمانة';

  @override
  String get shopProfileBottomSheet5 => 'يرجى إدخال اسم المحل';

  @override
  String get shopProfileBottomSheet6 => 'رقم هاتف المحل';

  @override
  String get shopProfileBottomSheet7 => 'مثلًا: 010xxxxxxxx';

  @override
  String get shopProfileBottomSheet8 => 'عنوان المحل';

  @override
  String get shopProfileBottomSheet9 =>
      'مثلًا: شارع السوق، بجوار المسجد الكبير';

  @override
  String get shopProfileBottomSheet10 => 'حساب إنستاباي (InstaPay)';

  @override
  String get shopProfileBottomSheet11 => 'مثلًا: name@instapay';

  @override
  String get shopProfileBottomSheet12 => 'رقم فودافون كاش / المحفظة الذكية';

  @override
  String get shopProfileBottomSheet13 => 'نوع النشاط التجاري';

  @override
  String get shopProfileBottomSheet14 => 'نشاط تجاري آخر 🏪';

  @override
  String get shopProfileBottomSheet15 => 'تفعيل نظام الأقساط';

  @override
  String get shopProfileBottomSheet16 =>
      'إظهار زر الأقساط وجداول السداد في التطبيق';

  @override
  String get shopProfileBottomSheet17 => 'حفظ التعديلات';

  @override
  String get cloudAccountButton1 => 'حسابك والنسخ على السحابة ☁️';

  @override
  String get cloudAccountButton2 => 'النسخ على السحابة';

  @override
  String get cloudAccountButton3 => 'سجّل الدخول بحساب جوجل';

  @override
  String get cloudBackupCard1 => 'لحظة…';

  @override
  String get cloudBackupCard2 => 'حدثت مشكلة غير متوقعة، حاول مرة أخرى';

  @override
  String get cloudBackupCard3 => 'نفتح حسابات جوجل…';

  @override
  String cloudBackupCard4(Object email) {
    return 'تم تسجيل الدخول بـ $email ✓';
  }

  @override
  String get cloudBackupCard5 => 'تم رفع النسخة مع ملاحظات ⚠️';

  @override
  String cloudBackupCard6(Object uploaded, Object rejected, Object n) {
    return 'رُفع $uploaded سجل، ورُفض $rejected سجل:\n\n$n';
  }

  @override
  String get cloudBackupCard7 => 'كل بياناتك محفوظة على السحابة بالفعل ✓';

  @override
  String cloudBackupCard8(Object uploaded) {
    return 'تم رفع $uploaded سجل إلى السحابة ✓';
  }

  @override
  String get cloudBackupCard9 => 'نجلب المحلات المرتبطة بحسابك…';

  @override
  String get cloudBackupCard10 => 'لا توجد نسخة على السحابة لهذا الحساب بعد';

  @override
  String get cloudBackupCard11 => 'اختر المحل';

  @override
  String get cloudBackupCard12 => ' (موظف)';

  @override
  String get cloudBackupCard13 => 'الاسترجاع من السحابة؟';

  @override
  String cloudBackupCard14(Object name) {
    return 'سننزّل نسخة \"$name\" من السحابة ونضيفها إلى هذا الهاتف.\n\n';
  }

  @override
  String get cloudBackupCard15 =>
      'لن نحذف أي شيء: البيانات الموجودة على الهاتف فقط ستبقى، وإذا عُدّل شيء على الهاتف بعد آخر نسخة فسنتركه كما هو.';

  @override
  String get cloudBackupCard16 => 'نعم، استرجع';

  @override
  String get cloudBackupCard17 => 'تم الاسترجاع 🎉';

  @override
  String cloudBackupCard18(Object keptLocal) {
    return '، وتُرك $keptLocal سجل كما هو لأن نسخة الهاتف أحدث';
  }

  @override
  String cloudBackupCard19(Object records, Object keptLocal) {
    return 'تم استرجاع $records سجل$keptLocal.';
  }

  @override
  String get cloudBackupCard20 =>
      ' أغلق التطبيق وافتحه مرة أخرى لتحديث كل الشاشات.';

  @override
  String get cloudBackupCard21 => 'أغلق التطبيق';

  @override
  String get cloudBackupCard22 => 'تسجيل الخروج؟';

  @override
  String get cloudBackupCard23 =>
      'ستبقى بياناتك على الهاتف وعلى السحابة، لكن النسخ سيتوقف حتى تسجّل الدخول مرة أخرى.';

  @override
  String get cloudBackupCard24 => 'خروج';

  @override
  String get cloudBackupCard25 => 'غير متاح في هذه النسخة من التطبيق';

  @override
  String get cloudBackupCard26 => 'النسخ الاحتياطي على السحابة';

  @override
  String get cloudBackupCard27 =>
      'سجّل بحساب جوجل لتُحفظ بياناتك على الإنترنت. إذا ضاع الهاتف، يمكنك استرجاعها على أي هاتف آخر.';

  @override
  String get cloudBackupCard28 => 'لا توجد نسخة بعد';

  @override
  String cloudBackupCard29(Object last) {
    return 'آخر نسخة: $last';
  }

  @override
  String get cloudBackupCard30 => 'جارٍ الرفع الآن…';

  @override
  String get cloudBackupCard31 =>
      'في انتظار الإنترنت — سيُرفع تلقائيًا عند عودته';

  @override
  String get cloudBackupCard32 => 'توقف الرفع، سنحاول مرة أخرى بعد قليل';

  @override
  String get cloudBackupCard33 => 'كل شيء مرفوع ✓';

  @override
  String get cloudBackupCard34 => 'الرفع تلقائي عند توفر الإنترنت';

  @override
  String get cloudBackupCard35 => 'ارفع نسخة احتياطية الآن';

  @override
  String get cloudBackupCard36 => 'استرجع بياناتك على هذا الهاتف';

  @override
  String get cloudBackupCard37 =>
      'لهاتف جديد أو بعد حذف التطبيق — لا يحذف شيئًا';

  @override
  String get cloudBackupCard38 => 'تسجيل الخروج';

  @override
  String get onboardingScreen1 => 'محلي';

  @override
  String get onboardingScreen2 =>
      'أُضيف عملاء تجريبيون لتجربة التطبيق، ويمكنك حذفهم في أي وقت';

  @override
  String get onboardingScreen3 => 'إعداد كشكول لأول مرة';

  @override
  String get onboardingScreen4 => 'متابعة إلى نوع النشاط';

  @override
  String get onboardingScreen5 => 'أهلًا بك في كشكول! 👋';

  @override
  String get onboardingScreen6 =>
      'دفترك الإلكتروني لحسابات الديون، والتحصيل عبر واتساب، والأقساط دون تعقيد.';

  @override
  String get onboardingScreen7 => 'اسم المحل *';

  @override
  String get onboardingScreen8 => 'مثال: بقالة الأمانة / هواتف النجم';

  @override
  String get onboardingScreen9 => 'يرجى كتابة اسم المحل (حرفان على الأقل)';

  @override
  String get onboardingScreen10 => 'رقم هاتف المحل (اختياري)';

  @override
  String get onboardingScreen11 =>
      'يظهر في الفواتير وكشوف الحساب وتذييل رسائل واتساب';

  @override
  String get onboardingScreen12 => 'بقالة وسوبرماركت';

  @override
  String get onboardingScreen13 => 'حسابات الديون اليومية وإغلاق الصندوق بسرعة';

  @override
  String get onboardingScreen14 => 'هواتف وإكسسوارات';

  @override
  String get onboardingScreen15 => 'بيانات الأجهزة مع تفعيل الأقساط تلقائيًا';

  @override
  String get onboardingScreen16 => 'أجهزة كهربائية ومنزلية';

  @override
  String get onboardingScreen17 =>
      'عقود البيع بالآجل مع تفعيل الأقساط تلقائيًا';

  @override
  String get onboardingScreen18 => 'صيدلية ومستحضرات';

  @override
  String get onboardingScreen19 => 'حدود الائتمان ومتابعة ديون الوصفات';

  @override
  String get onboardingScreen20 => 'أنشطة تجارية أخرى';

  @override
  String get onboardingScreen21 => 'دفتر مرن ومناسب لجميع أنواع التجارة';

  @override
  String get onboardingScreen22 => 'ما نوع نشاطك التجاري؟';

  @override
  String get onboardingScreen23 =>
      'سنهيئ واجهة التطبيق وأقسامه بحسب طبيعة عملك.';

  @override
  String get onboardingScreen24 => 'يدعم الأقساط';

  @override
  String get onboardingScreen25 => 'تفعيل نظام وجداول الأقساط';

  @override
  String get onboardingScreen26 =>
      'يمكنك تشغيله أو إيقافه في أي وقت من الإعدادات';

  @override
  String get onboardingScreen27 => 'ضمان وصول الإشعارات والتذكيرات 🔔';

  @override
  String get onboardingScreen28 =>
      'حتى يعمل كشكول في موعده اليومي لتنبيهك بالتحصيلات ومواعيد الأقساط:';

  @override
  String get onboardingScreen29 => 'إذن إرسال الإشعارات';

  @override
  String get onboardingScreen30 => 'تم تفعيل الإشعارات بنجاح ✅';

  @override
  String get onboardingScreen31 =>
      'نحتاج إذن الإشعارات لنرسل لك ملخص التحصيل اليومي';

  @override
  String get onboardingScreen32 => 'السماح بالإشعارات الآن';

  @override
  String onboardingScreen33(Object brandName) {
    return 'حماية التطبيق في الخلفية ($brandName)';
  }

  @override
  String get onboardingScreen34 => 'حماية التطبيق من الإغلاق في الخلفية';

  @override
  String get onboardingScreen35 => 'فتح إعدادات بطارية الهاتف';

  @override
  String get onboardingScreen36 => 'جاهز للانطلاق! 🚀';

  @override
  String get onboardingScreen37 => 'تم حفظ بيانات محلك. كيف تود أن تبدأ الآن؟';

  @override
  String get onboardingScreen38 => '+ إضافة أول عميل حقيقي';

  @override
  String get onboardingScreen39 =>
      'سجّل أول عميل وابدأ تدوين الديون والدفعات مباشرة';

  @override
  String get onboardingScreen40 => 'جرّب ببيانات تجريبية أولًا 💡';

  @override
  String get onboardingScreen41 =>
      'إضافة عميلين وحسابات تجريبية لاكتشاف مميزات كشكول (يمكن حذفهم بضغطة زر)';

  @override
  String get onboardingScreen42 => 'تخطَّ وانتقل إلى الشاشة الرئيسية';

  @override
  String get shopRepository1 => 'أحمد محمد (تجريبي)';

  @override
  String get shopRepository2 => 'مشتريات طلبات منزلية';

  @override
  String get shopRepository3 => 'محمود إبراهيم (تجريبي)';

  @override
  String get shopRepository4 => 'بضاعة أول الشهر';

  @override
  String get shopRepository5 => 'دفعة نقدية على الحساب';

  @override
  String get supplierWithBalance1 => 'السبت';

  @override
  String get supplierWithBalance2 => 'الأحد';

  @override
  String get supplierWithBalance3 => 'الإثنين';

  @override
  String get supplierWithBalance4 => 'الثلاثاء';

  @override
  String get supplierWithBalance5 => 'الأربعاء';

  @override
  String get supplierWithBalance6 => 'الخميس';

  @override
  String get supplierWithBalance7 => 'الجمعة';

  @override
  String get trashScreen1 => 'عملاء';

  @override
  String get trashScreen2 => 'عمليات';

  @override
  String get trashScreen3 => 'موردون';

  @override
  String get trashScreen4 => 'مصروفات';

  @override
  String get trashScreen5 => 'أقساط';

  @override
  String trashScreen6(Object title) {
    return 'تمت استعادة \"$title\" ✓';
  }

  @override
  String get trashScreen7 => 'تعذّرت الاستعادة، حاول مرة أخرى';

  @override
  String get trashScreen8 => 'سلة المحذوفات 🗑️';

  @override
  String get trashScreen9 =>
      'كل ما تحذفه يُنقل إلى هنا ولا يضيع. يمكنك استعادته في أي وقت، وسيعود أيضًا في النسخة الموجودة على السحابة.';

  @override
  String get trashScreen10 => 'حدثت مشكلة في تحميل المحذوفات';

  @override
  String get trashScreen11 => 'السلة فارغة ✨';

  @override
  String trashScreen12(Object deletedAt) {
    return 'حُذف $deletedAt';
  }

  @override
  String get trashScreen13 => 'استعادة';

  @override
  String get trashScreen14 => 'سلة المحذوفات';

  @override
  String get trashScreen15 => 'شاهد ما حُذف واستعده';

  @override
  String trashScreen16(Object count) {
    return 'بها $count عنصر — يمكنك استعادتها';
  }

  @override
  String get trashRepository1 => 'إيجار';

  @override
  String get trashRepository2 => 'كهرباء';

  @override
  String get trashRepository3 => 'رواتب';

  @override
  String get trashRepository4 => 'مستلزمات';

  @override
  String get trashRepository5 => 'دفع لمورد';

  @override
  String get trashRepository6 => 'مصروف';

  @override
  String get trashRepository7 => 'عليّ';

  @override
  String get trashRepository8 => 'دفع';

  @override
  String get trashRepository9 => 'دفعتُ له';

  @override
  String get trashRepository10 => 'غير معروف';

  @override
  String trashRepository11(Object itemDescription) {
    return 'تقسيط: $itemDescription';
  }

  @override
  String pdfStatementService1(Object sanitizedName, Object dateStr) {
    return 'كشف_حساب_${sanitizedName}_$dateStr.pdf';
  }

  @override
  String get pdfStatementService2 => 'كشف حساب عميل';

  @override
  String pdfStatementService3(Object customerName) {
    return 'العميل: $customerName';
  }

  @override
  String pdfStatementService4(Object phone) {
    return 'الهاتف: $phone';
  }

  @override
  String pdfStatementService5(Object periodDescription) {
    return 'الفترة: $periodDescription';
  }

  @override
  String get pdfStatementService6 => 'رصيد ما قبل هذه الفترة:';

  @override
  String get pdfStatementService7 => 'التاريخ';

  @override
  String get pdfStatementService8 => 'البيان';

  @override
  String get pdfStatementService9 => 'الرصيد';

  @override
  String pdfStatementService10(Object periodDebitsPiasters) {
    return 'إجمالي المشتريات / السلف: $periodDebitsPiasters';
  }

  @override
  String pdfStatementService11(Object periodCreditsPiasters) {
    return 'إجمالي المسدَّد: $periodCreditsPiasters';
  }

  @override
  String get pdfStatementService12 => 'الرصيد النهائي المطلوب:';

  @override
  String pdfStatementService13(Object trim) {
    return 'طرق الدفع المتاحة: $trim';
  }

  @override
  String get pdfStatementService14 => 'صُنع بكشكول — جرّبه مجانًا:';

  @override
  String get statementCalculator1 => 'كل المعاملات';

  @override
  String get statementCalculator2 => 'يناير';

  @override
  String get statementCalculator3 => 'فبراير';

  @override
  String get statementCalculator4 => 'مارس';

  @override
  String get statementCalculator5 => 'أبريل';

  @override
  String get statementCalculator6 => 'مايو';

  @override
  String get statementCalculator7 => 'يونيو';

  @override
  String get statementCalculator8 => 'يوليو';

  @override
  String get statementCalculator9 => 'أغسطس';

  @override
  String get statementCalculator10 => 'سبتمبر';

  @override
  String get statementCalculator11 => 'أكتوبر';

  @override
  String get statementCalculator12 => 'نوفمبر';

  @override
  String get statementCalculator13 => 'ديسمبر';

  @override
  String statementCalculator14(Object startDate, Object endDate) {
    return 'من $startDate إلى $endDate';
  }

  @override
  String statementCalculator15(Object startDate) {
    return 'من $startDate';
  }

  @override
  String statementCalculator16(Object endDate) {
    return 'حتى $endDate';
  }

  @override
  String growthFooter1(Object shopCode) {
    return '—\nصُنع بكشكول 📒 جرّبه مجانًا: $shopCode';
  }

  @override
  String growthFooter2(Object shopCode) {
    return 'أستخدم كشكول 📒 لمتابعة حسابات العملاء والموردين والصندوق دون دفتر ورقي.\nسهل جدًا ويعمل دون إنترنت. جرّبه مجانًا:\n$shopCode';
  }

  @override
  String get notificationService1 => 'التحصيل اليومي';

  @override
  String get notificationService2 =>
      'تذكير بالعملاء المستحق تحصيلهم ومواعيد دفعهم';

  @override
  String notificationService3(Object dueCount, Object amountStr) {
    return 'لديك $dueCount عملاء عليهم $amountStr — اضغط للتحصيل';
  }

  @override
  String get notificationService4 => 'تذكير التحصيل اليومي 📒';

  @override
  String get backupService1 => 'ملف قاعدة البيانات غير موجود';

  @override
  String backupService2(Object dateStr) {
    return 'نسخة احتياطية لتطبيق كشكول - $dateStr';
  }

  @override
  String get backupService3 => 'الملف المحدد غير موجود';

  @override
  String get backupService4 => 'الملف تالف أو غير مكتمل';

  @override
  String get backupService5 => 'صيغة الملف غير صحيحة (ليس ملف كشكول صالحًا)';

  @override
  String get backupService6 => 'الملف لا يحتوي على قاعدة بيانات كشكول';

  @override
  String get backupService7 => 'قاعدة البيانات داخل الملف تالفة';

  @override
  String get backupService8 => 'الملف ليس قاعدة بيانات SQLite صالحة';

  @override
  String get backupService9 => 'ملف النسخة الاحتياطية غير صالح';

  @override
  String get backupService10 => 'ملف قاعدة البيانات مفقود داخل الأرشيف';

  @override
  String get googleAuthService1 =>
      'النسخ على السحابة غير مُعدّ في هذه النسخة من التطبيق';

  @override
  String get googleAuthService2 => 'لم تُرجع جوجل بيانات الدخول، حاول مرة أخرى';

  @override
  String get googleAuthService3 => 'تم إلغاء تسجيل الدخول';

  @override
  String googleAuthService4(Object codeName) {
    return 'تعذّر تسجيل الدخول بجوجل ($codeName)';
  }

  @override
  String get cloudApi1 => 'عنوان الخادم غير مُعدّ في هذه النسخة من التطبيق';

  @override
  String get cloudApi2 => 'سجّل الدخول بحساب جوجل أولًا';

  @override
  String get cloudApi3 => 'لا يوجد اتصال بالإنترنت، حاول مرة أخرى';

  @override
  String get cloudApi4 => 'تأخر الخادم في الرد، حاول مرة أخرى';

  @override
  String get cloudApi5 => 'انتهت صلاحية الدخول، سجّل الدخول بجوجل مرة أخرى';

  @override
  String get cloudApi6 => 'هذا المحل مسجل على حساب جوجل آخر';

  @override
  String get cloudApi7 => 'هذه الميزة تحتاج إلى اشتراك';

  @override
  String get cloudApi8 => 'محاولات كثيرة، انتظر قليلًا ثم حاول مرة أخرى';

  @override
  String get cloudApi9 => 'سجّل الدخول بحساب جوجل مرة أخرى';

  @override
  String get cloudApi10 => 'تسجيل الدخول بجوجل غير مُعدّ على الخادم';

  @override
  String get cloudApi11 => 'حدثت مشكلة في الخادم، حاول بعد قليل';

  @override
  String cloudApi12(Object code) {
    return 'حدثت مشكلة ($code)';
  }

  @override
  String get cloudBackupService1 => 'تسجيل الدخول بجوجل غير متاح';

  @override
  String get cloudBackupService2 => 'أكمل بيانات المحل أولًا من الإعدادات';

  @override
  String get cloudBackupService3 => 'نجهّز بيانات المحل…';

  @override
  String cloudBackupService4(Object length, Object changesLength) {
    return 'جارٍ رفع $length من $changesLength…';
  }

  @override
  String get cloudBackupService5 => 'انتهينا ✓';

  @override
  String cloudBackupService6(Object changesLength) {
    return 'جارٍ تنزيل البيانات… ($changesLength)';
  }

  @override
  String cloudBackupService7(Object changesLength) {
    return 'جارٍ حفظ $changesLength سجل على الهاتف…';
  }

  @override
  String get cloudBackupService8 => 'المحل';

  @override
  String autoBackupCoordinator1(Object rejected) {
    return 'لم يُرفع $rejected سجل';
  }

  @override
  String get autoBackupCoordinator2 => 'حدثت مشكلة، سنحاول مرة أخرى بعد قليل';

  @override
  String get customerRating1 => 'عميل جديد (أقل من 3 معاملات)';

  @override
  String get customerRating2 => 'حسابه مُسدَّد ويدفع في مواعيده بانتظام';

  @override
  String customerRating3(Object oldestUnpaidAgeDays) {
    return 'متأخر: أقدم دين عليه منذ $oldestUnpaidAgeDays يوم وتجاوز حد الدين';
  }

  @override
  String get customerRating4 => 'تجاوز حد الدين المحدد للعميل';

  @override
  String get customerRating5 => 'سجّل دينًا اليوم فقط وحسابه منتظم';

  @override
  String customerRating6(Object oldestUnpaidAgeDays) {
    return 'أقدم مبلغ عليه منذ $oldestUnpaidAgeDays يوم فقط (ضمن الحد الآمن)';
  }

  @override
  String customerRating7(Object oldestUnpaidAgeDays) {
    return 'أقدم مبلغ عليه منذ $oldestUnpaidAgeDays يوم (تأخر أكثر من 45 يومًا)';
  }

  @override
  String customerRating8(Object oldestUnpaidAgeDays) {
    return 'أقدم مبلغ عليه منذ $oldestUnpaidAgeDays يوم (يحتاج متابعة)';
  }

  @override
  String get whatsappTemplate1 =>
      'السلام عليكم أ/ {customer_name} 👋\nمعك {shop_name}.\nرصيدك الحالي: {balance}\nآخر عملية: {last_transaction_date} - {last_transaction_amount}\nللدفع: {payment_info}\nشكرًا لتعاملك معنا 🙏';

  @override
  String get whatsappTemplate2 =>
      'تحية طيبة أ/ {customer_name}\nنود تذكيركم بأن الحساب الحالي لدى {shop_name} يبلغ {balance}.\nآخر عملية مسجلة: {last_transaction_date} ({last_transaction_amount})\nطرق السداد المتاحة: {payment_info}\nمع خالص الشكر والتقدير.';

  @override
  String get whatsappTemplate3 =>
      'السلام عليكم أ/ {customer_name} 👋\nمعك {shop_name}.\nنذكّرك بموعد استحقاق قسط ({item}) - القسط رقم {installment_number} من {installment_count}:\nالمبلغ المستحق: {amount}\nتاريخ الاستحقاق: {due_date}\nإجمالي المتبقي من الأقساط: {remaining_total}\nطرق السداد المتاحة: {payment_info}\nشكرًا لالتزامك معنا 🙏';

  @override
  String get whatsappTemplate4 => 'نقدًا في المحل أو التحويل المتاح';

  @override
  String get money1 => 'جنيه';

  @override
  String get batteryOptimizationHelper1 => 'نظام XOS / HiOS';

  @override
  String get batteryOptimizationHelper2 =>
      'افتح تطبيق Phone Master (مدير الهاتف) على جهازك.';

  @override
  String get batteryOptimizationHelper3 =>
      'ادخل إلى \"إدارة التشغيل التلقائي (Auto-start)\" وفعّل كشكول.';

  @override
  String get batteryOptimizationHelper4 =>
      'في إعدادات التطبيق، ادخل إلى \"البطارية\" واختر \"بلا قيود (Unrestricted)\".';

  @override
  String get batteryOptimizationHelper5 =>
      'في شاشة التطبيقات المفتوحة، اسحب التطبيق لأسفل لتثبيته بالقفل 🔒.';

  @override
  String get batteryOptimizationHelper6 => 'نظام MIUI / HyperOS';

  @override
  String get batteryOptimizationHelper7 =>
      'ادخل إلى إعدادات التطبيق وفعّل \"التشغيل التلقائي (Autostart)\".';

  @override
  String get batteryOptimizationHelper8 =>
      'من \"موفر البطارية (Battery Saver)\"، اختر \"بلا قيود (No Restrictions)\".';

  @override
  String get batteryOptimizationHelper9 =>
      'من شاشة التطبيقات الحديثة، اضغط مطولًا على كشكول واختر أيقونة القفل 🔒.';

  @override
  String get batteryOptimizationHelper10 => 'نظام ColorOS / Realme UI';

  @override
  String get batteryOptimizationHelper11 =>
      'من إعدادات التطبيق -> استخدام البطارية، فعّل \"السماح بالنشاط في الخلفية\".';

  @override
  String get batteryOptimizationHelper12 =>
      'فعّل خيار \"التشغيل التلقائي (Auto-launch)\".';

  @override
  String get batteryOptimizationHelper13 =>
      'في قائمة التطبيقات المفتوحة، اضغط على النقاط الثلاث واختر \"تثبيت (Lock)\".';

  @override
  String get batteryOptimizationHelper14 => 'نظام One UI';

  @override
  String get batteryOptimizationHelper15 =>
      'ادخل إلى الإعدادات -> العناية بالجهاز (Device Care) -> البطارية.';

  @override
  String get batteryOptimizationHelper16 =>
      'ادخل إلى \"حدود استخدام الخلفية (Background usage limits)\".';

  @override
  String get batteryOptimizationHelper17 =>
      'أضف كشكول إلى قائمة \"التطبيقات التي لا تنام أبدًا (Never sleeping apps)\".';

  @override
  String get batteryOptimizationHelper18 => 'نظام EMUI / MagicOS';

  @override
  String get batteryOptimizationHelper19 =>
      'ادخل إلى الإعدادات -> البطارية -> بدء تشغيل التطبيقات (App Launch).';

  @override
  String get batteryOptimizationHelper20 =>
      'ابحث عن \"كشكول\"، وحوّل الإدارة إلى يدوية، وفعّل (التشغيل التلقائي + العمل في الخلفية).';

  @override
  String get batteryOptimizationHelper21 => 'إعدادات النظام';

  @override
  String get batteryOptimizationHelper22 => 'حماية إشعارات النظام';

  @override
  String get batteryOptimizationHelper23 =>
      'ادخل إلى معلومات التطبيق في إعدادات الهاتف.';

  @override
  String get batteryOptimizationHelper24 =>
      'ادخل إلى قسم \"البطارية (Battery)\" واختر \"غير مقيد (Unrestricted)\".';

  @override
  String get batteryOptimizationHelper25 =>
      'تأكد من عدم تفعيل وضع توفير الطاقة الفائق على الهاتف لضمان وصول تنبيهات التحصيل.';

  @override
  String get homeWidgetService1 => 'لا أحد';

  @override
  String get homeWidgetService2 => 'عميل واحد';

  @override
  String get homeWidgetService3 => 'عميلان';

  @override
  String homeWidgetService4(Object count) {
    return '$count عملاء';
  }

  @override
  String get pinLockScreen1 => 'رمز الدخول غير صحيح، حاول مرة أخرى';

  @override
  String get pinLockScreen2 => 'الرمزان غير متطابقين، حاول من جديد';

  @override
  String get pinLockScreen3 =>
      'البصمة غير متاحة أو غير مفعّلة في إعدادات جهازك';

  @override
  String get pinLockScreen4 => 'أهلًا بك في كشكول 📒';

  @override
  String get pinLockScreen5 => 'تعيين رمز دخول جديد';

  @override
  String get pinLockScreen6 => 'أعد كتابة الرمز للتأكيد';

  @override
  String get pinLockScreen7 => 'أدخل رمز الدخول المكون من 4 أرقام';

  @override
  String get pinLockScreen8 => 'اكتب 4 أرقام تتذكرها لقفل التطبيق بها';

  @override
  String get pinLockScreen9 => 'اكتب الأرقام نفسها مرة أخرى';

  @override
  String get pinLockScreen10 => 'بصمة الإصبع';

  @override
  String get pinLockScreen11 => 'مسح';

  @override
  String get securityService1 => 'تأكيد الهوية لفتح كشكول';

  @override
  String get settingsLanguageTitle => 'اللغة';

  @override
  String get settingsLanguageSystem => 'لغة الهاتف (تلقائي)';

  @override
  String get cloudDeleteAccountTitle => 'احذف حسابي على السحابة';

  @override
  String get cloudDeleteAccountSubtitle =>
      'يحذف نسخ السحابة وحسابك نهائيًا — لن تُحذف بياناتك على الهاتف';

  @override
  String get cloudDeleteAccountConfirmTitle => 'حذف حسابك نهائيًا؟';

  @override
  String get cloudDeleteAccountConfirmBody =>
      'سنحذف حسابك وكل النسخ الموجودة على السحابة للمحلات التي تملكها، ولا يمكن استرجاعها. ستبقى البيانات الموجودة على هذا الهاتف كما هي.';

  @override
  String get cloudDeleteAccountConfirmButton => 'احذف نهائيًا';

  @override
  String get cloudDeleteAccountDone => 'تم حذف حسابك من السحابة';

  @override
  String get authFirstTimeTitle => 'أهلاً بك في كشكول! 👋';

  @override
  String get authFirstTimeQuestion => 'هل لديك حساب بالفعل أم أنت مستخدم جديد؟';

  @override
  String get authHaveAccount => 'لدي حساب بالفعل';

  @override
  String get authHaveAccountSubtitle =>
      'سجّل دخولك وسيتم استرجاع كافة بيانات محلك فوراً';

  @override
  String get authNewUser => 'مستخدم جديد';

  @override
  String get authNewUserSubtitle => 'ابدأ كشكول جديد وجهّز محلك خطوة بخطوة';

  @override
  String get authContinueGuest => 'المتابعة كضيف (بدون حساب)';

  @override
  String get authContinueGuestSubtitle =>
      'استخدم التطبيق محلياً بدون إنترنت تماماً';

  @override
  String get authLogin => 'تسجيل الدخول';

  @override
  String get authRegister => 'إنشاء حساب جديد';

  @override
  String get authEmail => 'البريد الإلكتروني';

  @override
  String get authPassword => 'كلمة المرور';

  @override
  String get authPasswordConfirm => 'تأكيد كلمة المرور';

  @override
  String get authNameOptional => 'الاسم الكامل (اختياري)';

  @override
  String get authLoginButton => 'تسجيل الدخول';

  @override
  String get authRegisterButton => 'إنشاء الحساب';

  @override
  String get authOrGoogle => 'أو المتابعة بحساب Google';

  @override
  String get authSignInWithGoogle => 'تسجيل الدخول بحساب Google';

  @override
  String get authSignInWithGoogleSubtitle =>
      'مزامنة سحابية واسترجاع بيانات محلك تلقائياً';

  @override
  String get authSwitchAccount => 'تبديل الحساب';

  @override
  String get authSwitchAccountSubtitle =>
      'اختر حساباً آخر أو سجّل الدخول بحساب جديد';

  @override
  String get authAddAccount => '+ تسجيل الدخول بحساب آخر';

  @override
  String get authCurrentAccount => 'الحساب النشط حالياً';

  @override
  String get authPasswordsDontMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get authPasswordTooShort => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';

  @override
  String get authInvalidEmail => 'يرجى كتابة بريد إلكتروني صحيح';

  @override
  String get authLoginSuccess => 'تم تسجيل الدخول بنجاح 🎉';

  @override
  String get authRegisterSuccess => 'تم إنشاء الحساب بنجاح 🎉';

  @override
  String authSwitchedTo(Object email) {
    return 'تم التبديل إلى حساب: $email';
  }

  @override
  String get cloudApiEmailTaken => 'هذا البريد مسجل مسبقاً، يرجى تسجيل الدخول';

  @override
  String get cloudApiInvalidCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة';

  @override
  String get authBackupBeforeSwitchTitle => 'تنبيه: بيانات غير محفوظة!';

  @override
  String get authBackupBeforeSwitchBody =>
      'يوجد بيانات لم يتم حفظ نسخة منها على السحابة لهذا الحساب. إذا قمت بتبديل الحساب الآن، سيتم مسح البيانات المحلية ولن تتمكن من استرجاعها إلا إذا قمت بعمل نسخة احتياطية أولاً.';

  @override
  String get authBackupFirst => 'أخذ نسخة احتياطية أولاً';

  @override
  String get authSwitchWithoutBackup => 'تبديل ومسح البيانات المحلية';

  @override
  String get authFetchingData => 'جاري جلب بياناتك من السحابة…';

  @override
  String get authEmailLoginButton => 'تسجيل الدخول بالبريد الإلكتروني';

  @override
  String get authEmailRegisterButton => 'إنشاء حساب جديد بالبريد';

  @override
  String get authWipingData => 'جاري مسح البيانات المحلية وتبديل الحساب…';
}

/// The translations for Arabic, as used in Egypt (`ar_EG`).
class AppLocalizationsArEg extends AppLocalizationsAr {
  AppLocalizationsArEg() : super('ar_EG');

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
  String placeholderScreen(String screenName) {
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
  String get customerPhoneInvalid => 'رقم الهاتف غير صحيح';

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

  @override
  String get main1 => 'كشكول';

  @override
  String get notebookImportButton1 => 'انقل حساباتك من الكشكول 📒';

  @override
  String get notebookImportButton2 =>
      'مش لازم تنقل كل حركة قديمة: كفاية اسم العميل واللي عليه دلوقتي.';

  @override
  String get notebookImportButton3 => 'العملاء وحساباتهم';

  @override
  String get notebookImportButton4 =>
      'سطر لكل عميل: الاسم والموبايل والمبلغ اللي عليه';

  @override
  String get notebookImportButton5 => 'قسط قديم';

  @override
  String get notebookImportButton6 =>
      'السعر، واللي اتدفع، والأقساط الباقية وميعاد الجاي';

  @override
  String get notebookImportButton7 => 'انقل من الكشكول';

  @override
  String get oldInstallmentImportScreen1 => 'ميعاد القسط الجاي';

  @override
  String get oldInstallmentImportScreen2 => 'اتحفظ القسط ✓';

  @override
  String oldInstallmentImportScreen3(
    Object remaining,
    Object countValue,
    Object nextDue,
  ) {
    return 'فاضل $remaining على $countValue قسط، أولهم يوم $nextDue.';
  }

  @override
  String get oldInstallmentImportScreen4 => 'خلصت';

  @override
  String get oldInstallmentImportScreen5 => 'قسط تاني';

  @override
  String get oldInstallmentImportScreen6 =>
      'حصلت مشكلة في الحفظ، مفيش حاجة اتحفظت';

  @override
  String get oldInstallmentImportScreen7 => ' شهرياً';

  @override
  String get oldInstallmentImportScreen8 => ' أسبوعياً';

  @override
  String oldInstallmentImportScreen9(
    Object remaining,
    Object count,
    Object count2,
    Object monthly,
  ) {
    return 'فاضل $remaining — $count قسط × حوالي $count2$monthly';
  }

  @override
  String get oldInstallmentImportScreen10 => 'قسط قديم من الكشكول';

  @override
  String oldInstallmentImportScreen11(Object savedCount) {
    return 'قسط قديم ($savedCount)';
  }

  @override
  String get oldInstallmentImportScreen12 =>
      'للأقساط اللي بدأت قبل التطبيق: اكتب السعر، واللي اتدفع لحد دلوقتي، وعدد الأقساط الباقية. التطبيق هيعمل جدول الباقي بس، ومش هيحسب المدفوع قبل كده في درج النهارده.';

  @override
  String get oldInstallmentImportScreen13 => 'العميل';

  @override
  String get oldInstallmentImportScreen14 => 'اسم العميل';

  @override
  String get oldInstallmentImportScreen15 => 'اكتب اسم عميل موجود أو جديد';

  @override
  String get oldInstallmentImportScreen16 => 'اكتب اسم العميل';

  @override
  String get oldInstallmentImportScreen17 =>
      'موبايل العميل (لو جديد — اختياري)';

  @override
  String get oldInstallmentImportScreen18 => 'رقم الموبايل غلط';

  @override
  String get oldInstallmentImportScreen19 => 'القسط';

  @override
  String get oldInstallmentImportScreen20 => 'السلعة';

  @override
  String get oldInstallmentImportScreen21 => 'مثلاً: تلاجة توشيبا';

  @override
  String get oldInstallmentImportScreen22 => 'اكتب اسم السلعة';

  @override
  String get oldInstallmentImportScreen23 => 'السعر الإجمالي';

  @override
  String get oldInstallmentImportScreen24 => 'ج';

  @override
  String get oldInstallmentImportScreen25 => 'مطلوب';

  @override
  String get oldInstallmentImportScreen26 => 'غلط';

  @override
  String get oldInstallmentImportScreen27 => 'اتدفع لحد دلوقتي';

  @override
  String get oldInstallmentImportScreen28 => 'لازم يكون أقل من السعر';

  @override
  String get oldInstallmentImportScreen29 => 'عدد الأقساط الباقية';

  @override
  String get oldInstallmentImportScreen30 => 'من 1 لـ 120';

  @override
  String oldInstallmentImportScreen31(Object nextDue) {
    return 'الجاي: $nextDue';
  }

  @override
  String get oldInstallmentImportScreen32 => 'شهري';

  @override
  String get oldInstallmentImportScreen33 => 'أسبوعي';

  @override
  String get oldInstallmentImportScreen34 => 'الضامن (اختياري)';

  @override
  String get oldInstallmentImportScreen35 => 'اسم الضامن';

  @override
  String get oldInstallmentImportScreen36 => 'موبايل الضامن';

  @override
  String get oldInstallmentImportScreen37 =>
      'صور من الكشكول أو العقد (اختياري — بتفضل على الموبايل)';

  @override
  String get oldInstallmentImportScreen38 =>
      'تقدر تضيف كذا صورة: صفحات الكشكول، العقد، بطاقة الضامن…';

  @override
  String oldInstallmentImportScreen39(Object photosLength) {
    return '$photosLength صورة — هتتحفظ في صور العميل';
  }

  @override
  String get oldInstallmentImportScreen40 => 'بيحفظ…';

  @override
  String get oldInstallmentImportScreen41 => 'احفظ القسط';

  @override
  String get notebookImportScreen1 => 'الحسابات دي لحد يوم';

  @override
  String notebookImportScreen2(Object firstError, Object error) {
    return 'سطر $firstError: $error';
  }

  @override
  String get notebookImportScreen3 => 'اكتب اسم عميل واحد على الأقل';

  @override
  String get notebookImportScreen4 => 'اتحفظ ✓';

  @override
  String notebookImportScreen5(Object newCustomers) {
    return '$newCustomers عميل جديد';
  }

  @override
  String notebookImportScreen6(Object existingCustomers) {
    return '$existingCustomers عميل موجود اتضاف على حسابه';
  }

  @override
  String notebookImportScreen7(Object totalPiasters) {
    return 'إجمالي: $totalPiasters';
  }

  @override
  String get notebookImportScreen8 => 'صفحة تانية';

  @override
  String get notebookImportScreen9 => 'تخرج من غير ما تحفظ؟';

  @override
  String get notebookImportScreen10 => 'اللي كتبته في الصفحة دي مش هيتحفظ.';

  @override
  String get notebookImportScreen11 => 'كمّل';

  @override
  String get notebookImportScreen12 => 'اخرج';

  @override
  String get notebookImportScreen13 => 'انقل الكشكول 📒';

  @override
  String notebookImportScreen14(Object savedPages) {
    return 'انقل الكشكول — صفحة $savedPages';
  }

  @override
  String get notebookImportScreen15 => 'سطر جديد';

  @override
  String notebookImportScreen16(Object validLength) {
    return '$validLength عميل';
  }

  @override
  String get notebookImportScreen17 => 'احفظ';

  @override
  String get notebookImportScreen18 =>
      'اكتب كل عميل في سطر: الاسم، والموبايل لو موجود، والمبلغ اللي عليه. دوس \"التالي\" في الكيبورد عشان تنقل بسرعة.';

  @override
  String get notebookImportScreen19 => 'الحساب لحد النهارده';

  @override
  String notebookImportScreen20(Object asOf) {
    return 'لحد $asOf';
  }

  @override
  String get notebookImportScreen21 =>
      'صور صفحة الكشكول (اختياري): بتتحفظ مع كل العملاء اللي في الصفحة';

  @override
  String notebookImportScreen22(Object pagePhotosLength) {
    return '$pagePhotosLength صورة للصفحة — هتتحفظ مع كل العملاء اللي في الصفحة';
  }

  @override
  String get notebookImportScreen23 => 'الصفحة';

  @override
  String get notebookImportScreen24 => 'صور للعميل ده';

  @override
  String get notebookImportScreen25 => 'شيل السطر';

  @override
  String get notebookImportScreen26 => 'الموبايل (اختياري)';

  @override
  String get notebookImportScreen27 => 'المبلغ';

  @override
  String get notebookImportScreen28 => 'بيدوّر…';

  @override
  String notebookImportScreen29(Object name) {
    return 'موجود عندك \"$name\" — المبلغ هيتضاف على حسابه';
  }

  @override
  String get notebookImportScreen30 => 'المبلغ عليه (العميل مديون)';

  @override
  String get notebookImportScreen31 => 'المبلغ له (انت مديون للعميل)';

  @override
  String get notebookImportScreen32 => 'عليه';

  @override
  String get notebookImportScreen33 => 'له';

  @override
  String get notebookImportService1 => 'رصيد سابق من الكشكول';

  @override
  String get notebookImportService2 => 'صفحة من الكشكول';

  @override
  String get notebookImportService3 => 'الاسم ناقص';

  @override
  String get notebookImportService4 => 'الاسم طويل جداً';

  @override
  String get notebookImportService5 => 'المبلغ غلط';

  @override
  String get notebookImportService6 => 'المدفوع مينفعش يبقى بالسالب';

  @override
  String get notebookImportService7 =>
      'المدفوع لازم يكون أقل من السعر الإجمالي';

  @override
  String get notebookImportService8 =>
      'عدد الأقساط الباقية لازم يكون 1 على الأقل';

  @override
  String notebookImportService9(Object paidPiasters) {
    return 'مستورد من الكشكول — مدفوع قبل كده $paidPiasters';
  }

  @override
  String notebookImportService10(Object trim, Object totalPricePiasters) {
    return 'قسط قديم: $trim (الباقي من $totalPricePiasters)';
  }

  @override
  String notebookImportService11(Object trim) {
    return 'قسط: $trim';
  }

  @override
  String get installmentsScreen1 => 'نظام الأقساط 📋';

  @override
  String get installmentsScreen2 =>
      'ابحث باسم العميل، السلعة، الموبايل، أو الضامن...';

  @override
  String get installmentsScreen3 => 'إجمالي الأقساط';

  @override
  String get installmentsScreen4 => 'أقساط متأخرة';

  @override
  String get installmentsScreen5 => 'خطط نشطة';

  @override
  String get installmentsScreen6 => 'الكل';

  @override
  String get installmentsScreen7 => 'النشطة ⏳';

  @override
  String get installmentsScreen8 => 'المكتملة ✓';

  @override
  String get installmentsScreen9 => 'الملغية';

  @override
  String installmentsScreen10(Object e) {
    return 'خطأ في تحميل الأقساط: $e';
  }

  @override
  String get installmentsScreen11 => 'مفيش أقساط مطابقة للبحث';

  @override
  String get installmentsScreen12 => 'مفيش خطط أقساط حالياً';

  @override
  String get installmentsScreen13 =>
      'اضغط على زرار (+ خطة قسط جديدة) لإنشاء وجدولة أول قسط لعميل.';

  @override
  String get installmentsScreen14 => 'خطة قسط جديدة';

  @override
  String installmentPlanDetailsScreen1(Object instapay) {
    return 'إنستاباي: $instapay';
  }

  @override
  String installmentPlanDetailsScreen2(Object wallet) {
    return 'محفظة/فودافون كاش: $wallet';
  }

  @override
  String installmentPlanDetailsScreen3(Object phoneNum) {
    return 'تليفون: $phoneNum';
  }

  @override
  String get installmentPlanDetailsScreen4 => 'إلغاء خطة القسط';

  @override
  String get installmentPlanDetailsScreen5 =>
      'هل أنت متأكد من رغبتك في إلغاء هذه الخطة؟ سيتم إيقاف التنبيهات مع الاحتفاظ بسجل المدفوعات.';

  @override
  String get installmentPlanDetailsScreen6 => 'رجوع';

  @override
  String get installmentPlanDetailsScreen7 => 'إلغاء الخطة';

  @override
  String get installmentPlanDetailsScreen8 => 'تم إلغاء خطة القسط';

  @override
  String get installmentPlanDetailsScreen9 => 'حذف خطة القسط';

  @override
  String get installmentPlanDetailsScreen10 =>
      'هل أنت متأكد من حذف خطة القسط نهائياً؟';

  @override
  String get installmentPlanDetailsScreen11 => 'إلغاء';

  @override
  String get installmentPlanDetailsScreen12 => 'حذف نهائي';

  @override
  String get installmentPlanDetailsScreen13 => 'تم حذف خطة القسط';

  @override
  String get installmentPlanDetailsScreen14 => 'تفاصيل القسط';

  @override
  String installmentPlanDetailsScreen15(Object e) {
    return 'خطأ: $e';
  }

  @override
  String get installmentPlanDetailsScreen16 =>
      'خطة القسط غير موجودة أو تم حذفها';

  @override
  String get installmentPlanDetailsScreen17 => 'حذف الخطة';

  @override
  String get installmentPlanDetailsScreen18 => 'السعر الإجمالي:';

  @override
  String get installmentPlanDetailsScreen19 => 'المقدم:';

  @override
  String get installmentPlanDetailsScreen20 => 'إجمالي المدفوع:';

  @override
  String get installmentPlanDetailsScreen21 => 'المتبقي:';

  @override
  String get installmentPlanDetailsScreen22 => 'سداد مبكر وتصفية بالكامل';

  @override
  String installmentPlanDetailsScreen23(Object guarantorName) {
    return 'الضامن: $guarantorName';
  }

  @override
  String get installmentPlanDetailsScreen24 => 'صورة العقد / إيصال الأمانة';

  @override
  String get installmentPlanDetailsScreen25 =>
      'اضغط لعرض المستند بالحجم الكامل';

  @override
  String get installmentPlanDetailsScreen26 => 'مستند القسط';

  @override
  String installmentPlanDetailsScreen27(Object installmentsLength) {
    return 'جدول الأقساط ($installmentsLength)';
  }

  @override
  String get installmentPlanDetailsScreen28 => 'سداد دفعة حرة';

  @override
  String installmentPlanDetailsScreen29(
    Object installmentIndex,
    Object dueDate,
  ) {
    return 'القسط رقم $installmentIndex • $dueDate';
  }

  @override
  String installmentPlanDetailsScreen30(Object paidPiasters) {
    return 'تم السداد بالكامل ✓ ($paidPiasters)';
  }

  @override
  String installmentPlanDetailsScreen31(
    Object paidPiasters,
    Object amountPiasters,
  ) {
    return 'مدفوع $paidPiasters من $amountPiasters';
  }

  @override
  String get installmentPlanDetailsScreen32 => 'متأخر عن ميعاده ⚠️';

  @override
  String get installmentPlanDetailsScreen33 => 'مستحق السداد اليوم 🔔';

  @override
  String installmentPlanDetailsScreen34(Object amountPiasters) {
    return 'قادم • $amountPiasters';
  }

  @override
  String get installmentPlanDetailsScreen35 => 'تذكير واتساب';

  @override
  String get installmentPlanDetailsScreen36 => 'سداد';

  @override
  String get addInstallmentPlanScreen1 => 'موبايل';

  @override
  String get addInstallmentPlanScreen2 => 'شاشة تلفزيون';

  @override
  String get addInstallmentPlanScreen3 => 'غسالة';

  @override
  String get addInstallmentPlanScreen4 => 'ثلاجة';

  @override
  String get addInstallmentPlanScreen5 => 'بوتاجاز';

  @override
  String get addInstallmentPlanScreen6 => 'لابتوب';

  @override
  String get addInstallmentPlanScreen7 => 'موتوسيكل';

  @override
  String get addInstallmentPlanScreen8 => 'أثاث / مفروشات';

  @override
  String get addInstallmentPlanScreen9 => 'برجاء اختيار العميل أولاً';

  @override
  String get addInstallmentPlanScreen10 =>
      'المقدم يجب أن يكون أقل من إجمالي السعر';

  @override
  String get addInstallmentPlanScreen11 =>
      'تم إنشاء خطة القسط وجدولة الأقساط بنجاح ✓';

  @override
  String addInstallmentPlanScreen12(Object e) {
    return 'حدث خطأ: $e';
  }

  @override
  String addInstallmentPlanScreen13(Object e) {
    return 'خطأ في تحميل العملاء: $e';
  }

  @override
  String get addInstallmentPlanScreen14 => 'اختر العميل';

  @override
  String get addInstallmentPlanScreen15 => 'برجاء اختيار العميل';

  @override
  String get addInstallmentPlanScreen16 => 'بيانات السلعة والمبالغ';

  @override
  String get addInstallmentPlanScreen17 => 'اسم السلعة أو المنتج *';

  @override
  String get addInstallmentPlanScreen18 => 'مثلاً: سامسونج A15 128GB';

  @override
  String get addInstallmentPlanScreen19 => 'اسم السلعة يجب ألا يقل عن حرفين';

  @override
  String get addInstallmentPlanScreen20 => 'السعر الإجمالي (جنيه) *';

  @override
  String get addInstallmentPlanScreen21 => 'مثلاً: 12000';

  @override
  String get addInstallmentPlanScreen22 => 'مبلغ غير صحيح';

  @override
  String get addInstallmentPlanScreen23 => 'المقدم (جنيه)';

  @override
  String get addInstallmentPlanScreen24 => 'المبلغ المتبقي للتقسيط:';

  @override
  String get addInstallmentPlanScreen25 => 'المدة ودورية السداد';

  @override
  String addInstallmentPlanScreen26(Object count) {
    return '$count قسط';
  }

  @override
  String get addInstallmentPlanScreen27 => 'عدد الأقساط *';

  @override
  String get addInstallmentPlanScreen28 => 'أدخل عدداً صحيحاً';

  @override
  String get addInstallmentPlanScreen29 => 'الدورية';

  @override
  String get addInstallmentPlanScreen30 => 'تاريخ استحقاق أول قسط';

  @override
  String get addInstallmentPlanScreen31 => 'تغيير التاريخ';

  @override
  String get addInstallmentPlanScreen32 => 'الضامن والمستندات (اختياري)';

  @override
  String get addInstallmentPlanScreen33 => 'مثلاً: محمد السيد إبراهيم';

  @override
  String get addInstallmentPlanScreen34 => 'رقم موبايل الضامن';

  @override
  String get addInstallmentPlanScreen35 => 'رقم الهاتف غير صحيح';

  @override
  String get addInstallmentPlanScreen36 => 'تم التقاط صورة المستند ✓';

  @override
  String get addInstallmentPlanScreen37 =>
      'تصوير العقد / إيصال الأمانة / البطاقة';

  @override
  String get addInstallmentPlanScreen38 => 'اضغط لتغيير الصورة';

  @override
  String get addInstallmentPlanScreen39 =>
      'حفظ صورة العقد للرجوع إليها في أي وقت';

  @override
  String get addInstallmentPlanScreen40 => 'تصوير';

  @override
  String get addInstallmentPlanScreen41 => 'ملاحظات إضافية';

  @override
  String get addInstallmentPlanScreen42 => 'ربط بكشكول العميل تلقائياً';

  @override
  String get addInstallmentPlanScreen43 =>
      'تسجيل السعر الإجمالي كدين والمقدم كدفعة في حساب العميل العام';

  @override
  String addInstallmentPlanScreen44(Object scheduleLength) {
    return 'معاينة جدول الأقساط ($scheduleLength أقساط)';
  }

  @override
  String addInstallmentPlanScreen45(Object amountPiasters) {
    return 'قيمة القسط: ~$amountPiasters';
  }

  @override
  String get addInstallmentPlanScreen46 => 'حفظ خطة القسط والجدولة';

  @override
  String installmentProgressBar1(
    Object paidCount,
    Object totalCount,
    Object percentInt,
  ) {
    return 'سداد $paidCount من $totalCount قسط ($percentInt%)';
  }

  @override
  String installmentProgressBar2(Object remainingPiasters) {
    return 'باقي: $remainingPiasters';
  }

  @override
  String get installmentProgressBar3 => 'خالص بالكامل ✓';

  @override
  String get payInstallmentDialog1 => 'برجاء كتابة مبلغ سداد صحيح أكبر من صفر';

  @override
  String payInstallmentDialog2(Object amountPiasters) {
    return 'تم تسجيل سداد $amountPiasters بنجاح ✓';
  }

  @override
  String payInstallmentDialog3(Object e) {
    return 'حدث خطأ أثناء السداد: $e';
  }

  @override
  String payInstallmentDialog4(Object installmentIndex) {
    return 'سداد القسط رقم $installmentIndex';
  }

  @override
  String payInstallmentDialog5(Object itemDescription) {
    return 'سداد قسط ($itemDescription)';
  }

  @override
  String get payInstallmentDialog6 => 'المبلغ المطلوب للقسط:';

  @override
  String get payInstallmentDialog7 => 'المبلغ المدفوع (جنيه)';

  @override
  String get payInstallmentDialog8 => 'طريقة الدفع';

  @override
  String get payInstallmentDialog9 => 'كاش 💵';

  @override
  String get payInstallmentDialog10 => 'إنستاباي ⚡';

  @override
  String get payInstallmentDialog11 => 'محفظة 📱';

  @override
  String get payInstallmentDialog12 => 'تاريخ السداد';

  @override
  String get payInstallmentDialog13 => 'تغيير';

  @override
  String get payInstallmentDialog14 => 'ملاحظة (اختياري)';

  @override
  String get payInstallmentDialog15 => 'مثلاً: تحويل مع فلان';

  @override
  String get payInstallmentDialog16 => 'تسجيل في كشف حساب العميل';

  @override
  String get payInstallmentDialog17 =>
      'يخصم المبلغ تلقائياً من رصيد العميل العام';

  @override
  String get payInstallmentDialog18 => 'تأكيد السداد';

  @override
  String earlySettlementDialog1(Object itemDescription) {
    return 'تمت تسوية وتصفية قسط ($itemDescription) بنجاح ✓';
  }

  @override
  String earlySettlementDialog2(Object e) {
    return 'حدث خطأ أثناء التسوية: $e';
  }

  @override
  String get earlySettlementDialog3 => 'سداد مبكر وتصفية القسط';

  @override
  String get earlySettlementDialog4 => 'إجمالي باقي الأقساط:';

  @override
  String get earlySettlementDialog5 => 'المبلغ المطلوب تحصيله:';

  @override
  String get earlySettlementDialog6 => 'خصم تعجيل سداد (جنيه)';

  @override
  String get earlySettlementDialog7 => 'تصفية القسط الآن';

  @override
  String installmentPlanCard1(Object overdueCount) {
    return 'متأخر ($overdueCount)';
  }

  @override
  String get installmentPlanCard2 => 'مكتمل ✓';

  @override
  String get installmentPlanCard3 => 'ملغي';

  @override
  String installmentPlanCard4(Object dueDate, Object paidPiasters) {
    return 'القسط القادم: $dueDate ($paidPiasters)';
  }

  @override
  String installmentPlanCard5(Object totalPricePiasters) {
    return 'الإجمالي: $totalPricePiasters';
  }

  @override
  String get installmentRepository1 => 'وصف السلعة يجب ألا يقل عن حرفين';

  @override
  String get installmentRepository2 => 'السعر الإجمالي يجب أن يكون أكبر من صفر';

  @override
  String get installmentRepository3 => 'المقدم لا يمكن أن يكون بالسالب';

  @override
  String get installmentRepository4 =>
      'المقدم يجب أن يكون أقل من السعر الإجمالي';

  @override
  String get installmentRepository5 => 'عدد الأقساط يجب أن يكون أكبر من صفر';

  @override
  String installmentRepository6(Object trim, Object installmentCount) {
    return 'قسط: $trim ($installmentCount أقساط)';
  }

  @override
  String installmentRepository7(Object trim) {
    return 'مقدم قسط: $trim';
  }

  @override
  String get installmentRepository8 => 'مبلغ السداد يجب أن يكون أكبر من صفر';

  @override
  String installmentRepository9(Object itemDescription, Object notes) {
    return 'سداد قسط: $itemDescription$notes';
  }

  @override
  String get installmentRepository10 => 'خطة القسط غير موجودة';

  @override
  String installmentRepository11(Object itemDescription) {
    return 'سداد مبكر لقسط: $itemDescription';
  }

  @override
  String installmentRepository12(Object itemDescription) {
    return 'خصم تعجيل سداد: $itemDescription';
  }

  @override
  String get collectionScreen1 => 'أقساط مستحقة';

  @override
  String get dueInstallmentsTab1 => 'العميل ليس لديه رقم تليفون مسجل';

  @override
  String get dueInstallmentsTab2 => 'مفيش أقساط مستحقة أو متأخرة اليوم 🎉';

  @override
  String get dueInstallmentsTab3 =>
      'كل عملاء الأقساط منتظمين في السداد حتى الآن.';

  @override
  String dueInstallmentsTab4(Object dueListLength) {
    return 'مطلوب تحصيل ($dueListLength) قسط:';
  }

  @override
  String dueInstallmentsTab5(
    Object itemDescription,
    Object installmentIndex,
    Object installmentCount,
  ) {
    return '$itemDescription • القسط ($installmentIndex من $installmentCount)';
  }

  @override
  String dueInstallmentsTab6(Object daysOverdue) {
    return 'متأخر $daysOverdue يوم';
  }

  @override
  String get dueInstallmentsTab7 => 'مستحق اليوم 🔔';

  @override
  String get dueInstallmentsTab8 => 'اتصال';

  @override
  String get dueInstallmentsTab9 => 'واتساب';

  @override
  String cashDrawerScreen1(Object err) {
    return 'حدث خطأ في تحميل بيانات الدرج: $err';
  }

  @override
  String drawerLiveCard1(Object notes) {
    return 'ملاحظة: $notes';
  }

  @override
  String expensesListCard1(Object expensesLength) {
    return '$expensesLength مصروف';
  }

  @override
  String get expensesListCard2 => 'إنستاباي';

  @override
  String get expensesListCard3 => 'محفظة';

  @override
  String get drawerFlowCard1 => '(إنستاباي / محفظة)';

  @override
  String addCashSalesBottomSheet1(Object currentSalesPiasters) {
    return 'المبيعات المسجلة حتى الآن: $currentSalesPiasters';
  }

  @override
  String get addCashSalesBottomSheet2 => 'إضافة للمبيعات (+)';

  @override
  String get addCashSalesBottomSheet3 => 'تعديل الإجمالي (=)';

  @override
  String get addCashSalesBottomSheet4 => 'المبلغ المراد إضافته';

  @override
  String get addCashSalesBottomSheet5 => 'إجمالي المبيعات الجديد';

  @override
  String addCashSalesBottomSheet6(Object val) {
    return '+$val جنيه';
  }

  @override
  String drawerHistoryTab1(
    Object cashSalesPiasters,
    Object openingCashPiasters,
  ) {
    return 'مبيعات كاش: $cashSalesPiasters · افتتاح: $openingCashPiasters';
  }

  @override
  String drawerHistoryTab2(Object date) {
    return 'تفاصيل يوم $date';
  }

  @override
  String get drawerHistoryTab3 => 'الفرق';

  @override
  String get customersScreen1 => 'نظام الأقساط';

  @override
  String get customersScreen2 => 'وضع الخصوصية';

  @override
  String get customersScreen3 => 'الترتيب';

  @override
  String get customerPhotosScreen1 => 'الصورة اتضافت';

  @override
  String customerPhotosScreen2(Object pathsLength) {
    return '$pathsLength صور اتضافوا';
  }

  @override
  String get customerPhotosScreen3 => 'الصورة اتشالت';

  @override
  String get customerPhotosScreen4 => 'رجّعها';

  @override
  String customerPhotosScreen5(Object customerName) {
    return 'صور $customerName';
  }

  @override
  String get customerPhotosScreen6 => 'ضيف صور';

  @override
  String get customerPhotosScreen7 => 'حصلت مشكلة في تحميل الصور';

  @override
  String get customerPhotosScreen8 =>
      'مفيش صور للعميل ده لسه.\nصوّر صفحاته من الكشكول أو أي ورقة تخصه — الصور بتفضل على الموبايل بس.';

  @override
  String get customerPhotosScreen9 => 'شيل الصورة';

  @override
  String customerDetailsScreen1(
    Object activePlansLength,
    Object remainingPiasters,
  ) {
    return 'أقساط نشطة ($activePlansLength) • باقي: $remainingPiasters';
  }

  @override
  String get customerDetailsScreen2 => 'بيع بالتقسيط للعميل';

  @override
  String get customerDetailsScreen3 => 'عرض';

  @override
  String get customerDetailsScreen4 => 'إضافة قسط جديد';

  @override
  String get customerDetailsScreen5 => 'صور العميل';

  @override
  String get photoStrip1 => 'صوّر بالكاميرا';

  @override
  String get photoStrip2 => 'اختار من المعرض';

  @override
  String get photoStrip3 => 'تقدر تختار كذا صورة مرة واحدة';

  @override
  String get photoStrip4 => 'صورة';

  @override
  String get photoStrip5 => 'كمان';

  @override
  String get photoStrip6 => 'ضيف صورة';

  @override
  String get photoStrip7 => 'الصور';

  @override
  String photoStrip8(Object title, Object index, Object count) {
    return '$title ($index من $count)';
  }

  @override
  String get photoStrip9 => 'الصورة';

  @override
  String get photoStrip10 => 'الصورة مش موجودة على الموبايل';

  @override
  String creditLimitProgressBar1(Object limitPiasters) {
    return 'حد الدين: $limitPiasters';
  }

  @override
  String ratingExplanationBottomSheet1(Object customerName) {
    return 'تقييم العميل: $customerName';
  }

  @override
  String get ratingExplanationBottomSheet2 => 'سبب التقييم الحالي:';

  @override
  String get ratingExplanationBottomSheet3 => 'كيف يعمل نظام التقييم؟';

  @override
  String get ratingExplanationBottomSheet4 => 'ممتاز';

  @override
  String get ratingExplanationBottomSheet5 =>
      'حسابه خالص أو أقدم دين عليه لم يتجاوز 14 يوماً.';

  @override
  String get ratingExplanationBottomSheet6 => 'متابعة';

  @override
  String get ratingExplanationBottomSheet7 =>
      'أقدم دين عليه بين 15 و 45 يوماً (يستحسن تذكيره بالدفع).';

  @override
  String get ratingExplanationBottomSheet8 => 'متأخر';

  @override
  String get ratingExplanationBottomSheet9 =>
      'أقدم دين عليه تجاوز 45 يوماً أو تخطى حد الدين المحدد له.';

  @override
  String get ratingExplanationBottomSheet10 => 'جديد';

  @override
  String get ratingExplanationBottomSheet11 => 'عميل مسجل له أقل من 3 معاملات.';

  @override
  String get ratingExplanationBottomSheet12 => 'فهمت';

  @override
  String get customerWithBalance1 => 'عميل جديد';

  @override
  String get settingsScreen1 => 'بيانات المحل 🏪';

  @override
  String get settingsScreen2 => 'الحماية والخصوصية 🔒';

  @override
  String get settingsScreen3 => 'ويدجت الشاشة الرئيسية 📱';

  @override
  String get settingsScreen4 => 'رسائل التذكير والتحصيل 💬';

  @override
  String get settingsScreen5 => 'النسخ الاحتياطي والبيانات 💾';

  @override
  String get settingsScreen6 => 'مشاركة التطبيق 🚀';

  @override
  String get settingsScreen7 => 'عام ⚙️';

  @override
  String get settingsScreen8 => 'كشكول 📒';

  @override
  String get settingsScreen9 =>
      'دفتر حسابات المحل بدون نت (Offline-First)\nالإصدار 1.0.0';

  @override
  String get settingsScreen10 => 'متجر عام';

  @override
  String get settingsScreen11 => 'بقالة وسوبرماركت 🛒';

  @override
  String get settingsScreen12 => 'موبايلات وإكسسوارات 📱';

  @override
  String get settingsScreen13 => 'أجهزة كهربائية ومنزلية ⚡';

  @override
  String get settingsScreen14 => 'صيدلية ومستحضرات 💊';

  @override
  String get settingsScreen15 => 'أنشطة وتجارة حرة 🏪';

  @override
  String settingsScreen16(Object tradeName) {
    return '$tradeName • تعديل النشاط وبيانات الدفع';
  }

  @override
  String get settingsScreen17 =>
      'إخفاء مبالغ الفلوس في الشاشة والودجت (••••••)';

  @override
  String get settingsScreen18 => 'قفل التطبيق برمز PIN (4 أرقام)';

  @override
  String get settingsScreen19 => 'مفعّل ومحمي (اضغط للإلغاء)';

  @override
  String get settingsScreen20 => 'غير مفعّل (اضغط للتعيين)';

  @override
  String get settingsScreen21 => 'مفعّل 🔒';

  @override
  String get settingsScreen22 => 'إعداد';

  @override
  String get settingsScreen23 => 'تم إلغاء قفل التطبيق بنجاح';

  @override
  String get settingsScreen24 => 'تم تعيين رمز الدخول بنجاح 🔒';

  @override
  String get settingsScreen25 => 'فتح بالبصمة / Face ID';

  @override
  String get settingsScreen26 => 'استخدام البصمة بدلاً من كتابة الرمز كل مرة';

  @override
  String get settingsScreen27 => 'جهازك لا يدعم التحقق بالبصمة حالياً';

  @override
  String get settingsScreen28 => 'دقيقة واحدة';

  @override
  String get settingsScreen29 => '5 دقائق';

  @override
  String get settingsScreen30 => '15 دقيقة';

  @override
  String get settingsScreen31 => 'فوراً';

  @override
  String get settingsScreen32 => 'مدة القفل التلقائي';

  @override
  String get settingsScreen33 => 'فور الخروج من التطبيق';

  @override
  String settingsScreen34(Object timeout) {
    return 'بعد $timeout دقيقة من الخروج';
  }

  @override
  String get settingsScreen35 => 'فوراً عند الخروج';

  @override
  String get settingsScreen36 => 'بعد دقيقة واحدة';

  @override
  String get settingsScreen37 => 'بعد 5 دقائق';

  @override
  String get settingsScreen38 => 'بعد 15 دقيقة';

  @override
  String get settingsScreen39 => 'صيغة رسالة التذكير';

  @override
  String get settingsScreen40 =>
      'تعديل نص الرسالة التلقائية للعملاء والمعاينة الحية';

  @override
  String get settingsScreen41 => 'حماية التنبيهات من الإغلاق في الخلفية';

  @override
  String get settingsScreen42 =>
      'دليل عملي لضمان وصول التذكيرات لأجهزة شاومي، ريلمي، وإنفينيكس';

  @override
  String get settingsScreen43 => 'لم يتم تصدير نسخة حتى الآن';

  @override
  String get settingsScreen44 => 'آخر نسخة احتياطية';

  @override
  String get settingsScreen45 => 'تصدير نسخة احتياطية (.kashkool)';

  @override
  String get settingsScreen46 =>
      'حفظ نسخة من الدفتر والصور وإرسالها على الواتساب أو درايف';

  @override
  String get settingsScreen47 => 'تم تصدير النسخة بنجاح 👍';

  @override
  String settingsScreen48(Object e) {
    return 'فشل التصدير: $e';
  }

  @override
  String get settingsScreen49 => 'استعادة نسخة احتياطية';

  @override
  String get settingsScreen50 =>
      'استرجاع الحسابات والصور من ملف .kashkool تم حفظه مسبقاً';

  @override
  String get settingsScreen51 => 'الملف غير صالح ❌';

  @override
  String get settingsScreen52 => 'الملف المحدد ليس نسخة صالحة لتطبيق كشكول.';

  @override
  String get settingsScreen53 => 'حسناً';

  @override
  String get settingsScreen54 => 'تأكيد استعادة النسخة';

  @override
  String get settingsScreen55 =>
      'انتبه: الاستعادة ستستبدل كل البيانات الحالية المسجلة في التطبيق بالبيانات الموجودة في الملف.';

  @override
  String settingsScreen56(Object exportedAt) {
    return 'تاريخ النسخة: $exportedAt';
  }

  @override
  String settingsScreen57(Object photosCount) {
    return 'عدد الصور المرفقة: $photosCount';
  }

  @override
  String settingsScreen58(Object fileSizeBytes) {
    return 'حجم الملف: $fileSizeBytes ك.ب';
  }

  @override
  String get settingsScreen59 => 'نعم، استبدل واسترجع البيانات';

  @override
  String get settingsScreen60 => 'تمت الاستعادة بنجاح 🎉';

  @override
  String get settingsScreen61 =>
      'تم استرجاع جميع الحسابات والمعاملات والصور بنجاح. يرجى إعادة تشغيل التطبيق لتحديث كل الشاشات.';

  @override
  String get settingsScreen62 => 'إعادة التشغيل الآن';

  @override
  String settingsScreen63(Object e) {
    return 'خطأ في الاستعادة: $e';
  }

  @override
  String get settingsScreen64 => 'داكن 🌙';

  @override
  String get settingsScreen65 => 'فاتح ☀️';

  @override
  String get settingsScreen66 => 'تلقائي';

  @override
  String get settingsScreen67 => 'مظهر التطبيق';

  @override
  String get settingsScreen68 => 'تلقائي (حسب نظام الجهاز)';

  @override
  String get settingsScreen69 => 'غير محدد';

  @override
  String get settingsScreen70 => 'حد الدين الافتراضي للعميل الجديد';

  @override
  String get settingsScreen71 => 'تواصل معنا عبر واتساب';

  @override
  String get settingsScreen72 => 'للاقتراحات والمساعدة الفنية المباشرة';

  @override
  String get settingsScreen73 =>
      'https://wa.me/201000000000?text=السلام%20عليكم%20عندي%20استفسار%20عن%20تطبيق%20كشكول';

  @override
  String get settingsScreen74 => 'سياسة الخصوصية وشروط الاستخدام';

  @override
  String get settingsScreen75 =>
      'بياناتك ملكك بالكامل ومتخزنة على تليفونك فقط بدون إنترنت';

  @override
  String get settingsScreen76 => 'سياسة الخصوصية في كشكول 🔒';

  @override
  String get settingsScreen77 =>
      '1. تطبيق كشكول هو تطبيق يعمل بالكامل بدون اتصال بالإنترنت (Offline-First).\n\n2. جميع الحسابات والأسماء وأرقام الهواتف وصور الفواتير والمعاملات مخزنة محلياً على جهازك فقط، ولا يتم إرسال أي بيانات لأي خادم خارجي.\n\n3. أنت المسؤول الأول عن عمل نسخة احتياطية بشكل دوري عبر خيار (تصدير نسخة احتياطية) لحفظ بياناتك في حال تغيير أو فقدان الهاتف.\n\n4. كشكول صُمم لخدمة أصحاب المحلات والتجار لحفظ حقوقهم وتسهيل متابعة ديونهم بكل أمان.';

  @override
  String get settingsScreen78 => 'نظام الجهاز (تلقائي)';

  @override
  String get settingsScreen79 => 'حد الدين الافتراضي (جنيه)';

  @override
  String get settingsScreen80 => 'المبلغ بالجنيه';

  @override
  String get settingsScreen81 => 'اتركه فارغاً لجعله غير محدد';

  @override
  String get settingsScreen82 => 'حفظ';

  @override
  String batteryGuideBottomSheet1(Object brandName) {
    return 'دليل حماية الإشعارات ($brandName)';
  }

  @override
  String get batteryGuideBottomSheet2 => 'دليل حماية التنبيهات من الإغلاق';

  @override
  String get batteryGuideBottomSheet3 =>
      'تقوم بعض الهواتف (مثل شاومي، ريلمي، إنفينيكس، وهواوي) بإيقاف التطبيقات في الخلفية لتوفير البطارية. لضمان وصول تذكير التحصيل اليومي ومواعيد الأقساط بدقة، يُرجى تطبيق الخطوات التالية:';

  @override
  String get batteryGuideBottomSheet4 => 'فتح إعدادات بطارية الهاتف الآن';

  @override
  String get backupReminderBanner1 => 'تم تصدير النسخة الاحتياطية بنجاح 👍';

  @override
  String backupReminderBanner2(Object e) {
    return 'حدث خطأ أثناء النسخ: $e';
  }

  @override
  String get backupReminderBanner3 => 'تنبيه: محتاج تعمل نسخة احتياطية ⚠️';

  @override
  String get backupReminderBanner4 =>
      'فات أكثر من 7 أيام من آخر نسخة. احفظ بياناتك عشان لو التليفون ضاع أو اتغير مفيش أي حساب يضيع.';

  @override
  String get backupReminderBanner5 => 'تجاهل مؤقتاً';

  @override
  String get backupReminderBanner6 => 'جاري الحفظ...';

  @override
  String get backupReminderBanner7 => 'نسخ احتياطي الآن';

  @override
  String get homeWidgetSettingsCard1 => 'عرض حساباتك على الشاشة الرئيسية';

  @override
  String get homeWidgetSettingsCard2 =>
      'الويدجت بتعرض ليك عند الناس والمحصّل النهارده من غير ما تفتح التطبيق';

  @override
  String get homeWidgetSettingsCard3 => 'الويدجت متوقفة ومش بتعرض أي أرقام';

  @override
  String get homeWidgetSettingsCard4 => 'ضيف الويدجت الصغيرة';

  @override
  String get homeWidgetSettingsCard5 => 'ليك عند الناس بس';

  @override
  String get homeWidgetSettingsCard6 => 'ضيف ويدجت ملخص اليوم';

  @override
  String get homeWidgetSettingsCard7 =>
      'ليك عند الناس + المحصّل النهارده + المستحقين + زرار تحصيل';

  @override
  String get homeWidgetSettingsCard8 =>
      'وافق على الرسالة اللي ظهرت عشان الويدجت تتضاف للشاشة 👍';

  @override
  String get homeWidgetSettingsCard9 => 'ضيف الويدجت بإيدك 📱';

  @override
  String get homeWidgetSettingsCard10 =>
      'موبايلك مش بيسمح للتطبيق يضيفها لوحده. اعمل كده:\n\n1. اضغط ضغطة طويلة على مكان فاضي في الشاشة الرئيسية\n2. اختار \"الأدوات\" أو \"Widgets\"\n3. دوّر على \"كشكول\" واسحب الويدجت للشاشة';

  @override
  String get messageTemplateEditorBottomSheet1 => 'بقالة الأمانة';

  @override
  String get messageTemplateEditorBottomSheet2 => 'فودافون كاش: 01012345678';

  @override
  String get messageTemplateEditorBottomSheet3 => 'محمد أحمد';

  @override
  String get messageTemplateEditorBottomSheet4 =>
      'تم حفظ نموذج الرسالة بنجاح 👍';

  @override
  String get messageTemplateEditorBottomSheet5 => 'تعديل رسالة التذكير 💬';

  @override
  String get messageTemplateEditorBottomSheet6 => 'نماذج جاهزة: ';

  @override
  String get messageTemplateEditorBottomSheet7 => 'ودّي 😊';

  @override
  String get messageTemplateEditorBottomSheet8 => 'رسمي 👔';

  @override
  String get messageTemplateEditorBottomSheet9 => 'اسم المحل';

  @override
  String get messageTemplateEditorBottomSheet10 => 'بيانات الدفع';

  @override
  String get messageTemplateEditorBottomSheet11 => 'تاريخ آخر حركة';

  @override
  String get messageTemplateEditorBottomSheet12 =>
      'اكتب نص رسالة التذكير هنا...';

  @override
  String get messageTemplateEditorBottomSheet13 =>
      'معاينة الرسالة كما ستصل للعميل:';

  @override
  String get messageTemplateEditorBottomSheet14 => 'حفظ النموذج';

  @override
  String shopProfileBottomSheet1(Object trim) {
    return 'محفظة كاش: $trim';
  }

  @override
  String get shopProfileBottomSheet2 => 'تم حفظ بيانات المحل بنجاح 👍';

  @override
  String get shopProfileBottomSheet3 => 'اسم المحل *';

  @override
  String get shopProfileBottomSheet4 => 'مثلاً: بقالة الأمانة';

  @override
  String get shopProfileBottomSheet5 => 'يرجى إدخال اسم المحل';

  @override
  String get shopProfileBottomSheet6 => 'رقم هاتف المحل';

  @override
  String get shopProfileBottomSheet7 => 'مثلاً: 010xxxxxxxx';

  @override
  String get shopProfileBottomSheet8 => 'عنوان المحل';

  @override
  String get shopProfileBottomSheet9 =>
      'مثلاً: شارع السوق، بجوار المسجد الكبير';

  @override
  String get shopProfileBottomSheet10 => 'حساب إنستاباي (InstaPay)';

  @override
  String get shopProfileBottomSheet11 => 'مثلاً: name@instapay';

  @override
  String get shopProfileBottomSheet12 => 'رقم فودافون كاش / المحفظة الذكية';

  @override
  String get shopProfileBottomSheet13 => 'نوع النشاط التجاري';

  @override
  String get shopProfileBottomSheet14 => 'نشاط وتجارة أخرى 🏪';

  @override
  String get shopProfileBottomSheet15 => 'تفعيل نظام الأقساط';

  @override
  String get shopProfileBottomSheet16 =>
      'إظهار زر الأقساط وجداول السداد في التطبيق';

  @override
  String get shopProfileBottomSheet17 => 'حفظ التعديلات';

  @override
  String get cloudAccountButton1 => 'حسابك والنسخ على السحابة ☁️';

  @override
  String get cloudAccountButton2 => 'النسخ على السحابة';

  @override
  String get cloudAccountButton3 => 'سجّل دخول بحساب جوجل';

  @override
  String get cloudBackupCard1 => 'لحظة…';

  @override
  String get cloudBackupCard2 => 'حصلت مشكلة غير متوقعة، جرّب تاني';

  @override
  String get cloudBackupCard3 => 'بنفتح حسابات جوجل…';

  @override
  String cloudBackupCard4(Object email) {
    return 'اتسجّل الدخول بـ $email ✓';
  }

  @override
  String get cloudBackupCard5 => 'النسخة اترفعت مع ملاحظات ⚠️';

  @override
  String cloudBackupCard6(Object uploaded, Object rejected, Object n) {
    return 'اترفع $uploaded سجل، و $rejected سجل اترفض:\n\n$n';
  }

  @override
  String get cloudBackupCard7 => 'كل بياناتك متخزنة على السحابة بالفعل ✓';

  @override
  String cloudBackupCard8(Object uploaded) {
    return 'اترفع $uploaded سجل على السحابة ✓';
  }

  @override
  String get cloudBackupCard9 => 'بنجيب المحلات اللي على حسابك…';

  @override
  String get cloudBackupCard10 => 'مفيش نسخة على السحابة للحساب ده لسه';

  @override
  String get cloudBackupCard11 => 'اختار المحل';

  @override
  String get cloudBackupCard12 => ' (عامل)';

  @override
  String get cloudBackupCard13 => 'استرجاع من السحابة؟';

  @override
  String cloudBackupCard14(Object name) {
    return 'هننزّل نسخة \"$name\" اللي على السحابة ونضيفها على الموبايل ده.\n\n';
  }

  @override
  String get cloudBackupCard15 =>
      'مش هنمسح أي حاجة: البيانات اللي على الموبايل بس هتفضل، ولو حاجة اتعدلت على الموبايل بعد آخر نسخة هنسيبها زي ما هي.';

  @override
  String get cloudBackupCard16 => 'أيوه، استرجع';

  @override
  String get cloudBackupCard17 => 'تم الاسترجاع 🎉';

  @override
  String cloudBackupCard18(Object keptLocal) {
    return '، واتساب $keptLocal سجل زي ما هو لأن نسخة الموبايل أحدث';
  }

  @override
  String cloudBackupCard19(Object records, Object keptLocal) {
    return 'اترجع $records سجل$keptLocal.';
  }

  @override
  String get cloudBackupCard20 =>
      ' اقفل التطبيق وافتحه تاني عشان كل الشاشات تتحدث.';

  @override
  String get cloudBackupCard21 => 'اقفل التطبيق';

  @override
  String get cloudBackupCard22 => 'تسجيل خروج؟';

  @override
  String get cloudBackupCard23 =>
      'بياناتك هتفضل على الموبايل وعلى السحابة. بس النسخ هيقف لحد ما تسجّل دخول تاني.';

  @override
  String get cloudBackupCard24 => 'خروج';

  @override
  String get cloudBackupCard25 => 'مش متاح في النسخة دي من التطبيق';

  @override
  String get cloudBackupCard26 => 'النسخ الاحتياطي على السحابة';

  @override
  String get cloudBackupCard27 =>
      'سجّل بحساب جوجل وبياناتك تتحفظ أونلاين. لو الموبايل ضاع، ترجّعها على أي موبايل تاني.';

  @override
  String get cloudBackupCard28 => 'لسه مفيش نسخة';

  @override
  String cloudBackupCard29(Object last) {
    return 'آخر نسخة: $last';
  }

  @override
  String get cloudBackupCard30 => 'بيرفع دلوقتي…';

  @override
  String get cloudBackupCard31 => 'مستني النت — هيرفع لوحده أول ما يرجع';

  @override
  String get cloudBackupCard32 => 'الرفع وقف، هنحاول تاني بعد شوية';

  @override
  String get cloudBackupCard33 => 'كله مرفوع ✓';

  @override
  String get cloudBackupCard34 => 'الرفع تلقائي لما النت يكون شغال';

  @override
  String get cloudBackupCard35 => 'ارفع نسخة احتياطية دلوقتي';

  @override
  String get cloudBackupCard36 => 'استرجع بياناتك على الموبايل ده';

  @override
  String get cloudBackupCard37 =>
      'لموبايل جديد أو بعد مسح التطبيق — مش بيمسح حاجة';

  @override
  String get cloudBackupCard38 => 'تسجيل خروج';

  @override
  String get onboardingScreen1 => 'محلي';

  @override
  String get onboardingScreen2 =>
      'تمت إضافة عملاء تجريبيين لتجربة التطبيق، يمكنك حذفهم في أي وقت';

  @override
  String get onboardingScreen3 => 'تهيئة كشكول لأول مرة';

  @override
  String get onboardingScreen4 => 'متابعة نوع النشاط';

  @override
  String get onboardingScreen5 => 'أهلاً بك في كشكول! 👋';

  @override
  String get onboardingScreen6 =>
      'دفترك الإلكتروني لحسابات الديون، التحصيل بالواتساب، والأقساط بدون تعقيد.';

  @override
  String get onboardingScreen7 => 'اسم المحل أو الكشكول *';

  @override
  String get onboardingScreen8 => 'مثال: بقالة الأمانة / موبايلات النجم';

  @override
  String get onboardingScreen9 => 'يرجى كتابة اسم المحل (حرفين على الأقل)';

  @override
  String get onboardingScreen10 => 'رقم هاتف المحل (اختياري)';

  @override
  String get onboardingScreen11 =>
      'يظهر في فواتير وكشوفات الحساب وتذييل رسائل الواتساب';

  @override
  String get onboardingScreen12 => 'بقالة وسوبرماركت';

  @override
  String get onboardingScreen13 => 'حسابات الديون اليومية وسرعة إغلاق الدرج';

  @override
  String get onboardingScreen14 => 'موبايلات وإكسسوارات';

  @override
  String get onboardingScreen15 =>
      'بيانات الأجهزة ويفعّل نظام الأقساط تلقائياً';

  @override
  String get onboardingScreen16 => 'أجهزة كهربائية ومنزلية';

  @override
  String get onboardingScreen17 =>
      'عقود بيع بالآجل ويفعّل نظام الأقساط تلقائياً';

  @override
  String get onboardingScreen18 => 'صيدلية ومستحضرات';

  @override
  String get onboardingScreen19 => 'حدود الائتمان ومتابعة ديون الروشتات';

  @override
  String get onboardingScreen20 => 'أنشطة وتجارة أخرى';

  @override
  String get onboardingScreen21 => 'دفتر مرن ومناسب لجميع أنواع التجارة الحرة';

  @override
  String get onboardingScreen22 => 'ما هو نوع نشاطك التجاري؟';

  @override
  String get onboardingScreen23 =>
      'سنقوم بتهيئة واجهة التطبيق والأقسام بناءً على طبيعة شغلك.';

  @override
  String get onboardingScreen24 => 'يدعم الأقساط';

  @override
  String get onboardingScreen25 => 'تفعيل نظام وجداول الأقساط';

  @override
  String get onboardingScreen26 =>
      'يمكنك تشغيله أو إيقافه في أي وقت من الإعدادات';

  @override
  String get onboardingScreen27 => 'ضمان وصول الإشعارات والتذكيرات 🔔';

  @override
  String get onboardingScreen28 =>
      'حتى يعمل كشكول في موعده اليومي لتنبيهك بالتحصيلات ومواعيد الأقساط:';

  @override
  String get onboardingScreen29 => 'إذن إرسال الإشعارات';

  @override
  String get onboardingScreen30 => 'تم تفعيل الإشعارات بنجاح ✅';

  @override
  String get onboardingScreen31 =>
      'محتاجين إذن الإشعارات عشان نبعتلك ملخص التحصيل اليومي';

  @override
  String get onboardingScreen32 => 'السماح بالإشعارات الآن';

  @override
  String onboardingScreen33(Object brandName) {
    return 'حماية التطبيق في الخلفية ($brandName)';
  }

  @override
  String get onboardingScreen34 => 'حماية التطبيق من الإغلاق في الخلفية';

  @override
  String get onboardingScreen35 => 'فتح إعدادات بطارية الهاتف';

  @override
  String get onboardingScreen36 => 'جاهز للانطلاق! 🚀';

  @override
  String get onboardingScreen37 => 'تم حفظ بيانات محلك. كيف تود أن تبدأ الآن؟';

  @override
  String get onboardingScreen38 => '+ إضافة أول عميل حقيقي';

  @override
  String get onboardingScreen39 =>
      'سجل أول عميل وابدأ تدوين الديون والدفعات مباشرة';

  @override
  String get onboardingScreen40 => 'جرب ببيانات تجريبية أولاً 💡';

  @override
  String get onboardingScreen41 =>
      'إضافة عميلين وحسابات تجريبية لاكتشاف مميزات كشكول (يمكن حذفهم بضغطة زر)';

  @override
  String get onboardingScreen42 => 'تخطي والذهاب إلى الشاشة الرئيسية';

  @override
  String get shopRepository1 => 'أحمد محمد (تجريبي)';

  @override
  String get shopRepository2 => 'مشتريات طلبات منزلية';

  @override
  String get shopRepository3 => 'محمود إبراهيم (تجريبي)';

  @override
  String get shopRepository4 => 'بضاعة أول الشهر';

  @override
  String get shopRepository5 => 'دفعة نقدية على الحساب';

  @override
  String get supplierWithBalance1 => 'السبت';

  @override
  String get supplierWithBalance2 => 'الأحد';

  @override
  String get supplierWithBalance3 => 'الإثنين';

  @override
  String get supplierWithBalance4 => 'الثلاثاء';

  @override
  String get supplierWithBalance5 => 'الأربعاء';

  @override
  String get supplierWithBalance6 => 'الخميس';

  @override
  String get supplierWithBalance7 => 'الجمعة';

  @override
  String get trashScreen1 => 'عملاء';

  @override
  String get trashScreen2 => 'عمليات';

  @override
  String get trashScreen3 => 'موردين';

  @override
  String get trashScreen4 => 'مصاريف';

  @override
  String get trashScreen5 => 'أقساط';

  @override
  String trashScreen6(Object title) {
    return 'رجع \"$title\" ✓';
  }

  @override
  String get trashScreen7 => 'مقدرناش نرجّعه، جرّب تاني';

  @override
  String get trashScreen8 => 'سلة المحذوفات 🗑️';

  @override
  String get trashScreen9 =>
      'أي حاجة بتمسحها بتتنقل هنا ومش بتضيع. تقدر ترجّعها في أي وقت، وهترجع كمان في النسخة اللي على السحابة.';

  @override
  String get trashScreen10 => 'حصلت مشكلة في تحميل المحذوفات';

  @override
  String get trashScreen11 => 'السلة فاضية ✨';

  @override
  String trashScreen12(Object deletedAt) {
    return 'اتمسح $deletedAt';
  }

  @override
  String get trashScreen13 => 'رجّع';

  @override
  String get trashScreen14 => 'سلة المحذوفات';

  @override
  String get trashScreen15 => 'شوف اللي اتمسح ورجّعه';

  @override
  String trashScreen16(Object count) {
    return 'فيها $count حاجة — تقدر ترجّعها';
  }

  @override
  String get trashRepository1 => 'إيجار';

  @override
  String get trashRepository2 => 'كهربا';

  @override
  String get trashRepository3 => 'مرتبات';

  @override
  String get trashRepository4 => 'مستلزمات';

  @override
  String get trashRepository5 => 'دفع لمورد';

  @override
  String get trashRepository6 => 'مصروف';

  @override
  String get trashRepository7 => 'عليّا';

  @override
  String get trashRepository8 => 'دفع';

  @override
  String get trashRepository9 => 'دفعتله';

  @override
  String get trashRepository10 => 'غير معروف';

  @override
  String trashRepository11(Object itemDescription) {
    return 'تقسيط: $itemDescription';
  }

  @override
  String pdfStatementService1(Object sanitizedName, Object dateStr) {
    return 'كشف_حساب_${sanitizedName}_$dateStr.pdf';
  }

  @override
  String get pdfStatementService2 => 'كشف حساب عميل';

  @override
  String pdfStatementService3(Object customerName) {
    return 'العميل: $customerName';
  }

  @override
  String pdfStatementService4(Object phone) {
    return 'التليفون: $phone';
  }

  @override
  String pdfStatementService5(Object periodDescription) {
    return 'الفترة: $periodDescription';
  }

  @override
  String get pdfStatementService6 => 'رصيد ما قبل هذه الفترة:';

  @override
  String get pdfStatementService7 => 'التاريخ';

  @override
  String get pdfStatementService8 => 'البيان';

  @override
  String get pdfStatementService9 => 'الرصيد';

  @override
  String pdfStatementService10(Object periodDebitsPiasters) {
    return 'إجمالي المشتريات / السلف: $periodDebitsPiasters';
  }

  @override
  String pdfStatementService11(Object periodCreditsPiasters) {
    return 'إجمالي المسدد: $periodCreditsPiasters';
  }

  @override
  String get pdfStatementService12 => 'الرصيد النهائي المطلوب:';

  @override
  String pdfStatementService13(Object trim) {
    return 'طرق الدفع المتاحة: $trim';
  }

  @override
  String get pdfStatementService14 => 'اتعمل بكشكول — جرّبه ببلاش:';

  @override
  String get statementCalculator1 => 'كل المعاملات';

  @override
  String get statementCalculator2 => 'يناير';

  @override
  String get statementCalculator3 => 'فبراير';

  @override
  String get statementCalculator4 => 'مارس';

  @override
  String get statementCalculator5 => 'أبريل';

  @override
  String get statementCalculator6 => 'مايو';

  @override
  String get statementCalculator7 => 'يونيو';

  @override
  String get statementCalculator8 => 'يوليو';

  @override
  String get statementCalculator9 => 'أغسطس';

  @override
  String get statementCalculator10 => 'سبتمبر';

  @override
  String get statementCalculator11 => 'أكتوبر';

  @override
  String get statementCalculator12 => 'نوفمبر';

  @override
  String get statementCalculator13 => 'ديسمبر';

  @override
  String statementCalculator14(Object startDate, Object endDate) {
    return 'من $startDate إلى $endDate';
  }

  @override
  String statementCalculator15(Object startDate) {
    return 'من $startDate';
  }

  @override
  String statementCalculator16(Object endDate) {
    return 'حتى $endDate';
  }

  @override
  String growthFooter1(Object shopCode) {
    return '—\nاتعمل بكشكول 📒 جرّبه ببلاش: $shopCode';
  }

  @override
  String growthFooter2(Object shopCode) {
    return 'أنا بستخدم كشكول 📒 عشان أتابع حسابات الزباين والموردين والدرج من غير دفتر ورق.\nسهل جداً وشغال من غير نت. جرّبه ببلاش:\n$shopCode';
  }

  @override
  String get notificationService1 => 'التحصيل اليومي';

  @override
  String get notificationService2 =>
      'تذكير بالعملاء المستحقين للتحصيل ومواعيد دفعهم';

  @override
  String notificationService3(Object dueCount, Object amountStr) {
    return 'عندك $dueCount عملاء عليهم $amountStr — اضغط للتحصيل';
  }

  @override
  String get notificationService4 => 'تذكير التحصيل اليومي 📒';

  @override
  String get backupService1 => 'ملف قاعدة البيانات غير موجود';

  @override
  String backupService2(Object dateStr) {
    return 'نسخة احتياطية لتطبيق كشكول - $dateStr';
  }

  @override
  String get backupService3 => 'الملف المحدد غير موجود';

  @override
  String get backupService4 => 'الملف تالف أو غير مكتمل';

  @override
  String get backupService5 => 'صيغة الملف غير صحيحة (ليست ملف كشكول صالح)';

  @override
  String get backupService6 => 'الملف لا يحتوي على قاعدة بيانات كشكول';

  @override
  String get backupService7 => 'قاعدة البيانات داخل الملف تالفة';

  @override
  String get backupService8 => 'الملف ليس قاعدة بيانات SQLite صالحة';

  @override
  String get backupService9 => 'ملف النسخة الاحتياطية غير صالح';

  @override
  String get backupService10 => 'ملف قاعدة البيانات مفقود داخل الأرشيف';

  @override
  String get googleAuthService1 =>
      'النسخ على السحابة مش متظبط في النسخة دي من التطبيق';

  @override
  String get googleAuthService2 => 'جوجل مارجعش بيانات الدخول، جرّب تاني';

  @override
  String get googleAuthService3 => 'تم إلغاء تسجيل الدخول';

  @override
  String googleAuthService4(Object codeName) {
    return 'مقدرناش نسجّل دخول بجوجل ($codeName)';
  }

  @override
  String get cloudApi1 => 'عنوان السيرفر مش متظبط في النسخة دي من التطبيق';

  @override
  String get cloudApi2 => 'سجّل دخول بحساب جوجل الأول';

  @override
  String get cloudApi3 => 'مفيش اتصال بالإنترنت، جرّب تاني';

  @override
  String get cloudApi4 => 'السيرفر اتأخر في الرد، جرّب تاني';

  @override
  String get cloudApi5 => 'انتهت صلاحية الدخول، سجّل دخول بحساب جوجل تاني';

  @override
  String get cloudApi6 => 'المحل ده متسجل على حساب جوجل تاني';

  @override
  String get cloudApi7 => 'الميزة دي محتاجة اشتراك';

  @override
  String get cloudApi8 => 'محاولات كتير، استنى شوية وجرّب تاني';

  @override
  String get cloudApi9 => 'سجّل دخول بحساب جوجل تاني';

  @override
  String get cloudApi10 => 'تسجيل الدخول بجوجل مش متظبط على السيرفر';

  @override
  String get cloudApi11 => 'حصلت مشكلة في السيرفر، جرّب بعد شوية';

  @override
  String cloudApi12(Object code) {
    return 'حصلت مشكلة ($code)';
  }

  @override
  String get cloudBackupService1 => 'تسجيل الدخول بجوجل مش متاح';

  @override
  String get cloudBackupService2 => 'كمّل بيانات المحل الأول من الإعدادات';

  @override
  String get cloudBackupService3 => 'بنجهّز بيانات المحل…';

  @override
  String cloudBackupService4(Object length, Object changesLength) {
    return 'بنرفع $length من $changesLength…';
  }

  @override
  String get cloudBackupService5 => 'خلصنا ✓';

  @override
  String cloudBackupService6(Object changesLength) {
    return 'بننزّل البيانات… ($changesLength)';
  }

  @override
  String cloudBackupService7(Object changesLength) {
    return 'بنحفظ $changesLength سجل على الموبايل…';
  }

  @override
  String get cloudBackupService8 => 'المحل';

  @override
  String autoBackupCoordinator1(Object rejected) {
    return '$rejected سجل مترفعش';
  }

  @override
  String get autoBackupCoordinator2 => 'حصلت مشكلة، هنحاول تاني بعد شوية';

  @override
  String get customerRating1 => 'عميل جديد (سجل أقل من 3 معاملات)';

  @override
  String get customerRating2 => 'حسابه خالص وبيدفع في مواعيده بانتظام';

  @override
  String customerRating3(Object oldestUnpaidAgeDays) {
    return 'متأخر: أقدم دين عليه من $oldestUnpaidAgeDays يوم وتخطى حد الدين';
  }

  @override
  String get customerRating4 => 'تعدى حد الدين المحدد للعميل';

  @override
  String get customerRating5 => 'سجل ديناً اليوم فقط وحسابه منتظم';

  @override
  String customerRating6(Object oldestUnpaidAgeDays) {
    return 'أقدم مبلغ عليه من $oldestUnpaidAgeDays يوم فقط (في نطاق الأمان)';
  }

  @override
  String customerRating7(Object oldestUnpaidAgeDays) {
    return 'أقدم مبلغ عليه من $oldestUnpaidAgeDays يوم (متأخر عن 45 يوم)';
  }

  @override
  String customerRating8(Object oldestUnpaidAgeDays) {
    return 'أقدم مبلغ عليه من $oldestUnpaidAgeDays يوم (يحتاج متابعة)';
  }

  @override
  String get whatsappTemplate1 =>
      'السلام عليكم أ/ {customer_name} 👋\nمعاك {shop_name}.\nرصيدك الحالي: {balance}\nآخر عملية: {last_transaction_date} - {last_transaction_amount}\nللدفع: {payment_info}\nشكراً لتعاملك معانا 🙏';

  @override
  String get whatsappTemplate2 =>
      'تحية طيبة أ/ {customer_name}\nنود تذكيركم بأن الحساب الحالي لدى {shop_name} يبلغ {balance}.\nآخر عملية مسجلة: {last_transaction_date} ({last_transaction_amount})\nطرق السداد المتاحة: {payment_info}\nمع خالص الشكر والتقدير.';

  @override
  String get whatsappTemplate3 =>
      'السلام عليكم أ/ {customer_name} 👋\nمعاك {shop_name}.\nبنفكرك بميعاد استحقاق قسط ({item}) - القسط رقم {installment_number} من {installment_count}:\nالمبلغ المستحق: {amount}\nتاريخ الاستحقاق: {due_date}\nإجمالي المتبقي من الأقساط: {remaining_total}\nطرق السداد المتاحة: {payment_info}\nشكراً لالتزامك معانا 🙏';

  @override
  String get whatsappTemplate4 => 'كاش في المحل أو التحويل المتاح';

  @override
  String get money1 => 'جنيه';

  @override
  String get batteryOptimizationHelper1 => 'نظام XOS / HiOS';

  @override
  String get batteryOptimizationHelper2 =>
      'افتح تطبيق Phone Master (مدير الهاتف) الموجود على جهازك.';

  @override
  String get batteryOptimizationHelper3 =>
      'ادخل على \"إدارة التشغيل التلقائي (Auto-start)\" وفعّل تطبيق كشكول.';

  @override
  String get batteryOptimizationHelper4 =>
      'في إعدادات التطبيق، ادخل على \"البطارية\" واختر \"بلا قيود (Unrestricted)\".';

  @override
  String get batteryOptimizationHelper5 =>
      'في شاشة التطبيقات المفتوحة، اسحب التطبيق لأسفل لتثبيته بالقفل 🔒.';

  @override
  String get batteryOptimizationHelper6 => 'نظام MIUI / HyperOS';

  @override
  String get batteryOptimizationHelper7 =>
      'ادخل على إعدادات التطبيق وفعّل \"التشغيل التلقائي (Autostart)\".';

  @override
  String get batteryOptimizationHelper8 =>
      'من \"موفر البطارية (Battery Saver)\"، اختر \"بلا قيود (No Restrictions)\".';

  @override
  String get batteryOptimizationHelper9 =>
      'من شاشة التطبيقات الحديثة، اضغط ضغطة مطولة على كشكول واختر أيقونة القفل 🔒.';

  @override
  String get batteryOptimizationHelper10 => 'نظام ColorOS / Realme UI';

  @override
  String get batteryOptimizationHelper11 =>
      'من إعدادات التطبيق -> استخدام البطارية، فعّل \"السماح بالنشاط في الخلفية\".';

  @override
  String get batteryOptimizationHelper12 =>
      'فعّل خيار \"التشغيل التلقائي (Auto-launch)\".';

  @override
  String get batteryOptimizationHelper13 =>
      'في قائمة التطبيقات المفتوحة، اضغط على النقاط الثلاث واختر \"تثبيت (Lock)\".';

  @override
  String get batteryOptimizationHelper14 => 'نظام One UI';

  @override
  String get batteryOptimizationHelper15 =>
      'ادخل على الإعدادات -> العناية بالجهاز (Device Care) -> البطارية.';

  @override
  String get batteryOptimizationHelper16 =>
      'ادخل على \"حدود استخدام الخلفية (Background usage limits)\".';

  @override
  String get batteryOptimizationHelper17 =>
      'أضف كشكول إلى قائمة \"التطبيقات التي لا تنام أبداً (Never sleeping apps)\".';

  @override
  String get batteryOptimizationHelper18 => 'نظام EMUI / MagicOS';

  @override
  String get batteryOptimizationHelper19 =>
      'ادخل على الإعدادات -> البطارية -> بدء تشغيل التطبيقات (App Launch).';

  @override
  String get batteryOptimizationHelper20 =>
      'ابحث عن \"كشكول\"، حوّل الإدارة إلى يدوية، وفعّل (التشغيل التلقائي + العمل في الخلفية).';

  @override
  String get batteryOptimizationHelper21 => 'إعدادات النظام';

  @override
  String get batteryOptimizationHelper22 => 'حماية إشعارات النظام';

  @override
  String get batteryOptimizationHelper23 =>
      'ادخل على معلومات التطبيق في إعدادات الهاتف.';

  @override
  String get batteryOptimizationHelper24 =>
      'ادخل على قسم \"البطارية (Battery)\" واختر \"غير مقيد (Unrestricted)\".';

  @override
  String get batteryOptimizationHelper25 =>
      'تأكد من عدم تفعيل وضع توفير الطاقة الفائق على الهاتف لضمان وصول تنبيهات التحصيل.';

  @override
  String get homeWidgetService1 => 'مفيش';

  @override
  String get homeWidgetService2 => 'عميل واحد';

  @override
  String get homeWidgetService3 => 'عميلين';

  @override
  String homeWidgetService4(Object count) {
    return '$count عملاء';
  }

  @override
  String get pinLockScreen1 => 'رمز الدخول غير صحيح، حاول تاني';

  @override
  String get pinLockScreen2 => 'الرمزان غير متطابقين، حاول من جديد';

  @override
  String get pinLockScreen3 =>
      'البصمة غير متاحة أو غير مفعّلة في إعدادات جهازك';

  @override
  String get pinLockScreen4 => 'أهلاً بيك في كشكول 📒';

  @override
  String get pinLockScreen5 => 'تعيين رمز دخول جديد';

  @override
  String get pinLockScreen6 => 'أعد كتابة الرمز للتأكيد';

  @override
  String get pinLockScreen7 => 'أدخل رمز الدخول المكون من 4 أرقام';

  @override
  String get pinLockScreen8 => 'اكتب 4 أرقام تفتكرهم عشان تقفل بيهم التطبيق';

  @override
  String get pinLockScreen9 => 'اكتب نفس الأرقام مرة تانية';

  @override
  String get pinLockScreen10 => 'بصمة الإصبع';

  @override
  String get pinLockScreen11 => 'مسح';

  @override
  String get securityService1 => 'تأكيد الهوية لفتح كشكول';

  @override
  String get settingsLanguageTitle => 'اللغة';

  @override
  String get settingsLanguageSystem => 'لغة الموبايل (تلقائي)';

  @override
  String get cloudDeleteAccountTitle => 'احذف حسابي على السحابة';

  @override
  String get cloudDeleteAccountSubtitle =>
      'بيمسح نسخ السحابة وحسابك نهائي — بياناتك على الموبايل مش هتتمسح';

  @override
  String get cloudDeleteAccountConfirmTitle => 'تمسح حسابك نهائي؟';

  @override
  String get cloudDeleteAccountConfirmBody =>
      'هنمسح حسابك وكل النسخ اللي على السحابة للمحلات اللي إنت صاحبها، ومش هينفع نرجّعهم. البيانات اللي على الموبايل ده هتفضل زي ما هي.';

  @override
  String get cloudDeleteAccountConfirmButton => 'امسح نهائي';

  @override
  String get cloudDeleteAccountDone => 'اتمسح حسابك من السحابة';

  @override
  String get authFirstTimeTitle => 'أهلاً بك في كشكول! 👋';

  @override
  String get authFirstTimeQuestion => 'هل عندك حساب بالفعل ولا مستخدم جديد؟';

  @override
  String get authHaveAccount => 'عندي حساب بالفعل';

  @override
  String get authHaveAccountSubtitle =>
      'سجّل دخولك وهنرجعلك كل بيانات محلك فوراً';

  @override
  String get authNewUser => 'مستخدم جديد';

  @override
  String get authNewUserSubtitle => 'ابدأ كشكول جديد وجهّز محلك خطوة بخطوة';

  @override
  String get authContinueGuest => 'المتابعة كضيف (بدون حساب)';

  @override
  String get authContinueGuestSubtitle =>
      'استخدم التطبيق محلياً بدون إنترنت خالص';

  @override
  String get authLogin => 'تسجيل الدخول';

  @override
  String get authRegister => 'إنشاء حساب جديد';

  @override
  String get authEmail => 'البريد الإلكتروني';

  @override
  String get authPassword => 'كلمة المرور';

  @override
  String get authPasswordConfirm => 'تأكيد كلمة المرور';

  @override
  String get authNameOptional => 'الاسم (اختياري)';

  @override
  String get authLoginButton => 'تسجيل الدخول';

  @override
  String get authRegisterButton => 'إنشاء حساب';

  @override
  String get authOrGoogle => 'أو المتابعة بحساب Google';

  @override
  String get authSignInWithGoogle => 'تسجيل الدخول بحساب Google';

  @override
  String get authSignInWithGoogleSubtitle =>
      'مزامنة سحابية واسترجاع بيانات محلك تلقائياً';

  @override
  String get authSwitchAccount => 'تبديل الحساب';

  @override
  String get authSwitchAccountSubtitle =>
      'اختر حساباً آخر أو سجّل دخول بحساب جديد';

  @override
  String get authAddAccount => '+ تسجيل الدخول بحساب آخر';

  @override
  String get authCurrentAccount => 'الحساب النشط حالياً';

  @override
  String get authPasswordsDontMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get authPasswordTooShort => 'كلمة المرور لازم تكون 6 أحرف على الأقل';

  @override
  String get authInvalidEmail => 'اكتب بريد إلكتروني صحيح';

  @override
  String get authLoginSuccess => 'تم تسجيل الدخول بنجاح 🎉';

  @override
  String get authRegisterSuccess => 'تم إنشاء الحساب بنجاح 🎉';

  @override
  String authSwitchedTo(Object email) {
    return 'تم التبديل إلى حساب: $email';
  }

  @override
  String get cloudApiEmailTaken => 'البريد ده مسجل قبل كده، جرّب تسجّل دخول';

  @override
  String get cloudApiInvalidCredentials => 'البريد أو كلمة المرور مش صحيحة';

  @override
  String get authBackupBeforeSwitchTitle => 'تنبيه: بيانات غير محفوظة!';

  @override
  String get authBackupBeforeSwitchBody =>
      'يوجد بيانات لم يتم حفظ نسخة منها على السحابة لهذا الحساب. لو بدّلت الحساب دلوقتي، البيانات المحلية هتتمسح ومش هتعرف ترجعها إلا لو عملت نسخة أولاً.';

  @override
  String get authBackupFirst => 'اعمل نسخة احتياطية أولاً';

  @override
  String get authSwitchWithoutBackup => 'تبديل ومسح البيانات المحلية';

  @override
  String get authFetchingData => 'جاري جلب بياناتك من السحابة…';

  @override
  String get authEmailLoginButton => 'تسجيل الدخول بالبريد الإلكتروني';

  @override
  String get authEmailRegisterButton => 'إنشاء حساب جديد بالبريد';

  @override
  String get authWipingData => 'جاري مسح البيانات المحلية وتبديل الحساب…';
}
