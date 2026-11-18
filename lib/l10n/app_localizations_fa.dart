// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'کشکول';

  @override
  String get navCustomers => 'مشتریان';

  @override
  String get navCollection => 'وصول';

  @override
  String get navSuppliers => 'تأمین‌کنندگان';

  @override
  String get navInventory => 'انبار';

  @override
  String get navCashDrawer => 'صندوق';

  @override
  String get inventoryTitle => 'انبار';

  @override
  String get inventoryManageButton => 'مدیریت کالاها و انبار';

  @override
  String get inventorySearchHint => 'جستجوی کالا یا بارکد...';

  @override
  String get inventoryAddProduct => 'کالای جدید';

  @override
  String get inventoryEditProduct => 'ویرایش کالا';

  @override
  String get inventoryNoProducts => 'هنوز کالایی ثبت نشده است';

  @override
  String get inventoryNoSearchResults => 'کالایی با این جستجو پیدا نشد';

  @override
  String get inventoryProductName => 'نام کالا';

  @override
  String get inventoryNameRequired => 'نام کالا را وارد کنید';

  @override
  String get inventoryBarcode => 'بارکد (اختیاری)';

  @override
  String get inventoryCategory => 'دستهبندی (اختیاری)';

  @override
  String get inventoryUnit => 'واحد فروش';

  @override
  String get inventoryUnitExample => 'مثال: عدد، کیلوگرم، لیتر';

  @override
  String get inventoryUnitRequired => 'واحد فروش را وارد کنید';

  @override
  String get inventoryPurchasePrice => 'قیمت خرید (جنیه)';

  @override
  String get inventorySalePrice => 'قیمت فروش (جنیه)';

  @override
  String get inventoryMinimumStock =>
      'وقتی موجودی به این حد رسید به من هشدار بده';

  @override
  String get inventoryInitialStock => 'موجودی فعلی';

  @override
  String get inventoryCurrentStock => 'موجودی انبار';

  @override
  String get inventoryInStock => 'موجود';

  @override
  String get inventoryLowStock => 'موجودی کم';

  @override
  String get inventoryAdjustStock => 'تنظیم موجودی';

  @override
  String get inventoryAddStock => 'افزودن به انبار';

  @override
  String get inventoryRemoveStock => 'کسر از انبار';

  @override
  String get inventoryQuantity => 'تعداد';

  @override
  String get inventoryNote => 'یادداشت (اختیاری)';

  @override
  String get inventoryMovementHistory => 'تحرکات انبار';

  @override
  String get inventoryMovementOpening => 'موجودی افتتاحیه';

  @override
  String get inventoryMovementAdjustment => 'تنظیم دستی';

  @override
  String get inventoryMovementPurchase => 'خرید';

  @override
  String get inventoryMovementSale => 'فروش';

  @override
  String get inventoryMovementCustomerReturn => 'مرجوعی مشتری';

  @override
  String get inventoryMovementSupplierReturn => 'مرجوعی تأمینکننده';

  @override
  String get inventoryNoMovements => 'هنوز تحرکاتی در انبار ثبت نشده است';

  @override
  String get inventorySave => 'ذخیره';

  @override
  String get inventoryCancel => 'لغو';

  @override
  String get inventoryDelete => 'حذف کالا';

  @override
  String get inventoryDeleteConfirm =>
      'کالا از لیست حذف میشود، اما سابقه تحرکات آن باقی میماند. مطمئن هستید؟';

  @override
  String get inventoryDeleted => 'کالا حذف شد';

  @override
  String get inventoryProductSaved => 'کالا ذخیره شد';

  @override
  String get inventoryStockSaved => 'انبار بهروز شد';

  @override
  String get inventoryInvalidQuantity =>
      'تعداد معتبری وارد کنید (تا ۳ رقم اعشار)';

  @override
  String get inventoryQuantityRequired => 'تعدادی بزرگتر از صفر وارد کنید';

  @override
  String get inventoryStockCannotBeNegative => 'موجودی برای این کسر کافی نیست';

  @override
  String get inventoryInvalidPrice => 'قیمت معتبری وارد کنید (منفی نباشد)';

  @override
  String get inventoryBarcodeExists => 'این بارکد برای کالای دیگری ثبت شده است';

  @override
  String get inventoryUnitChangeNotAllowed =>
      'بعد از ثبت تحرکات انبار نمیتوان واحد را تغییر داد';

  @override
  String get inventorySaveFailed =>
      'نتوانستیم تغییرات را ذخیره کنیم. اطلاعات را بررسی کرده دوباره تلاش کنید.';

  @override
  String get inventorySupplier => 'تأمینکننده (اختیاری)';

  @override
  String get inventorySupplierNone => 'بدون تأمینکننده';

  @override
  String get inventorySupplierFilter => 'فیلتر بر اساس تأمینکننده';

  @override
  String get inventoryFilterAllSuppliers => 'همه تأمینکنندگان';

  @override
  String get inventorySupplierProducts => 'کالاهای تأمینکننده';

  @override
  String get inventoryNoSupplierProducts =>
      'کالایی به این تأمینکننده مرتبط نیست';

  @override
  String get inventorySupplierCardTitle => 'تأمینکننده مسئول';

  @override
  String get inventoryOrderWhatsApp => 'سفارش کالاهای کمموجودی از طریق واتساپ';

  @override
  String get supplierReturn => 'مرجوعی به تأمینکننده';

  @override
  String get supplierReturnReason => 'دلیل مرجوعی (اختیاری)';

  @override
  String get supplierReturnSuccess =>
      'مرجوعی با موفقیت ثبت و مبلغ از حساب کسر شد';

  @override
  String get purchasePaidAmount => 'مبلغ پرداختشده فعلی';

  @override
  String get purchasePaymentFull => 'پرداخت کامل';

  @override
  String get purchasePaymentPartial => 'پرداخت جزئی (باقی نسیه)';

  @override
  String get purchasePaymentOnAccount => 'پیشپرداخت';

  @override
  String get purchasePaymentCredit => 'کاملاً نسیه';

  @override
  String get purchaseRemainingDebt => 'بدهی باقیمانده مغازه';

  @override
  String get purchaseAdvanceCredit => 'اعتبار اضافی مغازه (پیشپرداخت)';

  @override
  String get profitLossTitle => 'سود و زیان';

  @override
  String get profitLossRevenue => 'کل فروش';

  @override
  String get profitLossCogs => 'بهای کالای فروشرفته';

  @override
  String get profitLossGross => 'سود ناخالص';

  @override
  String get profitLossExpenses => 'هزینههای عملیاتی';

  @override
  String get profitLossNet => 'سود / زیان خالص';

  @override
  String get profitLossMargin => 'درصد حاشیه سود';

  @override
  String get profitLossPeriodToday => 'امروز';

  @override
  String get profitLossPeriodWeek => '۷ روز گذشته';

  @override
  String get profitLossPeriodMonth => 'این ماه';

  @override
  String get profitLossPeriodAll => 'همه زمانها';

  @override
  String get profitLossPositive => 'سود خالص';

  @override
  String get profitLossNegative => 'زیان خالص';

  @override
  String get profitLossCashSectionTitle => 'سود نقدی وصولشده';

  @override
  String get profitLossCashSectionSubtitle =>
      'سودی که از فروش نقدی بعد از کسر هزینهها واقعاً وارد صندوق شده است';

  @override
  String get profitLossCashNet => 'سود نقدی خالص در صندوق';

  @override
  String get profitLossCashRevenue => 'فروش نقدی';

  @override
  String get profitLossCashCogs => 'بهای کالای نقدی فروشرفته';

  @override
  String get profitLossCashGross => 'سود ناخالص نقدی';

  @override
  String get profitLossCreditSectionTitle => 'سود نسیه (نزد مشتریان)';

  @override
  String get profitLossCreditSectionSubtitle =>
      'سود کالایی که نسیه فروخته شده و هنوز وصول نشده است';

  @override
  String get profitLossCreditGross => 'سود نسیه نزد مشتریان';

  @override
  String get profitLossCreditRevenue => 'فروش نسیه';

  @override
  String get profitLossCreditCogs => 'بهای کالای نسیه';

  @override
  String get profitLossTotalExpectedNet => 'کل سود مورد انتظار (نقدی + نسیه)';

  @override
  String get profitLossCashVsCreditRatio => 'نسبت فروش نقدی به نسیه';

  @override
  String get shopReportTitle => 'گزارش کامل مغازه';

  @override
  String get shopReportInventoryValue => 'ارزش کالای مغازه';

  @override
  String get shopReportAtCost => 'به قیمت خرید (بها)';

  @override
  String get shopReportAtRetail => 'به قیمت فروش (مورد انتظار)';

  @override
  String get shopReportExpectedProfit => 'سود مورد انتظار از کالا';

  @override
  String get shopReportReceivables => 'طلبات ما از مشتریان (بدهیها)';

  @override
  String get shopReportPayables => 'بدهی ما به تأمینکنندگان';

  @override
  String get shopReportCashDrawer => 'پول داخل صندوق و گنجینه';

  @override
  String get shopReportNetWorth => 'سرمایه خالص مغازه';

  @override
  String get shopReportLowStockCount => 'کالاهایی که موجودیشان کم شده است';

  @override
  String get shopReportShare => 'اشتراکگذاری گزارش از طریق واتساپ';

  @override
  String get featureManagerTitle => 'سفارشی کردن قابلیتهای مغازه';

  @override
  String get featureManagerSubtitle =>
      'بخشها را بر اساس نوع و نیاز مغازیتان نشان دهید یا پنهان کنید';

  @override
  String get featureManagerNote =>
      'پنهان کردن هر قابلیت، اطلاعات آن را حذف نمیکند و هر زمانی میتوانید آن را با یک ضربه برگردانید.';

  @override
  String get featurePresetTitle => 'حالتهای سریع با یک ضربه';

  @override
  String get featurePresetSimple => 'دفتر بدهیها فقط';

  @override
  String get featurePresetSimpleDesc =>
      'تمرکز کامل فقط روی حساب مشتریان و وصولطلبی';

  @override
  String get featurePresetGrocery => 'بقالی و سوپرمارکت';

  @override
  String get featurePresetGroceryDesc =>
      'فروش سریع + کالا و تأمینکنندگان + صندوق روزانه';

  @override
  String get featurePresetElectronics => 'فروشگاه موبایل و لوازم الکتریکی';

  @override
  String get featurePresetElectronicsDesc =>
      'اقساط + انبار + فروش سریع و تأمینکنندگان';

  @override
  String get featurePresetAll => 'فعال کردن همه قابلیتها';

  @override
  String get featurePresetAllDesc => 'باز کردن تمام امکانات برنامه';

  @override
  String get featureQuickPosTitle => 'فروش سریع و صندوق فروش (POS)';

  @override
  String get featureQuickPosDesc =>
      'صفحهای اصلی برای ساختن فاکتور نقدی سریع و محاسبه پول باقیمانده';

  @override
  String get featureSuppliersTitle => 'تأمینکنندگان و فاکتورهای خرید';

  @override
  String get featureSuppliersDesc =>
      'پیگیری بدهی تأمینکنندگان، سفارش کالاهای کمموجودی و مرجوعیها';

  @override
  String get featureInstallmentsTitle => 'دفتر اقساط ماهانه';

  @override
  String get featureInstallmentsDesc =>
      'برنامه اقساط، قراردادهای خرید و یادآوری سررسید پرداخت';

  @override
  String get featureInventoryTitle => 'انبار و مدیریت کالاها';

  @override
  String get featureInventoryDesc => 'ثبت کالا، هشدار موجودی کم و سابقه تحرکات';

  @override
  String get featureCashDrawerTitle => 'صندوق و کشوی روزانه';

  @override
  String get featureCashDrawerDesc =>
      'محاسبه جریان نقدی روزانه، کسری، اضافی و بستن صندوق';

  @override
  String get featureProfitLossTitle => 'سود و زیان و گزارشها';

  @override
  String get featureProfitLossDesc =>
      'محاسبه سود خالص بعد از کسر هزینهها و گزارش سرمایه';

  @override
  String get featureOffersTitle => 'پیامهای ترقیجات و مناسبتها';

  @override
  String get featureOffersDesc =>
      'ارسال پیشنهادها و تخفیفها به گروههای مشتریان از طریق واتساپ';

  @override
  String get featureCoreAlwaysActive =>
      'مشتریان و وصولطلبی قابلیت اصلی هستند و همیشه فعالاند';

  @override
  String get featureStatusActive => 'فعال';

  @override
  String get featureStatusHidden => 'پنهان';

  @override
  String get quickPosTitle => 'فروش سریع';

  @override
  String get quickPosOpen => 'باز کردن فروش سریع';

  @override
  String get quickPosSearch => 'جستجو با نام یا بارکد را وارد کنید...';

  @override
  String get quickPosProducts => 'کالاها';

  @override
  String get quickPosAdd => 'اضافه به فروش';

  @override
  String get quickPosAvailable => 'موجود';

  @override
  String get quickPosCart => 'کالاهای فروش';

  @override
  String get quickPosEmptyCart => 'برای شروع فروش کالایی اضافه کنید';

  @override
  String get quickPosQuantity => 'تعداد';

  @override
  String get quickPosQuantityInvalid => 'تعداد معتبری بزرگتر از صفر وارد کنید';

  @override
  String get quickPosCash => 'نقدی';

  @override
  String get quickPosCredit => 'به حساب مشتری';

  @override
  String get quickPosSelectCustomer => 'انتخاب مشتری';

  @override
  String get quickPosCustomerRequired => 'برای فروش نسیه مشتری انتخاب کنید';

  @override
  String get quickPosTotal => 'مجموع';

  @override
  String get quickPosCompleteSale => 'تأیید فروش';

  @override
  String get quickPosSaving => 'در حال ذخیره فروش...';

  @override
  String get quickPosSaleSaved => 'فروش ثبت شد';

  @override
  String get quickPosSaveFailed =>
      'نتوانستیم فروش را ثبت کنیم. دوباره تلاش کنید.';

  @override
  String get quickPosInsufficientStock => 'موجودی برای این تعداد کافی نیست';

  @override
  String get quickPosCashDayClosed =>
      'صندوق امروز بسته شده است. برای ثبت فروش نقدی دوباره آن را باز کنید.';

  @override
  String get quickPosLoadFailed => 'نتوانستیم کالاها را بارگذاری کنیم';

  @override
  String get quickPosCustomersLoadFailed =>
      'نتوانستیم مشتریان را بارگذاری کنیم';

  @override
  String get quickPosSaleNote => 'فروش سریع';

  @override
  String get supplierPurchasesTitle => 'خریدهای تأمینکننده';

  @override
  String get supplierPurchaseNew => 'ثبت خرید';

  @override
  String get supplierPurchaseInvoiceNumber => 'شماره فاکتور (اختیاری)';

  @override
  String get supplierPurchasePaymentType => 'روش پرداخت';

  @override
  String get supplierPurchaseCash => 'نقدی';

  @override
  String get supplierPurchaseCredit => 'نسیه';

  @override
  String get supplierPurchaseAddProduct => 'انتخاب کالا';

  @override
  String get supplierPurchaseItems => 'اقلام فاکتور';

  @override
  String get supplierPurchaseQuantity => 'تعداد';

  @override
  String get supplierPurchaseUnitCost => 'قیمت خرید هر واحد (جنیه)';

  @override
  String get supplierPurchaseAddLine => 'اضافه کردن کالا';

  @override
  String get supplierPurchaseNoLines => 'حداقل یک کالا اضافه کنید';

  @override
  String get supplierPurchaseSave => 'ذخیره فاکتور';

  @override
  String get supplierPurchaseTotal => 'مجموع فاکتور';

  @override
  String get supplierPurchaseSaved => 'فاکتور خرید ثبت شد';

  @override
  String get supplierPurchaseSaveFailed =>
      'نتوانستیم فاکتور را ثبت کنیم. دوباره تلاش کنید.';

  @override
  String get supplierPurchaseNoInvoices =>
      'فاکتور خریدی برای این تأمینکننده وجود ندارد';

  @override
  String get supplierPurchaseDetails => 'جزئیات فاکتور';

  @override
  String get supplierPurchaseReturn => 'مرجوعی به تأمینکننده';

  @override
  String get supplierPurchaseReturned => 'مرجوعی';

  @override
  String get supplierPurchaseRemaining => 'قابل مرجوعی';

  @override
  String get supplierPurchaseReturnQuantity => 'تعداد مرجوعی';

  @override
  String get supplierPurchaseReturnSaved =>
      'مرجوعی ثبت و از حساب تأمینکننده کسر شد';

  @override
  String get supplierPurchaseReturnLimit =>
      'تعداد درخواستی بیشتر از مقدار قابل مرجوعی یا موجودی انبار است';

  @override
  String get supplierCreditNote => 'اعتبار ناشی از مرجوعی';

  @override
  String get supplierPurchaseInvalidInput =>
      'تعداد و قیمت را بررسی کرده دوباره تلاش کنید';

  @override
  String get supplierPurchaseLoadError =>
      'نتوانستیم فاکتورهای خرید را بارگذاری کنیم';

  @override
  String get navSettings => 'تنظیمات';

  @override
  String get debt => 'بدهی';

  @override
  String get payment => 'پرداخت';

  @override
  String get settled => 'تسویه';

  @override
  String get currency => 'EGP';

  @override
  String get piaster => 'قروش';

  @override
  String get save => 'ذخیره';

  @override
  String get cancel => 'لغو';

  @override
  String get delete => 'حذف';

  @override
  String get search => 'جستجو...';

  @override
  String placeholderScreen(String screenName) {
    return 'صفحه $screenName';
  }

  @override
  String get comingSoon => 'به‌زودی';

  @override
  String get totalReceivablesTitle => 'طلب شما از مشتریان';

  @override
  String get searchCustomersHint => 'جستجو با نام یا شماره...';

  @override
  String get filterAll => 'همه';

  @override
  String get filterHasDebt => 'بدهکار';

  @override
  String get filterSettled => 'تسویه‌شده';

  @override
  String get filterLate => 'دیرکرد';

  @override
  String get sortHighestDebt => 'بیشترین بدهی';

  @override
  String get sortName => 'نام';

  @override
  String get sortLastActivity => 'آخرین فعالیت';

  @override
  String get addNewCustomer => 'مشتری جدید';

  @override
  String get addCustomer => 'افزودن مشتری';

  @override
  String get editCustomer => 'ویرایش مشتری';

  @override
  String get customerName => 'نام مشتری';

  @override
  String get customerNameHint => 'مثلاً: آقای محمدی بقال';

  @override
  String get customerNameRequired => 'نام مشتری الزامی است';

  @override
  String get customerNameTooShort => 'نام باید حداقل ۲ حرف باشد';

  @override
  String get customerPhone => 'شماره موبایل';

  @override
  String get customerPhoneHint => '010xxxxxxxx';

  @override
  String get customerPhoneInvalid => 'شماره نامعتبر (010، 011، 012، 015)';

  @override
  String get customerNotes => 'یادداشت‌ها';

  @override
  String get customerNotesHint => 'مثلاً: همسایه طبقه دوم';

  @override
  String get creditLimit => 'سقف بدهی (اختیاری)';

  @override
  String get creditLimitHint => 'مثلاً: 1000';

  @override
  String get noCustomersTitle => 'دفتر شما خالی است!';

  @override
  String get noCustomersSubtitle =>
      'برای افزودن اولین مشتری و پیگیری آسان حساب‌ها، دکمه پایین را بزنید';

  @override
  String get noSearchResults => 'مشتری‌ای با این نام یا شماره نیست';

  @override
  String get duplicateCustomerWarning =>
      'هشدار: مشتری با همین نام یا شماره وجود دارد';

  @override
  String get customerDetails => 'اطلاعات مشتری';

  @override
  String get callCustomer => 'تماس';

  @override
  String get deleteCustomer => 'حذف مشتری';

  @override
  String get deleteCustomerConfirm => 'تأیید حذف مشتری';

  @override
  String deleteCustomerWarningDebt(String amount) {
    return 'توجه! این مشتری هنوز $amount بدهکار است. مطمئنید حذف شود؟';
  }

  @override
  String deleteCustomerSafeConfirm(String name) {
    return 'آیا از حذف مشتری $name مطمئنید؟';
  }

  @override
  String get customerDeleted => 'مشتری حذف شد';

  @override
  String get customerSaved => 'مشتری ذخیره شد';

  @override
  String get lastActivityNever => 'تراکنش قبلی ندارد';

  @override
  String lastActivityDate(String date) {
    return 'آخرین تراکنش: $date';
  }

  @override
  String creditLimitLabel(String amount) {
    return 'سقف بدهی: $amount';
  }

  @override
  String get creditLimitExceeded => 'سقف بدهی رد شد!';

  @override
  String get heOwes => 'بدهکار';

  @override
  String get hePaid => 'بستانکار (بیشتر پرداخته)';

  @override
  String get currentBalance => 'مانده فعلی';

  @override
  String get noTransactionsYet => 'هنوز تراکنشی ثبت نشده';

  @override
  String get addDebtTitle => 'ثبت بدهی جدید';

  @override
  String get addPaymentTitle => 'ثبت پرداخت';

  @override
  String get amountLabel => 'مبلغ';

  @override
  String get amountRequired => 'مبلغ معتبر بیشتر از صفر وارد کنید';

  @override
  String get today => 'امروز';

  @override
  String get yesterday => 'دیروز';

  @override
  String get date => 'تاریخ';

  @override
  String get pickDate => 'انتخاب تاریخ';

  @override
  String get paymentMethod => 'روش پرداخت';

  @override
  String get methodCash => 'نقدی';

  @override
  String get methodInstapay => 'InstaPay';

  @override
  String get methodWallet => 'کیف پول';

  @override
  String get methodOther => 'سایر';

  @override
  String get noteOptional => 'یادداشت (اختیاری: شکر، روغن، شارژ...)';

  @override
  String get voiceDictation => 'تایپ صوتی';

  @override
  String get listening => 'در حال شنیدن... صحبت کنید';

  @override
  String get speechNotAvailable => 'تایپ صوتی در این دستگاه در دسترس نیست';

  @override
  String get attachPhoto => 'پیوست عکس';

  @override
  String get camera => 'دوربین';

  @override
  String get gallery => 'گالری';

  @override
  String get removePhoto => 'حذف عکس';

  @override
  String get overpaymentTitle => 'مبلغ از بدهی بیشتر است!';

  @override
  String overpaymentMessage(
    String paidAmount,
    String dueAmount,
    String creditAmount,
  ) {
    return 'مبلغ پرداختی ($paidAmount) از بدهی ($dueAmount) بیشتر است. مازاد ($creditAmount) به‌عنوان طلب مشتری ثبت شود؟';
  }

  @override
  String get overpaymentConfirm => 'بله، ثبت طلب';

  @override
  String get transactionSaved => 'تراکنش ثبت شد';

  @override
  String get undo => 'بازگردانی';

  @override
  String get transactionUndone => 'تراکنش لغو شد';

  @override
  String get transactionDetails => 'جزئیات تراکنش';

  @override
  String get editTransaction => 'ویرایش تراکنش';

  @override
  String get deleteTransaction => 'حذف تراکنش';

  @override
  String get deleteTransactionConfirm => 'آیا از حذف این تراکنش مطمئنید؟';

  @override
  String get transactionDeleted => 'تراکنش حذف شد';

  @override
  String get viewPhoto => 'مشاهده عکس';

  @override
  String get creditLimitWarningTitle => 'هشدار سقف بدهی';

  @override
  String creditLimitExceededDialog(
    String customerName,
    String newTotal,
    String limit,
  ) {
    return 'بدهی $customerName به $newTotal می‌رسد، در حالی که سقف او $limit است';
  }

  @override
  String get saveAnyway => 'با این حال ثبت کن';

  @override
  String get changeLimit => 'تغییر سقف';

  @override
  String get newCreditLimit => 'سقف بدهی جدید';

  @override
  String get limitUpdated => 'سقف بدهی به‌روز شد';

  @override
  String get totalPayablesTitle => 'بدهی شما به تأمین‌کنندگان';

  @override
  String get netMarketPosition => 'وضعیت خالص مالی';

  @override
  String netReceivables(String amount) {
    return 'خالص طلب: $amount';
  }

  @override
  String netPayables(String amount) {
    return 'خالص بدهی: $amount';
  }

  @override
  String get netSettled => 'حساب‌ها برابر است (0 EGP)';

  @override
  String get addNewSupplier => 'تأمین‌کننده جدید';

  @override
  String get addSupplier => 'افزودن تأمین‌کننده';

  @override
  String get editSupplier => 'ویرایش تأمین‌کننده';

  @override
  String get supplierName => 'نام تأمین‌کننده / نماینده';

  @override
  String get supplierNameHint => 'مثلاً: رضا، نماینده شرکت';

  @override
  String get supplierNameRequired => 'نام تأمین‌کننده الزامی است';

  @override
  String get company => 'شرکت / نمایندگی';

  @override
  String get companyHint => 'مثلاً: کاله، مزمز';

  @override
  String get visitDay => 'روز بازدید هفتگی';

  @override
  String get noSpecificDay => 'روز مشخصی ندارد';

  @override
  String get supplierNotes => 'یادداشت‌ها';

  @override
  String get supplierNotesHint => 'مثلاً: ساعت ۱۰ صبح می‌آید';

  @override
  String get noSuppliersTitle => 'دفتر تأمین‌کنندگان خالی است!';

  @override
  String get noSuppliersSubtitle =>
      'برای افزودن اولین تأمین‌کننده دکمه پایین را بزنید';

  @override
  String get noSupplierSearchResults => 'تأمین‌کننده‌ای یافت نشد';

  @override
  String get searchSuppliersHint => 'جستجو با نام، شرکت یا شماره...';

  @override
  String get supplierDetails => 'اطلاعات تأمین‌کننده';

  @override
  String get iOweHim => 'بدهکارم';

  @override
  String get iPaidHim => 'پرداختم';

  @override
  String get deleteSupplier => 'حذف تأمین‌کننده';

  @override
  String get deleteSupplierConfirm => 'تأیید حذف تأمین‌کننده';

  @override
  String deleteSupplierWarningDebt(String amount) {
    return 'توجه! هنوز $amount به این تأمین‌کننده بدهکارید. مطمئنید حذف شود؟';
  }

  @override
  String deleteSupplierSafeConfirm(String name) {
    return 'آیا از حذف تأمین‌کننده $name مطمئنید؟';
  }

  @override
  String get supplierDeleted => 'تأمین‌کننده حذف شد';

  @override
  String get supplierSaved => 'تأمین‌کننده ذخیره شد';

  @override
  String visitDayPrefix(String day) {
    return 'روز بازدید: $day';
  }

  @override
  String get sortCompany => 'شرکت';

  @override
  String get sortVisitDay => 'روز بازدید';

  @override
  String get dueCustomersTitle => 'مشتریان سررسید';

  @override
  String get totalDueTitle => 'مجموع سررسید';

  @override
  String dueCustomersCount(int count) {
    return '$count مشتری';
  }

  @override
  String dueHeaderSummary(int count, String amount) {
    return '$count مشتری مجموعاً $amount بدهکارند';
  }

  @override
  String oldestDebtDays(int days) {
    return 'قدیمی‌ترین بدهی $days روز پیش';
  }

  @override
  String get oldestDebtToday => 'بدهی امروز ثبت شده';

  @override
  String lastReminderDays(int days) {
    return 'آخرین یادآوری: $days روز پیش';
  }

  @override
  String get lastReminderToday => 'آخرین یادآوری: امروز';

  @override
  String get neverReminded => 'هنوز یادآوری نشده';

  @override
  String snoozedUntilDate(String date) {
    return 'تا $date به تعویق افتاد';
  }

  @override
  String get sendWhatsApp => 'واتس‌اپ';

  @override
  String get sendSms => 'پیامک';

  @override
  String get moreActions => 'بیشتر';

  @override
  String get snooze3Days => '۳ روز تعویق';

  @override
  String get snooze7Days => 'یک هفته تعویق';

  @override
  String get cancelSnooze => 'لغو تعویق';

  @override
  String get recordCollectionPayment => 'ثبت پرداخت';

  @override
  String get didSendMessage => 'پیام ارسال شد؟';

  @override
  String didSendMessageDesc(String name) {
    return 'آیا یادآوری را از طریق واتس‌اپ برای $name فرستادید؟';
  }

  @override
  String get yesSent => 'بله، فرستادم';

  @override
  String get notSent => 'نه، نفرستادم';

  @override
  String get reminderMarkedSent => 'یادآوری ثبت شد';

  @override
  String get snoozedSuccess => 'یادآوری به تعویق افتاد';

  @override
  String get noDueCustomersTitle => 'امروز وصولی سررسیدی نیست 🎉';

  @override
  String get noDueCustomersSubtitle =>
      'همه مشتریان تسویه کرده‌اند یا اخیراً یادآوری شده‌اند.';

  @override
  String get whatsAppNotInstalled => 'واتس‌اپ نصب نیست. پیامک بفرستیم؟';

  @override
  String get openSms => 'ارسال پیامک';

  @override
  String get growthFooter => '\nارسال‌شده با اپ کشکول 📒';

  @override
  String get statementTitle => 'صورت‌حساب';

  @override
  String get generateStatement => 'تهیه صورت‌حساب';

  @override
  String get statementAllTime => 'همه تراکنش‌ها';

  @override
  String get statementThisMonth => 'این ماه';

  @override
  String get statementCustomRange => 'بازه دلخواه';

  @override
  String get statementFormatA4 => 'کاغذ A4';

  @override
  String get statementFormatReceipt => 'فیش حرارتی (80mm)';

  @override
  String get dateCol => 'تاریخ';

  @override
  String get descriptionCol => 'شرح';

  @override
  String get debtCol => 'بدهی';

  @override
  String get paymentCol => 'پرداخت';

  @override
  String get balanceCol => 'مانده';

  @override
  String get startingBalance => 'مانده ابتدای دوره';

  @override
  String get finalBalance => 'مانده نهایی';

  @override
  String periodLabel(String period) {
    return 'دوره: $period';
  }

  @override
  String statementGeneratedAt(String date) {
    return 'تاریخ تهیه: $date';
  }

  @override
  String get shareStatement => 'اشتراک صورت‌حساب';

  @override
  String get printStatement => 'چاپ';

  @override
  String statementShareSubject(String name) {
    return 'صورت‌حساب - $name';
  }

  @override
  String get totalDebits => 'مجموع خرید / نسیه';

  @override
  String get totalCredits => 'مجموع پرداخت‌ها';

  @override
  String get drawerTitle => 'بستن صندوق';

  @override
  String get todayDrawer => 'صندوق امروز';

  @override
  String get expectedInDrawer => 'مبلغ مورد انتظار در صندوق';

  @override
  String get openingCash => 'موجودی اول روز';

  @override
  String get openingCashHint => 'مبلغ شروع روز';

  @override
  String get editOpeningCash => 'ویرایش موجودی اول روز';

  @override
  String get cashSales => 'فروش نقدی';

  @override
  String get addCashSales => 'ثبت فروش نقدی';

  @override
  String get cashIn => 'ورودی صندوق (نقدی)';

  @override
  String get digitalIn => 'ورودی الکترونیکی';

  @override
  String get cashOut => 'خروجی صندوق (نقدی)';

  @override
  String get customerPaymentsCash => 'وصولی از مشتریان (نقدی)';

  @override
  String get customerPaymentsDigital => 'وصولی از مشتریان (الکترونیکی)';

  @override
  String get supplierPaymentsCash => 'پرداخت به تأمین‌کنندگان (نقدی)';

  @override
  String get expensesCash => 'هزینه‌های مغازه (نقدی)';

  @override
  String get addExpense => 'ثبت هزینه';

  @override
  String get editExpense => 'ویرایش هزینه';

  @override
  String get deleteExpense => 'حذف هزینه';

  @override
  String get deleteExpenseConfirm => 'آیا از حذف این هزینه مطمئنید؟';

  @override
  String get expenseCategory => 'دسته هزینه';

  @override
  String get catRent => 'اجاره';

  @override
  String get catElectricity => 'برق و قبوض';

  @override
  String get catSalary => 'حقوق و دستمزد';

  @override
  String get catSupplies => 'کالا و لوازم';

  @override
  String get catSupplierPayment => 'پرداخت به تأمین‌کننده';

  @override
  String get catOther => 'سایر';

  @override
  String get closeDay => 'بستن روز';

  @override
  String get reopenDay => 'بازگشایی روز';

  @override
  String get reopenDayConfirm => 'این روز برای ویرایش دوباره باز شود؟';

  @override
  String get dayClosedSuccess => 'روز بسته شد';

  @override
  String get dayReopenedSuccess => 'روز دوباره باز شد';

  @override
  String get dayIsClosed => 'روز بسته است';

  @override
  String get dayIsOpen => 'روز باز است';

  @override
  String get actualCountLabel => 'مبلغ واقعی در صندوق';

  @override
  String get actualCountHint => 'مبلغ شمارش‌شده را وارد کنید';

  @override
  String get drawerBalanced => 'صندوق کاملاً جور است 🎉';

  @override
  String get drawerShortage => 'کسری صندوق';

  @override
  String get drawerSurplus => 'اضافه صندوق';

  @override
  String differenceAmount(String amount) {
    return 'اختلاف: $amount';
  }

  @override
  String get closeDaySummary => 'خلاصه بستن روز';

  @override
  String get confirmCloseDay => 'تأیید بستن';

  @override
  String get historyTab => 'سابقه روزها';

  @override
  String get todayTab => 'صندوق امروز';

  @override
  String get monthlyTotals => 'جمع ماه';

  @override
  String get monthlySales => 'فروش نقدی';

  @override
  String get monthlyExpenses => 'هزینه‌های نقدی';

  @override
  String get monthlyNet => 'خالص صندوق';

  @override
  String get drawerNotes => 'یادداشت بستن (اختیاری)';

  @override
  String get noExpensesYet => 'امروز هزینه‌ای ثبت نشده';

  @override
  String get noHistoryYet => 'روز قبلی ثبت نشده';

  @override
  String get expenseAddedSuccess => 'هزینه ثبت شد';

  @override
  String get cashSalesAddedSuccess => 'فروش نقدی ثبت شد';

  @override
  String get openingCashUpdatedSuccess => 'موجودی اول روز به‌روز شد';

  @override
  String get dayDetails => 'جزئیات روز';

  @override
  String closedAtTime(String time) {
    return 'بسته شد در: $time';
  }

  @override
  String get readOnlyDayNotice =>
      'این روز بسته است. برای ویرایش، بازگشایی روز را بزنید.';

  @override
  String get privacyModeTitle => 'حالت حریم خصوصی';

  @override
  String get privacyModeSubtitle => 'پنهان کردن مبالغ در صفحه و ویجت (••••••)';

  @override
  String get shareAppTitle => 'اشتراک‌گذاری برنامه';

  @override
  String get shareAppSubtitle => 'کشکول را برای مغازه‌دارهای دیگر بفرستید';

  @override
  String shopCodeLabel(String code) {
    return 'کد مغازه: $code';
  }

  @override
  String get growthFooterToggleTitle => 'پنهان کردن امضای کشکول در پیام‌ها';

  @override
  String get growthFooterToggleSubtitle => 'در نسخه پولی 🔒';

  @override
  String get codeCopied => 'کد کپی شد';

  @override
  String get main1 => 'کشکول';

  @override
  String get notebookImportButton1 => 'دفترتان را به برنامه منتقل کنید 📒';

  @override
  String get notebookImportButton2 =>
      'لازم نیست همه موارد قدیمی را وارد کنید: نام مشتری و بدهی فعلی کافی است.';

  @override
  String get notebookImportButton3 => 'مشتریان و حساب‌ها';

  @override
  String get notebookImportButton4 => 'یک خط برای هر مشتری: نام، تلفن و بدهی';

  @override
  String get notebookImportButton5 => 'قسط قدیمی';

  @override
  String get notebookImportButton6 =>
      'قیمت، پرداخت‌شده، اقساط باقی و سررسید بعدی';

  @override
  String get notebookImportButton7 => 'انتقال از دفتر';

  @override
  String get oldInstallmentImportScreen1 => 'تاریخ قسط بعدی';

  @override
  String get oldInstallmentImportScreen2 => 'قسط ذخیره شد ✓';

  @override
  String oldInstallmentImportScreen3(
    Object remaining,
    Object countValue,
    Object nextDue,
  ) {
    return '$remaining باقی در $countValue قسط، اولی در $nextDue.';
  }

  @override
  String get oldInstallmentImportScreen4 => 'تمام';

  @override
  String get oldInstallmentImportScreen5 => 'قسط دیگر';

  @override
  String get oldInstallmentImportScreen6 => 'ذخیره ناموفق بود، چیزی ذخیره نشد';

  @override
  String get oldInstallmentImportScreen7 => ' ماهانه';

  @override
  String get oldInstallmentImportScreen8 => ' هفتگی';

  @override
  String oldInstallmentImportScreen9(
    Object remaining,
    Object count,
    Object count2,
    Object monthly,
  ) {
    return '$remaining باقی — $count قسط × حدود $count2$monthly';
  }

  @override
  String get oldInstallmentImportScreen10 => 'قسط قدیمی از دفتر';

  @override
  String oldInstallmentImportScreen11(Object savedCount) {
    return 'قسط قدیمی ($savedCount)';
  }

  @override
  String get oldInstallmentImportScreen12 =>
      'برای اقساطی که قبل از برنامه شروع شده‌اند: قیمت، مبلغ پرداخت‌شده تا الان و تعداد اقساط باقی را بنویسید. برنامه فقط جدول باقی‌مانده را می‌سازد و پرداخت‌های قبلی را در صندوق امروز حساب نمی‌کند.';

  @override
  String get oldInstallmentImportScreen13 => 'مشتری';

  @override
  String get oldInstallmentImportScreen14 => 'نام مشتری';

  @override
  String get oldInstallmentImportScreen15 =>
      'نام مشتری موجود یا جدید را بنویسید';

  @override
  String get oldInstallmentImportScreen16 => 'نام مشتری را بنویسید';

  @override
  String get oldInstallmentImportScreen17 =>
      'موبایل مشتری (اگر جدید است — اختیاری)';

  @override
  String get oldInstallmentImportScreen18 => 'شماره نامعتبر';

  @override
  String get oldInstallmentImportScreen19 => 'قسط';

  @override
  String get oldInstallmentImportScreen20 => 'کالا';

  @override
  String get oldInstallmentImportScreen21 => 'مثلاً: یخچال سامسونگ';

  @override
  String get oldInstallmentImportScreen22 => 'نام کالا را بنویسید';

  @override
  String get oldInstallmentImportScreen23 => 'قیمت کل';

  @override
  String get oldInstallmentImportScreen24 => 'EGP';

  @override
  String get oldInstallmentImportScreen25 => 'الزامی';

  @override
  String get oldInstallmentImportScreen26 => 'نامعتبر';

  @override
  String get oldInstallmentImportScreen27 => 'پرداخت‌شده تا الان';

  @override
  String get oldInstallmentImportScreen28 => 'باید کمتر از قیمت باشد';

  @override
  String get oldInstallmentImportScreen29 => 'تعداد اقساط باقی';

  @override
  String get oldInstallmentImportScreen30 => 'از ۱ تا ۱۲۰';

  @override
  String oldInstallmentImportScreen31(Object nextDue) {
    return 'بعدی: $nextDue';
  }

  @override
  String get oldInstallmentImportScreen32 => 'ماهانه';

  @override
  String get oldInstallmentImportScreen33 => 'هفتگی';

  @override
  String get oldInstallmentImportScreen34 => 'ضامن (اختیاری)';

  @override
  String get oldInstallmentImportScreen35 => 'نام ضامن';

  @override
  String get oldInstallmentImportScreen36 => 'موبایل ضامن';

  @override
  String get oldInstallmentImportScreen37 =>
      'عکس دفتر یا قرارداد (اختیاری — روی گوشی می‌ماند)';

  @override
  String get oldInstallmentImportScreen38 =>
      'می‌توانید چند عکس اضافه کنید: صفحات دفتر، قرارداد، کارت شناسایی ضامن…';

  @override
  String oldInstallmentImportScreen39(Object photosLength) {
    return '$photosLength عکس — در عکس‌های مشتری ذخیره می‌شود';
  }

  @override
  String get oldInstallmentImportScreen40 => 'در حال ذخیره…';

  @override
  String get oldInstallmentImportScreen41 => 'ذخیره قسط';

  @override
  String get notebookImportScreen1 => 'این حساب‌ها تا تاریخ';

  @override
  String notebookImportScreen2(Object firstError, Object error) {
    return 'خط $firstError: $error';
  }

  @override
  String get notebookImportScreen3 => 'حداقل نام یک مشتری را بنویسید';

  @override
  String get notebookImportScreen4 => 'ذخیره شد ✓';

  @override
  String notebookImportScreen5(Object newCustomers) {
    return '$newCustomers مشتری جدید';
  }

  @override
  String notebookImportScreen6(Object existingCustomers) {
    return '$existingCustomers مشتری موجود — به حسابشان اضافه شد';
  }

  @override
  String notebookImportScreen7(Object totalPiasters) {
    return 'جمع: $totalPiasters';
  }

  @override
  String get notebookImportScreen8 => 'صفحه بعد';

  @override
  String get notebookImportScreen9 => 'بدون ذخیره خارج شوید؟';

  @override
  String get notebookImportScreen10 => 'آنچه در این صفحه نوشتید ذخیره نمی‌شود.';

  @override
  String get notebookImportScreen11 => 'ادامه';

  @override
  String get notebookImportScreen12 => 'خروج';

  @override
  String get notebookImportScreen13 => 'انتقال دفتر 📒';

  @override
  String notebookImportScreen14(Object savedPages) {
    return 'انتقال دفتر — صفحه $savedPages';
  }

  @override
  String get notebookImportScreen15 => 'خط جدید';

  @override
  String notebookImportScreen16(Object validLength) {
    return '$validLength مشتری';
  }

  @override
  String get notebookImportScreen17 => 'ذخیره';

  @override
  String get notebookImportScreen18 =>
      'هر مشتری را در یک خط بنویسید: نام، موبایل اگر دارید، و مبلغ بدهی. برای سرعت، «بعدی» را روی صفحه‌کلید بزنید.';

  @override
  String get notebookImportScreen19 => 'حساب تا امروز';

  @override
  String notebookImportScreen20(Object asOf) {
    return 'تا $asOf';
  }

  @override
  String get notebookImportScreen21 =>
      'عکس صفحه دفتر (اختیاری): همراه همه مشتریان صفحه ذخیره می‌شود';

  @override
  String notebookImportScreen22(Object pagePhotosLength) {
    return '$pagePhotosLength عکس صفحه — همراه همه مشتریان صفحه ذخیره می‌شود';
  }

  @override
  String get notebookImportScreen23 => 'صفحه';

  @override
  String get notebookImportScreen24 => 'عکس‌های این مشتری';

  @override
  String get notebookImportScreen25 => 'حذف خط';

  @override
  String get notebookImportScreen26 => 'موبایل (اختیاری)';

  @override
  String get notebookImportScreen27 => 'مبلغ';

  @override
  String get notebookImportScreen28 => 'در حال جستجو…';

  @override
  String notebookImportScreen29(Object name) {
    return '«$name» از قبل وجود دارد — مبلغ به حسابش اضافه می‌شود';
  }

  @override
  String get notebookImportScreen30 => 'مشتری این مبلغ را بدهکار است';

  @override
  String get notebookImportScreen31 => 'شما این مبلغ را به مشتری بدهکارید';

  @override
  String get notebookImportScreen32 => 'بدهکار';

  @override
  String get notebookImportScreen33 => 'بستانکار';

  @override
  String get notebookImportService1 => 'مانده قبلی از دفتر';

  @override
  String get notebookImportService2 => 'صفحه دفتر';

  @override
  String get notebookImportService3 => 'نام وارد نشده';

  @override
  String get notebookImportService4 => 'نام خیلی طولانی است';

  @override
  String get notebookImportService5 => 'مبلغ نامعتبر';

  @override
  String get notebookImportService6 => 'مبلغ پرداختی نمی‌تواند منفی باشد';

  @override
  String get notebookImportService7 => 'مبلغ پرداختی باید کمتر از قیمت کل باشد';

  @override
  String get notebookImportService8 => 'حداقل ۱ قسط باید باقی باشد';

  @override
  String notebookImportService9(Object paidPiasters) {
    return 'وارد شده از دفتر — پرداخت قبلی: $paidPiasters';
  }

  @override
  String notebookImportService10(Object trim, Object totalPricePiasters) {
    return 'قسط قدیمی: $trim (باقی‌مانده از $totalPricePiasters)';
  }

  @override
  String notebookImportService11(Object trim) {
    return 'قسط: $trim';
  }

  @override
  String get installmentsScreen1 => 'اقساط 📋';

  @override
  String get installmentsScreen2 => 'جستجو با مشتری، کالا، موبایل یا ضامن...';

  @override
  String get installmentsScreen3 => 'مجموع اقساط';

  @override
  String get installmentsScreen4 => 'اقساط معوق';

  @override
  String get installmentsScreen5 => 'طرح‌های فعال';

  @override
  String get installmentsScreen6 => 'همه';

  @override
  String get installmentsScreen7 => 'فعال ⏳';

  @override
  String get installmentsScreen8 => 'تکمیل‌شده ✓';

  @override
  String get installmentsScreen9 => 'لغوشده';

  @override
  String installmentsScreen10(Object e) {
    return 'خطا در بارگذاری اقساط: $e';
  }

  @override
  String get installmentsScreen11 => 'قسطی پیدا نشد';

  @override
  String get installmentsScreen12 => 'هنوز طرح اقساطی نیست';

  @override
  String get installmentsScreen13 =>
      'برای ساخت اولین طرح اقساط، (+ طرح اقساط جدید) را بزنید.';

  @override
  String get installmentsScreen14 => 'طرح اقساط جدید';

  @override
  String installmentPlanDetailsScreen1(Object instapay) {
    return 'InstaPay: $instapay';
  }

  @override
  String installmentPlanDetailsScreen2(Object wallet) {
    return 'کیف پول / ودافون کش: $wallet';
  }

  @override
  String installmentPlanDetailsScreen3(Object phoneNum) {
    return 'تلفن: $phoneNum';
  }

  @override
  String get installmentPlanDetailsScreen4 => 'لغو طرح اقساط';

  @override
  String get installmentPlanDetailsScreen5 =>
      'این طرح لغو شود؟ یادآوری‌ها متوقف و سابقه پرداخت‌ها حفظ می‌شود.';

  @override
  String get installmentPlanDetailsScreen6 => 'بازگشت';

  @override
  String get installmentPlanDetailsScreen7 => 'لغو طرح';

  @override
  String get installmentPlanDetailsScreen8 => 'طرح اقساط لغو شد';

  @override
  String get installmentPlanDetailsScreen9 => 'حذف طرح اقساط';

  @override
  String get installmentPlanDetailsScreen10 => 'این طرح اقساط حذف شود؟';

  @override
  String get installmentPlanDetailsScreen11 => 'لغو';

  @override
  String get installmentPlanDetailsScreen12 => 'حذف';

  @override
  String get installmentPlanDetailsScreen13 => 'طرح اقساط حذف شد';

  @override
  String get installmentPlanDetailsScreen14 => 'جزئیات قسط';

  @override
  String installmentPlanDetailsScreen15(Object e) {
    return 'خطا: $e';
  }

  @override
  String get installmentPlanDetailsScreen16 => 'طرح اقساط پیدا نشد یا حذف شده';

  @override
  String get installmentPlanDetailsScreen17 => 'حذف طرح';

  @override
  String get installmentPlanDetailsScreen18 => 'قیمت کل:';

  @override
  String get installmentPlanDetailsScreen19 => 'پیش‌پرداخت:';

  @override
  String get installmentPlanDetailsScreen20 => 'مجموع پرداخت:';

  @override
  String get installmentPlanDetailsScreen21 => 'باقی‌مانده:';

  @override
  String get installmentPlanDetailsScreen22 => 'تسویه زودهنگام کامل';

  @override
  String installmentPlanDetailsScreen23(Object guarantorName) {
    return 'ضامن: $guarantorName';
  }

  @override
  String get installmentPlanDetailsScreen24 => 'عکس قرارداد / سفته';

  @override
  String get installmentPlanDetailsScreen25 => 'برای دیدن کامل سند بزنید';

  @override
  String get installmentPlanDetailsScreen26 => 'سند قسط';

  @override
  String installmentPlanDetailsScreen27(Object installmentsLength) {
    return 'جدول اقساط ($installmentsLength)';
  }

  @override
  String get installmentPlanDetailsScreen28 => 'پرداخت مبلغ دلخواه';

  @override
  String installmentPlanDetailsScreen29(
    Object installmentIndex,
    Object dueDate,
  ) {
    return 'قسط شماره $installmentIndex • $dueDate';
  }

  @override
  String installmentPlanDetailsScreen30(Object paidPiasters) {
    return 'کامل پرداخت شد ✓ ($paidPiasters)';
  }

  @override
  String installmentPlanDetailsScreen31(
    Object paidPiasters,
    Object amountPiasters,
  ) {
    return '$paidPiasters از $amountPiasters پرداخت شده';
  }

  @override
  String get installmentPlanDetailsScreen32 => 'معوق ⚠️';

  @override
  String get installmentPlanDetailsScreen33 => 'سررسید امروز 🔔';

  @override
  String installmentPlanDetailsScreen34(Object amountPiasters) {
    return 'آینده • $amountPiasters';
  }

  @override
  String get installmentPlanDetailsScreen35 => 'یادآوری واتس‌اپ';

  @override
  String get installmentPlanDetailsScreen36 => 'پرداخت';

  @override
  String get addInstallmentPlanScreen1 => 'گوشی موبایل';

  @override
  String get addInstallmentPlanScreen2 => 'تلویزیون';

  @override
  String get addInstallmentPlanScreen3 => 'ماشین لباسشویی';

  @override
  String get addInstallmentPlanScreen4 => 'یخچال';

  @override
  String get addInstallmentPlanScreen5 => 'اجاق گاز';

  @override
  String get addInstallmentPlanScreen6 => 'لپ‌تاپ';

  @override
  String get addInstallmentPlanScreen7 => 'موتورسیکلت';

  @override
  String get addInstallmentPlanScreen8 => 'مبلمان';

  @override
  String get addInstallmentPlanScreen9 => 'ابتدا مشتری را انتخاب کنید';

  @override
  String get addInstallmentPlanScreen10 =>
      'پیش‌پرداخت باید کمتر از قیمت کل باشد';

  @override
  String get addInstallmentPlanScreen11 => 'طرح اقساط ساخته و زمان‌بندی شد ✓';

  @override
  String addInstallmentPlanScreen12(Object e) {
    return 'خطایی رخ داد: $e';
  }

  @override
  String addInstallmentPlanScreen13(Object e) {
    return 'خطا در بارگذاری مشتریان: $e';
  }

  @override
  String get addInstallmentPlanScreen14 => 'انتخاب مشتری';

  @override
  String get addInstallmentPlanScreen15 => 'لطفاً مشتری را انتخاب کنید';

  @override
  String get addInstallmentPlanScreen16 => 'کالا و مبالغ';

  @override
  String get addInstallmentPlanScreen17 => 'نام کالا *';

  @override
  String get addInstallmentPlanScreen18 => 'مثلاً: سامسونگ A15 128GB';

  @override
  String get addInstallmentPlanScreen19 => 'نام کالا باید حداقل ۲ حرف باشد';

  @override
  String get addInstallmentPlanScreen20 => 'قیمت کل (EGP) *';

  @override
  String get addInstallmentPlanScreen21 => 'مثلاً: 12000';

  @override
  String get addInstallmentPlanScreen22 => 'مبلغ نامعتبر';

  @override
  String get addInstallmentPlanScreen23 => 'پیش‌پرداخت (EGP)';

  @override
  String get addInstallmentPlanScreen24 => 'مبلغ قابل تقسیط:';

  @override
  String get addInstallmentPlanScreen25 => 'مدت و دوره پرداخت';

  @override
  String addInstallmentPlanScreen26(Object count) {
    return '$count قسط';
  }

  @override
  String get addInstallmentPlanScreen27 => 'تعداد اقساط *';

  @override
  String get addInstallmentPlanScreen28 => 'یک عدد صحیح وارد کنید';

  @override
  String get addInstallmentPlanScreen29 => 'دوره';

  @override
  String get addInstallmentPlanScreen30 => 'سررسید قسط اول';

  @override
  String get addInstallmentPlanScreen31 => 'تغییر تاریخ';

  @override
  String get addInstallmentPlanScreen32 => 'ضامن و مدارک (اختیاری)';

  @override
  String get addInstallmentPlanScreen33 => 'مثلاً: محمد ابراهیمی';

  @override
  String get addInstallmentPlanScreen34 => 'شماره موبایل ضامن';

  @override
  String get addInstallmentPlanScreen35 => 'شماره نامعتبر (010، 011، 012، 015)';

  @override
  String get addInstallmentPlanScreen36 => 'عکس سند گرفته شد ✓';

  @override
  String get addInstallmentPlanScreen37 => 'عکس قرارداد / سفته / کارت شناسایی';

  @override
  String get addInstallmentPlanScreen38 => 'برای تغییر عکس بزنید';

  @override
  String get addInstallmentPlanScreen39 => 'عکس قرارداد را برای بعد نگه دارید';

  @override
  String get addInstallmentPlanScreen40 => 'عکس بگیر';

  @override
  String get addInstallmentPlanScreen41 => 'یادداشت‌های بیشتر';

  @override
  String get addInstallmentPlanScreen42 => 'اتصال خودکار به حساب مشتری';

  @override
  String get addInstallmentPlanScreen43 =>
      'ثبت قیمت کل به‌عنوان بدهی و پیش‌پرداخت به‌عنوان پرداخت در حساب مشتری';

  @override
  String addInstallmentPlanScreen44(Object scheduleLength) {
    return 'پیش‌نمایش جدول ($scheduleLength قسط)';
  }

  @override
  String addInstallmentPlanScreen45(Object amountPiasters) {
    return 'مبلغ قسط: ~$amountPiasters';
  }

  @override
  String get addInstallmentPlanScreen46 => 'ذخیره طرح و جدول';

  @override
  String installmentProgressBar1(
    Object paidCount,
    Object totalCount,
    Object percentInt,
  ) {
    return '$paidCount از $totalCount قسط پرداخت شده ($percentInt٪)';
  }

  @override
  String installmentProgressBar2(Object remainingPiasters) {
    return 'باقی: $remainingPiasters';
  }

  @override
  String get installmentProgressBar3 => 'کامل تسویه شد ✓';

  @override
  String get payInstallmentDialog1 => 'مبلغ معتبر بیشتر از صفر بنویسید';

  @override
  String payInstallmentDialog2(Object amountPiasters) {
    return 'پرداخت $amountPiasters ثبت شد ✓';
  }

  @override
  String payInstallmentDialog3(Object e) {
    return 'خطا در پرداخت: $e';
  }

  @override
  String payInstallmentDialog4(Object installmentIndex) {
    return 'پرداخت قسط شماره $installmentIndex';
  }

  @override
  String payInstallmentDialog5(Object itemDescription) {
    return 'پرداخت قسط ($itemDescription)';
  }

  @override
  String get payInstallmentDialog6 => 'مبلغ قسط:';

  @override
  String get payInstallmentDialog7 => 'مبلغ پرداختی (EGP)';

  @override
  String get payInstallmentDialog8 => 'روش پرداخت';

  @override
  String get payInstallmentDialog9 => 'نقدی 💵';

  @override
  String get payInstallmentDialog10 => 'InstaPay ⚡';

  @override
  String get payInstallmentDialog11 => 'کیف پول 📱';

  @override
  String get payInstallmentDialog12 => 'تاریخ پرداخت';

  @override
  String get payInstallmentDialog13 => 'تغییر';

  @override
  String get payInstallmentDialog14 => 'یادداشت (اختیاری)';

  @override
  String get payInstallmentDialog15 => 'مثلاً: از طریق دوستش فرستاد';

  @override
  String get payInstallmentDialog16 => 'ثبت در حساب مشتری';

  @override
  String get payInstallmentDialog17 => 'از مانده اصلی مشتری کسر می‌شود';

  @override
  String get payInstallmentDialog18 => 'تأیید پرداخت';

  @override
  String earlySettlementDialog1(Object itemDescription) {
    return 'قسط ($itemDescription) کامل تسویه شد ✓';
  }

  @override
  String earlySettlementDialog2(Object e) {
    return 'خطا در تسویه: $e';
  }

  @override
  String get earlySettlementDialog3 => 'تسویه زودهنگام';

  @override
  String get earlySettlementDialog4 => 'جمع اقساط باقی:';

  @override
  String get earlySettlementDialog5 => 'مبلغ قابل وصول:';

  @override
  String get earlySettlementDialog6 => 'تخفیف پرداخت زودهنگام (EGP)';

  @override
  String get earlySettlementDialog7 => 'تسویه همین حالا';

  @override
  String installmentPlanCard1(Object overdueCount) {
    return 'معوق ($overdueCount)';
  }

  @override
  String get installmentPlanCard2 => 'تکمیل ✓';

  @override
  String get installmentPlanCard3 => 'لغوشده';

  @override
  String installmentPlanCard4(Object dueDate, Object paidPiasters) {
    return 'قسط بعدی: $dueDate ($paidPiasters)';
  }

  @override
  String installmentPlanCard5(Object totalPricePiasters) {
    return 'جمع: $totalPricePiasters';
  }

  @override
  String get installmentRepository1 => 'شرح کالا باید حداقل ۲ حرف باشد';

  @override
  String get installmentRepository2 => 'قیمت کل باید بیشتر از صفر باشد';

  @override
  String get installmentRepository3 => 'پیش‌پرداخت نمی‌تواند منفی باشد';

  @override
  String get installmentRepository4 => 'پیش‌پرداخت باید کمتر از قیمت کل باشد';

  @override
  String get installmentRepository5 => 'تعداد اقساط باید بیشتر از صفر باشد';

  @override
  String installmentRepository6(Object trim, Object installmentCount) {
    return 'قسط: $trim ($installmentCount قسط)';
  }

  @override
  String installmentRepository7(Object trim) {
    return 'پیش‌پرداخت: $trim';
  }

  @override
  String get installmentRepository8 => 'مبلغ پرداخت باید بیشتر از صفر باشد';

  @override
  String installmentRepository9(Object itemDescription, Object notes) {
    return 'پرداخت قسط: $itemDescription$notes';
  }

  @override
  String get installmentRepository10 => 'طرح اقساط پیدا نشد';

  @override
  String installmentRepository11(Object itemDescription) {
    return 'تسویه زودهنگام: $itemDescription';
  }

  @override
  String installmentRepository12(Object itemDescription) {
    return 'تخفیف پرداخت زودهنگام: $itemDescription';
  }

  @override
  String get collectionScreen1 => 'اقساط سررسید';

  @override
  String get dueInstallmentsTab1 => 'شماره تلفن مشتری ثبت نشده';

  @override
  String get dueInstallmentsTab2 => 'امروز قسط سررسید یا معوقی نیست 🎉';

  @override
  String get dueInstallmentsTab3 =>
      'همه مشتریان اقساطی به‌موقع پرداخت می‌کنند.';

  @override
  String dueInstallmentsTab4(Object dueListLength) {
    return '$dueListLength قسط برای وصول:';
  }

  @override
  String dueInstallmentsTab5(
    Object itemDescription,
    Object installmentIndex,
    Object installmentCount,
  ) {
    return '$itemDescription • قسط ($installmentIndex از $installmentCount)';
  }

  @override
  String dueInstallmentsTab6(Object daysOverdue) {
    return '$daysOverdue روز دیرکرد';
  }

  @override
  String get dueInstallmentsTab7 => 'سررسید امروز 🔔';

  @override
  String get dueInstallmentsTab8 => 'تماس';

  @override
  String get dueInstallmentsTab9 => 'واتس‌اپ';

  @override
  String cashDrawerScreen1(Object err) {
    return 'خطا در بارگذاری صندوق: $err';
  }

  @override
  String drawerLiveCard1(Object notes) {
    return 'یادداشت: $notes';
  }

  @override
  String expensesListCard1(Object expensesLength) {
    return '$expensesLength هزینه';
  }

  @override
  String get expensesListCard2 => 'InstaPay';

  @override
  String get expensesListCard3 => 'کیف پول';

  @override
  String get drawerFlowCard1 => '(InstaPay / کیف پول)';

  @override
  String addCashSalesBottomSheet1(Object currentSalesPiasters) {
    return 'فروش ثبت‌شده تا الان: $currentSalesPiasters';
  }

  @override
  String get addCashSalesBottomSheet2 => 'افزودن به فروش (+)';

  @override
  String get addCashSalesBottomSheet3 => 'تغییر جمع (=)';

  @override
  String get addCashSalesBottomSheet4 => 'مبلغ افزودنی';

  @override
  String get addCashSalesBottomSheet5 => 'جمع جدید فروش';

  @override
  String addCashSalesBottomSheet6(Object val) {
    return '+$val EGP';
  }

  @override
  String drawerHistoryTab1(
    Object cashSalesPiasters,
    Object openingCashPiasters,
  ) {
    return 'فروش نقدی: $cashSalesPiasters · اول روز: $openingCashPiasters';
  }

  @override
  String drawerHistoryTab2(Object date) {
    return 'جزئیات روز $date';
  }

  @override
  String get drawerHistoryTab3 => 'اختلاف';

  @override
  String get customersScreen1 => 'اقساط';

  @override
  String get customersScreen2 => 'حالت حریم خصوصی';

  @override
  String get customersScreen3 => 'مرتب‌سازی';

  @override
  String get customerPhotosScreen1 => 'عکس اضافه شد';

  @override
  String customerPhotosScreen2(Object pathsLength) {
    return '$pathsLength عکس اضافه شد';
  }

  @override
  String get customerPhotosScreen3 => 'عکس برداشته شد';

  @override
  String get customerPhotosScreen4 => 'بازگردانی';

  @override
  String customerPhotosScreen5(Object customerName) {
    return 'عکس‌های $customerName';
  }

  @override
  String get customerPhotosScreen6 => 'افزودن عکس';

  @override
  String get customerPhotosScreen7 => 'بارگذاری عکس‌ها ناموفق بود';

  @override
  String get customerPhotosScreen8 =>
      'هنوز عکسی برای این مشتری نیست.\nاز صفحات دفتر یا هر برگه مربوط عکس بگیرید — عکس‌ها فقط روی همین گوشی می‌ماند.';

  @override
  String get customerPhotosScreen9 => 'برداشتن عکس';

  @override
  String customerDetailsScreen1(
    Object activePlansLength,
    Object remainingPiasters,
  ) {
    return 'اقساط فعال ($activePlansLength) • باقی: $remainingPiasters';
  }

  @override
  String get customerDetailsScreen2 => 'فروش اقساطی به این مشتری';

  @override
  String get customerDetailsScreen3 => 'مشاهده';

  @override
  String get customerDetailsScreen4 => 'افزودن قسط جدید';

  @override
  String get customerDetailsScreen5 => 'عکس‌های مشتری';

  @override
  String get photoStrip1 => 'عکس با دوربین';

  @override
  String get photoStrip2 => 'انتخاب از گالری';

  @override
  String get photoStrip3 => 'می‌توانید چند عکس را با هم انتخاب کنید';

  @override
  String get photoStrip4 => 'عکس';

  @override
  String get photoStrip5 => 'بیشتر';

  @override
  String get photoStrip6 => 'افزودن عکس';

  @override
  String get photoStrip7 => 'عکس‌ها';

  @override
  String photoStrip8(Object title, Object index, Object count) {
    return '$title ($index از $count)';
  }

  @override
  String get photoStrip9 => 'عکس';

  @override
  String get photoStrip10 => 'عکس روی این گوشی پیدا نشد';

  @override
  String creditLimitProgressBar1(Object limitPiasters) {
    return 'سقف بدهی: $limitPiasters';
  }

  @override
  String ratingExplanationBottomSheet1(Object customerName) {
    return 'امتیاز مشتری: $customerName';
  }

  @override
  String get ratingExplanationBottomSheet2 => 'دلیل امتیاز فعلی:';

  @override
  String get ratingExplanationBottomSheet3 => 'امتیازدهی چگونه کار می‌کند؟';

  @override
  String get ratingExplanationBottomSheet4 => 'عالی';

  @override
  String get ratingExplanationBottomSheet5 =>
      'تسویه کرده یا قدیمی‌ترین بدهی‌اش حداکثر ۱۴ روز است.';

  @override
  String get ratingExplanationBottomSheet6 => 'پیگیری';

  @override
  String get ratingExplanationBottomSheet7 =>
      'قدیمی‌ترین بدهی بین ۱۵ تا ۴۵ روز (بهتر است یادآوری شود).';

  @override
  String get ratingExplanationBottomSheet8 => 'دیرکرد';

  @override
  String get ratingExplanationBottomSheet9 =>
      'قدیمی‌ترین بدهی بیش از ۴۵ روز است یا سقف بدهی رد شده.';

  @override
  String get ratingExplanationBottomSheet10 => 'جدید';

  @override
  String get ratingExplanationBottomSheet11 => 'مشتری با کمتر از ۳ تراکنش.';

  @override
  String get ratingExplanationBottomSheet12 => 'متوجه شدم';

  @override
  String get customerWithBalance1 => 'مشتری جدید';

  @override
  String get settingsScreen1 => 'اطلاعات مغازه 🏪';

  @override
  String get settingsScreen2 => 'امنیت و حریم خصوصی 🔒';

  @override
  String get settingsScreen3 => 'ویجت صفحه اصلی 📱';

  @override
  String get settingsScreen4 => 'پیام‌های یادآوری 💬';

  @override
  String get settingsScreen5 => 'پشتیبان و داده‌ها 💾';

  @override
  String get settingsScreen6 => 'اشتراک برنامه 🚀';

  @override
  String get settingsScreen7 => 'عمومی ⚙️';

  @override
  String get settingsScreen8 => 'کشکول 📒';

  @override
  String get settingsScreen9 =>
      'دفتر حساب مغازه بدون اینترنت (Offline-First)\nنسخه 1.0.0';

  @override
  String get settingsScreen10 => 'فروشگاه عمومی';

  @override
  String get settingsScreen11 => 'بقالی و سوپرمارکت 🛒';

  @override
  String get settingsScreen12 => 'موبایل و لوازم جانبی 📱';

  @override
  String get settingsScreen13 => 'لوازم برقی و خانگی ⚡';

  @override
  String get settingsScreen14 => 'داروخانه و آرایشی 💊';

  @override
  String get settingsScreen15 => 'سایر کسب‌وکارها 🏪';

  @override
  String settingsScreen16(Object tradeName) {
    return '$tradeName • ویرایش کسب‌وکار و اطلاعات پرداخت';
  }

  @override
  String get settingsScreen17 => 'پنهان کردن مبالغ در صفحه و ویجت (••••••)';

  @override
  String get settingsScreen18 => 'قفل برنامه با PIN (۴ رقم)';

  @override
  String get settingsScreen19 => 'فعال و محافظت‌شده (برای غیرفعال‌سازی بزنید)';

  @override
  String get settingsScreen20 => 'غیرفعال (برای تنظیم بزنید)';

  @override
  String get settingsScreen21 => 'فعال 🔒';

  @override
  String get settingsScreen22 => 'تنظیم';

  @override
  String get settingsScreen23 => 'قفل برنامه غیرفعال شد';

  @override
  String get settingsScreen24 => 'PIN تنظیم شد 🔒';

  @override
  String get settingsScreen25 => 'باز کردن با اثر انگشت / Face ID';

  @override
  String get settingsScreen26 => 'استفاده از اثر انگشت به‌جای PIN';

  @override
  String get settingsScreen27 =>
      'دستگاه شما از احراز هویت بیومتریک پشتیبانی نمی‌کند';

  @override
  String get settingsScreen28 => '۱ دقیقه';

  @override
  String get settingsScreen29 => '۵ دقیقه';

  @override
  String get settingsScreen30 => '۱۵ دقیقه';

  @override
  String get settingsScreen31 => 'فوراً';

  @override
  String get settingsScreen32 => 'زمان قفل خودکار';

  @override
  String get settingsScreen33 => 'بلافاصله پس از خروج';

  @override
  String settingsScreen34(Object timeout) {
    return '$timeout دقیقه پس از خروج';
  }

  @override
  String get settingsScreen35 => 'بلافاصله هنگام خروج';

  @override
  String get settingsScreen36 => 'پس از ۱ دقیقه';

  @override
  String get settingsScreen37 => 'پس از ۵ دقیقه';

  @override
  String get settingsScreen38 => 'پس از ۱۵ دقیقه';

  @override
  String get settingsScreen39 => 'متن پیام یادآوری';

  @override
  String get settingsScreen40 => 'ویرایش پیام خودکار با پیش‌نمایش زنده';

  @override
  String get settingsScreen41 => 'جلوگیری از بسته شدن یادآوری‌ها در پس‌زمینه';

  @override
  String get settingsScreen42 =>
      'راهنمای عملی برای گوشی‌های شیائومی، ریلمی و اینفینیکس';

  @override
  String get settingsScreen43 => 'هنوز پشتیبانی تهیه نشده';

  @override
  String get settingsScreen44 => 'آخرین پشتیبان';

  @override
  String get settingsScreen45 => 'خروجی پشتیبان (.kashkool)';

  @override
  String get settingsScreen46 =>
      'یک نسخه از دفتر و عکس‌ها ذخیره و از طریق واتس‌اپ یا درایو بفرستید';

  @override
  String get settingsScreen47 => 'پشتیبان تهیه شد 👍';

  @override
  String settingsScreen48(Object e) {
    return 'خطا در خروجی: $e';
  }

  @override
  String get settingsScreen49 => 'بازیابی پشتیبان';

  @override
  String get settingsScreen50 => 'بازیابی حساب‌ها و عکس‌ها از فایل .kashkool';

  @override
  String get settingsScreen51 => 'فایل نامعتبر ❌';

  @override
  String get settingsScreen52 => 'این فایل پشتیبان معتبر کشکول نیست.';

  @override
  String get settingsScreen53 => 'باشه';

  @override
  String get settingsScreen54 => 'تأیید بازیابی';

  @override
  String get settingsScreen55 =>
      'توجه: بازیابی همه داده‌های فعلی برنامه را با داده‌های فایل جایگزین می‌کند.';

  @override
  String settingsScreen56(Object exportedAt) {
    return 'تاریخ پشتیبان: $exportedAt';
  }

  @override
  String settingsScreen57(Object photosCount) {
    return 'تعداد عکس‌ها: $photosCount';
  }

  @override
  String settingsScreen58(Object fileSizeBytes) {
    return 'حجم فایل: $fileSizeBytes KB';
  }

  @override
  String get settingsScreen59 => 'بله، جایگزین و بازیابی کن';

  @override
  String get settingsScreen60 => 'بازیابی انجام شد 🎉';

  @override
  String get settingsScreen61 =>
      'همه حساب‌ها، تراکنش‌ها و عکس‌ها بازیابی شد. برای به‌روزرسانی صفحات، برنامه را دوباره باز کنید.';

  @override
  String get settingsScreen62 => 'راه‌اندازی مجدد';

  @override
  String settingsScreen63(Object e) {
    return 'خطا در بازیابی: $e';
  }

  @override
  String get settingsScreen64 => 'تیره 🌙';

  @override
  String get settingsScreen65 => 'روشن ☀️';

  @override
  String get settingsScreen66 => 'خودکار';

  @override
  String get settingsScreen67 => 'ظاهر برنامه';

  @override
  String get settingsScreen68 => 'خودکار (مطابق گوشی)';

  @override
  String get settingsScreen69 => 'تعیین نشده';

  @override
  String get settingsScreen70 => 'سقف بدهی پیش‌فرض مشتری جدید';

  @override
  String get settingsScreen71 => 'تماس با ما در واتس‌اپ';

  @override
  String get settingsScreen72 => 'پیشنهادها و پشتیبانی مستقیم';

  @override
  String get settingsScreen73 =>
      'https://wa.me/201005083126?text=سلام%20درباره%20کشکول%20سؤال%20دارم';

  @override
  String get settingsScreen74 => 'حریم خصوصی و شرایط استفاده';

  @override
  String get settingsScreen75 =>
      'داده‌ها مال شماست و فقط روی گوشی شما، بدون اینترنت، ذخیره می‌شود';

  @override
  String get settingsScreen76 => 'سیاست حریم خصوصی کشکول 🔒';

  @override
  String get settingsScreen77 =>
      '۱. کشکول کاملاً بدون اینترنت کار می‌کند (Offline-First).\n\n۲. همه حساب‌ها، نام‌ها، شماره‌ها، عکس فاکتورها و تراکنش‌ها فقط روی دستگاه شما ذخیره می‌شود و هیچ داده‌ای به سرور خارجی ارسال نمی‌شود.\n\n۳. مسئولیت تهیه منظم پشتیبان (خروجی پشتیبان) برای حفظ داده‌ها هنگام تعویض یا گم شدن گوشی با شماست.\n\n۴. کشکول برای مغازه‌داران و تاجران ساخته شده تا طلب‌هایشان حفظ و بدهی‌ها با امنیت پیگیری شود.';

  @override
  String get settingsScreen78 => 'سیستم (خودکار)';

  @override
  String get settingsScreen79 => 'سقف بدهی پیش‌فرض (EGP)';

  @override
  String get settingsScreen80 => 'مبلغ به EGP';

  @override
  String get settingsScreen81 => 'برای بدون سقف خالی بگذارید';

  @override
  String get settingsScreen82 => 'ذخیره';

  @override
  String batteryGuideBottomSheet1(Object brandName) {
    return 'راهنمای اعلان‌ها ($brandName)';
  }

  @override
  String get batteryGuideBottomSheet2 => 'راهنمای فعال ماندن یادآوری‌ها';

  @override
  String get batteryGuideBottomSheet3 =>
      'برخی گوشی‌ها (مثل شیائومی، ریلمی، اینفینیکس و هواوی) برای صرفه‌جویی در باتری برنامه‌ها را در پس‌زمینه می‌بندند. برای دریافت به‌موقع یادآوری‌ها این مراحل را انجام دهید:';

  @override
  String get batteryGuideBottomSheet4 => 'باز کردن تنظیمات باتری';

  @override
  String get backupReminderBanner1 => 'پشتیبان تهیه شد 👍';

  @override
  String backupReminderBanner2(Object e) {
    return 'خطا در پشتیبان‌گیری: $e';
  }

  @override
  String get backupReminderBanner3 => 'وقت تهیه پشتیبان است ⚠️';

  @override
  String get backupReminderBanner4 =>
      'بیش از ۷ روز از آخرین پشتیبان گذشته. داده‌ها را ذخیره کنید تا با گم شدن یا تعویض گوشی چیزی از دست نرود.';

  @override
  String get backupReminderBanner5 => 'فعلاً نه';

  @override
  String get backupReminderBanner6 => 'در حال ذخیره...';

  @override
  String get backupReminderBanner7 => 'پشتیبان‌گیری همین حالا';

  @override
  String get homeWidgetSettingsCard1 => 'نمایش حساب‌ها در صفحه اصلی';

  @override
  String get homeWidgetSettingsCard2 =>
      'ویجت طلب شما و وصولی امروز را بدون باز کردن برنامه نشان می‌دهد';

  @override
  String get homeWidgetSettingsCard3 => 'ویجت خاموش است و عددی نشان نمی‌دهد';

  @override
  String get homeWidgetSettingsCard4 => 'افزودن ویجت کوچک';

  @override
  String get homeWidgetSettingsCard5 => 'فقط طلب شما از مشتریان';

  @override
  String get homeWidgetSettingsCard6 => 'افزودن ویجت خلاصه امروز';

  @override
  String get homeWidgetSettingsCard7 =>
      'طلب + وصولی امروز + سررسیدها + دکمه وصول';

  @override
  String get homeWidgetSettingsCard8 =>
      'برای افزودن ویجت، پیام نمایش‌داده‌شده را تأیید کنید 👍';

  @override
  String get homeWidgetSettingsCard9 => 'ویجت را دستی اضافه کنید 📱';

  @override
  String get homeWidgetSettingsCard10 =>
      'گوشی شما اجازه افزودن خودکار نمی‌دهد. این کار را بکنید:\n\n۱. روی جای خالی صفحه اصلی انگشت نگه دارید\n۲. «ابزارک‌ها» یا «Widgets» را انتخاب کنید\n۳. «کشکول» را پیدا کرده و ویجت را به صفحه بکشید';

  @override
  String get messageTemplateEditorBottomSheet1 => 'بقالی امانت';

  @override
  String get messageTemplateEditorBottomSheet2 => 'ودافون کش: 01012345678';

  @override
  String get messageTemplateEditorBottomSheet3 => 'محمد احمدی';

  @override
  String get messageTemplateEditorBottomSheet4 => 'قالب پیام ذخیره شد 👍';

  @override
  String get messageTemplateEditorBottomSheet5 => 'ویرایش پیام یادآوری 💬';

  @override
  String get messageTemplateEditorBottomSheet6 => 'قالب‌های آماده: ';

  @override
  String get messageTemplateEditorBottomSheet7 => 'دوستانه 😊';

  @override
  String get messageTemplateEditorBottomSheet8 => 'رسمی 👔';

  @override
  String get messageTemplateEditorBottomSheet9 => 'نام مغازه';

  @override
  String get messageTemplateEditorBottomSheet10 => 'اطلاعات پرداخت';

  @override
  String get messageTemplateEditorBottomSheet11 => 'تاریخ آخرین تراکنش';

  @override
  String get messageTemplateEditorBottomSheet12 =>
      'متن پیام یادآوری را اینجا بنویسید...';

  @override
  String get messageTemplateEditorBottomSheet13 => 'پیش‌نمایش پیام برای مشتری:';

  @override
  String get messageTemplateEditorBottomSheet14 => 'ذخیره قالب';

  @override
  String shopProfileBottomSheet1(Object trim) {
    return 'کیف پول: $trim';
  }

  @override
  String get shopProfileBottomSheet2 => 'اطلاعات مغازه ذخیره شد 👍';

  @override
  String get shopProfileBottomSheet3 => 'نام مغازه *';

  @override
  String get shopProfileBottomSheet4 => 'مثلاً: بقالی امانت';

  @override
  String get shopProfileBottomSheet5 => 'لطفاً نام مغازه را وارد کنید';

  @override
  String get shopProfileBottomSheet6 => 'تلفن مغازه';

  @override
  String get shopProfileBottomSheet7 => 'مثلاً: 010xxxxxxxx';

  @override
  String get shopProfileBottomSheet8 => 'آدرس مغازه';

  @override
  String get shopProfileBottomSheet9 => 'مثلاً: خیابان بازار، کنار مسجد بزرگ';

  @override
  String get shopProfileBottomSheet10 => 'حساب InstaPay';

  @override
  String get shopProfileBottomSheet11 => 'مثلاً: name@instapay';

  @override
  String get shopProfileBottomSheet12 => 'شماره ودافون کش / کیف پول';

  @override
  String get shopProfileBottomSheet13 => 'نوع کسب‌وکار';

  @override
  String get shopProfileBottomSheet14 => 'کسب‌وکار دیگر 🏪';

  @override
  String get shopProfileBottomSheet15 => 'فعال‌سازی اقساط';

  @override
  String get shopProfileBottomSheet16 => 'نمایش دکمه اقساط و جدول پرداخت';

  @override
  String get shopProfileBottomSheet17 => 'ذخیره تغییرات';

  @override
  String get cloudAccountButton1 => 'حساب شما و پشتیبان ابری ☁️';

  @override
  String get cloudAccountButton2 => 'پشتیبان ابری';

  @override
  String get cloudAccountButton3 => 'ورود با گوگل';

  @override
  String get cloudBackupCard1 => 'یک لحظه…';

  @override
  String get cloudBackupCard2 => 'مشکلی پیش آمد، دوباره تلاش کنید';

  @override
  String get cloudBackupCard3 => 'در حال باز کردن حساب‌های گوگل…';

  @override
  String cloudBackupCard4(Object email) {
    return 'با $email وارد شدید ✓';
  }

  @override
  String get cloudBackupCard5 => 'پشتیبان با هشدار بارگذاری شد ⚠️';

  @override
  String cloudBackupCard6(Object uploaded, Object rejected, Object n) {
    return '$uploaded رکورد بارگذاری و $rejected رکورد رد شد:\n\n$n';
  }

  @override
  String get cloudBackupCard7 => 'همه داده‌ها از قبل در فضای ابری است ✓';

  @override
  String cloudBackupCard8(Object uploaded) {
    return '$uploaded رکورد در فضای ابری بارگذاری شد ✓';
  }

  @override
  String get cloudBackupCard9 => 'در حال دریافت مغازه‌های حساب شما…';

  @override
  String get cloudBackupCard10 => 'هنوز پشتیبان ابری برای این حساب نیست';

  @override
  String get cloudBackupCard11 => 'انتخاب مغازه';

  @override
  String get cloudBackupCard12 => ' (کارمند)';

  @override
  String get cloudBackupCard13 => 'بازیابی از فضای ابری؟';

  @override
  String cloudBackupCard14(Object name) {
    return 'نسخه «$name» را از فضای ابری دانلود و به این گوشی اضافه می‌کنیم.\n\n';
  }

  @override
  String get cloudBackupCard15 =>
      'چیزی حذف نمی‌شود: داده‌هایی که فقط روی این گوشی است باقی می‌ماند و تغییرات بعد از آخرین پشتیبان دست‌نخورده می‌ماند.';

  @override
  String get cloudBackupCard16 => 'بله، بازیابی کن';

  @override
  String get cloudBackupCard17 => 'بازیابی شد 🎉';

  @override
  String cloudBackupCard18(Object keptLocal) {
    return ' و $keptLocal رکورد دست‌نخورده ماند چون نسخه گوشی جدیدتر است';
  }

  @override
  String cloudBackupCard19(Object records, Object keptLocal) {
    return '$records رکورد بازیابی شد$keptLocal.';
  }

  @override
  String get cloudBackupCard20 =>
      ' برای به‌روزرسانی صفحات، برنامه را ببندید و دوباره باز کنید.';

  @override
  String get cloudBackupCard21 => 'بستن برنامه';

  @override
  String get cloudBackupCard22 => 'خروج از حساب؟';

  @override
  String get cloudBackupCard23 =>
      'داده‌ها روی گوشی و فضای ابری می‌ماند، اما تا ورود دوباره پشتیبان‌گیری متوقف می‌شود.';

  @override
  String get cloudBackupCard24 => 'خروج';

  @override
  String get cloudBackupCard25 => 'در این نسخه از برنامه در دسترس نیست';

  @override
  String get cloudBackupCard26 => 'پشتیبان‌گیری ابری';

  @override
  String get cloudBackupCard27 =>
      'با گوگل وارد شوید تا داده‌ها آنلاین ذخیره شود. اگر گوشی گم شد، روی هر گوشی دیگری بازیابی کنید.';

  @override
  String get cloudBackupCard28 => 'هنوز پشتیبانی نیست';

  @override
  String cloudBackupCard29(Object last) {
    return 'آخرین پشتیبان: $last';
  }

  @override
  String get cloudBackupCard30 => 'در حال بارگذاری…';

  @override
  String get cloudBackupCard31 =>
      'در انتظار اینترنت — با وصل شدن خودکار بارگذاری می‌شود';

  @override
  String get cloudBackupCard32 =>
      'بارگذاری متوقف شد، کمی بعد دوباره تلاش می‌کنیم';

  @override
  String get cloudBackupCard33 => 'همه چیز بارگذاری شده ✓';

  @override
  String get cloudBackupCard34 => 'هنگام اتصال، خودکار بارگذاری می‌شود';

  @override
  String get cloudBackupCard35 => 'همین حالا پشتیبان بگیر';

  @override
  String get cloudBackupCard36 => 'بازیابی داده‌ها روی این گوشی';

  @override
  String get cloudBackupCard37 =>
      'برای گوشی جدید یا پس از نصب دوباره — چیزی حذف نمی‌کند';

  @override
  String get cloudBackupCard38 => 'خروج از حساب';

  @override
  String get onboardingScreen1 => 'مغازه من';

  @override
  String get onboardingScreen2 =>
      'مشتریان نمونه برای امتحان برنامه اضافه شدند؛ هر وقت خواستید حذفشان کنید';

  @override
  String get onboardingScreen3 => 'راه‌اندازی کشکول';

  @override
  String get onboardingScreen4 => 'ادامه: نوع کسب‌وکار';

  @override
  String get onboardingScreen5 => 'به کشکول خوش آمدید! 👋';

  @override
  String get onboardingScreen6 =>
      'دفتر دیجیتال ساده برای بدهی‌ها، یادآوری واتس‌اپ و اقساط.';

  @override
  String get onboardingScreen7 => 'نام مغازه *';

  @override
  String get onboardingScreen8 => 'مثلاً: بقالی امانت / موبایل ستاره';

  @override
  String get onboardingScreen9 => 'نام مغازه را بنویسید (حداقل ۲ حرف)';

  @override
  String get onboardingScreen10 => 'تلفن مغازه (اختیاری)';

  @override
  String get onboardingScreen11 =>
      'در فاکتورها، صورت‌حساب‌ها و پیام‌های واتس‌اپ نمایش داده می‌شود';

  @override
  String get onboardingScreen12 => 'بقالی و سوپرمارکت';

  @override
  String get onboardingScreen13 => 'بدهی‌های روزانه و بستن سریع صندوق';

  @override
  String get onboardingScreen14 => 'موبایل و لوازم جانبی';

  @override
  String get onboardingScreen15 =>
      'اطلاعات دستگاه‌ها با فعال‌سازی خودکار اقساط';

  @override
  String get onboardingScreen16 => 'لوازم برقی و خانگی';

  @override
  String get onboardingScreen17 =>
      'قراردادهای فروش نسیه با فعال‌سازی خودکار اقساط';

  @override
  String get onboardingScreen18 => 'داروخانه و آرایشی';

  @override
  String get onboardingScreen19 => 'سقف بدهی و پیگیری بدهی نسخه‌ها';

  @override
  String get onboardingScreen20 => 'سایر کسب‌وکارها';

  @override
  String get onboardingScreen21 => 'دفتری انعطاف‌پذیر برای هر نوع کسب‌وکار';

  @override
  String get onboardingScreen22 => 'نوع کسب‌وکار شما چیست؟';

  @override
  String get onboardingScreen23 => 'برنامه را متناسب با کار شما تنظیم می‌کنیم.';

  @override
  String get onboardingScreen24 => 'پشتیبانی از اقساط';

  @override
  String get onboardingScreen25 => 'فعال‌سازی طرح‌های اقساط';

  @override
  String get onboardingScreen26 =>
      'هر زمان از تنظیمات قابل روشن یا خاموش کردن است';

  @override
  String get onboardingScreen27 => 'دریافت مطمئن یادآوری‌ها 🔔';

  @override
  String get onboardingScreen28 =>
      'تا کشکول هر روز وصولی‌ها و اقساط را یادآوری کند:';

  @override
  String get onboardingScreen29 => 'مجوز اعلان‌ها';

  @override
  String get onboardingScreen30 => 'اعلان‌ها فعال شد ✅';

  @override
  String get onboardingScreen31 =>
      'برای ارسال خلاصه روزانه وصولی به مجوز اعلان نیاز داریم';

  @override
  String get onboardingScreen32 => 'اجازه اعلان‌ها';

  @override
  String onboardingScreen33(Object brandName) {
    return 'محافظت در پس‌زمینه ($brandName)';
  }

  @override
  String get onboardingScreen34 => 'جلوگیری از بسته شدن برنامه در پس‌زمینه';

  @override
  String get onboardingScreen35 => 'باز کردن تنظیمات باتری';

  @override
  String get onboardingScreen36 => 'آماده‌اید! 🚀';

  @override
  String get onboardingScreen37 =>
      'اطلاعات مغازه ذخیره شد. چطور می‌خواهید شروع کنید؟';

  @override
  String get onboardingScreen38 => '+ افزودن اولین مشتری واقعی';

  @override
  String get onboardingScreen39 =>
      'اولین مشتری را ثبت و فوراً ثبت بدهی و پرداخت را شروع کنید';

  @override
  String get onboardingScreen40 => 'اول با داده‌های نمونه امتحان کنید 💡';

  @override
  String get onboardingScreen41 =>
      'دو مشتری نمونه برای آشنایی با کشکول اضافه می‌کند (با یک ضربه حذف می‌شوند)';

  @override
  String get onboardingScreen42 => 'رد شدن و رفتن به صفحه اصلی';

  @override
  String get shopRepository1 => 'احمد محمدی (نمونه)';

  @override
  String get shopRepository2 => 'خرید خانگی';

  @override
  String get shopRepository3 => 'محمود ابراهیمی (نمونه)';

  @override
  String get shopRepository4 => 'کالای اول ماه';

  @override
  String get shopRepository5 => 'پرداخت نقدی به حساب';

  @override
  String get supplierWithBalance1 => 'شنبه';

  @override
  String get supplierWithBalance2 => 'یکشنبه';

  @override
  String get supplierWithBalance3 => 'دوشنبه';

  @override
  String get supplierWithBalance4 => 'سه‌شنبه';

  @override
  String get supplierWithBalance5 => 'چهارشنبه';

  @override
  String get supplierWithBalance6 => 'پنجشنبه';

  @override
  String get supplierWithBalance7 => 'جمعه';

  @override
  String get trashScreen1 => 'مشتریان';

  @override
  String get trashScreen2 => 'تراکنش‌ها';

  @override
  String get trashScreen3 => 'تأمین‌کنندگان';

  @override
  String get trashScreen4 => 'هزینه‌ها';

  @override
  String get trashScreen5 => 'اقساط';

  @override
  String trashScreen6(Object title) {
    return '«$title» بازگردانده شد ✓';
  }

  @override
  String get trashScreen7 => 'بازگردانی نشد، دوباره تلاش کنید';

  @override
  String get trashScreen8 => 'سطل زباله 🗑️';

  @override
  String get trashScreen9 =>
      'هر چه حذف کنید به اینجا می‌آید و از بین نمی‌رود. هر وقت بخواهید بازمی‌گردانید و در پشتیبان ابری هم برمی‌گردد.';

  @override
  String get trashScreen10 => 'بارگذاری موارد حذف‌شده ناموفق بود';

  @override
  String get trashScreen11 => 'سطل خالی است ✨';

  @override
  String trashScreen12(Object deletedAt) {
    return 'حذف‌شده $deletedAt';
  }

  @override
  String get trashScreen13 => 'بازگردانی';

  @override
  String get trashScreen14 => 'سطل زباله';

  @override
  String get trashScreen15 => 'مشاهده و بازگردانی موارد حذف‌شده';

  @override
  String trashScreen16(Object count) {
    return '$count مورد — قابل بازگردانی';
  }

  @override
  String get trashRepository1 => 'اجاره';

  @override
  String get trashRepository2 => 'برق';

  @override
  String get trashRepository3 => 'حقوق';

  @override
  String get trashRepository4 => 'لوازم';

  @override
  String get trashRepository5 => 'پرداخت به تأمین‌کننده';

  @override
  String get trashRepository6 => 'هزینه';

  @override
  String get trashRepository7 => 'بدهی من';

  @override
  String get trashRepository8 => 'پرداخت';

  @override
  String get trashRepository9 => 'پرداختم';

  @override
  String get trashRepository10 => 'نامشخص';

  @override
  String trashRepository11(Object itemDescription) {
    return 'اقساط: $itemDescription';
  }

  @override
  String pdfStatementService1(Object sanitizedName, Object dateStr) {
    return 'صورتحساب_${sanitizedName}_$dateStr.pdf';
  }

  @override
  String get pdfStatementService2 => 'صورت‌حساب مشتری';

  @override
  String pdfStatementService3(Object customerName) {
    return 'مشتری: $customerName';
  }

  @override
  String pdfStatementService4(Object phone) {
    return 'تلفن: $phone';
  }

  @override
  String pdfStatementService5(Object periodDescription) {
    return 'دوره: $periodDescription';
  }

  @override
  String get pdfStatementService6 => 'مانده پیش از این دوره:';

  @override
  String get pdfStatementService7 => 'تاریخ';

  @override
  String get pdfStatementService8 => 'شرح';

  @override
  String get pdfStatementService9 => 'مانده';

  @override
  String pdfStatementService10(Object periodDebitsPiasters) {
    return 'مجموع خرید / نسیه: $periodDebitsPiasters';
  }

  @override
  String pdfStatementService11(Object periodCreditsPiasters) {
    return 'مجموع پرداخت: $periodCreditsPiasters';
  }

  @override
  String get pdfStatementService12 => 'مانده نهایی قابل پرداخت:';

  @override
  String pdfStatementService13(Object trim) {
    return 'روش‌های پرداخت: $trim';
  }

  @override
  String get pdfStatementService14 =>
      'ساخته‌شده با کشکول — رایگان امتحان کنید:';

  @override
  String get statementCalculator1 => 'همه تراکنش‌ها';

  @override
  String get statementCalculator2 => 'ژانویه';

  @override
  String get statementCalculator3 => 'فوریه';

  @override
  String get statementCalculator4 => 'مارس';

  @override
  String get statementCalculator5 => 'آوریل';

  @override
  String get statementCalculator6 => 'مه';

  @override
  String get statementCalculator7 => 'ژوئن';

  @override
  String get statementCalculator8 => 'ژوئیه';

  @override
  String get statementCalculator9 => 'اوت';

  @override
  String get statementCalculator10 => 'سپتامبر';

  @override
  String get statementCalculator11 => 'اکتبر';

  @override
  String get statementCalculator12 => 'نوامبر';

  @override
  String get statementCalculator13 => 'دسامبر';

  @override
  String statementCalculator14(Object startDate, Object endDate) {
    return 'از $startDate تا $endDate';
  }

  @override
  String statementCalculator15(Object startDate) {
    return 'از $startDate';
  }

  @override
  String statementCalculator16(Object endDate) {
    return 'تا $endDate';
  }

  @override
  String growthFooter1(Object shopCode) {
    return '—\nساخته‌شده با کشکول 📒 رایگان امتحان کنید: $shopCode';
  }

  @override
  String growthFooter2(Object shopCode) {
    return 'من از کشکول 📒 برای حساب مشتریان، تأمین‌کنندگان و صندوق بدون دفتر کاغذی استفاده می‌کنم.\nخیلی ساده است و بدون اینترنت کار می‌کند. رایگان امتحان کنید:\n$shopCode';
  }

  @override
  String get notificationService1 => 'وصولی روزانه';

  @override
  String get notificationService2 => 'یادآوری مشتریانی که موعد پرداختشان رسیده';

  @override
  String notificationService3(Object dueCount, Object amountStr) {
    return '$dueCount مشتری $amountStr بدهکارند — برای وصول بزنید';
  }

  @override
  String get notificationService4 => 'یادآوری وصولی روزانه 📒';

  @override
  String get backupService1 => 'فایل پایگاه داده پیدا نشد';

  @override
  String backupService2(Object dateStr) {
    return 'پشتیبان کشکول - $dateStr';
  }

  @override
  String get backupService3 => 'فایل انتخاب‌شده وجود ندارد';

  @override
  String get backupService4 => 'فایل خراب یا ناقص است';

  @override
  String get backupService5 => 'قالب فایل نادرست است (فایل کشکول نیست)';

  @override
  String get backupService6 => 'فایل پایگاه داده کشکول ندارد';

  @override
  String get backupService7 => 'پایگاه داده داخل فایل خراب است';

  @override
  String get backupService8 => 'پایگاه داده SQLite معتبر نیست';

  @override
  String get backupService9 => 'فایل پشتیبان نامعتبر است';

  @override
  String get backupService10 => 'فایل پایگاه داده در آرشیو نیست';

  @override
  String get googleAuthService1 => 'پشتیبان ابری در این نسخه تنظیم نشده';

  @override
  String get googleAuthService2 =>
      'گوگل اطلاعات ورود را برنگرداند، دوباره تلاش کنید';

  @override
  String get googleAuthService3 => 'ورود لغو شد';

  @override
  String googleAuthService4(Object codeName) {
    return 'ورود با گوگل ناموفق بود ($codeName)';
  }

  @override
  String get cloudApi1 => 'آدرس سرور در این نسخه تنظیم نشده';

  @override
  String get cloudApi2 => 'ابتدا با گوگل وارد شوید';

  @override
  String get cloudApi3 => 'اینترنت وصل نیست، دوباره تلاش کنید';

  @override
  String get cloudApi4 => 'سرور دیر پاسخ داد، دوباره تلاش کنید';

  @override
  String get cloudApi5 => 'نشست منقضی شد، دوباره با گوگل وارد شوید';

  @override
  String get cloudApi6 => 'این مغازه روی حساب گوگل دیگری ثبت شده';

  @override
  String get cloudApi7 => 'این قابلیت به اشتراک نیاز دارد';

  @override
  String get cloudApi8 => 'تلاش‌های زیاد، کمی صبر کنید و دوباره امتحان کنید';

  @override
  String get cloudApi9 => 'دوباره با گوگل وارد شوید';

  @override
  String get cloudApi10 => 'ورود با گوگل روی سرور تنظیم نشده';

  @override
  String get cloudApi11 => 'مشکل سرور، کمی بعد امتحان کنید';

  @override
  String cloudApi12(Object code) {
    return 'مشکلی پیش آمد ($code)';
  }

  @override
  String get cloudBackupService1 => 'ورود با گوگل در دسترس نیست';

  @override
  String get cloudBackupService2 =>
      'ابتدا اطلاعات مغازه را در تنظیمات کامل کنید';

  @override
  String get cloudBackupService3 => 'در حال آماده‌سازی داده‌های مغازه…';

  @override
  String cloudBackupService4(Object length, Object changesLength) {
    return 'بارگذاری $length از $changesLength…';
  }

  @override
  String get cloudBackupService5 => 'تمام شد ✓';

  @override
  String cloudBackupService6(Object changesLength) {
    return 'در حال دانلود داده‌ها… ($changesLength)';
  }

  @override
  String cloudBackupService7(Object changesLength) {
    return 'ذخیره $changesLength رکورد روی گوشی…';
  }

  @override
  String get cloudBackupService8 => 'مغازه';

  @override
  String autoBackupCoordinator1(Object rejected) {
    return '$rejected رکورد بارگذاری نشد';
  }

  @override
  String get autoBackupCoordinator2 =>
      'مشکلی پیش آمد، کمی بعد دوباره تلاش می‌کنیم';

  @override
  String get customerRating1 => 'مشتری جدید (کمتر از ۳ تراکنش)';

  @override
  String get customerRating2 => 'حسابش تسویه است و به‌موقع پرداخت می‌کند';

  @override
  String customerRating3(Object oldestUnpaidAgeDays) {
    return 'دیرکرد: قدیمی‌ترین بدهی $oldestUnpaidAgeDays روز و سقف رد شده';
  }

  @override
  String get customerRating4 => 'سقف بدهی مشتری رد شده';

  @override
  String get customerRating5 => 'فقط امروز بدهی گرفته و حسابش منظم است';

  @override
  String customerRating6(Object oldestUnpaidAgeDays) {
    return 'قدیمی‌ترین مبلغ فقط $oldestUnpaidAgeDays روز است (محدوده امن)';
  }

  @override
  String customerRating7(Object oldestUnpaidAgeDays) {
    return 'قدیمی‌ترین مبلغ $oldestUnpaidAgeDays روز (بیش از ۴۵ روز تأخیر)';
  }

  @override
  String customerRating8(Object oldestUnpaidAgeDays) {
    return 'قدیمی‌ترین مبلغ $oldestUnpaidAgeDays روز (نیاز به پیگیری)';
  }

  @override
  String get whatsappTemplate1 =>
      'سلام {customer_name} 👋\n{shop_name} هستم.\nمانده فعلی شما: {balance}\nآخرین تراکنش: {last_transaction_date} - {last_transaction_amount}\nبرای پرداخت: {payment_info}\nممنون از همراهی شما 🙏';

  @override
  String get whatsappTemplate2 =>
      '{customer_name} گرامی،\nیادآوری می‌کنیم که مانده حساب شما نزد {shop_name} برابر {balance} است.\nآخرین تراکنش ثبت‌شده: {last_transaction_date} ({last_transaction_amount})\nروش‌های پرداخت: {payment_info}\nبا سپاس.';

  @override
  String get whatsappTemplate3 =>
      'سلام {customer_name} 👋\n{shop_name} هستم.\nیادآوری سررسید قسط ({item}) — قسط {installment_number} از {installment_count}:\nمبلغ قسط: {amount}\nتاریخ سررسید: {due_date}\nجمع باقی‌مانده: {remaining_total}\nروش‌های پرداخت: {payment_info}\nممنون از خوش‌حسابی شما 🙏';

  @override
  String get whatsappTemplate4 => 'نقدی در مغازه یا انتقال موجود';

  @override
  String get money1 => 'EGP';

  @override
  String get batteryOptimizationHelper1 => 'XOS / HiOS';

  @override
  String get batteryOptimizationHelper2 => 'برنامه Phone Master را باز کنید.';

  @override
  String get batteryOptimizationHelper3 =>
      'وارد «مدیریت اجرای خودکار (Auto-start)» شوید و کشکول را فعال کنید.';

  @override
  String get batteryOptimizationHelper4 =>
      'در تنظیمات برنامه، «باتری» را باز و «بدون محدودیت» را انتخاب کنید.';

  @override
  String get batteryOptimizationHelper5 =>
      'در برنامه‌های اخیر، برنامه را به پایین بکشید تا قفل شود 🔒.';

  @override
  String get batteryOptimizationHelper6 => 'MIUI / HyperOS';

  @override
  String get batteryOptimizationHelper7 =>
      'تنظیمات برنامه را باز و «اجرای خودکار» را فعال کنید.';

  @override
  String get batteryOptimizationHelper8 =>
      'در «صرفه‌جویی باتری»، «بدون محدودیت» را انتخاب کنید.';

  @override
  String get batteryOptimizationHelper9 =>
      'در برنامه‌های اخیر، روی کشکول انگشت نگه دارید و آیکون قفل را بزنید 🔒.';

  @override
  String get batteryOptimizationHelper10 => 'ColorOS / Realme UI';

  @override
  String get batteryOptimizationHelper11 =>
      'تنظیمات برنامه -> مصرف باتری، «اجازه فعالیت در پس‌زمینه» را فعال کنید.';

  @override
  String get batteryOptimizationHelper12 =>
      '«اجرای خودکار (Auto-launch)» را فعال کنید.';

  @override
  String get batteryOptimizationHelper13 =>
      'در برنامه‌های اخیر، سه‌نقطه را بزنید و «قفل» را انتخاب کنید.';

  @override
  String get batteryOptimizationHelper14 => 'One UI';

  @override
  String get batteryOptimizationHelper15 =>
      'به تنظیمات -> مراقبت از دستگاه -> باتری بروید.';

  @override
  String get batteryOptimizationHelper16 =>
      '«محدودیت‌های استفاده در پس‌زمینه» را باز کنید.';

  @override
  String get batteryOptimizationHelper17 =>
      'کشکول را به «برنامه‌هایی که هرگز نمی‌خوابند» اضافه کنید.';

  @override
  String get batteryOptimizationHelper18 => 'EMUI / MagicOS';

  @override
  String get batteryOptimizationHelper19 =>
      'به تنظیمات -> باتری -> اجرای برنامه بروید.';

  @override
  String get batteryOptimizationHelper20 =>
      '«کشکول» را پیدا کنید، مدیریت را دستی کنید و اجرای خودکار و اجرا در پس‌زمینه را فعال کنید.';

  @override
  String get batteryOptimizationHelper21 => 'تنظیمات سیستم';

  @override
  String get batteryOptimizationHelper22 => 'محافظت از اعلان‌های سیستم';

  @override
  String get batteryOptimizationHelper23 =>
      'اطلاعات برنامه را در تنظیمات گوشی باز کنید.';

  @override
  String get batteryOptimizationHelper24 =>
      '«باتری» را باز و «بدون محدودیت» را انتخاب کنید.';

  @override
  String get batteryOptimizationHelper25 =>
      'مطمئن شوید حالت صرفه‌جویی شدید انرژی خاموش است تا یادآوری‌ها برسد.';

  @override
  String get homeWidgetService1 => 'هیچ';

  @override
  String get homeWidgetService2 => '۱ مشتری';

  @override
  String get homeWidgetService3 => '۲ مشتری';

  @override
  String homeWidgetService4(Object count) {
    return '$count مشتری';
  }

  @override
  String get pinLockScreen1 => 'PIN اشتباه است، دوباره تلاش کنید';

  @override
  String get pinLockScreen2 => 'PINها یکسان نیستند، دوباره تلاش کنید';

  @override
  String get pinLockScreen3 => 'اثر انگشت در دسترس نیست یا تنظیم نشده';

  @override
  String get pinLockScreen4 => 'به کشکول خوش آمدید 📒';

  @override
  String get pinLockScreen5 => 'تنظیم PIN جدید';

  @override
  String get pinLockScreen6 => 'برای تأیید PIN را دوباره وارد کنید';

  @override
  String get pinLockScreen7 => 'PIN چهاررقمی را وارد کنید';

  @override
  String get pinLockScreen8 =>
      '۴ رقم که یادتان می‌ماند برای قفل برنامه بنویسید';

  @override
  String get pinLockScreen9 => 'همان ارقام را دوباره بنویسید';

  @override
  String get pinLockScreen10 => 'اثر انگشت';

  @override
  String get pinLockScreen11 => 'پاک کردن';

  @override
  String get securityService1 => 'برای باز کردن کشکول هویت خود را تأیید کنید';

  @override
  String get settingsLanguageTitle => 'زبان';

  @override
  String get settingsLanguageSystem => 'زبان گوشی (خودکار)';

  @override
  String get cloudDeleteAccountTitle => 'حذف حساب ابری من';

  @override
  String get cloudDeleteAccountSubtitle =>
      'پشتیبان‌های ابری و حساب را برای همیشه حذف می‌کند — داده‌های گوشی می‌ماند';

  @override
  String get cloudDeleteAccountConfirmTitle => 'حساب برای همیشه حذف شود؟';

  @override
  String get cloudDeleteAccountConfirmBody =>
      'حساب شما و همه پشتیبان‌های ابری مغازه‌هایتان حذف می‌شود و قابل بازگشت نیست. داده‌های این گوشی همان‌طور می‌ماند.';

  @override
  String get cloudDeleteAccountConfirmButton => 'حذف دائمی';

  @override
  String get cloudDeleteAccountDone => 'حساب ابری شما حذف شد';

  @override
  String get authFirstTimeTitle => 'به کاشکول خوش آمدید! 👋';

  @override
  String get authFirstTimeQuestion => 'از قبل حساب دارید یا کاربر جدید هستید؟';

  @override
  String get authHaveAccount => 'از قبل حساب دارم';

  @override
  String get authHaveAccountSubtitle =>
      'وارد شوید تا بلافاصله تمام اطلاعات مغازیتان برگردد';

  @override
  String get authNewUser => 'کاربر جدید';

  @override
  String get authNewUserSubtitle =>
      'کاشکول تازهای شروع کنید و مغازیتان را گام به گام آماده کنید';

  @override
  String get authContinueGuest => 'ادامه بهعنوان مهمان (بدون حساب)';

  @override
  String get authContinueGuestSubtitle =>
      'از برنامه بهصورت محلی و کاملاً بدون اینترنت استفاده کنید';

  @override
  String get authLogin => 'ورود';

  @override
  String get authRegister => 'ایجاد حساب جدید';

  @override
  String get authEmail => 'ایمیل';

  @override
  String get authPassword => 'رمز عبور';

  @override
  String get authPasswordConfirm => 'تأیید رمز عبور';

  @override
  String get authNameOptional => 'نام (اختیاری)';

  @override
  String get authLoginButton => 'ورود';

  @override
  String get authRegisterButton => 'ایجاد حساب';

  @override
  String get authOrGoogle => 'یا ادامه با حساب Google';

  @override
  String get authSignInWithGoogle => 'ورود با حساب Google';

  @override
  String get authSignInWithGoogleSubtitle =>
      'همگامسازی ابری و بازیافت خودکار اطلاعات مغازیتان';

  @override
  String get authSwitchAccount => 'تغییر حساب';

  @override
  String get authSwitchAccountSubtitle =>
      'حساب دیگری انتخاب یا با حساب تازهای وارد شوید';

  @override
  String get authAddAccount => '+ ورود با حساب دیگر';

  @override
  String get authCurrentAccount => 'حساب فعال فعلی';

  @override
  String get authPasswordsDontMatch => 'دو رمز عبور یکسان نیستند';

  @override
  String get authPasswordTooShort => 'رمز عبور باید حداقل ۶ کاراکتر باشد';

  @override
  String get authInvalidEmail => 'ایمیل معتبری وارد کنید';

  @override
  String get authLoginSuccess => 'ورود با موفقیت انجام شد 🎉';

  @override
  String get authRegisterSuccess => 'حساب با موفقیت ایجاد شد 🎉';

  @override
  String authSwitchedTo(Object email) {
    return 'تغییر به حساب: $email';
  }

  @override
  String get cloudApiEmailTaken =>
      'این ایمیل از قبل ثبت شده، سعی کنید وارد شوید';

  @override
  String get cloudApiInvalidCredentials => 'ایمیل یا رمز عبور اشتباه است';

  @override
  String get authBackupBeforeSwitchTitle => 'هشدار: اطلاعات ذخیرهنشده!';

  @override
  String get authBackupBeforeSwitchBody =>
      'اطلاعاتی وجود دارد که نسخهای از آنها روی ابر برای این حساب ذخیره نشده است. اگر الان حساب را تغییر دهید، اطلاعات محلی پاک میشوند و مگر اینکه اول نسخه پشتیبان بگیرید، نمیتوانید آنها را برگردانید.';

  @override
  String get authBackupFirst => 'اول نسخه پشتیبان بگیرید';

  @override
  String get authSwitchWithoutBackup => 'تغییر حساب و پاک کردن اطلاعات محلی';

  @override
  String get authFetchingData => 'در حال دریافت اطلاعات شما از ابر…';

  @override
  String get authEmailLoginButton => 'ورود با ایمیل';

  @override
  String get authEmailRegisterButton => 'ایجاد حساب جدید با ایمیل';

  @override
  String get authWipingData => 'در حال پاک کردن اطلاعات محلی و تغییر حساب…';

  @override
  String get offersBroadcasterTitle => 'پیامهای تبلیغاتی و تبریک';

  @override
  String get offersBroadcasterSubtitle =>
      'پیشنهادها و تبریکهایتان را با یک ضربه و بدون هزینه از طریق واتساپ برای مشتریان بفرستید';

  @override
  String get offersTemplateSection => '۱. قالب را انتخاب کنید';

  @override
  String get offersAudienceSection => '۲. مخاطبان مورد نظر را انتخاب کنید';

  @override
  String get offersMessageSection => '۳. متن پیام و پیشنمایش';

  @override
  String get offersTemplateRamadan => 'رمضان مبارک 🌙';

  @override
  String get offersTemplateEid => 'عید مبارک 🎉';

  @override
  String get offersTemplateBackToSchool => 'آغاز سال تحصیلی 📚';

  @override
  String get offersTemplateNewOffer => 'پیشنهادهای جدید 🎁';

  @override
  String get offersTemplateCustom => 'پیام دلخواه ✍️';

  @override
  String get offersAudienceAllWithPhone => 'همه مشتریان دارای شماره تلفن';

  @override
  String get offersAudienceGoodRating => 'مشتریان خوشحساب (سبز)';

  @override
  String get offersAudienceActive30Days => 'فعالهای ۳۰ روز اخیر';

  @override
  String get offersAudienceManual => 'انتخاب دستی دلخواه';

  @override
  String get offersTipSpam =>
      '💡 نکته: بهتر است در هر بار بیشتر از ۵۰ مشتری را در کمپین قرار ندهید تا با محدودیتهای واتساپ روبهرو نشوید.';

  @override
  String offersStartCampaign(Object count) {
    return 'شروع صف ارسال ($count مشتری)';
  }

  @override
  String offersResumeCampaign(Object pending) {
    return 'ادامه کمپین قبلی ($pending باقیمانده)';
  }

  @override
  String get offersDiscardCampaign => 'شروع کمپین جدید بهجای آن';

  @override
  String get offersQueueTitle => 'صف ارسال';

  @override
  String offersProgressLabel(Object sent, Object total, Object percent) {
    return 'ارسال $sent از $total مشتری ($percent%)';
  }

  @override
  String get offersSendViaWhatsApp => 'ارسال از طریق واتساپ';

  @override
  String get offersSkipCustomer => 'رد شدن از مشتری';

  @override
  String get offersPauseQueue => 'توقف موقت و بازگشت';

  @override
  String get offersCampaignCompleteTitle => 'با موفقیت تمام شد! 🎉';

  @override
  String get offersCampaignCompleteSubtitle =>
      'تمام پیامهای انتخابشده برای مشتریان با موفقیت ارسال شد.';

  @override
  String get offersNoRecipients =>
      'هیچ مشتریای وجود ندارد که هم با فیلتر انتخابشده مطابقت داشته و هم شماره تلفن داشته باشد';

  @override
  String offersSelectManualCustomers(Object count) {
    return 'انتخاب مشتریان ($count انتخابشده)';
  }

  @override
  String get offersSampleCustomerName => 'محمد احمد';

  @override
  String get offersInsertPlaceholderHint => 'برای درج متغیر در پیام فشار دهید:';

  @override
  String get offersDefaultRamadanText =>
      'سال مبارک جناب {customer_name} به مناسبت ماه مبارک رمضان، از طرف {shop_name} برای شما و خانوادتان ماهی مبارک آرزو میکنیم 🌙✨';

  @override
  String get offersDefaultEidText =>
      'عید مبارک بر شما و خانوادتان جناب {customer_name}، هر ساله در سلامت و خوشی باشید، از طرف {shop_name} 🎉🐑';

  @override
  String get offersDefaultBackToSchoolText =>
      'سال تحصیلی جدیدی پر از موفقیت و خوشی برای فرزندانمان جناب {customer_name}، تمام آنچه نیاز دارید در {shop_name} موجود است 📚✏️';

  @override
  String get offersDefaultNewOfferText =>
      'سلام جناب {customer_name}! پیشنهادها و تخفیفهای ویژهای برایتان در {shop_name} داریم، خوشحال میشویم هر وقتی مایل بودید سر بزنید 🎁🔥';

  @override
  String get offersDefaultCustomText =>
      'سلام جناب {customer_name}، درود ما از طرف {shop_name} بر شما 👋';

  @override
  String offersSentSuccessPrompt(Object name) {
    return 'آیا پیام به $name با موفقیت ارسال شد؟';
  }

  @override
  String get offersYesSent => 'بله، ارسال شد';

  @override
  String get offersNotSent => 'ارسال نشد';

  @override
  String get offersPreviewCardTitle => 'پیشنمایش پیام برای مشتری';

  @override
  String get offersIncludeGrowthFooter => 'اضافه کردن امضای کاشکول به آخر پیام';

  @override
  String offersCampaignActiveBanner(Object sent, Object total) {
    return 'شما یک کمپین ناتمام قبلی دارید ($sent از $total ارسالشده)';
  }

  @override
  String get notificationServiceInstallmentsChannelName => 'یادآوری اقساط';

  @override
  String get notificationServiceInstallmentsChannelDesc =>
      'هشدارهایی درباره سررسید اقساط پرداختنی و عقبافتاده';

  @override
  String get notificationServiceInstallmentsTitle => 'هشدار اقساط سررسیدشده 🔔';

  @override
  String notificationServiceInstallmentsBody(Object count, Object amountStr) {
    return '$count قسط سررسیدشده به مبلغ کل $amountStr — برای ادامه فشار دهید';
  }

  @override
  String get notificationServiceBackupChannelName => 'یادآوری نسخه پشتیبان';

  @override
  String get notificationServiceBackupChannelDesc =>
      'یادآوری منظم برای ذخیره اطلاعات دفترتان و جلوگیری از گم شدن آنها';

  @override
  String get notificationServiceBackupTitle =>
      'هشدار: باید نسخه پشتیبان بگیرید ⚠️';

  @override
  String notificationServiceBackupBody(Object days) {
    return '$days روز از آخرین نسخه پشتیبان گذشته است. اکنون برای ذخیره اطلاعاتتان فشار دهید.';
  }

  @override
  String get notificationServiceTestTitle => 'اعلان آزمایشی از کاشکول 🚀';

  @override
  String get notificationServiceTestBody =>
      'اعلانها کاملاً کار میکند و بهموقع به دستتان میرسد 👍';

  @override
  String get notificationServiceSettingsReminderTime => 'زمان یادآوری روزانه';

  @override
  String get notificationServiceSettingsReminderTimeSubtitle =>
      'زمان مشخص روزانه برای یادآوری وصولطلبیها و اقساط سررسیدشده';

  @override
  String get notificationServiceSettingsStatus => 'اعلانهای برنامه';

  @override
  String get notificationServiceSettingsStatusActive =>
      'فعال و بهدرستی کار میکند ✓';

  @override
  String get notificationServiceSettingsStatusDisabled =>
      'خاموش — برای دادن اجازه فشار دهید';

  @override
  String get notificationServiceSettingsSendTest => 'ارسال اعلان آزمایشی اکنون';

  @override
  String get notificationServiceSettingsSendTestSubtitle =>
      'بلافاصله بررسی کنید که اعلانها و صدای هشدار روی گوشیتان نمایش داده میشود';

  @override
  String get notificationServiceSettingsSendTestSuccess =>
      'اعلان آزمایشی ارسال شد! نوار اعلانها را بررسی کنید 👍';

  @override
  String get notificationServiceDailyScheduledTitle => 'وقت دریافت 💰';

  @override
  String get notificationServiceDailyScheduledBody =>
      'برای دیدن مشتریان بدهکار امروز، کشکول را باز کنید';

  @override
  String get navHome => 'خانه';

  @override
  String get moreSectionShop => 'ابزارهای فروشگاه';

  @override
  String get moreSectionApp => 'ارتباطات و تنظیمات';

  @override
  String get moreInventorySubtitle => 'محصولات، قیمت‌ها و موجودی';

  @override
  String get moreCashDrawerSubtitle => 'بستن روز و هزینه‌ها';

  @override
  String get moreInstallmentsTitle => 'اقساط';

  @override
  String get moreInstallmentsSubtitle => 'طرح‌های اقساط و تاریخ پرداخت';

  @override
  String get moreOffersSubtitle => 'پیشنهادها و تبریک‌ها به مشتریان';

  @override
  String get moreSettingsSubtitle => 'اطلاعات فروشگاه، امنیت و پشتیبان‌گیری';

  @override
  String get moreProfitLossSubtitle => 'سود خالص و هزینه‌های مغازه';

  @override
  String get moreShopReportSubtitle => 'کل موجودی کالا، نقدینگی و مطالبات';

  @override
  String get notificationServiceGeneralChannelDesc =>
      'اعلان‌های عمومی و آزمایشی کشکول';

  @override
  String get notificationServiceGeneralChannelName =>
      'اعلان‌های عمومی و آزمایشی';

  @override
  String notificationServiceLowStockBody(Object remainingStock) {
    return 'موجودی باقی‌مانده: $remainingStock';
  }

  @override
  String get notificationServiceLowStockChannelDesc =>
      'هشدار فوری هنگام رسیدن کالا به حداقل موجودی';

  @override
  String get notificationServiceLowStockChannelName => 'هشدارهای کسری موجودی';

  @override
  String get notificationServiceLowStockNoSupplierSuffix =>
      ' برای بررسی و ثبت سفارش ضربه بزنید';

  @override
  String notificationServiceLowStockSupplierSuffix(Object supplierName) {
    return ' تأمین‌کننده: $supplierName — برای سفارش از طریق واتس‌اپ ضربه بزنید';
  }

  @override
  String notificationServiceLowStockTitle(Object productName) {
    return '⚠️ هشدار کسری موجودی: $productName';
  }

  @override
  String get notificationServiceMultipleLowStockBody =>
      'کالاهای دارای کسری موجودی را بررسی کرده و سفارش دهید.';

  @override
  String notificationServiceMultipleLowStockTitle(Object count) {
    return '⚠️ $count کالا با کسری موجودی مواجه شده‌اند';
  }

  @override
  String get pdfInvoiceCash => 'نقدی';

  @override
  String get pdfInvoiceCredit => 'فاکتور فروش نسیه';

  @override
  String pdfInvoiceNumber(Object shortSaleId) {
    return 'شماره فاکتور: #$shortSaleId';
  }

  @override
  String get pdfInvoicePayCash => 'پرداخت نقدی';

  @override
  String get pdfInvoicePayOnCredit => 'ثبت دفتری (نسیه)';

  @override
  String get pdfInvoicePaymentMethod => 'روش تسویه:';

  @override
  String pdfInvoicePhone(Object phone) {
    return 'تلفن: $phone';
  }

  @override
  String get pdfInvoicePrice => 'قیمت';

  @override
  String get pdfInvoiceThankYou => 'از خرید شما سپاسگزاریم!';

  @override
  String get pdfInvoiceTotal => 'مجموع';

  @override
  String get pdfPreviewErrorLabel => 'ایجاد فایل با خطا مواجه شد';

  @override
  String get pdfPreviewPreparing => 'در حال آماده‌سازی فایل PDF...';

  @override
  String get pdfPreviewPrint => 'چاپ مستقیم';

  @override
  String get pdfPreviewRetry => 'تلاش مجدد';

  @override
  String get pdfPreviewShare => 'اشتراک‌گذاری PDF';

  @override
  String get pdfReportAvailableAmount => 'مبلغ در دسترس';

  @override
  String get pdfReportCashInDrawer => 'نقدینگی در صندوق';

  @override
  String get pdfReportCashProfitNote =>
      'یادداشت کشکول: سود نقدی پول واقعی ورودی به صندوق پس از کسر هزینه‌هاست. سود نسیه پس از وصول به نقدینگی تبدیل می‌شود.';

  @override
  String get pdfReportCashVsCreditTitle => 'مقایسه فروش نقدی و نسیه';

  @override
  String get pdfReportCount => 'تعداد';

  @override
  String get pdfReportCustomerUnit => 'مشتری';

  @override
  String get pdfReportDateLabel => 'تاریخ';

  @override
  String get pdfReportDebtSection => '۲. بدهی‌ها و مطالبات';

  @override
  String get pdfReportDigitalBalance => 'موجودی کیف پول دیجیتال / بانک';

  @override
  String get pdfReportGrandTotal => 'مجموع کل';

  @override
  String get pdfReportGrowthFooter =>
      'تولید شده با اپلیکیشن کشکول — دفتر نسیه و حسابداری رایگان';

  @override
  String get pdfReportInventoryAtCost => 'ارزش موجودی بر اساس قیمت خرید';

  @override
  String get pdfReportInventoryAtRetail => 'ارزش موجودی بر اساس قیمت فروش';

  @override
  String get pdfReportInventorySection => '۱. کالاها و انبار';

  @override
  String get pdfReportInventorySubtitle =>
      'گزارش ارزش‌گذاری موجودی و کالاهای موجود';

  @override
  String get pdfReportInventoryTitle => 'گزارش انبارگردانی عمومی';

  @override
  String get pdfReportInvoiceUnit => 'فاکتور';

  @override
  String get pdfReportItemUnit => 'کالا';

  @override
  String get pdfReportLiquiditySection => '۳. نقدینگی در دسترس';

  @override
  String get pdfReportLowStockLabel => 'کسری‌ها';

  @override
  String get pdfReportLowStockNeedOrder => 'نیاز به سفارش';

  @override
  String get pdfReportLowStockSubtitle =>
      'فهرست کامل کالاهای با کسری موجودی و قیمت‌ها';

  @override
  String get pdfReportLowStockTitle => 'گزارش کالاهای رو به اتمام و سفارشات';

  @override
  String get pdfReportMinimum => 'حداقل موجودی';

  @override
  String get pdfReportMovementUnit => 'تراکنش';

  @override
  String get pdfReportNetWorthFormula =>
      '= (موجودی با بهای تمام‌شده + نقدینگی صندوق و بانک + مطالبات) - بدهی تأمین‌کنندگان';

  @override
  String get pdfReportOperatingExpenses => 'هزینه‌های جاری (کسر شده از صندوق)';

  @override
  String get pdfReportOutOfStock => 'ناموجود';

  @override
  String get pdfReportParty => 'طرف حساب / دسته';

  @override
  String get pdfReportProductCountLabel => 'تعداد کل اقلام';

  @override
  String get pdfReportProfitLossTitle => 'گزارش سود و زیان';

  @override
  String get pdfReportRowNumber => 'ردیف';

  @override
  String get pdfReportSalesCount => 'تعداد فروش';

  @override
  String get pdfReportSalesRevenue => 'درآمد فروش';

  @override
  String get pdfReportShopOverviewSubtitle =>
      'بررسی جامع موجودی، مطالبات و نقدینگی';

  @override
  String get pdfReportShopOverviewTitle => 'گزارش وضعیت مالی مغازه';

  @override
  String get pdfReportSource => 'منبع / ردیف';

  @override
  String get pdfReportStatus => 'وضعیت';

  @override
  String get pdfReportSupplier => 'تأمین‌کننده';

  @override
  String get pdfReportSupplierPhone => 'تلفن تأمین‌کننده';

  @override
  String get pdfReportSupplierUnit => 'تأمین‌کننده';

  @override
  String get pdfReportTotalCashAvailable => 'مجموع نقدینگی موجود';

  @override
  String get pdfReportTotalCost => 'بهای تمام‌شده کل';

  @override
  String get pdfReportTotalCostLabel => 'ارزش کل به بهای تمام‌شده';

  @override
  String get pdfReportTotalNetProfit => 'کل سود خالص مغازه';

  @override
  String get pdfReportTotalProducts => 'کل کالاها';

  @override
  String get pdfReportValueCountHeader => 'مبلغ / تعداد';

  @override
  String get quickPosDoneNewSale => 'تأیید · فروش جدید';

  @override
  String quickPosFetchLastInvoiceFailed(Object e) {
    return 'دریافت فاکتور قبلی با خطا مواجه شد: $e';
  }

  @override
  String get quickPosInvoiceOptions => 'گزینه‌های فاکتور';

  @override
  String quickPosInvoiceTotal(Object total) {
    return 'مجموع فاکتور: $total';
  }

  @override
  String quickPosItemsCount(Object count) {
    return '$count قلم در سبد خرید';
  }

  @override
  String get quickPosLastInvoiceNoItems => 'فاکتور قبلی خالی است';

  @override
  String get quickPosNoItemsToPreview =>
      'کالایی برای پیش‌نمایش در این فاکتور نیست';

  @override
  String get quickPosNoItemsToPrint => 'کالایی برای چاپ در این فاکتور نیست';

  @override
  String get quickPosNoPreviousInvoices =>
      'هنوز فاکتور فروش ثبت‌شده‌ای وجود ندارد';

  @override
  String quickPosOpenInvoiceFailed(Object e) {
    return 'باز کردن فاکتور با خطا مواجه شد: $e';
  }

  @override
  String get quickPosOutOfStock => 'موجودی تمام شد';

  @override
  String get quickPosPaymentMethod => 'روش پرداخت';

  @override
  String get quickPosPreviewBeforeSave => 'پیش‌نمایش فاکتور قبل از ثبت';

  @override
  String get quickPosPreviewCurrentInvoice => 'پیش‌نمایش فاکتور فعلی';

  @override
  String quickPosPreviewFailed(Object e) {
    return 'باز کردن پیش‌نمایش با خطا مواجه شد: $e';
  }

  @override
  String get quickPosPreviewFileName => 'پیش_نمایش_فاکتور.pdf';

  @override
  String get quickPosPreviewLabel => 'پیش‌نمایش';

  @override
  String get quickPosPreviewPrintCurrent => 'چاپ و پیش‌نمایش فاکتور';

  @override
  String get quickPosPreviewSharePdf => 'پیش‌نمایش و اشتراک PDF';

  @override
  String quickPosPrintFailed(Object e) {
    return 'چاپ فاکتور با خطا مواجه شد: $e';
  }

  @override
  String get quickPosPrintLastInvoice => 'چاپ مجدد آخرین فاکتور';

  @override
  String get quickPosPrintThermalReceipt => 'چاپ فیش حرارتی (80mm)';

  @override
  String get quickPosReceiveCash => 'دریافت نقدی';

  @override
  String get quickPosRecordOnAccount => 'ثبت دفتری (نسیه)';

  @override
  String quickPosSaleInvoiceFileName(Object shortId) {
    return 'فاکتور_فروش_$shortId.pdf';
  }

  @override
  String quickPosSaleInvoiceTitle(Object shortId) {
    return 'فاکتور فروش #$shortId';
  }

  @override
  String get quickPosSaleSavedSuccessfully => 'فروش با موفقیت ثبت شد!';

  @override
  String get quickPosSaveAndPrint => 'ذخیره و چاپ';

  @override
  String get quickPosSaveAndPrintTooltip => 'ذخیره فروش و چاپ آنی فیش';

  @override
  String get quickPosSavingAndPrinting => 'فروش ثبت شد، در حال چاپ فیش...';

  @override
  String get quickPosTapToAdd => 'برای افزودن ضربه بزنید';

  @override
  String get quickPosTapToAddToCart => 'برای افزودن به سبد ضربه بزنید';

  @override
  String genericError(Object err) {
    return 'خطایی رخ داد: $err';
  }

  @override
  String get inventoryPdfExportTooltip => 'چاپ و خروجی PDF گزارش موجودی';

  @override
  String inventoryPdfFileNameFull(Object dateStr) {
    return 'انبارگردانی_کامل_$dateStr.pdf';
  }

  @override
  String inventoryPdfFileNameLowStock(Object dateStr) {
    return 'کسری_موجودی_$dateStr.pdf';
  }

  @override
  String get inventoryPdfMenuFull => 'چاپ انبارگردانی کامل';

  @override
  String get inventoryPdfMenuLowStock => 'چاپ فقط کالاهای رو به اتمام';

  @override
  String get inventoryPdfTitleFull => 'گزارش انبارگردانی عمومی';

  @override
  String get inventoryPdfTitleLowStock => 'گزارش کسری موجودی کالاها';

  @override
  String get notificationServiceSettingsSendTestFailure =>
      'ارسال اعلان آزمایشی ناموفق بود — دسترسی اعلان‌ها را بررسی کنید';

  @override
  String get printExportPdf => 'چاپ و خروجی PDF';

  @override
  String get profitLossAccountingTipBody =>
      'سود نقدی پول واقعی در صندوق پس از کسر هزینه‌هاست. سود نسیه با وصول به پول نقد تبدیل می‌شود.';

  @override
  String get profitLossAccountingTipTitle => 'نکته حسابداری از کشکول';

  @override
  String get profitLossCashBadge => 'نقدی';

  @override
  String get profitLossCreditBadge => 'نسیه';

  @override
  String profitLossNetCalculation(Object netCash, Object netCredit) {
    return '= $netCash نقدی + $netCredit نسیه';
  }

  @override
  String profitLossRecordedSales(Object salesCount) {
    return '$salesCount فاکتور فروش ثبت‌شده';
  }

  @override
  String profitLossReportFileName(Object dateStr) {
    return 'گزارش_سود_و_زیان_$dateStr.pdf';
  }

  @override
  String get profitLossReportTitle => 'گزارش سود و زیان';

  @override
  String restockAvailable(Object stock, Object unit) {
    return 'موجود: $stock $unit';
  }

  @override
  String get restockCopiedToClipboard => 'پیام سفارش کالا در حافظه کپی شد!';

  @override
  String restockError(Object err) {
    return 'بارگذاری کالاها با خطا مواجه شد: $err';
  }

  @override
  String get restockLinkProductsHint =>
      'کالاها را در صفحه موجودی به این تأمین‌کننده متصل کنید تا با یک لمس سفارش دهید.';

  @override
  String get restockMessageFooter =>
      'لطفاً دریافت سفارش و زمان تحویل را اعلام فرمایید.';

  @override
  String restockMessageGreeting(Object supplierName) {
    return 'سلام و درود جناب $supplierName';
  }

  @override
  String get restockMessageHeader =>
      'اقلام زیر برای مغازه کسری داریم و نیازمند سفارش است:';

  @override
  String restockMessageItem(Object name, Object qty, Object unit) {
    return '• $name — مقدار مورد نیاز: $qty $unit';
  }

  @override
  String restockMessageShop(Object shopName) {
    return 'از طرف مغازه $shopName';
  }

  @override
  String get restockMessageThanks => 'با تشکر فراوان!';

  @override
  String get restockSelectProductsHint =>
      'اقلام و مقادیر مورد نیاز برای سفارش از طریق واتس‌اپ را انتخاب کنید:';

  @override
  String get restockSendWhatsApp => 'ارسال سفارش از طریق واتس‌اپ';

  @override
  String get shopReportCashInDrawerLabel => 'نقدینگی در صندوق:';

  @override
  String get shopReportCopiedToClipboard => 'گزارش وضعیت مالی کپی شد!';

  @override
  String get shopReportCustomersWithDues => 'مشتریان بدهکار:';

  @override
  String get shopReportDigitalBalanceLabel => 'موجودی کارتخوان / بانک:';

  @override
  String shopReportFileName(Object dateStr) {
    return 'وضعیت_مالی_مغازه_$dateStr.pdf';
  }

  @override
  String shopReportLowStockOf(Object count, Object total) {
    return '$count قلم از مجموع $total';
  }

  @override
  String get shopReportNetWorthFormula =>
      '= (موجودی با بهای تمام‌شده + نقدینگی صندوق و بانک + مطالبات) - بدهی تأمین‌کنندگان';

  @override
  String shopReportSupplierCount(Object count) {
    return '$count تأمین‌کننده';
  }

  @override
  String get shopReportSuppliersOwed => 'تأمین‌کنندگان بستانکار:';

  @override
  String get shopReportTextCashAvailable => '--- نقدینگی در دسترس ---';

  @override
  String shopReportTextCashInDrawer(Object amount) {
    return '• نقدینگی صندوق: $amount';
  }

  @override
  String shopReportTextDate(Object dateStr) {
    return 'تاریخ: $dateStr';
  }

  @override
  String shopReportTextDigitalBalance(Object amount) {
    return '• بانک / کارتخوان: $amount';
  }

  @override
  String shopReportTextExpectedProfit(Object profit) {
    return '• سود مورد انتظار از انبار: $profit';
  }

  @override
  String get shopReportTextFooter => 'تولید شده توسط اپلیکیشن کشکول';

  @override
  String get shopReportTextInventory => '--- کالاها و انبار ---';

  @override
  String shopReportTextNetWorth(Object netWorth) {
    return 'ارزش خالص مغازه: $netWorth';
  }

  @override
  String shopReportTextPayables(Object amount, Object count) {
    return '• بدهی به تأمین‌کنندگان: $amount ($count تأمین‌کننده)';
  }

  @override
  String shopReportTextProductCounts(Object total, Object low) {
    return '• کل اقلام: $total ($low قلم رو به اتمام)';
  }

  @override
  String shopReportTextReceivables(Object amount, Object count) {
    return '• مطالبات از مشتریان: $amount ($count مشتری)';
  }

  @override
  String shopReportTextShop(Object shopName) {
    return 'مغازه: $shopName';
  }

  @override
  String get shopReportTextTitle => '=== گزارش وضعیت مالی مغازه ===';

  @override
  String shopReportTextTotalCash(Object amount) {
    return '• کل نقدینگی در دسترس: $amount';
  }

  @override
  String get shopReportTotalCashLabel => 'کل نقدینگی در دسترس:';

  @override
  String get shopReportTotalCustomerDues => 'کل مطالبات از مشتریان:';

  @override
  String get shopReportTotalSupplierDues => 'کل بدهی به تأمین‌کنندگان:';
}
