// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'کشکول';

  @override
  String get navCustomers => 'گاہک';

  @override
  String get navCollection => 'وصولی';

  @override
  String get navSuppliers => 'سپلائرز';

  @override
  String get navCashDrawer => 'کیش دراز';

  @override
  String get navSettings => 'ترتیبات';

  @override
  String get debt => 'ادھار';

  @override
  String get payment => 'ادائیگی';

  @override
  String get settled => 'بے باق';

  @override
  String get currency => 'EGP';

  @override
  String get piaster => 'پیاسٹر';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get cancel => 'منسوخ';

  @override
  String get delete => 'حذف کریں';

  @override
  String get search => 'تلاش...';

  @override
  String placeholderScreen(String screenName) {
    return '$screenName اسکرین';
  }

  @override
  String get comingSoon => 'جلد دستیاب ہوگا';

  @override
  String get totalReceivablesTitle => 'گاہکوں پر آپ کا بقایا';

  @override
  String get searchCustomersHint => 'نام یا فون نمبر سے تلاش کریں...';

  @override
  String get filterAll => 'سب';

  @override
  String get filterHasDebt => 'ادھار والے';

  @override
  String get filterSettled => 'بے باق';

  @override
  String get filterLate => 'تاخیر والے';

  @override
  String get sortHighestDebt => 'سب سے زیادہ ادھار';

  @override
  String get sortName => 'نام';

  @override
  String get sortLastActivity => 'آخری سرگرمی';

  @override
  String get addNewCustomer => 'نیا گاہک';

  @override
  String get addCustomer => 'گاہک شامل کریں';

  @override
  String get editCustomer => 'گاہک میں ترمیم';

  @override
  String get customerName => 'گاہک کا نام';

  @override
  String get customerNameHint => 'مثلاً: محمد کریانہ والے';

  @override
  String get customerNameRequired => 'گاہک کا نام ضروری ہے';

  @override
  String get customerNameTooShort => 'نام کم از کم 2 حروف کا ہو';

  @override
  String get customerPhone => 'موبائل نمبر';

  @override
  String get customerPhoneHint => '010xxxxxxxx';

  @override
  String get customerPhoneInvalid => 'غلط موبائل نمبر (010, 011, 012, 015)';

  @override
  String get customerNotes => 'نوٹس';

  @override
  String get customerNotesHint => 'مثلاً: دوسری منزل والے پڑوسی';

  @override
  String get creditLimit => 'ادھار کی حد (اختیاری)';

  @override
  String get creditLimitHint => 'مثلاً: 1000';

  @override
  String get noCustomersTitle => 'آپ کا کھاتہ خالی ہے!';

  @override
  String get noCustomersSubtitle =>
      'پہلا گاہک شامل کرنے اور اس کا حساب آسانی سے رکھنے کے لیے نیچے بٹن دبائیں';

  @override
  String get noSearchResults => 'اس نام یا نمبر کا کوئی گاہک نہیں';

  @override
  String get duplicateCustomerWarning =>
      'انتباہ: اسی نام یا نمبر کا گاہک پہلے سے موجود ہے';

  @override
  String get customerDetails => 'گاہک کی تفصیلات';

  @override
  String get callCustomer => 'کال کریں';

  @override
  String get deleteCustomer => 'گاہک حذف کریں';

  @override
  String get deleteCustomerConfirm => 'حذف کی تصدیق';

  @override
  String deleteCustomerWarningDebt(String amount) {
    return 'خبردار! اس گاہک پر ابھی $amount باقی ہے۔ کیا آپ واقعی حذف کرنا چاہتے ہیں؟';
  }

  @override
  String deleteCustomerSafeConfirm(String name) {
    return 'کیا آپ واقعی گاہک $name کو حذف کرنا چاہتے ہیں؟';
  }

  @override
  String get customerDeleted => 'گاہک حذف ہو گیا';

  @override
  String get customerSaved => 'گاہک محفوظ ہو گیا';

  @override
  String get lastActivityNever => 'کوئی پچھلی لین دین نہیں';

  @override
  String lastActivityDate(String date) {
    return 'آخری لین دین: $date';
  }

  @override
  String creditLimitLabel(String amount) {
    return 'ادھار کی حد: $amount';
  }

  @override
  String get creditLimitExceeded => 'ادھار کی حد سے تجاوز!';

  @override
  String get heOwes => 'ادھار';

  @override
  String get hePaid => 'جمع (زیادہ ادا کیا)';

  @override
  String get currentBalance => 'موجودہ بیلنس';

  @override
  String get noTransactionsYet => 'ابھی تک کوئی لین دین درج نہیں';

  @override
  String get addDebtTitle => 'نیا ادھار درج کریں';

  @override
  String get addPaymentTitle => 'ادائیگی درج کریں';

  @override
  String get amountLabel => 'رقم';

  @override
  String get amountRequired => 'صفر سے زیادہ درست رقم درج کریں';

  @override
  String get today => 'آج';

  @override
  String get yesterday => 'کل';

  @override
  String get date => 'تاریخ';

  @override
  String get pickDate => 'تاریخ منتخب کریں';

  @override
  String get paymentMethod => 'ادائیگی کا طریقہ';

  @override
  String get methodCash => 'نقد';

  @override
  String get methodInstapay => 'InstaPay';

  @override
  String get methodWallet => 'موبائل والیٹ';

  @override
  String get methodOther => 'دیگر';

  @override
  String get noteOptional => 'نوٹ (اختیاری: چینی، تیل، ری چارج...)';

  @override
  String get voiceDictation => 'آواز سے لکھیں';

  @override
  String get listening => 'سن رہا ہے... اب بولیں';

  @override
  String get speechNotAvailable => 'اس ڈیوائس پر آواز سے لکھنا دستیاب نہیں';

  @override
  String get attachPhoto => 'تصویر لگائیں';

  @override
  String get camera => 'کیمرہ';

  @override
  String get gallery => 'گیلری';

  @override
  String get removePhoto => 'تصویر ہٹائیں';

  @override
  String get overpaymentTitle => 'رقم ادھار سے زیادہ ہے!';

  @override
  String overpaymentMessage(
    String paidAmount,
    String dueAmount,
    String creditAmount,
  ) {
    return 'ادا کی گئی رقم ($paidAmount) ادھار ($dueAmount) سے زیادہ ہے۔ کیا اضافی ($creditAmount) گاہک کے کھاتے میں جمع کریں؟';
  }

  @override
  String get overpaymentConfirm => 'ہاں، جمع کریں';

  @override
  String get transactionSaved => 'لین دین درج ہو گیا';

  @override
  String get undo => 'واپس لیں';

  @override
  String get transactionUndone => 'لین دین واپس ہو گیا';

  @override
  String get transactionDetails => 'لین دین کی تفصیل';

  @override
  String get editTransaction => 'لین دین میں ترمیم';

  @override
  String get deleteTransaction => 'لین دین حذف کریں';

  @override
  String get deleteTransactionConfirm =>
      'کیا آپ یہ لین دین حذف کرنا چاہتے ہیں؟';

  @override
  String get transactionDeleted => 'لین دین حذف ہو گیا';

  @override
  String get viewPhoto => 'تصویر دیکھیں';

  @override
  String get creditLimitWarningTitle => 'ادھار کی حد کا انتباہ';

  @override
  String creditLimitExceededDialog(
    String customerName,
    String newTotal,
    String limit,
  ) {
    return '$customerName پر $newTotal ہو جائے گا، جبکہ حد $limit ہے';
  }

  @override
  String get saveAnyway => 'پھر بھی درج کریں';

  @override
  String get changeLimit => 'حد بدلیں';

  @override
  String get newCreditLimit => 'نئی ادھار حد';

  @override
  String get limitUpdated => 'ادھار کی حد تبدیل ہو گئی';

  @override
  String get totalPayablesTitle => 'سپلائرز کا آپ پر بقایا';

  @override
  String get netMarketPosition => 'خالص مالی پوزیشن';

  @override
  String netReceivables(String amount) {
    return 'خالص وصولی: $amount';
  }

  @override
  String netPayables(String amount) {
    return 'خالص واجب الادا: $amount';
  }

  @override
  String get netSettled => 'حساب برابر ہے (0 EGP)';

  @override
  String get addNewSupplier => 'نیا سپلائر';

  @override
  String get addSupplier => 'سپلائر شامل کریں';

  @override
  String get editSupplier => 'سپلائر میں ترمیم';

  @override
  String get supplierName => 'سپلائر / نمائندے کا نام';

  @override
  String get supplierNameHint => 'مثلاً: احمد، کمپنی کا نمائندہ';

  @override
  String get supplierNameRequired => 'سپلائر کا نام ضروری ہے';

  @override
  String get company => 'کمپنی / ایجنسی';

  @override
  String get companyHint => 'مثلاً: نیسلے، لیز';

  @override
  String get visitDay => 'ہفتہ وار آنے کا دن';

  @override
  String get noSpecificDay => 'کوئی مقررہ دن نہیں';

  @override
  String get supplierNotes => 'نوٹس';

  @override
  String get supplierNotesHint => 'مثلاً: صبح 10 بجے آتا ہے';

  @override
  String get noSuppliersTitle => 'سپلائرز کا کھاتہ خالی ہے!';

  @override
  String get noSuppliersSubtitle =>
      'پہلا سپلائر یا کمپنی شامل کرنے کے لیے نیچے بٹن دبائیں';

  @override
  String get noSupplierSearchResults => 'کوئی سپلائر نہیں ملا';

  @override
  String get searchSuppliersHint => 'نام، کمپنی یا نمبر سے تلاش کریں...';

  @override
  String get supplierDetails => 'سپلائر کی تفصیلات';

  @override
  String get iOweHim => 'میرے ذمے';

  @override
  String get iPaidHim => 'میں نے ادا کیا';

  @override
  String get deleteSupplier => 'سپلائر حذف کریں';

  @override
  String get deleteSupplierConfirm => 'حذف کی تصدیق';

  @override
  String deleteSupplierWarningDebt(String amount) {
    return 'خبردار! آپ پر اس سپلائر کے ابھی $amount باقی ہیں۔ کیا واقعی حذف کرنا ہے؟';
  }

  @override
  String deleteSupplierSafeConfirm(String name) {
    return 'کیا آپ واقعی سپلائر $name کو حذف کرنا چاہتے ہیں؟';
  }

  @override
  String get supplierDeleted => 'سپلائر حذف ہو گیا';

  @override
  String get supplierSaved => 'سپلائر محفوظ ہو گیا';

  @override
  String visitDayPrefix(String day) {
    return 'آنے کا دن: $day';
  }

  @override
  String get sortCompany => 'کمپنی';

  @override
  String get sortVisitDay => 'آنے کا دن';

  @override
  String get dueCustomersTitle => 'وصولی والے گاہک';

  @override
  String get totalDueTitle => 'کل واجب الوصول';

  @override
  String dueCustomersCount(int count) {
    return '$count گاہک';
  }

  @override
  String dueHeaderSummary(int count, String amount) {
    return 'آپ کے $count گاہکوں پر $amount ہیں';
  }

  @override
  String oldestDebtDays(int days) {
    return 'سب سے پرانا ادھار $days دن پہلے';
  }

  @override
  String get oldestDebtToday => 'ادھار آج درج ہوا';

  @override
  String lastReminderDays(int days) {
    return 'آخری یاد دہانی: $days دن پہلے';
  }

  @override
  String get lastReminderToday => 'آخری یاد دہانی: آج';

  @override
  String get neverReminded => 'ابھی یاد نہیں دلایا';

  @override
  String snoozedUntilDate(String date) {
    return '$date تک مؤخر';
  }

  @override
  String get sendWhatsApp => 'واٹس ایپ';

  @override
  String get sendSms => 'SMS';

  @override
  String get moreActions => 'مزید';

  @override
  String get snooze3Days => '3 دن مؤخر کریں';

  @override
  String get snooze7Days => 'ایک ہفتہ مؤخر کریں';

  @override
  String get cancelSnooze => 'تاخیر ختم کریں';

  @override
  String get recordCollectionPayment => 'ادائیگی درج کریں';

  @override
  String get didSendMessage => 'کیا پیغام بھیج دیا؟';

  @override
  String didSendMessageDesc(String name) {
    return 'کیا آپ نے $name کو واٹس ایپ پر یاد دہانی بھیجی؟';
  }

  @override
  String get yesSent => 'ہاں، بھیج دیا';

  @override
  String get notSent => 'نہیں، نہیں بھیجا';

  @override
  String get reminderMarkedSent => 'یاد دہانی درج ہو گئی';

  @override
  String get snoozedSuccess => 'یاد دہانی مؤخر ہو گئی';

  @override
  String get noDueCustomersTitle => 'آج کوئی وصولی نہیں 🎉';

  @override
  String get noDueCustomersSubtitle =>
      'تمام گاہکوں کا حساب ٹھیک ہے یا انہیں حال ہی میں یاد دلایا گیا۔';

  @override
  String get whatsAppNotInstalled => 'واٹس ایپ انسٹال نہیں۔ کیا SMS بھیجیں؟';

  @override
  String get openSms => 'SMS بھیجیں';

  @override
  String get growthFooter => '\nکشکول ایپ سے بھیجا گیا 📒';

  @override
  String get statementTitle => 'کھاتہ اسٹیٹمنٹ';

  @override
  String get generateStatement => 'اسٹیٹمنٹ بنائیں';

  @override
  String get statementAllTime => 'تمام لین دین';

  @override
  String get statementThisMonth => 'اس مہینے';

  @override
  String get statementCustomRange => 'مخصوص مدت';

  @override
  String get statementFormatA4 => 'A4 کاغذ';

  @override
  String get statementFormatReceipt => 'تھرمل رسید (80mm)';

  @override
  String get dateCol => 'تاریخ';

  @override
  String get descriptionCol => 'تفصیل';

  @override
  String get debtCol => 'ادھار';

  @override
  String get paymentCol => 'ادائیگی';

  @override
  String get balanceCol => 'بیلنس';

  @override
  String get startingBalance => 'ابتدائی بیلنس';

  @override
  String get finalBalance => 'آخری بیلنس';

  @override
  String periodLabel(String period) {
    return 'مدت: $period';
  }

  @override
  String statementGeneratedAt(String date) {
    return 'بنانے کی تاریخ: $date';
  }

  @override
  String get shareStatement => 'اسٹیٹمنٹ شیئر کریں';

  @override
  String get printStatement => 'پرنٹ';

  @override
  String statementShareSubject(String name) {
    return 'اسٹیٹمنٹ - $name';
  }

  @override
  String get totalDebits => 'کل خریداری / ادھار';

  @override
  String get totalCredits => 'کل ادائیگی';

  @override
  String get drawerTitle => 'کیش دراز بند کرنا';

  @override
  String get todayDrawer => 'آج کا دراز';

  @override
  String get expectedInDrawer => 'دراز میں ہونا چاہیے';

  @override
  String get openingCash => 'ابتدائی رقم';

  @override
  String get openingCashHint => 'دن کے شروع میں رقم';

  @override
  String get editOpeningCash => 'ابتدائی رقم بدلیں';

  @override
  String get cashSales => 'نقد فروخت';

  @override
  String get addCashSales => 'نقد فروخت درج کریں';

  @override
  String get cashIn => 'دراز میں آیا (نقد)';

  @override
  String get digitalIn => 'ڈیجیٹل آمد';

  @override
  String get cashOut => 'دراز سے نکلا (نقد)';

  @override
  String get customerPaymentsCash => 'گاہکوں سے وصولی (نقد)';

  @override
  String get customerPaymentsDigital => 'گاہکوں سے وصولی (ڈیجیٹل)';

  @override
  String get supplierPaymentsCash => 'سپلائرز کو ادائیگی (نقد)';

  @override
  String get expensesCash => 'دکان کے اخراجات (نقد)';

  @override
  String get addExpense => 'خرچ درج کریں';

  @override
  String get editExpense => 'خرچ میں ترمیم';

  @override
  String get deleteExpense => 'خرچ حذف کریں';

  @override
  String get deleteExpenseConfirm => 'کیا یہ خرچ حذف کرنا ہے؟';

  @override
  String get expenseCategory => 'خرچ کی قسم';

  @override
  String get catRent => 'کرایہ';

  @override
  String get catElectricity => 'بجلی و یوٹیلٹی';

  @override
  String get catSalary => 'تنخواہیں و دیہاڑی';

  @override
  String get catSupplies => 'سامان و اشیاء';

  @override
  String get catSupplierPayment => 'سپلائر کو ادائیگی';

  @override
  String get catOther => 'دیگر';

  @override
  String get closeDay => 'دن بند کریں';

  @override
  String get reopenDay => 'دن دوبارہ کھولیں';

  @override
  String get reopenDayConfirm => 'کیا ترمیم کے لیے یہ دن دوبارہ کھولنا ہے؟';

  @override
  String get dayClosedSuccess => 'دن بند ہو گیا';

  @override
  String get dayReopenedSuccess => 'دن دوبارہ کھل گیا';

  @override
  String get dayIsClosed => 'دن بند ہے';

  @override
  String get dayIsOpen => 'دن کھلا ہے';

  @override
  String get actualCountLabel => 'دراز میں اصل رقم';

  @override
  String get actualCountHint => 'گنی ہوئی رقم لکھیں';

  @override
  String get drawerBalanced => 'دراز بالکل درست ہے 🎉';

  @override
  String get drawerShortage => 'دراز میں کمی';

  @override
  String get drawerSurplus => 'دراز میں زیادتی';

  @override
  String differenceAmount(String amount) {
    return 'فرق: $amount';
  }

  @override
  String get closeDaySummary => 'دن بند کرنے کا خلاصہ';

  @override
  String get confirmCloseDay => 'بند کرنے کی تصدیق';

  @override
  String get historyTab => 'دنوں کا ریکارڈ';

  @override
  String get todayTab => 'آج کا دراز';

  @override
  String get monthlyTotals => 'مہینے کا کل';

  @override
  String get monthlySales => 'نقد فروخت';

  @override
  String get monthlyExpenses => 'نقد اخراجات';

  @override
  String get monthlyNet => 'دراز کا خالص';

  @override
  String get drawerNotes => 'بند کرنے کے نوٹس (اختیاری)';

  @override
  String get noExpensesYet => 'آج کوئی خرچ درج نہیں';

  @override
  String get noHistoryYet => 'پچھلے دن درج نہیں';

  @override
  String get expenseAddedSuccess => 'خرچ درج ہو گیا';

  @override
  String get cashSalesAddedSuccess => 'نقد فروخت درج ہو گئی';

  @override
  String get openingCashUpdatedSuccess => 'ابتدائی رقم بدل گئی';

  @override
  String get dayDetails => 'دن کی تفصیل';

  @override
  String closedAtTime(String time) {
    return 'بند ہوا: $time';
  }

  @override
  String get readOnlyDayNotice =>
      'یہ دن بند ہے۔ ترمیم کے لیے دن دوبارہ کھولیں دبائیں۔';

  @override
  String get privacyModeTitle => 'پرائیویسی موڈ';

  @override
  String get privacyModeSubtitle => 'اسکرین اور ویجیٹ میں رقم چھپائیں (••••••)';

  @override
  String get shareAppTitle => 'ایپ شیئر کریں';

  @override
  String get shareAppSubtitle => 'کشکول دوسرے دکانداروں کو بھیجیں';

  @override
  String shopCodeLabel(String code) {
    return 'دکان کوڈ: $code';
  }

  @override
  String get growthFooterToggleTitle => 'پیغامات سے کشکول کا دستخط چھپائیں';

  @override
  String get growthFooterToggleSubtitle => 'پیڈ پلان میں دستیاب 🔒';

  @override
  String get codeCopied => 'کوڈ کاپی ہو گیا';

  @override
  String get main1 => 'کشکول';

  @override
  String get notebookImportButton1 => 'اپنا کھاتہ ایپ میں منتقل کریں 📒';

  @override
  String get notebookImportButton2 =>
      'ہر پرانی انٹری ضروری نہیں: گاہک کا نام اور ابھی کا بقایا کافی ہے۔';

  @override
  String get notebookImportButton3 => 'گاہک اور ان کے حساب';

  @override
  String get notebookImportButton4 => 'ہر گاہک کی ایک لائن: نام، فون اور بقایا';

  @override
  String get notebookImportButton5 => 'پرانی قسط';

  @override
  String get notebookImportButton6 =>
      'قیمت، ادا شدہ، باقی قسطیں اور اگلی تاریخ';

  @override
  String get notebookImportButton7 => 'کھاتے سے منتقل کریں';

  @override
  String get oldInstallmentImportScreen1 => 'اگلی قسط کی تاریخ';

  @override
  String get oldInstallmentImportScreen2 => 'قسط محفوظ ہو گئی ✓';

  @override
  String oldInstallmentImportScreen3(
    Object remaining,
    Object countValue,
    Object nextDue,
  ) {
    return '$remaining باقی، $countValue قسطوں میں، پہلی $nextDue کو۔';
  }

  @override
  String get oldInstallmentImportScreen4 => 'ہو گیا';

  @override
  String get oldInstallmentImportScreen5 => 'اور قسط';

  @override
  String get oldInstallmentImportScreen6 =>
      'محفوظ کرنے میں مسئلہ، کچھ محفوظ نہیں ہوا';

  @override
  String get oldInstallmentImportScreen7 => ' ماہانہ';

  @override
  String get oldInstallmentImportScreen8 => ' ہفتہ وار';

  @override
  String oldInstallmentImportScreen9(
    Object remaining,
    Object count,
    Object count2,
    Object monthly,
  ) {
    return '$remaining باقی — $count قسطیں × تقریباً $count2$monthly';
  }

  @override
  String get oldInstallmentImportScreen10 => 'کھاتے سے پرانی قسط';

  @override
  String oldInstallmentImportScreen11(Object savedCount) {
    return 'پرانی قسط ($savedCount)';
  }

  @override
  String get oldInstallmentImportScreen12 =>
      'ایپ سے پہلے شروع ہونے والی قسطوں کے لیے: قیمت، اب تک ادا شدہ رقم اور باقی قسطوں کی تعداد لکھیں۔ ایپ صرف باقی شیڈول بنائے گی اور پچھلی ادائیگی آج کے دراز میں نہیں گنے گی۔';

  @override
  String get oldInstallmentImportScreen13 => 'گاہک';

  @override
  String get oldInstallmentImportScreen14 => 'گاہک کا نام';

  @override
  String get oldInstallmentImportScreen15 => 'موجودہ یا نئے گاہک کا نام لکھیں';

  @override
  String get oldInstallmentImportScreen16 => 'گاہک کا نام لکھیں';

  @override
  String get oldInstallmentImportScreen17 =>
      'گاہک کا موبائل (اگر نیا ہو — اختیاری)';

  @override
  String get oldInstallmentImportScreen18 => 'غلط موبائل نمبر';

  @override
  String get oldInstallmentImportScreen19 => 'قسط';

  @override
  String get oldInstallmentImportScreen20 => 'سامان';

  @override
  String get oldInstallmentImportScreen21 => 'مثلاً: سام سنگ فریج';

  @override
  String get oldInstallmentImportScreen22 => 'سامان کا نام لکھیں';

  @override
  String get oldInstallmentImportScreen23 => 'کل قیمت';

  @override
  String get oldInstallmentImportScreen24 => 'EGP';

  @override
  String get oldInstallmentImportScreen25 => 'ضروری';

  @override
  String get oldInstallmentImportScreen26 => 'غلط';

  @override
  String get oldInstallmentImportScreen27 => 'اب تک ادا';

  @override
  String get oldInstallmentImportScreen28 => 'قیمت سے کم ہونا چاہیے';

  @override
  String get oldInstallmentImportScreen29 => 'باقی قسطیں';

  @override
  String get oldInstallmentImportScreen30 => '1 سے 120 تک';

  @override
  String oldInstallmentImportScreen31(Object nextDue) {
    return 'اگلی: $nextDue';
  }

  @override
  String get oldInstallmentImportScreen32 => 'ماہانہ';

  @override
  String get oldInstallmentImportScreen33 => 'ہفتہ وار';

  @override
  String get oldInstallmentImportScreen34 => 'ضامن (اختیاری)';

  @override
  String get oldInstallmentImportScreen35 => 'ضامن کا نام';

  @override
  String get oldInstallmentImportScreen36 => 'ضامن کا موبائل';

  @override
  String get oldInstallmentImportScreen37 =>
      'کھاتے یا معاہدے کی تصاویر (اختیاری — فون پر ہی رہیں گی)';

  @override
  String get oldInstallmentImportScreen38 =>
      'آپ کئی تصاویر شامل کر سکتے ہیں: کھاتے کے صفحات، معاہدہ، ضامن کا شناختی کارڈ…';

  @override
  String oldInstallmentImportScreen39(Object photosLength) {
    return '$photosLength تصاویر — گاہک کی تصاویر میں محفوظ ہوں گی';
  }

  @override
  String get oldInstallmentImportScreen40 => 'محفوظ ہو رہا ہے…';

  @override
  String get oldInstallmentImportScreen41 => 'قسط محفوظ کریں';

  @override
  String get notebookImportScreen1 => 'یہ حساب اس دن تک';

  @override
  String notebookImportScreen2(Object firstError, Object error) {
    return 'لائن $firstError: $error';
  }

  @override
  String get notebookImportScreen3 => 'کم از کم ایک گاہک کا نام لکھیں';

  @override
  String get notebookImportScreen4 => 'محفوظ ہو گیا ✓';

  @override
  String notebookImportScreen5(Object newCustomers) {
    return '$newCustomers نئے گاہک';
  }

  @override
  String notebookImportScreen6(Object existingCustomers) {
    return '$existingCustomers موجودہ گاہک — ان کے حساب میں شامل';
  }

  @override
  String notebookImportScreen7(Object totalPiasters) {
    return 'کل: $totalPiasters';
  }

  @override
  String get notebookImportScreen8 => 'اگلا صفحہ';

  @override
  String get notebookImportScreen9 => 'محفوظ کیے بغیر نکلیں؟';

  @override
  String get notebookImportScreen10 => 'اس صفحے پر لکھا ہوا محفوظ نہیں ہوگا۔';

  @override
  String get notebookImportScreen11 => 'جاری رکھیں';

  @override
  String get notebookImportScreen12 => 'نکلیں';

  @override
  String get notebookImportScreen13 => 'کھاتہ منتقل کریں 📒';

  @override
  String notebookImportScreen14(Object savedPages) {
    return 'کھاتہ منتقل کریں — صفحہ $savedPages';
  }

  @override
  String get notebookImportScreen15 => 'نئی لائن';

  @override
  String notebookImportScreen16(Object validLength) {
    return '$validLength گاہک';
  }

  @override
  String get notebookImportScreen17 => 'محفوظ کریں';

  @override
  String get notebookImportScreen18 =>
      'ہر گاہک ایک لائن میں لکھیں: نام، موبائل اگر ہو، اور بقایا رقم۔ تیزی سے آگے جانے کے لیے کی بورڈ پر \"اگلا\" دبائیں۔';

  @override
  String get notebookImportScreen19 => 'آج تک کا حساب';

  @override
  String notebookImportScreen20(Object asOf) {
    return '$asOf تک';
  }

  @override
  String get notebookImportScreen21 =>
      'کھاتے کے صفحے کی تصاویر (اختیاری): صفحے کے ہر گاہک کے ساتھ محفوظ';

  @override
  String notebookImportScreen22(Object pagePhotosLength) {
    return 'صفحے کی $pagePhotosLength تصاویر — ہر گاہک کے ساتھ محفوظ ہوں گی';
  }

  @override
  String get notebookImportScreen23 => 'صفحہ';

  @override
  String get notebookImportScreen24 => 'اس گاہک کی تصاویر';

  @override
  String get notebookImportScreen25 => 'لائن ہٹائیں';

  @override
  String get notebookImportScreen26 => 'موبائل (اختیاری)';

  @override
  String get notebookImportScreen27 => 'رقم';

  @override
  String get notebookImportScreen28 => 'تلاش ہو رہی ہے…';

  @override
  String notebookImportScreen29(Object name) {
    return '\"$name\" پہلے سے موجود ہے — رقم اس کے حساب میں شامل ہوگی';
  }

  @override
  String get notebookImportScreen30 => 'یہ رقم گاہک پر ہے';

  @override
  String get notebookImportScreen31 => 'یہ رقم آپ پر گاہک کی ہے';

  @override
  String get notebookImportScreen32 => 'ادھار';

  @override
  String get notebookImportScreen33 => 'جمع';

  @override
  String get notebookImportService1 => 'کھاتے سے پچھلا بیلنس';

  @override
  String get notebookImportService2 => 'کھاتے کا صفحہ';

  @override
  String get notebookImportService3 => 'نام موجود نہیں';

  @override
  String get notebookImportService4 => 'نام بہت لمبا ہے';

  @override
  String get notebookImportService5 => 'غلط رقم';

  @override
  String get notebookImportService6 => 'ادا شدہ رقم منفی نہیں ہو سکتی';

  @override
  String get notebookImportService7 => 'ادا شدہ رقم کل قیمت سے کم ہو';

  @override
  String get notebookImportService8 => 'کم از کم 1 قسط باقی ہو';

  @override
  String notebookImportService9(Object paidPiasters) {
    return 'کھاتے سے منتقل — پہلے ادا: $paidPiasters';
  }

  @override
  String notebookImportService10(Object trim, Object totalPricePiasters) {
    return 'پرانی قسط: $trim ($totalPricePiasters میں سے باقی)';
  }

  @override
  String notebookImportService11(Object trim) {
    return 'قسط: $trim';
  }

  @override
  String get installmentsScreen1 => 'قسطیں 📋';

  @override
  String get installmentsScreen2 =>
      'گاہک، سامان، موبائل یا ضامن سے تلاش کریں...';

  @override
  String get installmentsScreen3 => 'کل قسطیں';

  @override
  String get installmentsScreen4 => 'تاخیر والی قسطیں';

  @override
  String get installmentsScreen5 => 'فعال پلان';

  @override
  String get installmentsScreen6 => 'سب';

  @override
  String get installmentsScreen7 => 'فعال ⏳';

  @override
  String get installmentsScreen8 => 'مکمل ✓';

  @override
  String get installmentsScreen9 => 'منسوخ';

  @override
  String installmentsScreen10(Object e) {
    return 'قسطیں لوڈ نہیں ہوئیں: $e';
  }

  @override
  String get installmentsScreen11 => 'کوئی قسط نہیں ملی';

  @override
  String get installmentsScreen12 => 'ابھی کوئی قسط پلان نہیں';

  @override
  String get installmentsScreen13 =>
      'پہلا قسط پلان بنانے کے لیے (+ نیا قسط پلان) دبائیں۔';

  @override
  String get installmentsScreen14 => 'نیا قسط پلان';

  @override
  String installmentPlanDetailsScreen1(Object instapay) {
    return 'InstaPay: $instapay';
  }

  @override
  String installmentPlanDetailsScreen2(Object wallet) {
    return 'والیٹ / ووڈافون کیش: $wallet';
  }

  @override
  String installmentPlanDetailsScreen3(Object phoneNum) {
    return 'فون: $phoneNum';
  }

  @override
  String get installmentPlanDetailsScreen4 => 'قسط پلان منسوخ کریں';

  @override
  String get installmentPlanDetailsScreen5 =>
      'کیا یہ پلان منسوخ کرنا ہے؟ یاد دہانیاں بند ہو جائیں گی اور ادائیگیوں کا ریکارڈ رہے گا۔';

  @override
  String get installmentPlanDetailsScreen6 => 'واپس';

  @override
  String get installmentPlanDetailsScreen7 => 'پلان منسوخ کریں';

  @override
  String get installmentPlanDetailsScreen8 => 'قسط پلان منسوخ ہو گیا';

  @override
  String get installmentPlanDetailsScreen9 => 'قسط پلان حذف کریں';

  @override
  String get installmentPlanDetailsScreen10 => 'کیا یہ قسط پلان حذف کرنا ہے؟';

  @override
  String get installmentPlanDetailsScreen11 => 'منسوخ';

  @override
  String get installmentPlanDetailsScreen12 => 'حذف کریں';

  @override
  String get installmentPlanDetailsScreen13 => 'قسط پلان حذف ہو گیا';

  @override
  String get installmentPlanDetailsScreen14 => 'قسط کی تفصیل';

  @override
  String installmentPlanDetailsScreen15(Object e) {
    return 'خرابی: $e';
  }

  @override
  String get installmentPlanDetailsScreen16 =>
      'قسط پلان نہیں ملا یا حذف ہو گیا';

  @override
  String get installmentPlanDetailsScreen17 => 'پلان حذف کریں';

  @override
  String get installmentPlanDetailsScreen18 => 'کل قیمت:';

  @override
  String get installmentPlanDetailsScreen19 => 'پیشگی:';

  @override
  String get installmentPlanDetailsScreen20 => 'کل ادا:';

  @override
  String get installmentPlanDetailsScreen21 => 'باقی:';

  @override
  String get installmentPlanDetailsScreen22 => 'پوری رقم پہلے ادا کریں';

  @override
  String installmentPlanDetailsScreen23(Object guarantorName) {
    return 'ضامن: $guarantorName';
  }

  @override
  String get installmentPlanDetailsScreen24 => 'معاہدہ / رسید کی تصویر';

  @override
  String get installmentPlanDetailsScreen25 =>
      'دستاویز پوری دیکھنے کے لیے دبائیں';

  @override
  String get installmentPlanDetailsScreen26 => 'قسط کی دستاویز';

  @override
  String installmentPlanDetailsScreen27(Object installmentsLength) {
    return 'قسطوں کا شیڈول ($installmentsLength)';
  }

  @override
  String get installmentPlanDetailsScreen28 => 'کوئی بھی رقم ادا کریں';

  @override
  String installmentPlanDetailsScreen29(
    Object installmentIndex,
    Object dueDate,
  ) {
    return 'قسط نمبر $installmentIndex • $dueDate';
  }

  @override
  String installmentPlanDetailsScreen30(Object paidPiasters) {
    return 'پوری ادائیگی ہو گئی ✓ ($paidPiasters)';
  }

  @override
  String installmentPlanDetailsScreen31(
    Object paidPiasters,
    Object amountPiasters,
  ) {
    return '$amountPiasters میں سے $paidPiasters ادا';
  }

  @override
  String get installmentPlanDetailsScreen32 => 'تاخیر ⚠️';

  @override
  String get installmentPlanDetailsScreen33 => 'آج واجب الادا 🔔';

  @override
  String installmentPlanDetailsScreen34(Object amountPiasters) {
    return 'آنے والی • $amountPiasters';
  }

  @override
  String get installmentPlanDetailsScreen35 => 'واٹس ایپ یاد دہانی';

  @override
  String get installmentPlanDetailsScreen36 => 'ادا کریں';

  @override
  String get addInstallmentPlanScreen1 => 'موبائل فون';

  @override
  String get addInstallmentPlanScreen2 => 'ٹی وی';

  @override
  String get addInstallmentPlanScreen3 => 'واشنگ مشین';

  @override
  String get addInstallmentPlanScreen4 => 'فریج';

  @override
  String get addInstallmentPlanScreen5 => 'چولہا';

  @override
  String get addInstallmentPlanScreen6 => 'لیپ ٹاپ';

  @override
  String get addInstallmentPlanScreen7 => 'موٹر سائیکل';

  @override
  String get addInstallmentPlanScreen8 => 'فرنیچر';

  @override
  String get addInstallmentPlanScreen9 => 'پہلے گاہک منتخب کریں';

  @override
  String get addInstallmentPlanScreen10 => 'پیشگی کل قیمت سے کم ہو';

  @override
  String get addInstallmentPlanScreen11 => 'قسط پلان بن گیا اور شیڈول ہو گیا ✓';

  @override
  String addInstallmentPlanScreen12(Object e) {
    return 'خرابی ہوئی: $e';
  }

  @override
  String addInstallmentPlanScreen13(Object e) {
    return 'گاہک لوڈ نہیں ہوئے: $e';
  }

  @override
  String get addInstallmentPlanScreen14 => 'گاہک منتخب کریں';

  @override
  String get addInstallmentPlanScreen15 => 'براہ کرم گاہک منتخب کریں';

  @override
  String get addInstallmentPlanScreen16 => 'سامان اور رقم';

  @override
  String get addInstallmentPlanScreen17 => 'سامان کا نام *';

  @override
  String get addInstallmentPlanScreen18 => 'مثلاً: سام سنگ A15 128GB';

  @override
  String get addInstallmentPlanScreen19 => 'سامان کا نام کم از کم 2 حروف کا ہو';

  @override
  String get addInstallmentPlanScreen20 => 'کل قیمت (EGP) *';

  @override
  String get addInstallmentPlanScreen21 => 'مثلاً: 12000';

  @override
  String get addInstallmentPlanScreen22 => 'غلط رقم';

  @override
  String get addInstallmentPlanScreen23 => 'پیشگی (EGP)';

  @override
  String get addInstallmentPlanScreen24 => 'قسطوں میں ادا ہونے والی رقم:';

  @override
  String get addInstallmentPlanScreen25 => 'مدت اور وقفہ';

  @override
  String addInstallmentPlanScreen26(Object count) {
    return '$count قسطیں';
  }

  @override
  String get addInstallmentPlanScreen27 => 'قسطوں کی تعداد *';

  @override
  String get addInstallmentPlanScreen28 => 'پورا عدد درج کریں';

  @override
  String get addInstallmentPlanScreen29 => 'وقفہ';

  @override
  String get addInstallmentPlanScreen30 => 'پہلی قسط کی تاریخ';

  @override
  String get addInstallmentPlanScreen31 => 'تاریخ بدلیں';

  @override
  String get addInstallmentPlanScreen32 => 'ضامن اور دستاویزات (اختیاری)';

  @override
  String get addInstallmentPlanScreen33 => 'مثلاً: محمد ابراہیم';

  @override
  String get addInstallmentPlanScreen34 => 'ضامن کا موبائل نمبر';

  @override
  String get addInstallmentPlanScreen35 =>
      'غلط موبائل نمبر (010, 011, 012, 015)';

  @override
  String get addInstallmentPlanScreen36 => 'دستاویز کی تصویر لے لی ✓';

  @override
  String get addInstallmentPlanScreen37 =>
      'معاہدہ / رسید / شناختی کارڈ کی تصویر لیں';

  @override
  String get addInstallmentPlanScreen38 => 'تصویر بدلنے کے لیے دبائیں';

  @override
  String get addInstallmentPlanScreen39 => 'معاہدے کی تصویر بعد کے لیے رکھیں';

  @override
  String get addInstallmentPlanScreen40 => 'تصویر لیں';

  @override
  String get addInstallmentPlanScreen41 => 'اضافی نوٹس';

  @override
  String get addInstallmentPlanScreen42 => 'گاہک کے کھاتے سے جوڑیں';

  @override
  String get addInstallmentPlanScreen43 =>
      'کل قیمت ادھار اور پیشگی ادائیگی کے طور پر گاہک کے کھاتے میں درج کریں';

  @override
  String addInstallmentPlanScreen44(Object scheduleLength) {
    return 'شیڈول کا جائزہ ($scheduleLength قسطیں)';
  }

  @override
  String addInstallmentPlanScreen45(Object amountPiasters) {
    return 'قسط کی رقم: ~$amountPiasters';
  }

  @override
  String get addInstallmentPlanScreen46 => 'پلان اور شیڈول محفوظ کریں';

  @override
  String installmentProgressBar1(
    Object paidCount,
    Object totalCount,
    Object percentInt,
  ) {
    return '$totalCount میں سے $paidCount قسطیں ادا ($percentInt%)';
  }

  @override
  String installmentProgressBar2(Object remainingPiasters) {
    return 'باقی: $remainingPiasters';
  }

  @override
  String get installmentProgressBar3 => 'مکمل ادا ✓';

  @override
  String get payInstallmentDialog1 => 'صفر سے زیادہ درست رقم لکھیں';

  @override
  String payInstallmentDialog2(Object amountPiasters) {
    return '$amountPiasters کی ادائیگی درج ہو گئی ✓';
  }

  @override
  String payInstallmentDialog3(Object e) {
    return 'ادائیگی میں خرابی: $e';
  }

  @override
  String payInstallmentDialog4(Object installmentIndex) {
    return 'قسط نمبر $installmentIndex ادا کریں';
  }

  @override
  String payInstallmentDialog5(Object itemDescription) {
    return 'قسط کی ادائیگی ($itemDescription)';
  }

  @override
  String get payInstallmentDialog6 => 'واجب الادا رقم:';

  @override
  String get payInstallmentDialog7 => 'ادا شدہ رقم (EGP)';

  @override
  String get payInstallmentDialog8 => 'ادائیگی کا طریقہ';

  @override
  String get payInstallmentDialog9 => 'نقد 💵';

  @override
  String get payInstallmentDialog10 => 'InstaPay ⚡';

  @override
  String get payInstallmentDialog11 => 'والیٹ 📱';

  @override
  String get payInstallmentDialog12 => 'ادائیگی کی تاریخ';

  @override
  String get payInstallmentDialog13 => 'بدلیں';

  @override
  String get payInstallmentDialog14 => 'نوٹ (اختیاری)';

  @override
  String get payInstallmentDialog15 => 'مثلاً: کسی کے ذریعے بھیجا';

  @override
  String get payInstallmentDialog16 => 'گاہک کے کھاتے میں درج کریں';

  @override
  String get payInstallmentDialog17 => 'گاہک کے مرکزی بیلنس سے کٹ جائے گا';

  @override
  String get payInstallmentDialog18 => 'ادائیگی کی تصدیق';

  @override
  String earlySettlementDialog1(Object itemDescription) {
    return '($itemDescription) کی قسط مکمل ادا ✓';
  }

  @override
  String earlySettlementDialog2(Object e) {
    return 'ادائیگی مکمل کرنے میں خرابی: $e';
  }

  @override
  String get earlySettlementDialog3 => 'قبل از وقت مکمل ادائیگی';

  @override
  String get earlySettlementDialog4 => 'باقی قسطوں کا کل:';

  @override
  String get earlySettlementDialog5 => 'وصول کرنے والی رقم:';

  @override
  String get earlySettlementDialog6 => 'جلد ادائیگی پر رعایت (EGP)';

  @override
  String get earlySettlementDialog7 => 'ابھی مکمل ادا کریں';

  @override
  String installmentPlanCard1(Object overdueCount) {
    return 'تاخیر ($overdueCount)';
  }

  @override
  String get installmentPlanCard2 => 'مکمل ✓';

  @override
  String get installmentPlanCard3 => 'منسوخ';

  @override
  String installmentPlanCard4(Object dueDate, Object paidPiasters) {
    return 'اگلی قسط: $dueDate ($paidPiasters)';
  }

  @override
  String installmentPlanCard5(Object totalPricePiasters) {
    return 'کل: $totalPricePiasters';
  }

  @override
  String get installmentRepository1 => 'سامان کی تفصیل کم از کم 2 حروف کی ہو';

  @override
  String get installmentRepository2 => 'کل قیمت صفر سے زیادہ ہو';

  @override
  String get installmentRepository3 => 'پیشگی منفی نہیں ہو سکتی';

  @override
  String get installmentRepository4 => 'پیشگی کل قیمت سے کم ہو';

  @override
  String get installmentRepository5 => 'قسطوں کی تعداد صفر سے زیادہ ہو';

  @override
  String installmentRepository6(Object trim, Object installmentCount) {
    return 'قسط: $trim ($installmentCount قسطیں)';
  }

  @override
  String installmentRepository7(Object trim) {
    return 'پیشگی: $trim';
  }

  @override
  String get installmentRepository8 => 'ادائیگی کی رقم صفر سے زیادہ ہو';

  @override
  String installmentRepository9(Object itemDescription, Object notes) {
    return 'قسط کی ادائیگی: $itemDescription$notes';
  }

  @override
  String get installmentRepository10 => 'قسط پلان نہیں ملا';

  @override
  String installmentRepository11(Object itemDescription) {
    return 'قبل از وقت ادائیگی: $itemDescription';
  }

  @override
  String installmentRepository12(Object itemDescription) {
    return 'جلد ادائیگی رعایت: $itemDescription';
  }

  @override
  String get collectionScreen1 => 'واجب الادا قسطیں';

  @override
  String get dueInstallmentsTab1 => 'گاہک کا فون نمبر درج نہیں';

  @override
  String get dueInstallmentsTab2 => 'آج کوئی قسط واجب یا لیٹ نہیں 🎉';

  @override
  String get dueInstallmentsTab3 => 'تمام قسط والے گاہک وقت پر ادا کر رہے ہیں۔';

  @override
  String dueInstallmentsTab4(Object dueListLength) {
    return '$dueListLength قسطیں وصول کرنی ہیں:';
  }

  @override
  String dueInstallmentsTab5(
    Object itemDescription,
    Object installmentIndex,
    Object installmentCount,
  ) {
    return '$itemDescription • قسط ($installmentCount میں سے $installmentIndex)';
  }

  @override
  String dueInstallmentsTab6(Object daysOverdue) {
    return '$daysOverdue دن لیٹ';
  }

  @override
  String get dueInstallmentsTab7 => 'آج واجب الادا 🔔';

  @override
  String get dueInstallmentsTab8 => 'کال';

  @override
  String get dueInstallmentsTab9 => 'واٹس ایپ';

  @override
  String cashDrawerScreen1(Object err) {
    return 'دراز کا ڈیٹا لوڈ نہیں ہوا: $err';
  }

  @override
  String drawerLiveCard1(Object notes) {
    return 'نوٹ: $notes';
  }

  @override
  String expensesListCard1(Object expensesLength) {
    return '$expensesLength اخراجات';
  }

  @override
  String get expensesListCard2 => 'InstaPay';

  @override
  String get expensesListCard3 => 'والیٹ';

  @override
  String get drawerFlowCard1 => '(InstaPay / والیٹ)';

  @override
  String addCashSalesBottomSheet1(Object currentSalesPiasters) {
    return 'اب تک درج فروخت: $currentSalesPiasters';
  }

  @override
  String get addCashSalesBottomSheet2 => 'فروخت میں شامل کریں (+)';

  @override
  String get addCashSalesBottomSheet3 => 'کل بدلیں (=)';

  @override
  String get addCashSalesBottomSheet4 => 'شامل کرنے والی رقم';

  @override
  String get addCashSalesBottomSheet5 => 'فروخت کا نیا کل';

  @override
  String addCashSalesBottomSheet6(Object val) {
    return '+$val EGP';
  }

  @override
  String drawerHistoryTab1(
    Object cashSalesPiasters,
    Object openingCashPiasters,
  ) {
    return 'نقد فروخت: $cashSalesPiasters · ابتدائی: $openingCashPiasters';
  }

  @override
  String drawerHistoryTab2(Object date) {
    return '$date کی تفصیل';
  }

  @override
  String get drawerHistoryTab3 => 'فرق';

  @override
  String get customersScreen1 => 'قسطیں';

  @override
  String get customersScreen2 => 'پرائیویسی موڈ';

  @override
  String get customersScreen3 => 'ترتیب';

  @override
  String get customerPhotosScreen1 => 'تصویر شامل ہو گئی';

  @override
  String customerPhotosScreen2(Object pathsLength) {
    return '$pathsLength تصاویر شامل ہو گئیں';
  }

  @override
  String get customerPhotosScreen3 => 'تصویر ہٹا دی گئی';

  @override
  String get customerPhotosScreen4 => 'واپس لائیں';

  @override
  String customerPhotosScreen5(Object customerName) {
    return '$customerName کی تصاویر';
  }

  @override
  String get customerPhotosScreen6 => 'تصاویر شامل کریں';

  @override
  String get customerPhotosScreen7 => 'تصاویر لوڈ نہیں ہوئیں';

  @override
  String get customerPhotosScreen8 =>
      'اس گاہک کی ابھی کوئی تصویر نہیں۔\nکھاتے کے صفحات یا کوئی کاغذ کی تصویر لیں — تصاویر صرف اسی فون پر رہیں گی۔';

  @override
  String get customerPhotosScreen9 => 'تصویر ہٹائیں';

  @override
  String customerDetailsScreen1(
    Object activePlansLength,
    Object remainingPiasters,
  ) {
    return 'فعال قسطیں ($activePlansLength) • باقی: $remainingPiasters';
  }

  @override
  String get customerDetailsScreen2 => 'اس گاہک کو قسطوں پر بیچیں';

  @override
  String get customerDetailsScreen3 => 'دیکھیں';

  @override
  String get customerDetailsScreen4 => 'نئی قسط شامل کریں';

  @override
  String get customerDetailsScreen5 => 'گاہک کی تصاویر';

  @override
  String get photoStrip1 => 'کیمرے سے تصویر لیں';

  @override
  String get photoStrip2 => 'گیلری سے منتخب کریں';

  @override
  String get photoStrip3 => 'ایک ساتھ کئی تصاویر منتخب کر سکتے ہیں';

  @override
  String get photoStrip4 => 'تصویر';

  @override
  String get photoStrip5 => 'مزید';

  @override
  String get photoStrip6 => 'تصویر شامل کریں';

  @override
  String get photoStrip7 => 'تصاویر';

  @override
  String photoStrip8(Object title, Object index, Object count) {
    return '$title ($count میں سے $index)';
  }

  @override
  String get photoStrip9 => 'تصویر';

  @override
  String get photoStrip10 => 'تصویر اس فون پر نہیں ملی';

  @override
  String creditLimitProgressBar1(Object limitPiasters) {
    return 'ادھار کی حد: $limitPiasters';
  }

  @override
  String ratingExplanationBottomSheet1(Object customerName) {
    return 'گاہک کی ریٹنگ: $customerName';
  }

  @override
  String get ratingExplanationBottomSheet2 => 'موجودہ ریٹنگ کی وجہ:';

  @override
  String get ratingExplanationBottomSheet3 => 'ریٹنگ کیسے کام کرتی ہے؟';

  @override
  String get ratingExplanationBottomSheet4 => 'بہترین';

  @override
  String get ratingExplanationBottomSheet5 =>
      'حساب صاف ہے یا سب سے پرانا ادھار 14 دن سے زیادہ نہیں۔';

  @override
  String get ratingExplanationBottomSheet6 => 'نگرانی';

  @override
  String get ratingExplanationBottomSheet7 =>
      'سب سے پرانا ادھار 15 سے 45 دن (یاد دلانا بہتر ہے)۔';

  @override
  String get ratingExplanationBottomSheet8 => 'لیٹ';

  @override
  String get ratingExplanationBottomSheet9 =>
      'سب سے پرانا ادھار 45 دن سے زیادہ ہے یا ادھار کی حد پار ہو گئی۔';

  @override
  String get ratingExplanationBottomSheet10 => 'نیا';

  @override
  String get ratingExplanationBottomSheet11 => '3 سے کم لین دین والا گاہک۔';

  @override
  String get ratingExplanationBottomSheet12 => 'سمجھ گیا';

  @override
  String get customerWithBalance1 => 'نیا گاہک';

  @override
  String get settingsScreen1 => 'دکان کی تفصیلات 🏪';

  @override
  String get settingsScreen2 => 'سیکیورٹی اور پرائیویسی 🔒';

  @override
  String get settingsScreen3 => 'ہوم اسکرین ویجیٹ 📱';

  @override
  String get settingsScreen4 => 'یاد دہانی کے پیغامات 💬';

  @override
  String get settingsScreen5 => 'بیک اپ اور ڈیٹا 💾';

  @override
  String get settingsScreen6 => 'ایپ شیئر کریں 🚀';

  @override
  String get settingsScreen7 => 'عمومی ⚙️';

  @override
  String get settingsScreen8 => 'کشکول 📒';

  @override
  String get settingsScreen9 =>
      'انٹرنیٹ کے بغیر دکان کا کھاتہ (Offline-First)\nورژن 1.0.0';

  @override
  String get settingsScreen10 => 'جنرل اسٹور';

  @override
  String get settingsScreen11 => 'کریانہ اور سپر مارکیٹ 🛒';

  @override
  String get settingsScreen12 => 'موبائل اور ایکسیسریز 📱';

  @override
  String get settingsScreen13 => 'الیکٹرانکس اور گھریلو آلات ⚡';

  @override
  String get settingsScreen14 => 'فارمیسی اور کاسمیٹکس 💊';

  @override
  String get settingsScreen15 => 'دیگر کاروبار 🏪';

  @override
  String settingsScreen16(Object tradeName) {
    return '$tradeName • کاروبار اور ادائیگی کی تفصیل بدلیں';
  }

  @override
  String get settingsScreen17 => 'اسکرین اور ویجیٹ میں رقم چھپائیں (••••••)';

  @override
  String get settingsScreen18 => 'PIN سے ایپ لاک کریں (4 ہندسے)';

  @override
  String get settingsScreen19 => 'فعال اور محفوظ (بند کرنے کے لیے دبائیں)';

  @override
  String get settingsScreen20 => 'غیر فعال (سیٹ کرنے کے لیے دبائیں)';

  @override
  String get settingsScreen21 => 'فعال 🔒';

  @override
  String get settingsScreen22 => 'سیٹ کریں';

  @override
  String get settingsScreen23 => 'ایپ لاک بند ہو گیا';

  @override
  String get settingsScreen24 => 'PIN سیٹ ہو گیا 🔒';

  @override
  String get settingsScreen25 => 'فنگر پرنٹ / Face ID سے کھولیں';

  @override
  String get settingsScreen26 => 'ہر بار PIN کے بجائے فنگر پرنٹ استعمال کریں';

  @override
  String get settingsScreen27 => 'آپ کا ڈیوائس فنگر پرنٹ سپورٹ نہیں کرتا';

  @override
  String get settingsScreen28 => '1 منٹ';

  @override
  String get settingsScreen29 => '5 منٹ';

  @override
  String get settingsScreen30 => '15 منٹ';

  @override
  String get settingsScreen31 => 'فوراً';

  @override
  String get settingsScreen32 => 'خودکار لاک کا وقت';

  @override
  String get settingsScreen33 => 'ایپ سے نکلتے ہی';

  @override
  String settingsScreen34(Object timeout) {
    return 'نکلنے کے $timeout منٹ بعد';
  }

  @override
  String get settingsScreen35 => 'نکلتے ہی فوراً';

  @override
  String get settingsScreen36 => '1 منٹ بعد';

  @override
  String get settingsScreen37 => '5 منٹ بعد';

  @override
  String get settingsScreen38 => '15 منٹ بعد';

  @override
  String get settingsScreen39 => 'یاد دہانی کا پیغام';

  @override
  String get settingsScreen40 => 'گاہکوں کا خودکار پیغام بدلیں اور فوری دیکھیں';

  @override
  String get settingsScreen41 => 'پس منظر میں یاد دہانیاں بند ہونے سے بچائیں';

  @override
  String get settingsScreen42 =>
      'شاؤمی، ریئل می اور انفینکس فونز کے لیے رہنمائی';

  @override
  String get settingsScreen43 => 'ابھی تک کوئی بیک اپ نہیں بنا';

  @override
  String get settingsScreen44 => 'آخری بیک اپ';

  @override
  String get settingsScreen45 => 'بیک اپ ایکسپورٹ کریں (.kashkool)';

  @override
  String get settingsScreen46 =>
      'کھاتے اور تصاویر کی کاپی محفوظ کر کے واٹس ایپ یا ڈرائیو پر بھیجیں';

  @override
  String get settingsScreen47 => 'بیک اپ ایکسپورٹ ہو گیا 👍';

  @override
  String settingsScreen48(Object e) {
    return 'ایکسپورٹ ناکام: $e';
  }

  @override
  String get settingsScreen49 => 'بیک اپ بحال کریں';

  @override
  String get settingsScreen50 =>
      'پہلے سے محفوظ .kashkool فائل سے حساب اور تصاویر بحال کریں';

  @override
  String get settingsScreen51 => 'غلط فائل ❌';

  @override
  String get settingsScreen52 => 'یہ فائل کشکول کا درست بیک اپ نہیں۔';

  @override
  String get settingsScreen53 => 'ٹھیک ہے';

  @override
  String get settingsScreen54 => 'بحالی کی تصدیق';

  @override
  String get settingsScreen55 =>
      'خبردار: بحالی ایپ کا موجودہ سارا ڈیٹا فائل کے ڈیٹا سے بدل دے گی۔';

  @override
  String settingsScreen56(Object exportedAt) {
    return 'بیک اپ کی تاریخ: $exportedAt';
  }

  @override
  String settingsScreen57(Object photosCount) {
    return 'شامل تصاویر: $photosCount';
  }

  @override
  String settingsScreen58(Object fileSizeBytes) {
    return 'فائل کا سائز: $fileSizeBytes KB';
  }

  @override
  String get settingsScreen59 => 'ہاں، بدلیں اور بحال کریں';

  @override
  String get settingsScreen60 => 'بحالی مکمل 🎉';

  @override
  String get settingsScreen61 =>
      'تمام حساب، لین دین اور تصاویر بحال ہو گئیں۔ سب اسکرینیں تازہ کرنے کے لیے ایپ دوبارہ شروع کریں۔';

  @override
  String get settingsScreen62 => 'ابھی دوبارہ شروع کریں';

  @override
  String settingsScreen63(Object e) {
    return 'بحالی میں خرابی: $e';
  }

  @override
  String get settingsScreen64 => 'ڈارک 🌙';

  @override
  String get settingsScreen65 => 'لائٹ ☀️';

  @override
  String get settingsScreen66 => 'خودکار';

  @override
  String get settingsScreen67 => 'ایپ کی شکل';

  @override
  String get settingsScreen68 => 'خودکار (فون کے مطابق)';

  @override
  String get settingsScreen69 => 'مقرر نہیں';

  @override
  String get settingsScreen70 => 'نئے گاہک کی ڈیفالٹ ادھار حد';

  @override
  String get settingsScreen71 => 'واٹس ایپ پر رابطہ کریں';

  @override
  String get settingsScreen72 => 'مشورے اور براہ راست مدد';

  @override
  String get settingsScreen73 =>
      'https://wa.me/201000000000?text=السلام%20علیکم%20کشکول%20کے%20بارے%20میں%20سوال%20ہے';

  @override
  String get settingsScreen74 => 'پرائیویسی پالیسی اور شرائط';

  @override
  String get settingsScreen75 =>
      'آپ کا ڈیٹا آپ کا ہے اور صرف آپ کے فون پر رہتا ہے';

  @override
  String get settingsScreen76 => 'کشکول کی پرائیویسی پالیسی 🔒';

  @override
  String get settingsScreen77 =>
      '1. کشکول مکمل طور پر انٹرنیٹ کے بغیر چلتی ہے (Offline-First)۔\n\n2. تمام حساب، نام، فون نمبر، رسیدوں کی تصاویر اور لین دین صرف آپ کے فون پر محفوظ ہیں۔ کوئی ڈیٹا کسی بیرونی سرور پر نہیں جاتا۔\n\n3. فون بدلنے یا گم ہونے کی صورت میں ڈیٹا بچانے کے لیے باقاعدہ بیک اپ (بیک اپ ایکسپورٹ کریں) بنانا آپ کی ذمہ داری ہے۔\n\n4. کشکول دکانداروں اور تاجروں کے لیے بنائی گئی ہے تاکہ وہ اپنا حق محفوظ رکھیں اور ادھار آسانی سے سنبھالیں۔';

  @override
  String get settingsScreen78 => 'سسٹم (خودکار)';

  @override
  String get settingsScreen79 => 'ڈیفالٹ ادھار حد (EGP)';

  @override
  String get settingsScreen80 => 'رقم (EGP)';

  @override
  String get settingsScreen81 => 'کوئی حد نہ ہو تو خالی چھوڑیں';

  @override
  String get settingsScreen82 => 'محفوظ کریں';

  @override
  String batteryGuideBottomSheet1(Object brandName) {
    return 'نوٹیفکیشن گائیڈ ($brandName)';
  }

  @override
  String get batteryGuideBottomSheet2 => 'یاد دہانیاں چالو رکھنے کی گائیڈ';

  @override
  String get batteryGuideBottomSheet3 =>
      'کچھ فون (جیسے شاؤمی، ریئل می، انفینکس اور ہواوے) بیٹری بچانے کے لیے پس منظر میں ایپس بند کر دیتے ہیں۔ یاد دہانیاں وقت پر آئیں اس کے لیے یہ اقدامات کریں:';

  @override
  String get batteryGuideBottomSheet4 => 'ابھی بیٹری سیٹنگز کھولیں';

  @override
  String get backupReminderBanner1 => 'بیک اپ ایکسپورٹ ہو گیا 👍';

  @override
  String backupReminderBanner2(Object e) {
    return 'بیک اپ میں خرابی: $e';
  }

  @override
  String get backupReminderBanner3 => 'بیک اپ بنانے کا وقت ⚠️';

  @override
  String get backupReminderBanner4 =>
      'آخری بیک اپ کو 7 دن سے زیادہ ہو گئے۔ ڈیٹا محفوظ کریں تاکہ فون گم یا تبدیل ہونے پر کچھ ضائع نہ ہو۔';

  @override
  String get backupReminderBanner5 => 'ابھی نہیں';

  @override
  String get backupReminderBanner6 => 'محفوظ ہو رہا ہے...';

  @override
  String get backupReminderBanner7 => 'ابھی بیک اپ بنائیں';

  @override
  String get homeWidgetSettingsCard1 => 'ہوم اسکرین پر حساب دکھائیں';

  @override
  String get homeWidgetSettingsCard2 =>
      'ویجیٹ ایپ کھولے بغیر گاہکوں پر بقایا اور آج کی وصولی دکھاتا ہے';

  @override
  String get homeWidgetSettingsCard3 => 'ویجیٹ بند ہے اور کوئی رقم نہیں دکھاتا';

  @override
  String get homeWidgetSettingsCard4 => 'چھوٹا ویجیٹ شامل کریں';

  @override
  String get homeWidgetSettingsCard5 => 'صرف گاہکوں پر بقایا';

  @override
  String get homeWidgetSettingsCard6 => 'آج کے خلاصے کا ویجیٹ شامل کریں';

  @override
  String get homeWidgetSettingsCard7 =>
      'بقایا + آج کی وصولی + واجب الوصول + وصولی بٹن';

  @override
  String get homeWidgetSettingsCard8 =>
      'ویجیٹ شامل کرنے کے لیے آنے والا پیغام منظور کریں 👍';

  @override
  String get homeWidgetSettingsCard9 => 'ویجیٹ خود شامل کریں 📱';

  @override
  String get homeWidgetSettingsCard10 =>
      'آپ کا فون ایپ کو خود ویجیٹ شامل کرنے نہیں دیتا۔ یہ کریں:\n\n1. ہوم اسکرین پر خالی جگہ دیر تک دبائیں\n2. \"Widgets\" منتخب کریں\n3. \"کشکول\" تلاش کر کے ویجیٹ اسکرین پر کھینچیں';

  @override
  String get messageTemplateEditorBottomSheet1 => 'امانت کریانہ';

  @override
  String get messageTemplateEditorBottomSheet2 => 'ووڈافون کیش: 01012345678';

  @override
  String get messageTemplateEditorBottomSheet3 => 'محمد احمد';

  @override
  String get messageTemplateEditorBottomSheet4 =>
      'پیغام کا نمونہ محفوظ ہو گیا 👍';

  @override
  String get messageTemplateEditorBottomSheet5 => 'یاد دہانی کا پیغام بدلیں 💬';

  @override
  String get messageTemplateEditorBottomSheet6 => 'تیار نمونے: ';

  @override
  String get messageTemplateEditorBottomSheet7 => 'دوستانہ 😊';

  @override
  String get messageTemplateEditorBottomSheet8 => 'رسمی 👔';

  @override
  String get messageTemplateEditorBottomSheet9 => 'دکان کا نام';

  @override
  String get messageTemplateEditorBottomSheet10 => 'ادائیگی کی تفصیل';

  @override
  String get messageTemplateEditorBottomSheet11 => 'آخری لین دین کی تاریخ';

  @override
  String get messageTemplateEditorBottomSheet12 =>
      'یاد دہانی کا پیغام یہاں لکھیں...';

  @override
  String get messageTemplateEditorBottomSheet13 => 'گاہک کو ایسا پیغام ملے گا:';

  @override
  String get messageTemplateEditorBottomSheet14 => 'نمونہ محفوظ کریں';

  @override
  String shopProfileBottomSheet1(Object trim) {
    return 'موبائل والیٹ: $trim';
  }

  @override
  String get shopProfileBottomSheet2 => 'دکان کی تفصیلات محفوظ ہو گئیں 👍';

  @override
  String get shopProfileBottomSheet3 => 'دکان کا نام *';

  @override
  String get shopProfileBottomSheet4 => 'مثلاً: امانت کریانہ';

  @override
  String get shopProfileBottomSheet5 => 'براہ کرم دکان کا نام لکھیں';

  @override
  String get shopProfileBottomSheet6 => 'دکان کا فون نمبر';

  @override
  String get shopProfileBottomSheet7 => 'مثلاً: 010xxxxxxxx';

  @override
  String get shopProfileBottomSheet8 => 'دکان کا پتہ';

  @override
  String get shopProfileBottomSheet9 => 'مثلاً: بازار روڈ، بڑی مسجد کے ساتھ';

  @override
  String get shopProfileBottomSheet10 => 'InstaPay اکاؤنٹ';

  @override
  String get shopProfileBottomSheet11 => 'مثلاً: name@instapay';

  @override
  String get shopProfileBottomSheet12 => 'ووڈافون کیش / موبائل والیٹ نمبر';

  @override
  String get shopProfileBottomSheet13 => 'کاروبار کی قسم';

  @override
  String get shopProfileBottomSheet14 => 'دیگر کاروبار 🏪';

  @override
  String get shopProfileBottomSheet15 => 'قسطوں کا نظام چالو کریں';

  @override
  String get shopProfileBottomSheet16 => 'قسطوں کا بٹن اور شیڈول دکھائیں';

  @override
  String get shopProfileBottomSheet17 => 'تبدیلیاں محفوظ کریں';

  @override
  String get cloudAccountButton1 => 'آپ کا اکاؤنٹ اور کلاؤڈ بیک اپ ☁️';

  @override
  String get cloudAccountButton2 => 'کلاؤڈ بیک اپ';

  @override
  String get cloudAccountButton3 => 'گوگل سے سائن ان کریں';

  @override
  String get cloudBackupCard1 => 'ایک لمحہ…';

  @override
  String get cloudBackupCard2 => 'کچھ غلط ہو گیا، دوبارہ کوشش کریں';

  @override
  String get cloudBackupCard3 => 'گوگل اکاؤنٹس کھل رہے ہیں…';

  @override
  String cloudBackupCard4(Object email) {
    return '$email سے سائن ان ✓';
  }

  @override
  String get cloudBackupCard5 => 'بیک اپ کچھ مسائل کے ساتھ اپ لوڈ ہوا ⚠️';

  @override
  String cloudBackupCard6(Object uploaded, Object rejected, Object n) {
    return '$uploaded ریکارڈ اپ لوڈ، $rejected رد ہوئے:\n\n$n';
  }

  @override
  String get cloudBackupCard7 => 'آپ کا سارا ڈیٹا پہلے ہی کلاؤڈ پر ہے ✓';

  @override
  String cloudBackupCard8(Object uploaded) {
    return '$uploaded ریکارڈ کلاؤڈ پر اپ لوڈ ✓';
  }

  @override
  String get cloudBackupCard9 => 'آپ کے اکاؤنٹ کی دکانیں لوڈ ہو رہی ہیں…';

  @override
  String get cloudBackupCard10 => 'اس اکاؤنٹ کا ابھی کوئی کلاؤڈ بیک اپ نہیں';

  @override
  String get cloudBackupCard11 => 'دکان منتخب کریں';

  @override
  String get cloudBackupCard12 => ' (ملازم)';

  @override
  String get cloudBackupCard13 => 'کلاؤڈ سے بحال کریں؟';

  @override
  String cloudBackupCard14(Object name) {
    return 'ہم \"$name\" کا بیک اپ کلاؤڈ سے ڈاؤن لوڈ کر کے اس فون میں شامل کریں گے۔\n\n';
  }

  @override
  String get cloudBackupCard15 =>
      'کچھ حذف نہیں ہوگا: صرف اس فون پر موجود ڈیٹا رہے گا، اور آخری بیک اپ کے بعد فون پر بدلی ہوئی چیزیں ویسی ہی رہیں گی۔';

  @override
  String get cloudBackupCard16 => 'ہاں، بحال کریں';

  @override
  String get cloudBackupCard17 => 'بحال ہو گیا 🎉';

  @override
  String cloudBackupCard18(Object keptLocal) {
    return '، اور $keptLocal ریکارڈ ویسے ہی رہے کیونکہ فون والا نیا ہے';
  }

  @override
  String cloudBackupCard19(Object records, Object keptLocal) {
    return '$records ریکارڈ بحال ہوئے$keptLocal۔';
  }

  @override
  String get cloudBackupCard20 =>
      ' سب اسکرینیں تازہ کرنے کے لیے ایپ بند کر کے دوبارہ کھولیں۔';

  @override
  String get cloudBackupCard21 => 'ایپ بند کریں';

  @override
  String get cloudBackupCard22 => 'سائن آؤٹ کریں؟';

  @override
  String get cloudBackupCard23 =>
      'آپ کا ڈیٹا فون اور کلاؤڈ پر رہے گا، مگر دوبارہ سائن ان تک بیک اپ رک جائے گا۔';

  @override
  String get cloudBackupCard24 => 'سائن آؤٹ';

  @override
  String get cloudBackupCard25 => 'ایپ کے اس ورژن میں دستیاب نہیں';

  @override
  String get cloudBackupCard26 => 'کلاؤڈ بیک اپ';

  @override
  String get cloudBackupCard27 =>
      'گوگل سے سائن ان کریں تاکہ ڈیٹا آن لائن محفوظ رہے۔ فون گم ہو جائے تو کسی بھی دوسرے فون پر بحال کریں۔';

  @override
  String get cloudBackupCard28 => 'ابھی کوئی بیک اپ نہیں';

  @override
  String cloudBackupCard29(Object last) {
    return 'آخری بیک اپ: $last';
  }

  @override
  String get cloudBackupCard30 => 'ابھی اپ لوڈ ہو رہا ہے…';

  @override
  String get cloudBackupCard31 =>
      'انٹرنیٹ کا انتظار — واپس آتے ہی خود اپ لوڈ ہوگا';

  @override
  String get cloudBackupCard32 =>
      'اپ لوڈ رک گیا، تھوڑی دیر میں دوبارہ کوشش ہوگی';

  @override
  String get cloudBackupCard33 => 'سب کچھ اپ لوڈ ہو گیا ✓';

  @override
  String get cloudBackupCard34 => 'انٹرنیٹ ہو تو خودکار اپ لوڈ';

  @override
  String get cloudBackupCard35 => 'ابھی بیک اپ اپ لوڈ کریں';

  @override
  String get cloudBackupCard36 => 'اپنا ڈیٹا اس فون پر بحال کریں';

  @override
  String get cloudBackupCard37 =>
      'نئے فون یا دوبارہ انسٹال کے بعد — کچھ حذف نہیں کرتا';

  @override
  String get cloudBackupCard38 => 'سائن آؤٹ';

  @override
  String get onboardingScreen1 => 'میری دکان';

  @override
  String get onboardingScreen2 =>
      'ایپ آزمانے کے لیے نمونہ گاہک شامل کیے گئے، آپ انہیں کبھی بھی حذف کر سکتے ہیں';

  @override
  String get onboardingScreen3 => 'کشکول کی پہلی سیٹ اپ';

  @override
  String get onboardingScreen4 => 'اگلا: کاروبار کی قسم';

  @override
  String get onboardingScreen5 => 'کشکول میں خوش آمدید! 👋';

  @override
  String get onboardingScreen6 =>
      'ادھار، واٹس ایپ یاد دہانی اور قسطوں کے لیے آسان ڈیجیٹل کھاتہ۔';

  @override
  String get onboardingScreen7 => 'دکان کا نام *';

  @override
  String get onboardingScreen8 => 'مثلاً: امانت کریانہ / اسٹار موبائلز';

  @override
  String get onboardingScreen9 => 'دکان کا نام لکھیں (کم از کم 2 حروف)';

  @override
  String get onboardingScreen10 => 'دکان کا فون (اختیاری)';

  @override
  String get onboardingScreen11 =>
      'رسیدوں، اسٹیٹمنٹ اور واٹس ایپ پیغامات میں دکھایا جاتا ہے';

  @override
  String get onboardingScreen12 => 'کریانہ اور سپر مارکیٹ';

  @override
  String get onboardingScreen13 => 'روزانہ ادھار اور جلد دراز بندی';

  @override
  String get onboardingScreen14 => 'موبائل اور ایکسیسریز';

  @override
  String get onboardingScreen15 => 'ڈیوائس کی تفصیل، قسطیں خود بخود چالو';

  @override
  String get onboardingScreen16 => 'الیکٹرانکس اور گھریلو آلات';

  @override
  String get onboardingScreen17 => 'ادھار فروخت کے معاہدے، قسطیں خود بخود چالو';

  @override
  String get onboardingScreen18 => 'فارمیسی اور کاسمیٹکس';

  @override
  String get onboardingScreen19 => 'ادھار کی حد اور نسخوں کا حساب';

  @override
  String get onboardingScreen20 => 'دیگر کاروبار';

  @override
  String get onboardingScreen21 => 'ہر قسم کے کاروبار کے لیے لچکدار کھاتہ';

  @override
  String get onboardingScreen22 => 'آپ کا کاروبار کس قسم کا ہے؟';

  @override
  String get onboardingScreen23 => 'ہم ایپ کو آپ کے کام کے مطابق ترتیب دیں گے۔';

  @override
  String get onboardingScreen24 => 'قسطوں کی سہولت';

  @override
  String get onboardingScreen25 => 'قسطوں کا نظام چالو کریں';

  @override
  String get onboardingScreen26 => 'سیٹنگز سے کبھی بھی چالو یا بند کر سکتے ہیں';

  @override
  String get onboardingScreen27 => 'یاد دہانیاں آپ تک پہنچیں 🔔';

  @override
  String get onboardingScreen28 =>
      'تاکہ کشکول آپ کو روز وصولی اور قسطوں کی یاد دلا سکے:';

  @override
  String get onboardingScreen29 => 'نوٹیفکیشن کی اجازت';

  @override
  String get onboardingScreen30 => 'نوٹیفکیشن چالو ہو گئے ✅';

  @override
  String get onboardingScreen31 =>
      'روزانہ وصولی کا خلاصہ بھیجنے کے لیے نوٹیفکیشن کی اجازت چاہیے';

  @override
  String get onboardingScreen32 => 'نوٹیفکیشن کی اجازت دیں';

  @override
  String onboardingScreen33(Object brandName) {
    return 'پس منظر میں حفاظت ($brandName)';
  }

  @override
  String get onboardingScreen34 => 'پس منظر میں ایپ بند ہونے سے بچائیں';

  @override
  String get onboardingScreen35 => 'بیٹری سیٹنگز کھولیں';

  @override
  String get onboardingScreen36 => 'تیار ہیں! 🚀';

  @override
  String get onboardingScreen37 =>
      'آپ کی دکان کی تفصیل محفوظ ہو گئی۔ کیسے شروع کرنا چاہیں گے؟';

  @override
  String get onboardingScreen38 => '+ پہلا اصل گاہک شامل کریں';

  @override
  String get onboardingScreen39 =>
      'پہلا گاہک درج کریں اور فوراً ادھار و ادائیگی لکھنا شروع کریں';

  @override
  String get onboardingScreen40 => 'پہلے نمونہ ڈیٹا سے آزمائیں 💡';

  @override
  String get onboardingScreen41 =>
      'کشکول آزمانے کے لیے دو نمونہ گاہک شامل کرتا ہے (ایک ٹیپ سے حذف)';

  @override
  String get onboardingScreen42 => 'چھوڑیں اور ہوم اسکرین پر جائیں';

  @override
  String get shopRepository1 => 'احمد محمد (نمونہ)';

  @override
  String get shopRepository2 => 'گھریلو خریداری';

  @override
  String get shopRepository3 => 'محمود ابراہیم (نمونہ)';

  @override
  String get shopRepository4 => 'مہینے کے شروع کا سامان';

  @override
  String get shopRepository5 => 'حساب میں نقد ادائیگی';

  @override
  String get supplierWithBalance1 => 'ہفتہ';

  @override
  String get supplierWithBalance2 => 'اتوار';

  @override
  String get supplierWithBalance3 => 'پیر';

  @override
  String get supplierWithBalance4 => 'منگل';

  @override
  String get supplierWithBalance5 => 'بدھ';

  @override
  String get supplierWithBalance6 => 'جمعرات';

  @override
  String get supplierWithBalance7 => 'جمعہ';

  @override
  String get trashScreen1 => 'گاہک';

  @override
  String get trashScreen2 => 'لین دین';

  @override
  String get trashScreen3 => 'سپلائرز';

  @override
  String get trashScreen4 => 'اخراجات';

  @override
  String get trashScreen5 => 'قسطیں';

  @override
  String trashScreen6(Object title) {
    return '\"$title\" واپس آ گیا ✓';
  }

  @override
  String get trashScreen7 => 'واپس نہیں لا سکے، دوبارہ کوشش کریں';

  @override
  String get trashScreen8 => 'کوڑے دان 🗑️';

  @override
  String get trashScreen9 =>
      'جو کچھ آپ حذف کرتے ہیں یہاں آ جاتا ہے، ضائع نہیں ہوتا۔ کبھی بھی واپس لا سکتے ہیں، اور کلاؤڈ بیک اپ میں بھی واپس آ جائے گا۔';

  @override
  String get trashScreen10 => 'حذف شدہ چیزیں لوڈ نہیں ہوئیں';

  @override
  String get trashScreen11 => 'کوڑے دان خالی ہے ✨';

  @override
  String trashScreen12(Object deletedAt) {
    return 'حذف: $deletedAt';
  }

  @override
  String get trashScreen13 => 'واپس لائیں';

  @override
  String get trashScreen14 => 'کوڑے دان';

  @override
  String get trashScreen15 => 'حذف شدہ دیکھیں اور واپس لائیں';

  @override
  String trashScreen16(Object count) {
    return '$count چیزیں — واپس لا سکتے ہیں';
  }

  @override
  String get trashRepository1 => 'کرایہ';

  @override
  String get trashRepository2 => 'بجلی';

  @override
  String get trashRepository3 => 'تنخواہیں';

  @override
  String get trashRepository4 => 'سامان';

  @override
  String get trashRepository5 => 'سپلائر کو ادائیگی';

  @override
  String get trashRepository6 => 'خرچ';

  @override
  String get trashRepository7 => 'میرے ذمے';

  @override
  String get trashRepository8 => 'ادائیگی';

  @override
  String get trashRepository9 => 'میں نے ادا کیا';

  @override
  String get trashRepository10 => 'نامعلوم';

  @override
  String trashRepository11(Object itemDescription) {
    return 'قسطیں: $itemDescription';
  }

  @override
  String pdfStatementService1(Object sanitizedName, Object dateStr) {
    return 'Statement_${sanitizedName}_$dateStr.pdf';
  }

  @override
  String get pdfStatementService2 => 'گاہک کی اسٹیٹمنٹ';

  @override
  String pdfStatementService3(Object customerName) {
    return 'گاہک: $customerName';
  }

  @override
  String pdfStatementService4(Object phone) {
    return 'فون: $phone';
  }

  @override
  String pdfStatementService5(Object periodDescription) {
    return 'مدت: $periodDescription';
  }

  @override
  String get pdfStatementService6 => 'اس مدت سے پہلے کا بیلنس:';

  @override
  String get pdfStatementService7 => 'تاریخ';

  @override
  String get pdfStatementService8 => 'تفصیل';

  @override
  String get pdfStatementService9 => 'بیلنس';

  @override
  String pdfStatementService10(Object periodDebitsPiasters) {
    return 'کل خریداری / ادھار: $periodDebitsPiasters';
  }

  @override
  String pdfStatementService11(Object periodCreditsPiasters) {
    return 'کل ادائیگی: $periodCreditsPiasters';
  }

  @override
  String get pdfStatementService12 => 'آخری واجب الادا بیلنس:';

  @override
  String pdfStatementService13(Object trim) {
    return 'ادائیگی کے طریقے: $trim';
  }

  @override
  String get pdfStatementService14 => 'کشکول سے بنایا گیا — مفت آزمائیں:';

  @override
  String get statementCalculator1 => 'تمام لین دین';

  @override
  String get statementCalculator2 => 'جنوری';

  @override
  String get statementCalculator3 => 'فروری';

  @override
  String get statementCalculator4 => 'مارچ';

  @override
  String get statementCalculator5 => 'اپریل';

  @override
  String get statementCalculator6 => 'مئی';

  @override
  String get statementCalculator7 => 'جون';

  @override
  String get statementCalculator8 => 'جولائی';

  @override
  String get statementCalculator9 => 'اگست';

  @override
  String get statementCalculator10 => 'ستمبر';

  @override
  String get statementCalculator11 => 'اکتوبر';

  @override
  String get statementCalculator12 => 'نومبر';

  @override
  String get statementCalculator13 => 'دسمبر';

  @override
  String statementCalculator14(Object startDate, Object endDate) {
    return '$startDate سے $endDate تک';
  }

  @override
  String statementCalculator15(Object startDate) {
    return '$startDate سے';
  }

  @override
  String statementCalculator16(Object endDate) {
    return '$endDate تک';
  }

  @override
  String growthFooter1(Object shopCode) {
    return '—\nکشکول سے بنایا گیا 📒 مفت آزمائیں: $shopCode';
  }

  @override
  String growthFooter2(Object shopCode) {
    return 'میں کشکول 📒 استعمال کرتا ہوں تاکہ کاغذی کھاتے کے بغیر گاہکوں، سپلائرز اور دراز کا حساب رکھوں۔\nبہت آسان اور انٹرنیٹ کے بغیر چلتی ہے۔ مفت آزمائیں:\n$shopCode';
  }

  @override
  String get notificationService1 => 'روزانہ وصولی';

  @override
  String get notificationService2 => 'وصولی والے گاہکوں کی یاد دہانی';

  @override
  String notificationService3(Object dueCount, Object amountStr) {
    return '$dueCount گاہکوں پر $amountStr ہیں — وصولی کے لیے دبائیں';
  }

  @override
  String get notificationService4 => 'روزانہ وصولی کی یاد دہانی 📒';

  @override
  String get backupService1 => 'ڈیٹابیس فائل نہیں ملی';

  @override
  String backupService2(Object dateStr) {
    return 'کشکول بیک اپ - $dateStr';
  }

  @override
  String get backupService3 => 'منتخب فائل موجود نہیں';

  @override
  String get backupService4 => 'فائل خراب یا نامکمل ہے';

  @override
  String get backupService5 => 'غلط فائل فارمیٹ (کشکول فائل نہیں)';

  @override
  String get backupService6 => 'فائل میں کشکول ڈیٹابیس نہیں';

  @override
  String get backupService7 => 'فائل کے اندر ڈیٹابیس خراب ہے';

  @override
  String get backupService8 => 'درست SQLite ڈیٹابیس نہیں';

  @override
  String get backupService9 => 'غلط بیک اپ فائل';

  @override
  String get backupService10 => 'آرکائیو میں ڈیٹابیس فائل نہیں';

  @override
  String get googleAuthService1 => 'اس ورژن میں کلاؤڈ بیک اپ سیٹ نہیں';

  @override
  String get googleAuthService2 =>
      'گوگل نے سائن ان کی تفصیل نہیں دی، دوبارہ کوشش کریں';

  @override
  String get googleAuthService3 => 'سائن ان منسوخ';

  @override
  String googleAuthService4(Object codeName) {
    return 'گوگل سے سائن ان نہیں ہو سکا ($codeName)';
  }

  @override
  String get cloudApi1 => 'اس ورژن میں سرور ایڈریس سیٹ نہیں';

  @override
  String get cloudApi2 => 'پہلے گوگل سے سائن ان کریں';

  @override
  String get cloudApi3 => 'انٹرنیٹ نہیں، دوبارہ کوشش کریں';

  @override
  String get cloudApi4 => 'سرور نے دیر سے جواب دیا، دوبارہ کوشش کریں';

  @override
  String get cloudApi5 => 'سیشن ختم ہو گیا، دوبارہ گوگل سے سائن ان کریں';

  @override
  String get cloudApi6 => 'یہ دکان کسی اور گوگل اکاؤنٹ پر ہے';

  @override
  String get cloudApi7 => 'یہ فیچر سبسکرپشن مانگتا ہے';

  @override
  String get cloudApi8 => 'بہت زیادہ کوششیں، تھوڑا رک کر دوبارہ کوشش کریں';

  @override
  String get cloudApi9 => 'دوبارہ گوگل سے سائن ان کریں';

  @override
  String get cloudApi10 => 'سرور پر گوگل سائن ان سیٹ نہیں';

  @override
  String get cloudApi11 => 'سرور میں مسئلہ، تھوڑی دیر بعد کوشش کریں';

  @override
  String cloudApi12(Object code) {
    return 'مسئلہ ہوا ($code)';
  }

  @override
  String get cloudBackupService1 => 'گوگل سائن ان دستیاب نہیں';

  @override
  String get cloudBackupService2 => 'پہلے سیٹنگز سے دکان کی تفصیل مکمل کریں';

  @override
  String get cloudBackupService3 => 'دکان کا ڈیٹا تیار ہو رہا ہے…';

  @override
  String cloudBackupService4(Object length, Object changesLength) {
    return '$changesLength میں سے $length اپ لوڈ ہو رہے ہیں…';
  }

  @override
  String get cloudBackupService5 => 'مکمل ✓';

  @override
  String cloudBackupService6(Object changesLength) {
    return 'ڈیٹا ڈاؤن لوڈ ہو رہا ہے… ($changesLength)';
  }

  @override
  String cloudBackupService7(Object changesLength) {
    return '$changesLength ریکارڈ فون پر محفوظ ہو رہے ہیں…';
  }

  @override
  String get cloudBackupService8 => 'دکان';

  @override
  String autoBackupCoordinator1(Object rejected) {
    return '$rejected ریکارڈ اپ لوڈ نہیں ہوئے';
  }

  @override
  String get autoBackupCoordinator2 =>
      'مسئلہ ہوا، تھوڑی دیر میں دوبارہ کوشش ہوگی';

  @override
  String get customerRating1 => 'نیا گاہک (3 سے کم لین دین)';

  @override
  String get customerRating2 => 'حساب صاف اور وقت پر ادا کرتا ہے';

  @override
  String customerRating3(Object oldestUnpaidAgeDays) {
    return 'لیٹ: سب سے پرانا ادھار $oldestUnpaidAgeDays دن کا اور حد پار';
  }

  @override
  String get customerRating4 => 'گاہک کی ادھار حد پار ہو گئی';

  @override
  String get customerRating5 => 'صرف آج ادھار لیا، حساب ٹھیک ہے';

  @override
  String customerRating6(Object oldestUnpaidAgeDays) {
    return 'سب سے پرانی رقم صرف $oldestUnpaidAgeDays دن کی (محفوظ حد)';
  }

  @override
  String customerRating7(Object oldestUnpaidAgeDays) {
    return 'سب سے پرانی رقم $oldestUnpaidAgeDays دن کی (45 دن سے زیادہ لیٹ)';
  }

  @override
  String customerRating8(Object oldestUnpaidAgeDays) {
    return 'سب سے پرانی رقم $oldestUnpaidAgeDays دن کی (نگرانی چاہیے)';
  }

  @override
  String get whatsappTemplate1 =>
      'السلام علیکم {customer_name} 👋\n{shop_name} سے بات ہو رہی ہے۔\nآپ کا موجودہ بیلنس: {balance}\nآخری لین دین: {last_transaction_date} - {last_transaction_amount}\nادائیگی کے لیے: {payment_info}\nہمارے ساتھ کاروبار کا شکریہ 🙏';

  @override
  String get whatsappTemplate2 =>
      'محترم {customer_name}،\nیاد دہانی ہے کہ {shop_name} میں آپ کا موجودہ بیلنس {balance} ہے۔\nآخری درج لین دین: {last_transaction_date} ({last_transaction_amount})\nادائیگی کے طریقے: {payment_info}\nشکریہ کے ساتھ۔';

  @override
  String get whatsappTemplate3 =>
      'السلام علیکم {customer_name} 👋\n{shop_name} سے بات ہو رہی ہے۔\n({item}) کی قسط کی یاد دہانی — {installment_count} میں سے قسط نمبر {installment_number}:\nواجب الادا رقم: {amount}\nآخری تاریخ: {due_date}\nکل باقی: {remaining_total}\nادائیگی کے طریقے: {payment_info}\nوقت پر ادائیگی کا شکریہ 🙏';

  @override
  String get whatsappTemplate4 => 'دکان پر نقد یا دستیاب ٹرانسفر';

  @override
  String get money1 => 'EGP';

  @override
  String get batteryOptimizationHelper1 => 'XOS / HiOS';

  @override
  String get batteryOptimizationHelper2 =>
      'اپنے فون پر Phone Master ایپ کھولیں۔';

  @override
  String get batteryOptimizationHelper3 =>
      '\"Auto-start\" مینجمنٹ میں جا کر کشکول چالو کریں۔';

  @override
  String get batteryOptimizationHelper4 =>
      'ایپ کی سیٹنگز میں \"Battery\" کھولیں اور \"Unrestricted\" منتخب کریں۔';

  @override
  String get batteryOptimizationHelper5 =>
      'حالیہ ایپس میں ایپ کو نیچے کھینچ کر لاک کریں 🔒۔';

  @override
  String get batteryOptimizationHelper6 => 'MIUI / HyperOS';

  @override
  String get batteryOptimizationHelper7 =>
      'ایپ سیٹنگز کھولیں اور \"Autostart\" چالو کریں۔';

  @override
  String get batteryOptimizationHelper8 =>
      '\"Battery saver\" میں \"No restrictions\" منتخب کریں۔';

  @override
  String get batteryOptimizationHelper9 =>
      'حالیہ ایپس میں کشکول کو دیر تک دبائیں اور لاک آئیکن چنیں 🔒۔';

  @override
  String get batteryOptimizationHelper10 => 'ColorOS / Realme UI';

  @override
  String get batteryOptimizationHelper11 =>
      'ایپ سیٹنگز -> Battery usage میں \"Allow background activity\" چالو کریں۔';

  @override
  String get batteryOptimizationHelper12 => '\"Auto-launch\" چالو کریں۔';

  @override
  String get batteryOptimizationHelper13 =>
      'حالیہ ایپس میں تین نقطے دبائیں اور \"Lock\" منتخب کریں۔';

  @override
  String get batteryOptimizationHelper14 => 'One UI';

  @override
  String get batteryOptimizationHelper15 =>
      'Settings -> Device care -> Battery میں جائیں۔';

  @override
  String get batteryOptimizationHelper16 =>
      '\"Background usage limits\" کھولیں۔';

  @override
  String get batteryOptimizationHelper17 =>
      'کشکول کو \"Never sleeping apps\" میں شامل کریں۔';

  @override
  String get batteryOptimizationHelper18 => 'EMUI / MagicOS';

  @override
  String get batteryOptimizationHelper19 =>
      'Settings -> Battery -> App launch میں جائیں۔';

  @override
  String get batteryOptimizationHelper20 =>
      '\"Kashkool\" تلاش کریں، مینول پر کریں اور Auto-launch + Run in background چالو کریں۔';

  @override
  String get batteryOptimizationHelper21 => 'سسٹم سیٹنگز';

  @override
  String get batteryOptimizationHelper22 => 'سسٹم نوٹیفکیشن کی حفاظت';

  @override
  String get batteryOptimizationHelper23 =>
      'فون سیٹنگز میں ایپ کی معلومات کھولیں۔';

  @override
  String get batteryOptimizationHelper24 =>
      '\"Battery\" کھولیں اور \"Unrestricted\" منتخب کریں۔';

  @override
  String get batteryOptimizationHelper25 =>
      'یاد دہانیاں آئیں اس کے لیے الٹرا پاور سیونگ موڈ بند رکھیں۔';

  @override
  String get homeWidgetService1 => 'کوئی نہیں';

  @override
  String get homeWidgetService2 => '1 گاہک';

  @override
  String get homeWidgetService3 => '2 گاہک';

  @override
  String homeWidgetService4(Object count) {
    return '$count گاہک';
  }

  @override
  String get pinLockScreen1 => 'غلط PIN، دوبارہ کوشش کریں';

  @override
  String get pinLockScreen2 => 'دونوں PIN مختلف ہیں، دوبارہ کوشش کریں';

  @override
  String get pinLockScreen3 => 'فنگر پرنٹ دستیاب نہیں یا سیٹ نہیں';

  @override
  String get pinLockScreen4 => 'کشکول میں خوش آمدید 📒';

  @override
  String get pinLockScreen5 => 'نیا PIN سیٹ کریں';

  @override
  String get pinLockScreen6 => 'تصدیق کے لیے PIN دوبارہ لکھیں';

  @override
  String get pinLockScreen7 => '4 ہندسوں کا PIN درج کریں';

  @override
  String get pinLockScreen8 =>
      'ایپ لاک کرنے کے لیے یاد رہنے والے 4 ہندسے لکھیں';

  @override
  String get pinLockScreen9 => 'وہی ہندسے دوبارہ لکھیں';

  @override
  String get pinLockScreen10 => 'فنگر پرنٹ';

  @override
  String get pinLockScreen11 => 'مٹائیں';

  @override
  String get securityService1 => 'کشکول کھولنے کے لیے شناخت کی تصدیق کریں';

  @override
  String get settingsLanguageTitle => 'زبان';

  @override
  String get settingsLanguageSystem => 'فون کی زبان (خودکار)';

  @override
  String get cloudDeleteAccountTitle => 'کلاؤڈ اکاؤنٹ حذف کریں';

  @override
  String get cloudDeleteAccountSubtitle =>
      'کلاؤڈ بیک اپ اور اکاؤنٹ ہمیشہ کے لیے حذف — فون کا ڈیٹا رہے گا';

  @override
  String get cloudDeleteAccountConfirmTitle => 'اکاؤنٹ ہمیشہ کے لیے حذف کریں؟';

  @override
  String get cloudDeleteAccountConfirmBody =>
      'ہم آپ کا اکاؤنٹ اور آپ کی دکانوں کے تمام کلاؤڈ بیک اپ حذف کر دیں گے۔ یہ واپس نہیں ہو سکتا۔ اس فون کا ڈیٹا ویسا ہی رہے گا۔';

  @override
  String get cloudDeleteAccountConfirmButton => 'ہمیشہ کے لیے حذف کریں';

  @override
  String get cloudDeleteAccountDone => 'آپ کا کلاؤڈ اکاؤنٹ حذف ہو گیا';

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
