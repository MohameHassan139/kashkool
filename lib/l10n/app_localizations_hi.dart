// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'काशकूल';

  @override
  String get navCustomers => 'ग्राहक';

  @override
  String get navCollection => 'वसूली';

  @override
  String get navSuppliers => 'सप्लायर';

  @override
  String get navInventory => 'المخزون';

  @override
  String get navCashDrawer => 'कैश ड्रॉअर';

  @override
  String get inventoryTitle => 'المخزون';

  @override
  String get inventoryManageButton => 'إدارة الأصناف والمخزون';

  @override
  String get inventorySearchHint => 'ابحث عن صنف أو باركود...';

  @override
  String get inventoryAddProduct => 'صنف جديد';

  @override
  String get inventoryEditProduct => 'تعديل الصنف';

  @override
  String get inventoryNoProducts => 'لسه مفيش أصناف مسجلة';

  @override
  String get inventoryNoSearchResults => 'مفيش أصناف مطابقة للبحث';

  @override
  String get inventoryProductName => 'اسم الصنف';

  @override
  String get inventoryNameRequired => 'اكتب اسم الصنف';

  @override
  String get inventoryBarcode => 'الباركود (اختياري)';

  @override
  String get inventoryCategory => 'التصنيف (اختياري)';

  @override
  String get inventoryUnit => 'وحدة البيع';

  @override
  String get inventoryUnitExample => 'مثال: قطعة، كجم، لتر';

  @override
  String get inventoryUnitRequired => 'اكتب وحدة البيع';

  @override
  String get inventoryPurchasePrice => 'سعر الشراء بالجنيه';

  @override
  String get inventorySalePrice => 'سعر البيع بالجنيه';

  @override
  String get inventoryMinimumStock => 'نبّهني لما الكمية توصل';

  @override
  String get inventoryInitialStock => 'الكمية الموجودة حاليًا';

  @override
  String get inventoryCurrentStock => 'الموجود في المخزن';

  @override
  String get inventoryInStock => 'متوفر';

  @override
  String get inventoryLowStock => 'الكمية قليلة';

  @override
  String get inventoryAdjustStock => 'تعديل الكمية';

  @override
  String get inventoryAddStock => 'إضافة للمخزون';

  @override
  String get inventoryRemoveStock => 'خصم من المخزون';

  @override
  String get inventoryQuantity => 'الكمية';

  @override
  String get inventoryNote => 'ملاحظة (اختياري)';

  @override
  String get inventoryMovementHistory => 'حركة المخزون';

  @override
  String get inventoryMovementOpening => 'رصيد افتتاحي';

  @override
  String get inventoryMovementAdjustment => 'تعديل يدوي';

  @override
  String get inventoryMovementPurchase => 'شراء';

  @override
  String get inventoryMovementSale => 'بيع';

  @override
  String get inventoryMovementCustomerReturn => 'مرتجع عميل';

  @override
  String get inventoryMovementSupplierReturn => 'مرتجع مورد';

  @override
  String get inventoryNoMovements => 'مفيش حركات مخزون لسه';

  @override
  String get inventorySave => 'حفظ';

  @override
  String get inventoryCancel => 'إلغاء';

  @override
  String get inventoryDelete => 'حذف الصنف';

  @override
  String get inventoryDeleteConfirm =>
      'الصنف مش هيظهر في القائمة، لكن سجل حركته هيفضل محفوظ. متأكد؟';

  @override
  String get inventoryDeleted => 'تم حذف الصنف';

  @override
  String get inventoryProductSaved => 'تم حفظ الصنف';

  @override
  String get inventoryStockSaved => 'تم تحديث المخزون';

  @override
  String get inventoryInvalidQuantity => 'اكتب كمية صحيحة (لحد 3 أرقام عشرية)';

  @override
  String get inventoryQuantityRequired => 'اكتب كمية أكبر من صفر';

  @override
  String get inventoryStockCannotBeNegative => 'الكمية الموجودة مش كفاية للخصم';

  @override
  String get inventoryInvalidPrice => 'اكتب سعر صحيح غير سالب';

  @override
  String get inventoryBarcodeExists => 'الباركود مسجل لصنف تاني';

  @override
  String get inventoryUnitChangeNotAllowed =>
      'مش ممكن تغيير الوحدة بعد تسجيل حركة للمخزون';

  @override
  String get inventorySaveFailed =>
      'ماقدرناش نحفظ التغيير. راجع البيانات وحاول تاني.';

  @override
  String get quickPosTitle => 'بيع سريع';

  @override
  String get quickPosOpen => 'افتح البيع السريع';

  @override
  String get quickPosSearch => 'ابحث بالاسم أو اكتب الباركود...';

  @override
  String get quickPosProducts => 'الأصناف';

  @override
  String get quickPosAdd => 'ضيف للبيع';

  @override
  String get quickPosAvailable => 'المتاح';

  @override
  String get quickPosCart => 'أصناف البيع';

  @override
  String get quickPosEmptyCart => 'ضيف أصناف عشان تبدأ البيع';

  @override
  String get quickPosQuantity => 'الكمية';

  @override
  String get quickPosQuantityInvalid => 'اكتب كمية صحيحة أكبر من صفر';

  @override
  String get quickPosCash => 'نقدي';

  @override
  String get quickPosCredit => 'على حساب عميل';

  @override
  String get quickPosSelectCustomer => 'اختار العميل';

  @override
  String get quickPosCustomerRequired => 'اختار عميل للبيع على الحساب';

  @override
  String get quickPosTotal => 'الإجمالي';

  @override
  String get quickPosCompleteSale => 'تأكيد البيع';

  @override
  String get quickPosSaving => 'بيتم حفظ البيع...';

  @override
  String get quickPosSaleSaved => 'تم تسجيل البيع';

  @override
  String get quickPosSaveFailed => 'ماقدرناش نسجل البيع. حاول تاني.';

  @override
  String get quickPosInsufficientStock => 'المخزون مش كفاية للكمية دي';

  @override
  String get quickPosCashDayClosed =>
      'الدرج بتاع النهارده اتقفل. افتحه تاني عشان تسجل بيع نقدي.';

  @override
  String get quickPosLoadFailed => 'ماقدرناش نحمّل الأصناف';

  @override
  String get quickPosCustomersLoadFailed => 'ماقدرناش نحمّل العملاء';

  @override
  String get quickPosSaleNote => 'بيع سريع';

  @override
  String get supplierPurchasesTitle => 'مشتريات المورد';

  @override
  String get supplierPurchaseNew => 'تسجيل شراء';

  @override
  String get supplierPurchaseInvoiceNumber => 'رقم الفاتورة (اختياري)';

  @override
  String get supplierPurchasePaymentType => 'طريقة الحساب';

  @override
  String get supplierPurchaseCash => 'نقدي';

  @override
  String get supplierPurchaseCredit => 'على الحساب';

  @override
  String get supplierPurchaseAddProduct => 'اختار صنف';

  @override
  String get supplierPurchaseItems => 'أصناف الفاتورة';

  @override
  String get supplierPurchaseQuantity => 'الكمية';

  @override
  String get supplierPurchaseUnitCost => 'سعر شراء الوحدة بالجنيه';

  @override
  String get supplierPurchaseAddLine => 'إضافة الصنف';

  @override
  String get supplierPurchaseNoLines => 'ضيف صنف واحد على الأقل';

  @override
  String get supplierPurchaseSave => 'حفظ الفاتورة';

  @override
  String get supplierPurchaseTotal => 'إجمالي الفاتورة';

  @override
  String get supplierPurchaseSaved => 'تم تسجيل فاتورة الشراء';

  @override
  String get supplierPurchaseSaveFailed => 'ماقدرناش نسجل الفاتورة. حاول تاني.';

  @override
  String get supplierPurchaseNoInvoices => 'مفيش فواتير شراء للمورد ده';

  @override
  String get supplierPurchaseDetails => 'تفاصيل الفاتورة';

  @override
  String get supplierPurchaseReturn => 'إرجاع للمورد';

  @override
  String get supplierPurchaseReturned => 'المرتجع';

  @override
  String get supplierPurchaseRemaining => 'المتاح للمرتجع';

  @override
  String get supplierPurchaseReturnQuantity => 'كمية المرتجع';

  @override
  String get supplierPurchaseReturnSaved =>
      'تم تسجيل المرتجع واتخصم من حساب المورد';

  @override
  String get supplierPurchaseReturnLimit =>
      'الكمية المطلوبة أكبر من المتاح للمرتجع أو المخزون';

  @override
  String get supplierCreditNote => 'رصيد دائن من مرتجع';

  @override
  String get supplierPurchaseInvalidInput => 'راجع الكمية والسعر وحاول تاني';

  @override
  String get supplierPurchaseLoadError => 'ماقدرناش نحمّل فواتير الشراء';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get debt => 'उधार';

  @override
  String get payment => 'भुगतान';

  @override
  String get settled => 'चुकता';

  @override
  String get currency => 'EGP';

  @override
  String get piaster => 'पियास्टर';

  @override
  String get save => 'सेव करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get search => 'खोजें...';

  @override
  String placeholderScreen(String screenName) {
    return '$screenName स्क्रीन';
  }

  @override
  String get comingSoon => 'जल्द आ रहा है';

  @override
  String get totalReceivablesTitle => 'ग्राहकों पर आपका बकाया';

  @override
  String get searchCustomersHint => 'नाम या फ़ोन से खोजें...';

  @override
  String get filterAll => 'सभी';

  @override
  String get filterHasDebt => 'उधार वाले';

  @override
  String get filterSettled => 'चुकता';

  @override
  String get filterLate => 'देरी वाले';

  @override
  String get sortHighestDebt => 'सबसे ज़्यादा उधार';

  @override
  String get sortName => 'नाम';

  @override
  String get sortLastActivity => 'आख़िरी गतिविधि';

  @override
  String get addNewCustomer => 'नया ग्राहक';

  @override
  String get addCustomer => 'ग्राहक जोड़ें';

  @override
  String get editCustomer => 'ग्राहक संपादित करें';

  @override
  String get customerName => 'ग्राहक का नाम';

  @override
  String get customerNameHint => 'जैसे: मोहम्मद किराना वाले';

  @override
  String get customerNameRequired => 'ग्राहक का नाम ज़रूरी है';

  @override
  String get customerNameTooShort => 'नाम कम से कम 2 अक्षर का हो';

  @override
  String get customerPhone => 'मोबाइल नंबर';

  @override
  String get customerPhoneHint => '010xxxxxxxx';

  @override
  String get customerPhoneInvalid => 'गलत मोबाइल नंबर (010, 011, 012, 015)';

  @override
  String get customerNotes => 'नोट्स';

  @override
  String get customerNotesHint => 'जैसे: दूसरी मंज़िल वाले पड़ोसी';

  @override
  String get creditLimit => 'उधार सीमा (वैकल्पिक)';

  @override
  String get creditLimitHint => 'जैसे: 1000';

  @override
  String get noCustomersTitle => 'आपका खाता खाली है!';

  @override
  String get noCustomersSubtitle =>
      'पहला ग्राहक जोड़ने और उसका हिसाब आसानी से रखने के लिए नीचे बटन दबाएँ';

  @override
  String get noSearchResults => 'इस नाम या नंबर का कोई ग्राहक नहीं';

  @override
  String get duplicateCustomerWarning =>
      'चेतावनी: इसी नाम या नंबर का ग्राहक पहले से है';

  @override
  String get customerDetails => 'ग्राहक विवरण';

  @override
  String get callCustomer => 'कॉल करें';

  @override
  String get deleteCustomer => 'ग्राहक हटाएँ';

  @override
  String get deleteCustomerConfirm => 'हटाने की पुष्टि करें';

  @override
  String deleteCustomerWarningDebt(String amount) {
    return 'ध्यान दें! इस ग्राहक पर अभी $amount बाकी है। क्या आप सच में हटाना चाहते हैं?';
  }

  @override
  String deleteCustomerSafeConfirm(String name) {
    return 'क्या आप सच में ग्राहक $name को हटाना चाहते हैं?';
  }

  @override
  String get customerDeleted => 'ग्राहक हटा दिया गया';

  @override
  String get customerSaved => 'ग्राहक सेव हो गया';

  @override
  String get lastActivityNever => 'कोई पिछला लेन-देन नहीं';

  @override
  String lastActivityDate(String date) {
    return 'आख़िरी लेन-देन: $date';
  }

  @override
  String creditLimitLabel(String amount) {
    return 'उधार सीमा: $amount';
  }

  @override
  String get creditLimitExceeded => 'उधार सीमा पार!';

  @override
  String get heOwes => 'उधार';

  @override
  String get hePaid => 'जमा (ज़्यादा दिया)';

  @override
  String get currentBalance => 'मौजूदा बैलेंस';

  @override
  String get noTransactionsYet => 'अभी तक कोई लेन-देन दर्ज नहीं';

  @override
  String get addDebtTitle => 'नया उधार दर्ज करें';

  @override
  String get addPaymentTitle => 'भुगतान दर्ज करें';

  @override
  String get amountLabel => 'रकम';

  @override
  String get amountRequired => 'शून्य से ज़्यादा सही रकम डालें';

  @override
  String get today => 'आज';

  @override
  String get yesterday => 'कल';

  @override
  String get date => 'तारीख़';

  @override
  String get pickDate => 'तारीख़ चुनें';

  @override
  String get paymentMethod => 'भुगतान का तरीका';

  @override
  String get methodCash => 'नकद';

  @override
  String get methodInstapay => 'InstaPay';

  @override
  String get methodWallet => 'मोबाइल वॉलेट';

  @override
  String get methodOther => 'अन्य';

  @override
  String get noteOptional => 'नोट (वैकल्पिक: चीनी, तेल, रिचार्ज...)';

  @override
  String get voiceDictation => 'बोलकर लिखें';

  @override
  String get listening => 'सुन रहा है... अब बोलें';

  @override
  String get speechNotAvailable => 'इस डिवाइस पर बोलकर लिखना उपलब्ध नहीं';

  @override
  String get attachPhoto => 'फ़ोटो जोड़ें';

  @override
  String get camera => 'कैमरा';

  @override
  String get gallery => 'गैलरी';

  @override
  String get removePhoto => 'फ़ोटो हटाएँ';

  @override
  String get overpaymentTitle => 'रकम उधार से ज़्यादा है!';

  @override
  String overpaymentMessage(
    String paidAmount,
    String dueAmount,
    String creditAmount,
  ) {
    return 'दी गई रकम ($paidAmount) उधार ($dueAmount) से ज़्यादा है। क्या ज़्यादा रकम ($creditAmount) ग्राहक के खाते में जमा करें?';
  }

  @override
  String get overpaymentConfirm => 'हाँ, जमा करें';

  @override
  String get transactionSaved => 'लेन-देन दर्ज हो गया';

  @override
  String get undo => 'वापस लें';

  @override
  String get transactionUndone => 'लेन-देन वापस ले लिया गया';

  @override
  String get transactionDetails => 'लेन-देन का विवरण';

  @override
  String get editTransaction => 'लेन-देन बदलें';

  @override
  String get deleteTransaction => 'लेन-देन हटाएँ';

  @override
  String get deleteTransactionConfirm => 'क्या आप यह लेन-देन हटाना चाहते हैं?';

  @override
  String get transactionDeleted => 'लेन-देन हटा दिया गया';

  @override
  String get viewPhoto => 'फ़ोटो देखें';

  @override
  String get creditLimitWarningTitle => 'उधार सीमा चेतावनी';

  @override
  String creditLimitExceededDialog(
    String customerName,
    String newTotal,
    String limit,
  ) {
    return '$customerName पर $newTotal हो जाएगा, जबकि सीमा $limit है';
  }

  @override
  String get saveAnyway => 'फिर भी दर्ज करें';

  @override
  String get changeLimit => 'सीमा बदलें';

  @override
  String get newCreditLimit => 'नई उधार सीमा';

  @override
  String get limitUpdated => 'उधार सीमा बदल गई';

  @override
  String get totalPayablesTitle => 'सप्लायरों का आप पर बकाया';

  @override
  String get netMarketPosition => 'कुल वित्तीय स्थिति';

  @override
  String netReceivables(String amount) {
    return 'कुल लेना: $amount';
  }

  @override
  String netPayables(String amount) {
    return 'कुल देना: $amount';
  }

  @override
  String get netSettled => 'हिसाब बराबर है (0 EGP)';

  @override
  String get addNewSupplier => 'नया सप्लायर';

  @override
  String get addSupplier => 'सप्लायर जोड़ें';

  @override
  String get editSupplier => 'सप्लायर बदलें';

  @override
  String get supplierName => 'सप्लायर / एजेंट का नाम';

  @override
  String get supplierNameHint => 'जैसे: राजेश, कंपनी एजेंट';

  @override
  String get supplierNameRequired => 'सप्लायर का नाम ज़रूरी है';

  @override
  String get company => 'कंपनी / एजेंसी';

  @override
  String get companyHint => 'जैसे: अमूल, पारले';

  @override
  String get visitDay => 'हफ़्ते का विज़िट दिन';

  @override
  String get noSpecificDay => 'कोई तय दिन नहीं';

  @override
  String get supplierNotes => 'नोट्स';

  @override
  String get supplierNotesHint => 'जैसे: सुबह 10 बजे आता है';

  @override
  String get noSuppliersTitle => 'सप्लायर खाता खाली है!';

  @override
  String get noSuppliersSubtitle =>
      'पहला सप्लायर या कंपनी जोड़ने के लिए नीचे बटन दबाएँ';

  @override
  String get noSupplierSearchResults => 'कोई सप्लायर नहीं मिला';

  @override
  String get searchSuppliersHint => 'नाम, कंपनी या नंबर से खोजें...';

  @override
  String get supplierDetails => 'सप्लायर विवरण';

  @override
  String get iOweHim => 'मुझ पर बकाया';

  @override
  String get iPaidHim => 'मैंने चुकाया';

  @override
  String get deleteSupplier => 'सप्लायर हटाएँ';

  @override
  String get deleteSupplierConfirm => 'हटाने की पुष्टि करें';

  @override
  String deleteSupplierWarningDebt(String amount) {
    return 'ध्यान दें! इस सप्लायर के आप पर अभी $amount बाकी हैं। क्या सच में हटाना है?';
  }

  @override
  String deleteSupplierSafeConfirm(String name) {
    return 'क्या आप सच में सप्लायर $name को हटाना चाहते हैं?';
  }

  @override
  String get supplierDeleted => 'सप्लायर हटा दिया गया';

  @override
  String get supplierSaved => 'सप्लायर सेव हो गया';

  @override
  String visitDayPrefix(String day) {
    return 'विज़िट का दिन: $day';
  }

  @override
  String get sortCompany => 'कंपनी';

  @override
  String get sortVisitDay => 'विज़िट का दिन';

  @override
  String get dueCustomersTitle => 'वसूली वाले ग्राहक';

  @override
  String get totalDueTitle => 'कुल बकाया';

  @override
  String dueCustomersCount(int count) {
    return '$count ग्राहक';
  }

  @override
  String dueHeaderSummary(int count, String amount) {
    return 'आपके $count ग्राहकों पर $amount बाकी हैं';
  }

  @override
  String oldestDebtDays(int days) {
    return 'सबसे पुराना उधार $days दिन पहले';
  }

  @override
  String get oldestDebtToday => 'उधार आज दर्ज हुआ';

  @override
  String lastReminderDays(int days) {
    return 'आख़िरी याद: $days दिन पहले';
  }

  @override
  String get lastReminderToday => 'आख़िरी याद: आज';

  @override
  String get neverReminded => 'अभी याद नहीं दिलाया';

  @override
  String snoozedUntilDate(String date) {
    return '$date तक टाला गया';
  }

  @override
  String get sendWhatsApp => 'व्हाट्सऐप';

  @override
  String get sendSms => 'SMS';

  @override
  String get moreActions => 'और';

  @override
  String get snooze3Days => '3 दिन टालें';

  @override
  String get snooze7Days => 'एक हफ़्ता टालें';

  @override
  String get cancelSnooze => 'टालना रद्द करें';

  @override
  String get recordCollectionPayment => 'भुगतान दर्ज करें';

  @override
  String get didSendMessage => 'क्या मैसेज भेज दिया?';

  @override
  String didSendMessageDesc(String name) {
    return 'क्या आपने $name को व्हाट्सऐप पर याद दिलाया?';
  }

  @override
  String get yesSent => 'हाँ, भेज दिया';

  @override
  String get notSent => 'नहीं, नहीं भेजा';

  @override
  String get reminderMarkedSent => 'याद दिलाना दर्ज हुआ';

  @override
  String get snoozedSuccess => 'याद दिलाना टाल दिया';

  @override
  String get noDueCustomersTitle => 'आज कोई वसूली नहीं 🎉';

  @override
  String get noDueCustomersSubtitle =>
      'सभी ग्राहकों का हिसाब ठीक है या उन्हें हाल ही में याद दिलाया गया।';

  @override
  String get whatsAppNotInstalled =>
      'व्हाट्सऐप इंस्टॉल नहीं है। क्या SMS भेजें?';

  @override
  String get openSms => 'SMS भेजें';

  @override
  String get growthFooter => '\nकाशकूल ऐप से भेजा गया 📒';

  @override
  String get statementTitle => 'खाता विवरण';

  @override
  String get generateStatement => 'विवरण बनाएँ';

  @override
  String get statementAllTime => 'सभी लेन-देन';

  @override
  String get statementThisMonth => 'इस महीने';

  @override
  String get statementCustomRange => 'कस्टम अवधि';

  @override
  String get statementFormatA4 => 'A4 पेपर';

  @override
  String get statementFormatReceipt => 'थर्मल रसीद (80mm)';

  @override
  String get dateCol => 'तारीख़';

  @override
  String get descriptionCol => 'विवरण';

  @override
  String get debtCol => 'उधार';

  @override
  String get paymentCol => 'भुगतान';

  @override
  String get balanceCol => 'बैलेंस';

  @override
  String get startingBalance => 'शुरुआती बैलेंस';

  @override
  String get finalBalance => 'अंतिम बैलेंस';

  @override
  String periodLabel(String period) {
    return 'अवधि: $period';
  }

  @override
  String statementGeneratedAt(String date) {
    return 'बनाने की तारीख़: $date';
  }

  @override
  String get shareStatement => 'विवरण शेयर करें';

  @override
  String get printStatement => 'प्रिंट';

  @override
  String statementShareSubject(String name) {
    return 'खाता विवरण - $name';
  }

  @override
  String get totalDebits => 'कुल ख़रीद / उधार';

  @override
  String get totalCredits => 'कुल भुगतान';

  @override
  String get drawerTitle => 'कैश ड्रॉअर बंद करना';

  @override
  String get todayDrawer => 'आज का ड्रॉअर';

  @override
  String get expectedInDrawer => 'ड्रॉअर में होना चाहिए';

  @override
  String get openingCash => 'शुरुआती रकम';

  @override
  String get openingCashHint => 'दिन की शुरुआत की रकम';

  @override
  String get editOpeningCash => 'शुरुआती रकम बदलें';

  @override
  String get cashSales => 'नकद बिक्री';

  @override
  String get addCashSales => 'नकद बिक्री दर्ज करें';

  @override
  String get cashIn => 'ड्रॉअर में आया (नकद)';

  @override
  String get digitalIn => 'डिजिटल आमद';

  @override
  String get cashOut => 'ड्रॉअर से निकला (नकद)';

  @override
  String get customerPaymentsCash => 'ग्राहकों से वसूली (नकद)';

  @override
  String get customerPaymentsDigital => 'ग्राहकों से वसूली (डिजिटल)';

  @override
  String get supplierPaymentsCash => 'सप्लायरों को भुगतान (नकद)';

  @override
  String get expensesCash => 'दुकान के ख़र्च (नकद)';

  @override
  String get addExpense => 'ख़र्च दर्ज करें';

  @override
  String get editExpense => 'ख़र्च बदलें';

  @override
  String get deleteExpense => 'ख़र्च हटाएँ';

  @override
  String get deleteExpenseConfirm => 'क्या यह ख़र्च हटाना है?';

  @override
  String get expenseCategory => 'ख़र्च की श्रेणी';

  @override
  String get catRent => 'किराया';

  @override
  String get catElectricity => 'बिजली और बिल';

  @override
  String get catSalary => 'वेतन और दिहाड़ी';

  @override
  String get catSupplies => 'माल और सामान';

  @override
  String get catSupplierPayment => 'सप्लायर को भुगतान';

  @override
  String get catOther => 'अन्य';

  @override
  String get closeDay => 'दिन बंद करें';

  @override
  String get reopenDay => 'दिन फिर खोलें';

  @override
  String get reopenDayConfirm => 'क्या बदलाव के लिए यह दिन फिर खोलना है?';

  @override
  String get dayClosedSuccess => 'दिन बंद हो गया';

  @override
  String get dayReopenedSuccess => 'दिन फिर खुल गया';

  @override
  String get dayIsClosed => 'दिन बंद है';

  @override
  String get dayIsOpen => 'दिन खुला है';

  @override
  String get actualCountLabel => 'ड्रॉअर में असली रकम';

  @override
  String get actualCountHint => 'गिनी हुई रकम लिखें';

  @override
  String get drawerBalanced => 'ड्रॉअर बिल्कुल सही है 🎉';

  @override
  String get drawerShortage => 'ड्रॉअर में कमी';

  @override
  String get drawerSurplus => 'ड्रॉअर में ज़्यादा';

  @override
  String differenceAmount(String amount) {
    return 'अंतर: $amount';
  }

  @override
  String get closeDaySummary => 'दिन बंद करने का सारांश';

  @override
  String get confirmCloseDay => 'बंद करने की पुष्टि';

  @override
  String get historyTab => 'दिनों का रिकॉर्ड';

  @override
  String get todayTab => 'आज का ड्रॉअर';

  @override
  String get monthlyTotals => 'महीने का कुल';

  @override
  String get monthlySales => 'नकद बिक्री';

  @override
  String get monthlyExpenses => 'नकद ख़र्च';

  @override
  String get monthlyNet => 'ड्रॉअर का शुद्ध';

  @override
  String get drawerNotes => 'बंद करने के नोट्स (वैकल्पिक)';

  @override
  String get noExpensesYet => 'आज कोई ख़र्च दर्ज नहीं';

  @override
  String get noHistoryYet => 'पिछले दिन दर्ज नहीं';

  @override
  String get expenseAddedSuccess => 'ख़र्च दर्ज हो गया';

  @override
  String get cashSalesAddedSuccess => 'नकद बिक्री दर्ज हो गई';

  @override
  String get openingCashUpdatedSuccess => 'शुरुआती रकम बदल गई';

  @override
  String get dayDetails => 'दिन का विवरण';

  @override
  String closedAtTime(String time) {
    return 'बंद हुआ: $time';
  }

  @override
  String get readOnlyDayNotice =>
      'यह दिन बंद है। बदलाव के लिए दिन फिर खोलें दबाएँ।';

  @override
  String get privacyModeTitle => 'प्राइवेसी मोड';

  @override
  String get privacyModeSubtitle => 'स्क्रीन और विजेट में रकम छिपाएँ (••••••)';

  @override
  String get shareAppTitle => 'ऐप शेयर करें';

  @override
  String get shareAppSubtitle => 'काशकूल दूसरे दुकानदारों को भेजें';

  @override
  String shopCodeLabel(String code) {
    return 'दुकान कोड: $code';
  }

  @override
  String get growthFooterToggleTitle => 'मैसेज से काशकूल का सिग्नेचर छिपाएँ';

  @override
  String get growthFooterToggleSubtitle => 'पेड प्लान में उपलब्ध 🔒';

  @override
  String get codeCopied => 'कोड कॉपी हो गया';

  @override
  String get main1 => 'काशकूल';

  @override
  String get notebookImportButton1 => 'अपना खाता ऐप में डालें 📒';

  @override
  String get notebookImportButton2 =>
      'हर पुरानी एंट्री ज़रूरी नहीं: ग्राहक का नाम और अभी का बकाया काफ़ी है।';

  @override
  String get notebookImportButton3 => 'ग्राहक और उनका हिसाब';

  @override
  String get notebookImportButton4 =>
      'हर ग्राहक की एक लाइन: नाम, फ़ोन और बकाया';

  @override
  String get notebookImportButton5 => 'पुरानी किस्त';

  @override
  String get notebookImportButton6 =>
      'क़ीमत, चुकाई रकम, बाकी किस्तें और अगली तारीख़';

  @override
  String get notebookImportButton7 => 'खाते से डालें';

  @override
  String get oldInstallmentImportScreen1 => 'अगली किस्त की तारीख़';

  @override
  String get oldInstallmentImportScreen2 => 'किस्त सेव हो गई ✓';

  @override
  String oldInstallmentImportScreen3(
    Object remaining,
    Object countValue,
    Object nextDue,
  ) {
    return '$remaining बाकी, $countValue किस्तों में, पहली $nextDue को।';
  }

  @override
  String get oldInstallmentImportScreen4 => 'हो गया';

  @override
  String get oldInstallmentImportScreen5 => 'एक और किस्त';

  @override
  String get oldInstallmentImportScreen6 =>
      'सेव करने में दिक़्क़त, कुछ सेव नहीं हुआ';

  @override
  String get oldInstallmentImportScreen7 => ' हर महीने';

  @override
  String get oldInstallmentImportScreen8 => ' हर हफ़्ते';

  @override
  String oldInstallmentImportScreen9(
    Object remaining,
    Object count,
    Object count2,
    Object monthly,
  ) {
    return '$remaining बाकी — $count किस्तें × लगभग $count2$monthly';
  }

  @override
  String get oldInstallmentImportScreen10 => 'खाते से पुरानी किस्त';

  @override
  String oldInstallmentImportScreen11(Object savedCount) {
    return 'पुरानी किस्त ($savedCount)';
  }

  @override
  String get oldInstallmentImportScreen12 =>
      'ऐप से पहले शुरू हुई किस्तों के लिए: क़ीमत, अब तक चुकाई रकम और बाकी किस्तों की संख्या लिखें। ऐप सिर्फ़ बाकी शेड्यूल बनाएगा और पुराना भुगतान आज के ड्रॉअर में नहीं गिनेगा।';

  @override
  String get oldInstallmentImportScreen13 => 'ग्राहक';

  @override
  String get oldInstallmentImportScreen14 => 'ग्राहक का नाम';

  @override
  String get oldInstallmentImportScreen15 => 'मौजूदा या नए ग्राहक का नाम लिखें';

  @override
  String get oldInstallmentImportScreen16 => 'ग्राहक का नाम लिखें';

  @override
  String get oldInstallmentImportScreen17 =>
      'ग्राहक का मोबाइल (नया हो तो — वैकल्पिक)';

  @override
  String get oldInstallmentImportScreen18 => 'गलत मोबाइल नंबर';

  @override
  String get oldInstallmentImportScreen19 => 'किस्त';

  @override
  String get oldInstallmentImportScreen20 => 'सामान';

  @override
  String get oldInstallmentImportScreen21 => 'जैसे: सैमसंग फ्रिज';

  @override
  String get oldInstallmentImportScreen22 => 'सामान का नाम लिखें';

  @override
  String get oldInstallmentImportScreen23 => 'कुल क़ीमत';

  @override
  String get oldInstallmentImportScreen24 => 'EGP';

  @override
  String get oldInstallmentImportScreen25 => 'ज़रूरी';

  @override
  String get oldInstallmentImportScreen26 => 'गलत';

  @override
  String get oldInstallmentImportScreen27 => 'अब तक चुकाया';

  @override
  String get oldInstallmentImportScreen28 => 'क़ीमत से कम होना चाहिए';

  @override
  String get oldInstallmentImportScreen29 => 'बाकी किस्तें';

  @override
  String get oldInstallmentImportScreen30 => '1 से 120 तक';

  @override
  String oldInstallmentImportScreen31(Object nextDue) {
    return 'अगली: $nextDue';
  }

  @override
  String get oldInstallmentImportScreen32 => 'मासिक';

  @override
  String get oldInstallmentImportScreen33 => 'साप्ताहिक';

  @override
  String get oldInstallmentImportScreen34 => 'ज़मानतदार (वैकल्पिक)';

  @override
  String get oldInstallmentImportScreen35 => 'ज़मानतदार का नाम';

  @override
  String get oldInstallmentImportScreen36 => 'ज़मानतदार का मोबाइल';

  @override
  String get oldInstallmentImportScreen37 =>
      'खाते या अनुबंध की फ़ोटो (वैकल्पिक — फ़ोन पर ही रहेंगी)';

  @override
  String get oldInstallmentImportScreen38 =>
      'आप कई फ़ोटो जोड़ सकते हैं: खाते के पन्ने, अनुबंध, ज़मानतदार का आईडी…';

  @override
  String oldInstallmentImportScreen39(Object photosLength) {
    return '$photosLength फ़ोटो — ग्राहक की फ़ोटो में सेव होंगी';
  }

  @override
  String get oldInstallmentImportScreen40 => 'सेव हो रहा है…';

  @override
  String get oldInstallmentImportScreen41 => 'किस्त सेव करें';

  @override
  String get notebookImportScreen1 => 'यह हिसाब इस दिन तक';

  @override
  String notebookImportScreen2(Object firstError, Object error) {
    return 'लाइन $firstError: $error';
  }

  @override
  String get notebookImportScreen3 => 'कम से कम एक ग्राहक का नाम लिखें';

  @override
  String get notebookImportScreen4 => 'सेव हो गया ✓';

  @override
  String notebookImportScreen5(Object newCustomers) {
    return '$newCustomers नए ग्राहक';
  }

  @override
  String notebookImportScreen6(Object existingCustomers) {
    return '$existingCustomers मौजूदा ग्राहक — उनके हिसाब में जोड़ा';
  }

  @override
  String notebookImportScreen7(Object totalPiasters) {
    return 'कुल: $totalPiasters';
  }

  @override
  String get notebookImportScreen8 => 'अगला पन्ना';

  @override
  String get notebookImportScreen9 => 'बिना सेव किए निकलें?';

  @override
  String get notebookImportScreen10 => 'इस पन्ने पर लिखा सेव नहीं होगा।';

  @override
  String get notebookImportScreen11 => 'जारी रखें';

  @override
  String get notebookImportScreen12 => 'निकलें';

  @override
  String get notebookImportScreen13 => 'खाता डालें 📒';

  @override
  String notebookImportScreen14(Object savedPages) {
    return 'खाता डालें — पन्ना $savedPages';
  }

  @override
  String get notebookImportScreen15 => 'नई लाइन';

  @override
  String notebookImportScreen16(Object validLength) {
    return '$validLength ग्राहक';
  }

  @override
  String get notebookImportScreen17 => 'सेव करें';

  @override
  String get notebookImportScreen18 =>
      'हर ग्राहक एक लाइन में लिखें: नाम, मोबाइल अगर हो, और बकाया रकम। तेज़ी से आगे बढ़ने के लिए कीबोर्ड पर \"अगला\" दबाएँ।';

  @override
  String get notebookImportScreen19 => 'आज तक का हिसाब';

  @override
  String notebookImportScreen20(Object asOf) {
    return '$asOf तक';
  }

  @override
  String get notebookImportScreen21 =>
      'खाते के पन्ने की फ़ोटो (वैकल्पिक): पन्ने के हर ग्राहक के साथ सेव';

  @override
  String notebookImportScreen22(Object pagePhotosLength) {
    return 'पन्ने की $pagePhotosLength फ़ोटो — हर ग्राहक के साथ सेव होंगी';
  }

  @override
  String get notebookImportScreen23 => 'पन्ना';

  @override
  String get notebookImportScreen24 => 'इस ग्राहक की फ़ोटो';

  @override
  String get notebookImportScreen25 => 'लाइन हटाएँ';

  @override
  String get notebookImportScreen26 => 'मोबाइल (वैकल्पिक)';

  @override
  String get notebookImportScreen27 => 'रकम';

  @override
  String get notebookImportScreen28 => 'खोज रहा है…';

  @override
  String notebookImportScreen29(Object name) {
    return '\"$name\" पहले से है — रकम उसके हिसाब में जुड़ेगी';
  }

  @override
  String get notebookImportScreen30 => 'यह रकम ग्राहक पर है';

  @override
  String get notebookImportScreen31 => 'यह रकम आप पर ग्राहक की है';

  @override
  String get notebookImportScreen32 => 'उधार';

  @override
  String get notebookImportScreen33 => 'जमा';

  @override
  String get notebookImportService1 => 'खाते से पिछला बैलेंस';

  @override
  String get notebookImportService2 => 'खाते का पन्ना';

  @override
  String get notebookImportService3 => 'नाम नहीं है';

  @override
  String get notebookImportService4 => 'नाम बहुत लंबा है';

  @override
  String get notebookImportService5 => 'गलत रकम';

  @override
  String get notebookImportService6 => 'चुकाई रकम ऋणात्मक नहीं हो सकती';

  @override
  String get notebookImportService7 => 'चुकाई रकम कुल क़ीमत से कम हो';

  @override
  String get notebookImportService8 => 'कम से कम 1 किस्त बाकी हो';

  @override
  String notebookImportService9(Object paidPiasters) {
    return 'खाते से डाला गया — पहले चुकाया: $paidPiasters';
  }

  @override
  String notebookImportService10(Object trim, Object totalPricePiasters) {
    return 'पुरानी किस्त: $trim ($totalPricePiasters में से बाकी)';
  }

  @override
  String notebookImportService11(Object trim) {
    return 'किस्त: $trim';
  }

  @override
  String get installmentsScreen1 => 'किस्तें 📋';

  @override
  String get installmentsScreen2 =>
      'ग्राहक, सामान, मोबाइल या ज़मानतदार से खोजें...';

  @override
  String get installmentsScreen3 => 'कुल किस्तें';

  @override
  String get installmentsScreen4 => 'देर वाली किस्तें';

  @override
  String get installmentsScreen5 => 'चालू प्लान';

  @override
  String get installmentsScreen6 => 'सभी';

  @override
  String get installmentsScreen7 => 'चालू ⏳';

  @override
  String get installmentsScreen8 => 'पूरी ✓';

  @override
  String get installmentsScreen9 => 'रद्द';

  @override
  String installmentsScreen10(Object e) {
    return 'किस्तें लोड नहीं हुईं: $e';
  }

  @override
  String get installmentsScreen11 => 'कोई किस्त नहीं मिली';

  @override
  String get installmentsScreen12 => 'अभी कोई किस्त प्लान नहीं';

  @override
  String get installmentsScreen13 =>
      'पहला किस्त प्लान बनाने के लिए (+ नया किस्त प्लान) दबाएँ।';

  @override
  String get installmentsScreen14 => 'नया किस्त प्लान';

  @override
  String installmentPlanDetailsScreen1(Object instapay) {
    return 'InstaPay: $instapay';
  }

  @override
  String installmentPlanDetailsScreen2(Object wallet) {
    return 'वॉलेट / वोडाफ़ोन कैश: $wallet';
  }

  @override
  String installmentPlanDetailsScreen3(Object phoneNum) {
    return 'फ़ोन: $phoneNum';
  }

  @override
  String get installmentPlanDetailsScreen4 => 'किस्त प्लान रद्द करें';

  @override
  String get installmentPlanDetailsScreen5 =>
      'क्या यह प्लान रद्द करना है? रिमाइंडर बंद होंगे और भुगतान का रिकॉर्ड रहेगा।';

  @override
  String get installmentPlanDetailsScreen6 => 'वापस';

  @override
  String get installmentPlanDetailsScreen7 => 'प्लान रद्द करें';

  @override
  String get installmentPlanDetailsScreen8 => 'किस्त प्लान रद्द हो गया';

  @override
  String get installmentPlanDetailsScreen9 => 'किस्त प्लान हटाएँ';

  @override
  String get installmentPlanDetailsScreen10 => 'क्या यह किस्त प्लान हटाना है?';

  @override
  String get installmentPlanDetailsScreen11 => 'रद्द करें';

  @override
  String get installmentPlanDetailsScreen12 => 'हटाएँ';

  @override
  String get installmentPlanDetailsScreen13 => 'किस्त प्लान हटा दिया गया';

  @override
  String get installmentPlanDetailsScreen14 => 'किस्त का विवरण';

  @override
  String installmentPlanDetailsScreen15(Object e) {
    return 'त्रुटि: $e';
  }

  @override
  String get installmentPlanDetailsScreen16 =>
      'किस्त प्लान नहीं मिला या हटा दिया गया';

  @override
  String get installmentPlanDetailsScreen17 => 'प्लान हटाएँ';

  @override
  String get installmentPlanDetailsScreen18 => 'कुल क़ीमत:';

  @override
  String get installmentPlanDetailsScreen19 => 'डाउन पेमेंट:';

  @override
  String get installmentPlanDetailsScreen20 => 'कुल चुकाया:';

  @override
  String get installmentPlanDetailsScreen21 => 'बाकी:';

  @override
  String get installmentPlanDetailsScreen22 => 'पूरी रकम पहले चुकाएँ';

  @override
  String installmentPlanDetailsScreen23(Object guarantorName) {
    return 'ज़मानतदार: $guarantorName';
  }

  @override
  String get installmentPlanDetailsScreen24 => 'अनुबंध / रसीद की फ़ोटो';

  @override
  String get installmentPlanDetailsScreen25 =>
      'दस्तावेज़ पूरा देखने के लिए दबाएँ';

  @override
  String get installmentPlanDetailsScreen26 => 'किस्त का दस्तावेज़';

  @override
  String installmentPlanDetailsScreen27(Object installmentsLength) {
    return 'किस्तों का शेड्यूल ($installmentsLength)';
  }

  @override
  String get installmentPlanDetailsScreen28 => 'कोई भी रकम चुकाएँ';

  @override
  String installmentPlanDetailsScreen29(
    Object installmentIndex,
    Object dueDate,
  ) {
    return 'किस्त नंबर $installmentIndex • $dueDate';
  }

  @override
  String installmentPlanDetailsScreen30(Object paidPiasters) {
    return 'पूरा चुका दिया ✓ ($paidPiasters)';
  }

  @override
  String installmentPlanDetailsScreen31(
    Object paidPiasters,
    Object amountPiasters,
  ) {
    return '$amountPiasters में से $paidPiasters चुकाया';
  }

  @override
  String get installmentPlanDetailsScreen32 => 'देर हो गई ⚠️';

  @override
  String get installmentPlanDetailsScreen33 => 'आज देय 🔔';

  @override
  String installmentPlanDetailsScreen34(Object amountPiasters) {
    return 'आने वाली • $amountPiasters';
  }

  @override
  String get installmentPlanDetailsScreen35 => 'व्हाट्सऐप रिमाइंडर';

  @override
  String get installmentPlanDetailsScreen36 => 'चुकाएँ';

  @override
  String get addInstallmentPlanScreen1 => 'मोबाइल फ़ोन';

  @override
  String get addInstallmentPlanScreen2 => 'टीवी';

  @override
  String get addInstallmentPlanScreen3 => 'वॉशिंग मशीन';

  @override
  String get addInstallmentPlanScreen4 => 'फ्रिज';

  @override
  String get addInstallmentPlanScreen5 => 'गैस चूल्हा';

  @override
  String get addInstallmentPlanScreen6 => 'लैपटॉप';

  @override
  String get addInstallmentPlanScreen7 => 'मोटरसाइकिल';

  @override
  String get addInstallmentPlanScreen8 => 'फ़र्नीचर';

  @override
  String get addInstallmentPlanScreen9 => 'पहले ग्राहक चुनें';

  @override
  String get addInstallmentPlanScreen10 => 'डाउन पेमेंट कुल क़ीमत से कम हो';

  @override
  String get addInstallmentPlanScreen11 =>
      'किस्त प्लान बन गया और शेड्यूल हो गया ✓';

  @override
  String addInstallmentPlanScreen12(Object e) {
    return 'कुछ गड़बड़ हुई: $e';
  }

  @override
  String addInstallmentPlanScreen13(Object e) {
    return 'ग्राहक लोड नहीं हुए: $e';
  }

  @override
  String get addInstallmentPlanScreen14 => 'ग्राहक चुनें';

  @override
  String get addInstallmentPlanScreen15 => 'कृपया ग्राहक चुनें';

  @override
  String get addInstallmentPlanScreen16 => 'सामान और रकम';

  @override
  String get addInstallmentPlanScreen17 => 'सामान का नाम *';

  @override
  String get addInstallmentPlanScreen18 => 'जैसे: सैमसंग A15 128GB';

  @override
  String get addInstallmentPlanScreen19 =>
      'सामान का नाम कम से कम 2 अक्षर का हो';

  @override
  String get addInstallmentPlanScreen20 => 'कुल क़ीमत (EGP) *';

  @override
  String get addInstallmentPlanScreen21 => 'जैसे: 12000';

  @override
  String get addInstallmentPlanScreen22 => 'गलत रकम';

  @override
  String get addInstallmentPlanScreen23 => 'डाउन पेमेंट (EGP)';

  @override
  String get addInstallmentPlanScreen24 => 'किस्तों में चुकाने की रकम:';

  @override
  String get addInstallmentPlanScreen25 => 'अवधि और अंतराल';

  @override
  String addInstallmentPlanScreen26(Object count) {
    return '$count किस्तें';
  }

  @override
  String get addInstallmentPlanScreen27 => 'किस्तों की संख्या *';

  @override
  String get addInstallmentPlanScreen28 => 'पूर्ण संख्या डालें';

  @override
  String get addInstallmentPlanScreen29 => 'अंतराल';

  @override
  String get addInstallmentPlanScreen30 => 'पहली किस्त की तारीख़';

  @override
  String get addInstallmentPlanScreen31 => 'तारीख़ बदलें';

  @override
  String get addInstallmentPlanScreen32 => 'ज़मानतदार और दस्तावेज़ (वैकल्पिक)';

  @override
  String get addInstallmentPlanScreen33 => 'जैसे: मोहम्मद इब्राहिम';

  @override
  String get addInstallmentPlanScreen34 => 'ज़मानतदार का मोबाइल नंबर';

  @override
  String get addInstallmentPlanScreen35 =>
      'गलत मोबाइल नंबर (010, 011, 012, 015)';

  @override
  String get addInstallmentPlanScreen36 => 'दस्तावेज़ की फ़ोटो ले ली ✓';

  @override
  String get addInstallmentPlanScreen37 => 'अनुबंध / रसीद / आईडी की फ़ोटो लें';

  @override
  String get addInstallmentPlanScreen38 => 'फ़ोटो बदलने के लिए दबाएँ';

  @override
  String get addInstallmentPlanScreen39 => 'अनुबंध की फ़ोटो बाद के लिए रखें';

  @override
  String get addInstallmentPlanScreen40 => 'फ़ोटो लें';

  @override
  String get addInstallmentPlanScreen41 => 'अतिरिक्त नोट्स';

  @override
  String get addInstallmentPlanScreen42 => 'ग्राहक के खाते से जोड़ें';

  @override
  String get addInstallmentPlanScreen43 =>
      'कुल क़ीमत उधार और डाउन पेमेंट भुगतान के रूप में ग्राहक के खाते में दर्ज करें';

  @override
  String addInstallmentPlanScreen44(Object scheduleLength) {
    return 'शेड्यूल की झलक ($scheduleLength किस्तें)';
  }

  @override
  String addInstallmentPlanScreen45(Object amountPiasters) {
    return 'किस्त की रकम: ~$amountPiasters';
  }

  @override
  String get addInstallmentPlanScreen46 => 'प्लान और शेड्यूल सेव करें';

  @override
  String installmentProgressBar1(
    Object paidCount,
    Object totalCount,
    Object percentInt,
  ) {
    return '$totalCount में से $paidCount किस्तें चुकाईं ($percentInt%)';
  }

  @override
  String installmentProgressBar2(Object remainingPiasters) {
    return 'बाकी: $remainingPiasters';
  }

  @override
  String get installmentProgressBar3 => 'पूरा चुकता ✓';

  @override
  String get payInstallmentDialog1 => 'शून्य से ज़्यादा सही रकम लिखें';

  @override
  String payInstallmentDialog2(Object amountPiasters) {
    return '$amountPiasters का भुगतान दर्ज हुआ ✓';
  }

  @override
  String payInstallmentDialog3(Object e) {
    return 'भुगतान में गड़बड़ी: $e';
  }

  @override
  String payInstallmentDialog4(Object installmentIndex) {
    return 'किस्त नंबर $installmentIndex चुकाएँ';
  }

  @override
  String payInstallmentDialog5(Object itemDescription) {
    return 'किस्त भुगतान ($itemDescription)';
  }

  @override
  String get payInstallmentDialog6 => 'देय रकम:';

  @override
  String get payInstallmentDialog7 => 'चुकाई रकम (EGP)';

  @override
  String get payInstallmentDialog8 => 'भुगतान का तरीका';

  @override
  String get payInstallmentDialog9 => 'नकद 💵';

  @override
  String get payInstallmentDialog10 => 'InstaPay ⚡';

  @override
  String get payInstallmentDialog11 => 'वॉलेट 📱';

  @override
  String get payInstallmentDialog12 => 'भुगतान की तारीख़';

  @override
  String get payInstallmentDialog13 => 'बदलें';

  @override
  String get payInstallmentDialog14 => 'नोट (वैकल्पिक)';

  @override
  String get payInstallmentDialog15 => 'जैसे: किसी के हाथ भेजा';

  @override
  String get payInstallmentDialog16 => 'ग्राहक के खाते में दर्ज करें';

  @override
  String get payInstallmentDialog17 => 'ग्राहक के मुख्य बैलेंस से कट जाएगा';

  @override
  String get payInstallmentDialog18 => 'भुगतान की पुष्टि';

  @override
  String earlySettlementDialog1(Object itemDescription) {
    return '($itemDescription) की किस्त पूरी चुकता ✓';
  }

  @override
  String earlySettlementDialog2(Object e) {
    return 'चुकता करने में गड़बड़ी: $e';
  }

  @override
  String get earlySettlementDialog3 => 'समय से पहले पूरा भुगतान';

  @override
  String get earlySettlementDialog4 => 'बाकी किस्तों का कुल:';

  @override
  String get earlySettlementDialog5 => 'वसूलने की रकम:';

  @override
  String get earlySettlementDialog6 => 'जल्दी भुगतान छूट (EGP)';

  @override
  String get earlySettlementDialog7 => 'अभी पूरा चुकाएँ';

  @override
  String installmentPlanCard1(Object overdueCount) {
    return 'देर ($overdueCount)';
  }

  @override
  String get installmentPlanCard2 => 'पूरा ✓';

  @override
  String get installmentPlanCard3 => 'रद्द';

  @override
  String installmentPlanCard4(Object dueDate, Object paidPiasters) {
    return 'अगली किस्त: $dueDate ($paidPiasters)';
  }

  @override
  String installmentPlanCard5(Object totalPricePiasters) {
    return 'कुल: $totalPricePiasters';
  }

  @override
  String get installmentRepository1 => 'सामान का विवरण कम से कम 2 अक्षर का हो';

  @override
  String get installmentRepository2 => 'कुल क़ीमत शून्य से ज़्यादा हो';

  @override
  String get installmentRepository3 => 'डाउन पेमेंट ऋणात्मक नहीं हो सकता';

  @override
  String get installmentRepository4 => 'डाउन पेमेंट कुल क़ीमत से कम हो';

  @override
  String get installmentRepository5 => 'किस्तों की संख्या शून्य से ज़्यादा हो';

  @override
  String installmentRepository6(Object trim, Object installmentCount) {
    return 'किस्त: $trim ($installmentCount किस्तें)';
  }

  @override
  String installmentRepository7(Object trim) {
    return 'डाउन पेमेंट: $trim';
  }

  @override
  String get installmentRepository8 => 'भुगतान की रकम शून्य से ज़्यादा हो';

  @override
  String installmentRepository9(Object itemDescription, Object notes) {
    return 'किस्त भुगतान: $itemDescription$notes';
  }

  @override
  String get installmentRepository10 => 'किस्त प्लान नहीं मिला';

  @override
  String installmentRepository11(Object itemDescription) {
    return 'समय से पहले भुगतान: $itemDescription';
  }

  @override
  String installmentRepository12(Object itemDescription) {
    return 'जल्दी भुगतान छूट: $itemDescription';
  }

  @override
  String get collectionScreen1 => 'देय किस्तें';

  @override
  String get dueInstallmentsTab1 => 'ग्राहक का फ़ोन नंबर दर्ज नहीं';

  @override
  String get dueInstallmentsTab2 => 'आज कोई किस्त देय या लेट नहीं 🎉';

  @override
  String get dueInstallmentsTab3 =>
      'सभी किस्त वाले ग्राहक समय पर चुका रहे हैं।';

  @override
  String dueInstallmentsTab4(Object dueListLength) {
    return '$dueListLength किस्तें वसूलनी हैं:';
  }

  @override
  String dueInstallmentsTab5(
    Object itemDescription,
    Object installmentIndex,
    Object installmentCount,
  ) {
    return '$itemDescription • किस्त ($installmentCount में से $installmentIndex)';
  }

  @override
  String dueInstallmentsTab6(Object daysOverdue) {
    return '$daysOverdue दिन लेट';
  }

  @override
  String get dueInstallmentsTab7 => 'आज देय 🔔';

  @override
  String get dueInstallmentsTab8 => 'कॉल';

  @override
  String get dueInstallmentsTab9 => 'व्हाट्सऐप';

  @override
  String cashDrawerScreen1(Object err) {
    return 'ड्रॉअर का डेटा लोड नहीं हुआ: $err';
  }

  @override
  String drawerLiveCard1(Object notes) {
    return 'नोट: $notes';
  }

  @override
  String expensesListCard1(Object expensesLength) {
    return '$expensesLength ख़र्च';
  }

  @override
  String get expensesListCard2 => 'InstaPay';

  @override
  String get expensesListCard3 => 'वॉलेट';

  @override
  String get drawerFlowCard1 => '(InstaPay / वॉलेट)';

  @override
  String addCashSalesBottomSheet1(Object currentSalesPiasters) {
    return 'अब तक दर्ज बिक्री: $currentSalesPiasters';
  }

  @override
  String get addCashSalesBottomSheet2 => 'बिक्री में जोड़ें (+)';

  @override
  String get addCashSalesBottomSheet3 => 'कुल बदलें (=)';

  @override
  String get addCashSalesBottomSheet4 => 'जोड़ने की रकम';

  @override
  String get addCashSalesBottomSheet5 => 'बिक्री का नया कुल';

  @override
  String addCashSalesBottomSheet6(Object val) {
    return '+$val EGP';
  }

  @override
  String drawerHistoryTab1(
    Object cashSalesPiasters,
    Object openingCashPiasters,
  ) {
    return 'नकद बिक्री: $cashSalesPiasters · शुरुआती: $openingCashPiasters';
  }

  @override
  String drawerHistoryTab2(Object date) {
    return '$date का विवरण';
  }

  @override
  String get drawerHistoryTab3 => 'अंतर';

  @override
  String get customersScreen1 => 'किस्तें';

  @override
  String get customersScreen2 => 'प्राइवेसी मोड';

  @override
  String get customersScreen3 => 'क्रम';

  @override
  String get customerPhotosScreen1 => 'फ़ोटो जुड़ गई';

  @override
  String customerPhotosScreen2(Object pathsLength) {
    return '$pathsLength फ़ोटो जुड़ गईं';
  }

  @override
  String get customerPhotosScreen3 => 'फ़ोटो हटा दी गई';

  @override
  String get customerPhotosScreen4 => 'वापस लाएँ';

  @override
  String customerPhotosScreen5(Object customerName) {
    return '$customerName की फ़ोटो';
  }

  @override
  String get customerPhotosScreen6 => 'फ़ोटो जोड़ें';

  @override
  String get customerPhotosScreen7 => 'फ़ोटो लोड नहीं हुईं';

  @override
  String get customerPhotosScreen8 =>
      'इस ग्राहक की अभी कोई फ़ोटो नहीं।\nखाते के पन्नों या किसी काग़ज़ की फ़ोटो लें — फ़ोटो सिर्फ़ इसी फ़ोन पर रहेंगी।';

  @override
  String get customerPhotosScreen9 => 'फ़ोटो हटाएँ';

  @override
  String customerDetailsScreen1(
    Object activePlansLength,
    Object remainingPiasters,
  ) {
    return 'चालू किस्तें ($activePlansLength) • बाकी: $remainingPiasters';
  }

  @override
  String get customerDetailsScreen2 => 'इस ग्राहक को किस्तों पर बेचें';

  @override
  String get customerDetailsScreen3 => 'देखें';

  @override
  String get customerDetailsScreen4 => 'नई किस्त जोड़ें';

  @override
  String get customerDetailsScreen5 => 'ग्राहक की फ़ोटो';

  @override
  String get photoStrip1 => 'कैमरे से फ़ोटो लें';

  @override
  String get photoStrip2 => 'गैलरी से चुनें';

  @override
  String get photoStrip3 => 'एक साथ कई फ़ोटो चुन सकते हैं';

  @override
  String get photoStrip4 => 'फ़ोटो';

  @override
  String get photoStrip5 => 'और';

  @override
  String get photoStrip6 => 'फ़ोटो जोड़ें';

  @override
  String get photoStrip7 => 'फ़ोटो';

  @override
  String photoStrip8(Object title, Object index, Object count) {
    return '$title ($count में से $index)';
  }

  @override
  String get photoStrip9 => 'फ़ोटो';

  @override
  String get photoStrip10 => 'फ़ोटो इस फ़ोन पर नहीं मिली';

  @override
  String creditLimitProgressBar1(Object limitPiasters) {
    return 'उधार सीमा: $limitPiasters';
  }

  @override
  String ratingExplanationBottomSheet1(Object customerName) {
    return 'ग्राहक रेटिंग: $customerName';
  }

  @override
  String get ratingExplanationBottomSheet2 => 'मौजूदा रेटिंग की वजह:';

  @override
  String get ratingExplanationBottomSheet3 => 'रेटिंग कैसे काम करती है?';

  @override
  String get ratingExplanationBottomSheet4 => 'बेहतरीन';

  @override
  String get ratingExplanationBottomSheet5 =>
      'हिसाब साफ़ है या सबसे पुराना उधार 14 दिन से ज़्यादा नहीं।';

  @override
  String get ratingExplanationBottomSheet6 => 'निगरानी';

  @override
  String get ratingExplanationBottomSheet7 =>
      'सबसे पुराना उधार 15 से 45 दिन (याद दिलाना बेहतर है)।';

  @override
  String get ratingExplanationBottomSheet8 => 'लेट';

  @override
  String get ratingExplanationBottomSheet9 =>
      'सबसे पुराना उधार 45 दिन से ज़्यादा है या उधार सीमा पार हो गई।';

  @override
  String get ratingExplanationBottomSheet10 => 'नया';

  @override
  String get ratingExplanationBottomSheet11 => '3 से कम लेन-देन वाला ग्राहक।';

  @override
  String get ratingExplanationBottomSheet12 => 'समझ गया';

  @override
  String get customerWithBalance1 => 'नया ग्राहक';

  @override
  String get settingsScreen1 => 'दुकान की जानकारी 🏪';

  @override
  String get settingsScreen2 => 'सुरक्षा और प्राइवेसी 🔒';

  @override
  String get settingsScreen3 => 'होम स्क्रीन विजेट 📱';

  @override
  String get settingsScreen4 => 'रिमाइंडर मैसेज 💬';

  @override
  String get settingsScreen5 => 'बैकअप और डेटा 💾';

  @override
  String get settingsScreen6 => 'ऐप शेयर करें 🚀';

  @override
  String get settingsScreen7 => 'सामान्य ⚙️';

  @override
  String get settingsScreen8 => 'काशकूल 📒';

  @override
  String get settingsScreen9 =>
      'बिना इंटरनेट दुकान का खाता (Offline-First)\nवर्ज़न 1.0.0';

  @override
  String get settingsScreen10 => 'जनरल स्टोर';

  @override
  String get settingsScreen11 => 'किराना और सुपरमार्केट 🛒';

  @override
  String get settingsScreen12 => 'मोबाइल और एक्सेसरीज़ 📱';

  @override
  String get settingsScreen13 => 'इलेक्ट्रॉनिक्स और घरेलू सामान ⚡';

  @override
  String get settingsScreen14 => 'फ़ार्मेसी और कॉस्मेटिक्स 💊';

  @override
  String get settingsScreen15 => 'अन्य कारोबार 🏪';

  @override
  String settingsScreen16(Object tradeName) {
    return '$tradeName • कारोबार और भुगतान की जानकारी बदलें';
  }

  @override
  String get settingsScreen17 => 'स्क्रीन और विजेट में रकम छिपाएँ (••••••)';

  @override
  String get settingsScreen18 => 'PIN से ऐप लॉक करें (4 अंक)';

  @override
  String get settingsScreen19 => 'चालू और सुरक्षित (बंद करने के लिए दबाएँ)';

  @override
  String get settingsScreen20 => 'बंद (सेट करने के लिए दबाएँ)';

  @override
  String get settingsScreen21 => 'चालू 🔒';

  @override
  String get settingsScreen22 => 'सेट करें';

  @override
  String get settingsScreen23 => 'ऐप लॉक बंद हो गया';

  @override
  String get settingsScreen24 => 'PIN सेट हो गया 🔒';

  @override
  String get settingsScreen25 => 'फ़िंगरप्रिंट / Face ID से खोलें';

  @override
  String get settingsScreen26 => 'हर बार PIN की जगह फ़िंगरप्रिंट इस्तेमाल करें';

  @override
  String get settingsScreen27 => 'आपका डिवाइस फ़िंगरप्रिंट सपोर्ट नहीं करता';

  @override
  String get settingsScreen28 => '1 मिनट';

  @override
  String get settingsScreen29 => '5 मिनट';

  @override
  String get settingsScreen30 => '15 मिनट';

  @override
  String get settingsScreen31 => 'तुरंत';

  @override
  String get settingsScreen32 => 'ऑटो-लॉक का समय';

  @override
  String get settingsScreen33 => 'ऐप से निकलते ही';

  @override
  String settingsScreen34(Object timeout) {
    return 'निकलने के $timeout मिनट बाद';
  }

  @override
  String get settingsScreen35 => 'निकलते ही तुरंत';

  @override
  String get settingsScreen36 => '1 मिनट बाद';

  @override
  String get settingsScreen37 => '5 मिनट बाद';

  @override
  String get settingsScreen38 => '15 मिनट बाद';

  @override
  String get settingsScreen39 => 'रिमाइंडर मैसेज';

  @override
  String get settingsScreen40 => 'ग्राहकों का ऑटो मैसेज बदलें और तुरंत देखें';

  @override
  String get settingsScreen41 => 'बैकग्राउंड में रिमाइंडर बंद होने से बचाएँ';

  @override
  String get settingsScreen42 => 'शाओमी, रियलमी और इनफ़िनिक्स फ़ोन के लिए गाइड';

  @override
  String get settingsScreen43 => 'अभी तक कोई बैकअप नहीं बना';

  @override
  String get settingsScreen44 => 'आख़िरी बैकअप';

  @override
  String get settingsScreen45 => 'बैकअप एक्सपोर्ट करें (.kashkool)';

  @override
  String get settingsScreen46 =>
      'खाते और फ़ोटो की कॉपी सेव करके व्हाट्सऐप या ड्राइव पर भेजें';

  @override
  String get settingsScreen47 => 'बैकअप एक्सपोर्ट हो गया 👍';

  @override
  String settingsScreen48(Object e) {
    return 'एक्सपोर्ट नहीं हुआ: $e';
  }

  @override
  String get settingsScreen49 => 'बैकअप वापस लाएँ';

  @override
  String get settingsScreen50 =>
      'पहले सेव की गई .kashkool फ़ाइल से हिसाब और फ़ोटो वापस लाएँ';

  @override
  String get settingsScreen51 => 'गलत फ़ाइल ❌';

  @override
  String get settingsScreen52 => 'यह फ़ाइल काशकूल का सही बैकअप नहीं है।';

  @override
  String get settingsScreen53 => 'ठीक है';

  @override
  String get settingsScreen54 => 'वापस लाने की पुष्टि';

  @override
  String get settingsScreen55 =>
      'ध्यान दें: वापस लाने से ऐप का मौजूदा सारा डेटा फ़ाइल के डेटा से बदल जाएगा।';

  @override
  String settingsScreen56(Object exportedAt) {
    return 'बैकअप की तारीख़: $exportedAt';
  }

  @override
  String settingsScreen57(Object photosCount) {
    return 'शामिल फ़ोटो: $photosCount';
  }

  @override
  String settingsScreen58(Object fileSizeBytes) {
    return 'फ़ाइल का साइज़: $fileSizeBytes KB';
  }

  @override
  String get settingsScreen59 => 'हाँ, बदलें और वापस लाएँ';

  @override
  String get settingsScreen60 => 'वापस आ गया 🎉';

  @override
  String get settingsScreen61 =>
      'सारे हिसाब, लेन-देन और फ़ोटो वापस आ गए। सब स्क्रीन ताज़ा करने के लिए ऐप फिर से चालू करें।';

  @override
  String get settingsScreen62 => 'अभी फिर से चालू करें';

  @override
  String settingsScreen63(Object e) {
    return 'वापस लाने में गड़बड़ी: $e';
  }

  @override
  String get settingsScreen64 => 'डार्क 🌙';

  @override
  String get settingsScreen65 => 'लाइट ☀️';

  @override
  String get settingsScreen66 => 'ऑटो';

  @override
  String get settingsScreen67 => 'ऐप का रूप';

  @override
  String get settingsScreen68 => 'ऑटो (फ़ोन के हिसाब से)';

  @override
  String get settingsScreen69 => 'तय नहीं';

  @override
  String get settingsScreen70 => 'नए ग्राहक की डिफ़ॉल्ट उधार सीमा';

  @override
  String get settingsScreen71 => 'व्हाट्सऐप पर संपर्क करें';

  @override
  String get settingsScreen72 => 'सुझाव और सीधी मदद';

  @override
  String get settingsScreen73 =>
      'https://wa.me/201000000000?text=Hello%2C%20I%20have%20a%20question%20about%20Kashkool';

  @override
  String get settingsScreen74 => 'प्राइवेसी पॉलिसी और शर्तें';

  @override
  String get settingsScreen75 =>
      'आपका डेटा आपका है और सिर्फ़ आपके फ़ोन पर रहता है';

  @override
  String get settingsScreen76 => 'काशकूल प्राइवेसी पॉलिसी 🔒';

  @override
  String get settingsScreen77 =>
      '1. काशकूल पूरी तरह बिना इंटरनेट चलता है (Offline-First)।\n\n2. सारे हिसाब, नाम, फ़ोन नंबर, बिल की फ़ोटो और लेन-देन सिर्फ़ आपके फ़ोन पर रहते हैं। कोई डेटा किसी बाहरी सर्वर पर नहीं जाता।\n\n3. फ़ोन बदलने या खोने पर डेटा बचाने के लिए नियमित बैकअप (बैकअप एक्सपोर्ट करें) बनाना आपकी ज़िम्मेदारी है।\n\n4. काशकूल दुकानदारों और व्यापारियों के लिए बना है ताकि वे अपना बकाया सुरक्षित रखें और उधार आसानी से संभालें।';

  @override
  String get settingsScreen78 => 'सिस्टम (ऑटो)';

  @override
  String get settingsScreen79 => 'डिफ़ॉल्ट उधार सीमा (EGP)';

  @override
  String get settingsScreen80 => 'रकम (EGP)';

  @override
  String get settingsScreen81 => 'कोई सीमा न हो तो ख़ाली छोड़ें';

  @override
  String get settingsScreen82 => 'सेव करें';

  @override
  String batteryGuideBottomSheet1(Object brandName) {
    return 'नोटिफ़िकेशन गाइड ($brandName)';
  }

  @override
  String get batteryGuideBottomSheet2 => 'रिमाइंडर चालू रखने की गाइड';

  @override
  String get batteryGuideBottomSheet3 =>
      'कुछ फ़ोन (जैसे शाओमी, रियलमी, इनफ़िनिक्स और हुआवेई) बैटरी बचाने के लिए बैकग्राउंड में ऐप बंद कर देते हैं। रिमाइंडर समय पर आएँ, इसके लिए ये कदम उठाएँ:';

  @override
  String get batteryGuideBottomSheet4 => 'अभी बैटरी सेटिंग्स खोलें';

  @override
  String get backupReminderBanner1 => 'बैकअप एक्सपोर्ट हो गया 👍';

  @override
  String backupReminderBanner2(Object e) {
    return 'बैकअप में गड़बड़ी: $e';
  }

  @override
  String get backupReminderBanner3 => 'बैकअप बनाने का समय ⚠️';

  @override
  String get backupReminderBanner4 =>
      'आख़िरी बैकअप को 7 दिन से ज़्यादा हो गए। डेटा सेव करें ताकि फ़ोन खोने या बदलने पर कुछ न खोए।';

  @override
  String get backupReminderBanner5 => 'अभी नहीं';

  @override
  String get backupReminderBanner6 => 'सेव हो रहा है...';

  @override
  String get backupReminderBanner7 => 'अभी बैकअप लें';

  @override
  String get homeWidgetSettingsCard1 => 'होम स्क्रीन पर हिसाब दिखाएँ';

  @override
  String get homeWidgetSettingsCard2 =>
      'विजेट ऐप खोले बिना ग्राहकों पर बकाया और आज की वसूली दिखाता है';

  @override
  String get homeWidgetSettingsCard3 => 'विजेट बंद है और कोई रकम नहीं दिखाता';

  @override
  String get homeWidgetSettingsCard4 => 'छोटा विजेट जोड़ें';

  @override
  String get homeWidgetSettingsCard5 => 'सिर्फ़ ग्राहकों पर बकाया';

  @override
  String get homeWidgetSettingsCard6 => 'आज के सारांश का विजेट जोड़ें';

  @override
  String get homeWidgetSettingsCard7 =>
      'बकाया + आज की वसूली + देय ग्राहक + वसूली बटन';

  @override
  String get homeWidgetSettingsCard8 =>
      'विजेट जोड़ने के लिए आने वाला मैसेज मंज़ूर करें 👍';

  @override
  String get homeWidgetSettingsCard9 => 'विजेट ख़ुद जोड़ें 📱';

  @override
  String get homeWidgetSettingsCard10 =>
      'आपका फ़ोन ऐप को अपने-आप विजेट जोड़ने नहीं देता। ऐसा करें:\n\n1. होम स्क्रीन पर ख़ाली जगह देर तक दबाएँ\n2. \"Widgets\" चुनें\n3. \"Kashkool\" ढूँढकर विजेट स्क्रीन पर खींचें';

  @override
  String get messageTemplateEditorBottomSheet1 => 'अमानत किराना';

  @override
  String get messageTemplateEditorBottomSheet2 => 'वोडाफ़ोन कैश: 01012345678';

  @override
  String get messageTemplateEditorBottomSheet3 => 'मोहम्मद अहमद';

  @override
  String get messageTemplateEditorBottomSheet4 =>
      'मैसेज टेम्पलेट सेव हो गया 👍';

  @override
  String get messageTemplateEditorBottomSheet5 => 'रिमाइंडर मैसेज बदलें 💬';

  @override
  String get messageTemplateEditorBottomSheet6 => 'तैयार टेम्पलेट: ';

  @override
  String get messageTemplateEditorBottomSheet7 => 'दोस्ताना 😊';

  @override
  String get messageTemplateEditorBottomSheet8 => 'औपचारिक 👔';

  @override
  String get messageTemplateEditorBottomSheet9 => 'दुकान का नाम';

  @override
  String get messageTemplateEditorBottomSheet10 => 'भुगतान की जानकारी';

  @override
  String get messageTemplateEditorBottomSheet11 => 'आख़िरी लेन-देन की तारीख़';

  @override
  String get messageTemplateEditorBottomSheet12 =>
      'रिमाइंडर मैसेज यहाँ लिखें...';

  @override
  String get messageTemplateEditorBottomSheet13 =>
      'ग्राहक को ऐसा मैसेज मिलेगा:';

  @override
  String get messageTemplateEditorBottomSheet14 => 'टेम्पलेट सेव करें';

  @override
  String shopProfileBottomSheet1(Object trim) {
    return 'मोबाइल वॉलेट: $trim';
  }

  @override
  String get shopProfileBottomSheet2 => 'दुकान की जानकारी सेव हो गई 👍';

  @override
  String get shopProfileBottomSheet3 => 'दुकान का नाम *';

  @override
  String get shopProfileBottomSheet4 => 'जैसे: अमानत किराना';

  @override
  String get shopProfileBottomSheet5 => 'कृपया दुकान का नाम लिखें';

  @override
  String get shopProfileBottomSheet6 => 'दुकान का फ़ोन नंबर';

  @override
  String get shopProfileBottomSheet7 => 'जैसे: 010xxxxxxxx';

  @override
  String get shopProfileBottomSheet8 => 'दुकान का पता';

  @override
  String get shopProfileBottomSheet9 => 'जैसे: बाज़ार रोड, बड़ी मस्जिद के पास';

  @override
  String get shopProfileBottomSheet10 => 'InstaPay अकाउंट';

  @override
  String get shopProfileBottomSheet11 => 'जैसे: name@instapay';

  @override
  String get shopProfileBottomSheet12 => 'वोडाफ़ोन कैश / मोबाइल वॉलेट नंबर';

  @override
  String get shopProfileBottomSheet13 => 'कारोबार का प्रकार';

  @override
  String get shopProfileBottomSheet14 => 'अन्य कारोबार 🏪';

  @override
  String get shopProfileBottomSheet15 => 'किस्तों की सुविधा चालू करें';

  @override
  String get shopProfileBottomSheet16 => 'किस्तों का बटन और शेड्यूल दिखाएँ';

  @override
  String get shopProfileBottomSheet17 => 'बदलाव सेव करें';

  @override
  String get cloudAccountButton1 => 'आपका अकाउंट और क्लाउड बैकअप ☁️';

  @override
  String get cloudAccountButton2 => 'क्लाउड बैकअप';

  @override
  String get cloudAccountButton3 => 'गूगल से साइन इन करें';

  @override
  String get cloudBackupCard1 => 'एक पल…';

  @override
  String get cloudBackupCard2 => 'कुछ गड़बड़ हुई, फिर कोशिश करें';

  @override
  String get cloudBackupCard3 => 'गूगल अकाउंट खुल रहे हैं…';

  @override
  String cloudBackupCard4(Object email) {
    return '$email से साइन इन ✓';
  }

  @override
  String get cloudBackupCard5 => 'बैकअप कुछ दिक़्क़तों के साथ अपलोड हुआ ⚠️';

  @override
  String cloudBackupCard6(Object uploaded, Object rejected, Object n) {
    return '$uploaded रिकॉर्ड अपलोड, $rejected रद्द हुए:\n\n$n';
  }

  @override
  String get cloudBackupCard7 => 'आपका सारा डेटा पहले से क्लाउड पर है ✓';

  @override
  String cloudBackupCard8(Object uploaded) {
    return '$uploaded रिकॉर्ड क्लाउड पर अपलोड ✓';
  }

  @override
  String get cloudBackupCard9 => 'आपके अकाउंट की दुकानें लोड हो रही हैं…';

  @override
  String get cloudBackupCard10 => 'इस अकाउंट का अभी कोई क्लाउड बैकअप नहीं';

  @override
  String get cloudBackupCard11 => 'दुकान चुनें';

  @override
  String get cloudBackupCard12 => ' (कर्मचारी)';

  @override
  String get cloudBackupCard13 => 'क्लाउड से वापस लाएँ?';

  @override
  String cloudBackupCard14(Object name) {
    return 'हम \"$name\" का बैकअप क्लाउड से डाउनलोड करके इस फ़ोन में जोड़ेंगे।\n\n';
  }

  @override
  String get cloudBackupCard15 =>
      'कुछ नहीं हटेगा: सिर्फ़ इस फ़ोन पर मौजूद डेटा रहेगा, और आख़िरी बैकअप के बाद फ़ोन पर बदली चीज़ें वैसी ही रहेंगी।';

  @override
  String get cloudBackupCard16 => 'हाँ, वापस लाएँ';

  @override
  String get cloudBackupCard17 => 'वापस आ गया 🎉';

  @override
  String cloudBackupCard18(Object keptLocal) {
    return '، और $keptLocal रिकॉर्ड वैसे ही रहे क्योंकि फ़ोन वाला नया है';
  }

  @override
  String cloudBackupCard19(Object records, Object keptLocal) {
    return '$records रिकॉर्ड वापस आए$keptLocal।';
  }

  @override
  String get cloudBackupCard20 =>
      ' सब स्क्रीन ताज़ा करने के लिए ऐप बंद करके फिर खोलें।';

  @override
  String get cloudBackupCard21 => 'ऐप बंद करें';

  @override
  String get cloudBackupCard22 => 'साइन आउट करें?';

  @override
  String get cloudBackupCard23 =>
      'आपका डेटा फ़ोन और क्लाउड पर रहेगा, लेकिन फिर से साइन इन तक बैकअप रुक जाएगा।';

  @override
  String get cloudBackupCard24 => 'साइन आउट';

  @override
  String get cloudBackupCard25 => 'ऐप के इस वर्ज़न में उपलब्ध नहीं';

  @override
  String get cloudBackupCard26 => 'क्लाउड बैकअप';

  @override
  String get cloudBackupCard27 =>
      'गूगल से साइन इन करें ताकि डेटा ऑनलाइन सेव रहे। फ़ोन खो जाए तो किसी भी दूसरे फ़ोन पर वापस लाएँ।';

  @override
  String get cloudBackupCard28 => 'अभी कोई बैकअप नहीं';

  @override
  String cloudBackupCard29(Object last) {
    return 'आख़िरी बैकअप: $last';
  }

  @override
  String get cloudBackupCard30 => 'अभी अपलोड हो रहा है…';

  @override
  String get cloudBackupCard31 =>
      'इंटरनेट का इंतज़ार — वापस आते ही अपने-आप अपलोड होगा';

  @override
  String get cloudBackupCard32 => 'अपलोड रुक गया, थोड़ी देर में फिर कोशिश होगी';

  @override
  String get cloudBackupCard33 => 'सब कुछ अपलोड हो गया ✓';

  @override
  String get cloudBackupCard34 => 'इंटरनेट होने पर अपने-आप अपलोड';

  @override
  String get cloudBackupCard35 => 'अभी बैकअप अपलोड करें';

  @override
  String get cloudBackupCard36 => 'अपना डेटा इस फ़ोन पर वापस लाएँ';

  @override
  String get cloudBackupCard37 =>
      'नए फ़ोन या दोबारा इंस्टॉल के बाद — कुछ नहीं हटाता';

  @override
  String get cloudBackupCard38 => 'साइन आउट';

  @override
  String get onboardingScreen1 => 'मेरी दुकान';

  @override
  String get onboardingScreen2 =>
      'ऐप आज़माने के लिए डेमो ग्राहक जोड़े गए, आप उन्हें कभी भी हटा सकते हैं';

  @override
  String get onboardingScreen3 => 'काशकूल की पहली सेटिंग';

  @override
  String get onboardingScreen4 => 'आगे: कारोबार का प्रकार';

  @override
  String get onboardingScreen5 => 'काशकूल में आपका स्वागत है! 👋';

  @override
  String get onboardingScreen6 =>
      'उधार, व्हाट्सऐप रिमाइंडर और किस्तों के लिए आसान डिजिटल खाता।';

  @override
  String get onboardingScreen7 => 'दुकान का नाम *';

  @override
  String get onboardingScreen8 => 'जैसे: अमानत किराना / स्टार मोबाइल्स';

  @override
  String get onboardingScreen9 => 'दुकान का नाम लिखें (कम से कम 2 अक्षर)';

  @override
  String get onboardingScreen10 => 'दुकान का फ़ोन (वैकल्पिक)';

  @override
  String get onboardingScreen11 =>
      'रसीदों, विवरण और व्हाट्सऐप मैसेज में दिखता है';

  @override
  String get onboardingScreen12 => 'किराना और सुपरमार्केट';

  @override
  String get onboardingScreen13 => 'रोज़ का उधार और जल्दी ड्रॉअर बंद करना';

  @override
  String get onboardingScreen14 => 'मोबाइल और एक्सेसरीज़';

  @override
  String get onboardingScreen15 => 'डिवाइस की जानकारी, किस्तें अपने-आप चालू';

  @override
  String get onboardingScreen16 => 'इलेक्ट्रॉनिक्स और घरेलू सामान';

  @override
  String get onboardingScreen17 =>
      'उधार बिक्री के अनुबंध, किस्तें अपने-आप चालू';

  @override
  String get onboardingScreen18 => 'फ़ार्मेसी और कॉस्मेटिक्स';

  @override
  String get onboardingScreen19 => 'उधार सीमा और पर्चियों का हिसाब';

  @override
  String get onboardingScreen20 => 'अन्य कारोबार';

  @override
  String get onboardingScreen21 => 'हर तरह के कारोबार के लिए लचीला खाता';

  @override
  String get onboardingScreen22 => 'आपका कारोबार किस तरह का है?';

  @override
  String get onboardingScreen23 => 'हम ऐप को आपके काम के हिसाब से सेट करेंगे।';

  @override
  String get onboardingScreen24 => 'किस्तों की सुविधा';

  @override
  String get onboardingScreen25 => 'किस्त प्लान चालू करें';

  @override
  String get onboardingScreen26 => 'सेटिंग्स से कभी भी चालू या बंद कर सकते हैं';

  @override
  String get onboardingScreen27 => 'रिमाइंडर आप तक पहुँचें 🔔';

  @override
  String get onboardingScreen28 =>
      'ताकि काशकूल आपको रोज़ वसूली और किस्तों की याद दिला सके:';

  @override
  String get onboardingScreen29 => 'नोटिफ़िकेशन की अनुमति';

  @override
  String get onboardingScreen30 => 'नोटिफ़िकेशन चालू हो गए ✅';

  @override
  String get onboardingScreen31 =>
      'रोज़ की वसूली का सारांश भेजने के लिए नोटिफ़िकेशन की अनुमति चाहिए';

  @override
  String get onboardingScreen32 => 'नोटिफ़िकेशन की अनुमति दें';

  @override
  String onboardingScreen33(Object brandName) {
    return 'बैकग्राउंड सुरक्षा ($brandName)';
  }

  @override
  String get onboardingScreen34 => 'बैकग्राउंड में ऐप बंद होने से बचाएँ';

  @override
  String get onboardingScreen35 => 'बैटरी सेटिंग्स खोलें';

  @override
  String get onboardingScreen36 => 'तैयार हैं! 🚀';

  @override
  String get onboardingScreen37 =>
      'आपकी दुकान की जानकारी सेव हो गई। कैसे शुरू करना चाहेंगे?';

  @override
  String get onboardingScreen38 => '+ पहला असली ग्राहक जोड़ें';

  @override
  String get onboardingScreen39 =>
      'पहला ग्राहक दर्ज करें और तुरंत उधार व भुगतान लिखना शुरू करें';

  @override
  String get onboardingScreen40 => 'पहले डेमो डेटा से आज़माएँ 💡';

  @override
  String get onboardingScreen41 =>
      'काशकूल आज़माने के लिए दो डेमो ग्राहक जोड़ता है (एक टैप में हटाएँ)';

  @override
  String get onboardingScreen42 => 'छोड़ें और होम स्क्रीन पर जाएँ';

  @override
  String get shopRepository1 => 'अहमद मोहम्मद (डेमो)';

  @override
  String get shopRepository2 => 'घरेलू ख़रीदारी';

  @override
  String get shopRepository3 => 'महमूद इब्राहिम (डेमो)';

  @override
  String get shopRepository4 => 'महीने की शुरुआत का माल';

  @override
  String get shopRepository5 => 'खाते में नकद भुगतान';

  @override
  String get supplierWithBalance1 => 'शनिवार';

  @override
  String get supplierWithBalance2 => 'रविवार';

  @override
  String get supplierWithBalance3 => 'सोमवार';

  @override
  String get supplierWithBalance4 => 'मंगलवार';

  @override
  String get supplierWithBalance5 => 'बुधवार';

  @override
  String get supplierWithBalance6 => 'गुरुवार';

  @override
  String get supplierWithBalance7 => 'शुक्रवार';

  @override
  String get trashScreen1 => 'ग्राहक';

  @override
  String get trashScreen2 => 'लेन-देन';

  @override
  String get trashScreen3 => 'सप्लायर';

  @override
  String get trashScreen4 => 'ख़र्च';

  @override
  String get trashScreen5 => 'किस्तें';

  @override
  String trashScreen6(Object title) {
    return '\"$title\" वापस आ गया ✓';
  }

  @override
  String get trashScreen7 => 'वापस नहीं ला सके, फिर कोशिश करें';

  @override
  String get trashScreen8 => 'ट्रैश 🗑️';

  @override
  String get trashScreen9 =>
      'जो कुछ आप हटाते हैं यहाँ आ जाता है, खोता नहीं। कभी भी वापस ला सकते हैं, और क्लाउड बैकअप में भी वापस आएगा।';

  @override
  String get trashScreen10 => 'हटाई गई चीज़ें लोड नहीं हुईं';

  @override
  String get trashScreen11 => 'ट्रैश ख़ाली है ✨';

  @override
  String trashScreen12(Object deletedAt) {
    return 'हटाया: $deletedAt';
  }

  @override
  String get trashScreen13 => 'वापस लाएँ';

  @override
  String get trashScreen14 => 'ट्रैश';

  @override
  String get trashScreen15 => 'हटाई चीज़ें देखें और वापस लाएँ';

  @override
  String trashScreen16(Object count) {
    return '$count चीज़ें — वापस ला सकते हैं';
  }

  @override
  String get trashRepository1 => 'किराया';

  @override
  String get trashRepository2 => 'बिजली';

  @override
  String get trashRepository3 => 'वेतन';

  @override
  String get trashRepository4 => 'सामान';

  @override
  String get trashRepository5 => 'सप्लायर को भुगतान';

  @override
  String get trashRepository6 => 'ख़र्च';

  @override
  String get trashRepository7 => 'मुझ पर';

  @override
  String get trashRepository8 => 'भुगतान';

  @override
  String get trashRepository9 => 'मैंने चुकाया';

  @override
  String get trashRepository10 => 'अज्ञात';

  @override
  String trashRepository11(Object itemDescription) {
    return 'किस्तें: $itemDescription';
  }

  @override
  String pdfStatementService1(Object sanitizedName, Object dateStr) {
    return 'Statement_${sanitizedName}_$dateStr.pdf';
  }

  @override
  String get pdfStatementService2 => 'ग्राहक खाता विवरण';

  @override
  String pdfStatementService3(Object customerName) {
    return 'ग्राहक: $customerName';
  }

  @override
  String pdfStatementService4(Object phone) {
    return 'फ़ोन: $phone';
  }

  @override
  String pdfStatementService5(Object periodDescription) {
    return 'अवधि: $periodDescription';
  }

  @override
  String get pdfStatementService6 => 'इस अवधि से पहले का बैलेंस:';

  @override
  String get pdfStatementService7 => 'तारीख़';

  @override
  String get pdfStatementService8 => 'विवरण';

  @override
  String get pdfStatementService9 => 'बैलेंस';

  @override
  String pdfStatementService10(Object periodDebitsPiasters) {
    return 'कुल ख़रीद / उधार: $periodDebitsPiasters';
  }

  @override
  String pdfStatementService11(Object periodCreditsPiasters) {
    return 'कुल भुगतान: $periodCreditsPiasters';
  }

  @override
  String get pdfStatementService12 => 'अंतिम देय बैलेंस:';

  @override
  String pdfStatementService13(Object trim) {
    return 'भुगतान के तरीके: $trim';
  }

  @override
  String get pdfStatementService14 => 'काशकूल से बना — मुफ़्त आज़माएँ:';

  @override
  String get statementCalculator1 => 'सभी लेन-देन';

  @override
  String get statementCalculator2 => 'जनवरी';

  @override
  String get statementCalculator3 => 'फ़रवरी';

  @override
  String get statementCalculator4 => 'मार्च';

  @override
  String get statementCalculator5 => 'अप्रैल';

  @override
  String get statementCalculator6 => 'मई';

  @override
  String get statementCalculator7 => 'जून';

  @override
  String get statementCalculator8 => 'जुलाई';

  @override
  String get statementCalculator9 => 'अगस्त';

  @override
  String get statementCalculator10 => 'सितंबर';

  @override
  String get statementCalculator11 => 'अक्टूबर';

  @override
  String get statementCalculator12 => 'नवंबर';

  @override
  String get statementCalculator13 => 'दिसंबर';

  @override
  String statementCalculator14(Object startDate, Object endDate) {
    return '$startDate से $endDate तक';
  }

  @override
  String statementCalculator15(Object startDate) {
    return '$startDate से';
  }

  @override
  String statementCalculator16(Object endDate) {
    return '$endDate तक';
  }

  @override
  String growthFooter1(Object shopCode) {
    return '—\nकाशकूल से बना 📒 मुफ़्त आज़माएँ: $shopCode';
  }

  @override
  String growthFooter2(Object shopCode) {
    return 'मैं काशकूल 📒 इस्तेमाल करता हूँ ताकि बिना काग़ज़ी खाते के ग्राहकों, सप्लायरों और ड्रॉअर का हिसाब रखूँ।\nबहुत आसान और बिना इंटरनेट चलता है। मुफ़्त आज़माएँ:\n$shopCode';
  }

  @override
  String get notificationService1 => 'रोज़ की वसूली';

  @override
  String get notificationService2 => 'वसूली वाले ग्राहकों की याद';

  @override
  String notificationService3(Object dueCount, Object amountStr) {
    return '$dueCount ग्राहकों पर $amountStr बाकी — वसूली के लिए दबाएँ';
  }

  @override
  String get notificationService4 => 'रोज़ की वसूली का रिमाइंडर 📒';

  @override
  String get backupService1 => 'डेटाबेस फ़ाइल नहीं मिली';

  @override
  String backupService2(Object dateStr) {
    return 'काशकूल बैकअप - $dateStr';
  }

  @override
  String get backupService3 => 'चुनी गई फ़ाइल मौजूद नहीं';

  @override
  String get backupService4 => 'फ़ाइल ख़राब या अधूरी है';

  @override
  String get backupService5 => 'गलत फ़ाइल फ़ॉर्मेट (काशकूल फ़ाइल नहीं)';

  @override
  String get backupService6 => 'फ़ाइल में काशकूल डेटाबेस नहीं';

  @override
  String get backupService7 => 'फ़ाइल के अंदर डेटाबेस ख़राब है';

  @override
  String get backupService8 => 'सही SQLite डेटाबेस नहीं';

  @override
  String get backupService9 => 'गलत बैकअप फ़ाइल';

  @override
  String get backupService10 => 'आर्काइव में डेटाबेस फ़ाइल नहीं';

  @override
  String get googleAuthService1 => 'इस वर्ज़न में क्लाउड बैकअप सेट नहीं';

  @override
  String get googleAuthService2 =>
      'गूगल ने साइन इन की जानकारी नहीं दी, फिर कोशिश करें';

  @override
  String get googleAuthService3 => 'साइन इन रद्द';

  @override
  String googleAuthService4(Object codeName) {
    return 'गूगल से साइन इन नहीं हो सका ($codeName)';
  }

  @override
  String get cloudApi1 => 'इस वर्ज़न में सर्वर पता सेट नहीं';

  @override
  String get cloudApi2 => 'पहले गूगल से साइन इन करें';

  @override
  String get cloudApi3 => 'इंटरनेट नहीं है, फिर कोशिश करें';

  @override
  String get cloudApi4 => 'सर्वर ने देर से जवाब दिया, फिर कोशिश करें';

  @override
  String get cloudApi5 => 'सेशन ख़त्म हो गया, फिर से गूगल से साइन इन करें';

  @override
  String get cloudApi6 => 'यह दुकान किसी दूसरे गूगल अकाउंट पर है';

  @override
  String get cloudApi7 => 'इस फ़ीचर के लिए सब्सक्रिप्शन चाहिए';

  @override
  String get cloudApi8 => 'बहुत ज़्यादा कोशिशें, थोड़ा रुककर फिर कोशिश करें';

  @override
  String get cloudApi9 => 'फिर से गूगल से साइन इन करें';

  @override
  String get cloudApi10 => 'सर्वर पर गूगल साइन इन सेट नहीं';

  @override
  String get cloudApi11 => 'सर्वर में दिक़्क़त, थोड़ी देर बाद कोशिश करें';

  @override
  String cloudApi12(Object code) {
    return 'दिक़्क़त हुई ($code)';
  }

  @override
  String get cloudBackupService1 => 'गूगल साइन इन उपलब्ध नहीं';

  @override
  String get cloudBackupService2 =>
      'पहले सेटिंग्स से दुकान की जानकारी पूरी करें';

  @override
  String get cloudBackupService3 => 'दुकान का डेटा तैयार हो रहा है…';

  @override
  String cloudBackupService4(Object length, Object changesLength) {
    return '$changesLength में से $length अपलोड हो रहे हैं…';
  }

  @override
  String get cloudBackupService5 => 'हो गया ✓';

  @override
  String cloudBackupService6(Object changesLength) {
    return 'डेटा डाउनलोड हो रहा है… ($changesLength)';
  }

  @override
  String cloudBackupService7(Object changesLength) {
    return '$changesLength रिकॉर्ड फ़ोन पर सेव हो रहे हैं…';
  }

  @override
  String get cloudBackupService8 => 'दुकान';

  @override
  String autoBackupCoordinator1(Object rejected) {
    return '$rejected रिकॉर्ड अपलोड नहीं हुए';
  }

  @override
  String get autoBackupCoordinator2 =>
      'दिक़्क़त हुई, थोड़ी देर में फिर कोशिश होगी';

  @override
  String get customerRating1 => 'नया ग्राहक (3 से कम लेन-देन)';

  @override
  String get customerRating2 => 'हिसाब साफ़ और समय पर चुकाता है';

  @override
  String customerRating3(Object oldestUnpaidAgeDays) {
    return 'लेट: सबसे पुराना उधार $oldestUnpaidAgeDays दिन का और सीमा पार';
  }

  @override
  String get customerRating4 => 'ग्राहक की उधार सीमा पार';

  @override
  String get customerRating5 => 'सिर्फ़ आज उधार लिया, हिसाब ठीक है';

  @override
  String customerRating6(Object oldestUnpaidAgeDays) {
    return 'सबसे पुरानी रकम सिर्फ़ $oldestUnpaidAgeDays दिन की (सुरक्षित सीमा)';
  }

  @override
  String customerRating7(Object oldestUnpaidAgeDays) {
    return 'सबसे पुरानी रकम $oldestUnpaidAgeDays दिन की (45 दिन से ज़्यादा लेट)';
  }

  @override
  String customerRating8(Object oldestUnpaidAgeDays) {
    return 'सबसे पुरानी रकम $oldestUnpaidAgeDays दिन की (निगरानी चाहिए)';
  }

  @override
  String get whatsappTemplate1 =>
      'नमस्ते {customer_name} 👋\n{shop_name} से बात कर रहे हैं।\nआपका मौजूदा बैलेंस: {balance}\nआख़िरी लेन-देन: {last_transaction_date} - {last_transaction_amount}\nभुगतान के लिए: {payment_info}\nहमारे साथ कारोबार के लिए धन्यवाद 🙏';

  @override
  String get whatsappTemplate2 =>
      'आदरणीय {customer_name},\nयाद दिला दें कि {shop_name} में आपका मौजूदा बैलेंस {balance} है।\nआख़िरी दर्ज लेन-देन: {last_transaction_date} ({last_transaction_amount})\nभुगतान के तरीके: {payment_info}\nसादर।';

  @override
  String get whatsappTemplate3 =>
      'नमस्ते {customer_name} 👋\n{shop_name} से बात कर रहे हैं।\n({item}) की किस्त की याद — {installment_count} में से किस्त नंबर {installment_number}:\nदेय रकम: {amount}\nआख़िरी तारीख़: {due_date}\nकुल बाकी: {remaining_total}\nभुगतान के तरीके: {payment_info}\nसमय पर भुगतान के लिए धन्यवाद 🙏';

  @override
  String get whatsappTemplate4 => 'दुकान पर नकद या उपलब्ध ट्रांसफ़र';

  @override
  String get money1 => 'EGP';

  @override
  String get batteryOptimizationHelper1 => 'XOS / HiOS';

  @override
  String get batteryOptimizationHelper2 =>
      'अपने फ़ोन पर Phone Master ऐप खोलें।';

  @override
  String get batteryOptimizationHelper3 =>
      '\"Auto-start\" मैनेजमेंट में जाकर काशकूल चालू करें।';

  @override
  String get batteryOptimizationHelper4 =>
      'ऐप की सेटिंग्स में \"Battery\" खोलें और \"Unrestricted\" चुनें।';

  @override
  String get batteryOptimizationHelper5 =>
      'हाल की ऐप्स में ऐप को नीचे खींचकर लॉक करें 🔒।';

  @override
  String get batteryOptimizationHelper6 => 'MIUI / HyperOS';

  @override
  String get batteryOptimizationHelper7 =>
      'ऐप की सेटिंग्स खोलें और \"Autostart\" चालू करें।';

  @override
  String get batteryOptimizationHelper8 =>
      '\"Battery saver\" में \"No restrictions\" चुनें।';

  @override
  String get batteryOptimizationHelper9 =>
      'हाल की ऐप्स में काशकूल को देर तक दबाएँ और लॉक आइकन चुनें 🔒।';

  @override
  String get batteryOptimizationHelper10 => 'ColorOS / Realme UI';

  @override
  String get batteryOptimizationHelper11 =>
      'ऐप सेटिंग्स -> Battery usage में \"Allow background activity\" चालू करें।';

  @override
  String get batteryOptimizationHelper12 => '\"Auto-launch\" चालू करें।';

  @override
  String get batteryOptimizationHelper13 =>
      'हाल की ऐप्स में तीन बिंदु दबाएँ और \"Lock\" चुनें।';

  @override
  String get batteryOptimizationHelper14 => 'One UI';

  @override
  String get batteryOptimizationHelper15 =>
      'Settings -> Device care -> Battery में जाएँ।';

  @override
  String get batteryOptimizationHelper16 =>
      '\"Background usage limits\" खोलें।';

  @override
  String get batteryOptimizationHelper17 =>
      'काशकूल को \"Never sleeping apps\" में जोड़ें।';

  @override
  String get batteryOptimizationHelper18 => 'EMUI / MagicOS';

  @override
  String get batteryOptimizationHelper19 =>
      'Settings -> Battery -> App launch में जाएँ।';

  @override
  String get batteryOptimizationHelper20 =>
      '\"Kashkool\" खोजें, मैनुअल करें और Auto-launch + Run in background चालू करें।';

  @override
  String get batteryOptimizationHelper21 => 'सिस्टम सेटिंग्स';

  @override
  String get batteryOptimizationHelper22 => 'सिस्टम नोटिफ़िकेशन की सुरक्षा';

  @override
  String get batteryOptimizationHelper23 =>
      'फ़ोन सेटिंग्स में ऐप की जानकारी खोलें।';

  @override
  String get batteryOptimizationHelper24 =>
      '\"Battery\" खोलें और \"Unrestricted\" चुनें।';

  @override
  String get batteryOptimizationHelper25 =>
      'रिमाइंडर आएँ इसके लिए अल्ट्रा पावर सेविंग मोड बंद रखें।';

  @override
  String get homeWidgetService1 => 'कोई नहीं';

  @override
  String get homeWidgetService2 => '1 ग्राहक';

  @override
  String get homeWidgetService3 => '2 ग्राहक';

  @override
  String homeWidgetService4(Object count) {
    return '$count ग्राहक';
  }

  @override
  String get pinLockScreen1 => 'गलत PIN, फिर कोशिश करें';

  @override
  String get pinLockScreen2 => 'दोनों PIN अलग हैं, फिर कोशिश करें';

  @override
  String get pinLockScreen3 => 'फ़िंगरप्रिंट उपलब्ध नहीं या सेट नहीं';

  @override
  String get pinLockScreen4 => 'काशकूल में स्वागत है 📒';

  @override
  String get pinLockScreen5 => 'नया PIN सेट करें';

  @override
  String get pinLockScreen6 => 'पुष्टि के लिए PIN फिर लिखें';

  @override
  String get pinLockScreen7 => '4 अंकों का PIN डालें';

  @override
  String get pinLockScreen8 => 'ऐप लॉक करने के लिए याद रहने वाले 4 अंक लिखें';

  @override
  String get pinLockScreen9 => 'वही अंक फिर लिखें';

  @override
  String get pinLockScreen10 => 'फ़िंगरप्रिंट';

  @override
  String get pinLockScreen11 => 'मिटाएँ';

  @override
  String get securityService1 => 'काशकूल खोलने के लिए पहचान की पुष्टि करें';

  @override
  String get settingsLanguageTitle => 'भाषा';

  @override
  String get settingsLanguageSystem => 'फ़ोन की भाषा (ऑटो)';

  @override
  String get cloudDeleteAccountTitle => 'क्लाउड अकाउंट हटाएँ';

  @override
  String get cloudDeleteAccountSubtitle =>
      'क्लाउड बैकअप और अकाउंट हमेशा के लिए हटाता है — फ़ोन का डेटा रहेगा';

  @override
  String get cloudDeleteAccountConfirmTitle => 'अकाउंट हमेशा के लिए हटाएँ?';

  @override
  String get cloudDeleteAccountConfirmBody =>
      'हम आपका अकाउंट और आपकी दुकानों के सारे क्लाउड बैकअप हटा देंगे। यह वापस नहीं होगा। इस फ़ोन का डेटा वैसा ही रहेगा।';

  @override
  String get cloudDeleteAccountConfirmButton => 'हमेशा के लिए हटाएँ';

  @override
  String get cloudDeleteAccountDone => 'आपका क्लाउड अकाउंट हटा दिया गया';

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
