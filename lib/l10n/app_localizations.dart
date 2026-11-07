import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ar, this message translates to:
  /// **'كشكول'**
  String get appTitle;

  /// No description provided for @navCustomers.
  ///
  /// In ar, this message translates to:
  /// **'العملاء'**
  String get navCustomers;

  /// No description provided for @navCollection.
  ///
  /// In ar, this message translates to:
  /// **'التحصيل'**
  String get navCollection;

  /// No description provided for @navSuppliers.
  ///
  /// In ar, this message translates to:
  /// **'الموردين'**
  String get navSuppliers;

  /// No description provided for @navCashDrawer.
  ///
  /// In ar, this message translates to:
  /// **'الدرج'**
  String get navCashDrawer;

  /// No description provided for @navSettings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get navSettings;

  /// No description provided for @debt.
  ///
  /// In ar, this message translates to:
  /// **'عليه'**
  String get debt;

  /// No description provided for @payment.
  ///
  /// In ar, this message translates to:
  /// **'دفع'**
  String get payment;

  /// No description provided for @settled.
  ///
  /// In ar, this message translates to:
  /// **'خالصين'**
  String get settled;

  /// No description provided for @currency.
  ///
  /// In ar, this message translates to:
  /// **'جنيه'**
  String get currency;

  /// No description provided for @piaster.
  ///
  /// In ar, this message translates to:
  /// **'قرش'**
  String get piaster;

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @search.
  ///
  /// In ar, this message translates to:
  /// **'بحث...'**
  String get search;

  /// No description provided for @placeholderScreen.
  ///
  /// In ar, this message translates to:
  /// **'شاشة {screenName}'**
  String placeholderScreen(Object screenName);

  /// No description provided for @comingSoon.
  ///
  /// In ar, this message translates to:
  /// **'هتتوفر في الخطوة القادمة إن شاء الله'**
  String get comingSoon;

  /// No description provided for @totalReceivablesTitle.
  ///
  /// In ar, this message translates to:
  /// **'ليك عند الناس'**
  String get totalReceivablesTitle;

  /// No description provided for @searchCustomersHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث بالاسم أو رقم التليفون...'**
  String get searchCustomersHint;

  /// No description provided for @filterAll.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get filterAll;

  /// No description provided for @filterHasDebt.
  ///
  /// In ar, this message translates to:
  /// **'عليهم فلوس'**
  String get filterHasDebt;

  /// No description provided for @filterSettled.
  ///
  /// In ar, this message translates to:
  /// **'خالصين'**
  String get filterSettled;

  /// No description provided for @filterLate.
  ///
  /// In ar, this message translates to:
  /// **'متأخرين'**
  String get filterLate;

  /// No description provided for @sortHighestDebt.
  ///
  /// In ar, this message translates to:
  /// **'أعلى دين'**
  String get sortHighestDebt;

  /// No description provided for @sortName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get sortName;

  /// No description provided for @sortLastActivity.
  ///
  /// In ar, this message translates to:
  /// **'آخر نشاط'**
  String get sortLastActivity;

  /// No description provided for @addNewCustomer.
  ///
  /// In ar, this message translates to:
  /// **'عميل جديد'**
  String get addNewCustomer;

  /// No description provided for @addCustomer.
  ///
  /// In ar, this message translates to:
  /// **'إضافة عميل'**
  String get addCustomer;

  /// No description provided for @editCustomer.
  ///
  /// In ar, this message translates to:
  /// **'تعديل العميل'**
  String get editCustomer;

  /// No description provided for @customerName.
  ///
  /// In ar, this message translates to:
  /// **'اسم العميل'**
  String get customerName;

  /// No description provided for @customerNameHint.
  ///
  /// In ar, this message translates to:
  /// **'مثلاً: عم محمد البقال'**
  String get customerNameHint;

  /// No description provided for @customerNameRequired.
  ///
  /// In ar, this message translates to:
  /// **'اسم العميل مطلوب'**
  String get customerNameRequired;

  /// No description provided for @customerNameTooShort.
  ///
  /// In ar, this message translates to:
  /// **'الاسم يجب ألا يقل عن حرفين'**
  String get customerNameTooShort;

  /// No description provided for @customerPhone.
  ///
  /// In ar, this message translates to:
  /// **'رقم الموبايل'**
  String get customerPhone;

  /// No description provided for @customerPhoneHint.
  ///
  /// In ar, this message translates to:
  /// **'010xxxxxxxx'**
  String get customerPhoneHint;

  /// No description provided for @customerPhoneInvalid.
  ///
  /// In ar, this message translates to:
  /// **'رقم الموبايل غير صحيح (010, 011, 012, 015)'**
  String get customerPhoneInvalid;

  /// No description provided for @customerNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات'**
  String get customerNotes;

  /// No description provided for @customerNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'مثلاً: جار الدور التاني'**
  String get customerNotesHint;

  /// No description provided for @creditLimit.
  ///
  /// In ar, this message translates to:
  /// **'حد الدين (اختياري)'**
  String get creditLimit;

  /// No description provided for @creditLimitHint.
  ///
  /// In ar, this message translates to:
  /// **'مثلاً: 1000'**
  String get creditLimitHint;

  /// No description provided for @noCustomersTitle.
  ///
  /// In ar, this message translates to:
  /// **'دفترك فاضي!'**
  String get noCustomersTitle;

  /// No description provided for @noCustomersSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اضغط على الزرار تحت وضيف أول عميل عشان تبدأ تتابع حساباته بسهولة'**
  String get noCustomersSubtitle;

  /// No description provided for @noSearchResults.
  ///
  /// In ar, this message translates to:
  /// **'مفيش عملاء بالاسم أو الرقم ده'**
  String get noSearchResults;

  /// No description provided for @duplicateCustomerWarning.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه: يوجد عميل مسجل بالفعل بنفس الاسم أو رقم التليفون'**
  String get duplicateCustomerWarning;

  /// No description provided for @customerDetails.
  ///
  /// In ar, this message translates to:
  /// **'بيانات العميل'**
  String get customerDetails;

  /// No description provided for @callCustomer.
  ///
  /// In ar, this message translates to:
  /// **'اتصال'**
  String get callCustomer;

  /// No description provided for @deleteCustomer.
  ///
  /// In ar, this message translates to:
  /// **'حذف العميل'**
  String get deleteCustomer;

  /// No description provided for @deleteCustomerConfirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد حذف العميل'**
  String get deleteCustomerConfirm;

  /// No description provided for @deleteCustomerWarningDebt.
  ///
  /// In ar, this message translates to:
  /// **'انتبه! العميل ده لسه عليه حساب قدره {amount}. متأكد إنك عاوز تحذفه؟'**
  String deleteCustomerWarningDebt(String amount);

  /// No description provided for @deleteCustomerSafeConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من حذف العميل {name}؟'**
  String deleteCustomerSafeConfirm(String name);

  /// No description provided for @customerDeleted.
  ///
  /// In ar, this message translates to:
  /// **'تم حذف العميل بنجاح'**
  String get customerDeleted;

  /// No description provided for @customerSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم حفظ بيانات العميل بنجاح'**
  String get customerSaved;

  /// No description provided for @lastActivityNever.
  ///
  /// In ar, this message translates to:
  /// **'مفيش حركات سابقة'**
  String get lastActivityNever;

  /// No description provided for @lastActivityDate.
  ///
  /// In ar, this message translates to:
  /// **'آخر حركة: {date}'**
  String lastActivityDate(String date);

  /// No description provided for @creditLimitLabel.
  ///
  /// In ar, this message translates to:
  /// **'حد الدين: {amount}'**
  String creditLimitLabel(String amount);

  /// No description provided for @creditLimitExceeded.
  ///
  /// In ar, this message translates to:
  /// **'تعدى حد الدين!'**
  String get creditLimitExceeded;

  /// No description provided for @heOwes.
  ///
  /// In ar, this message translates to:
  /// **'عليه'**
  String get heOwes;

  /// No description provided for @hePaid.
  ///
  /// In ar, this message translates to:
  /// **'له (دافع زيادة)'**
  String get hePaid;

  /// No description provided for @currentBalance.
  ///
  /// In ar, this message translates to:
  /// **'الرصيد الحالي'**
  String get currentBalance;

  /// No description provided for @noTransactionsYet.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد معاملات مسجلة حتى الآن'**
  String get noTransactionsYet;

  /// No description provided for @addDebtTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل دين جديد (عليه)'**
  String get addDebtTitle;

  /// No description provided for @addPaymentTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل سداد (دفع)'**
  String get addPaymentTitle;

  /// No description provided for @amountLabel.
  ///
  /// In ar, this message translates to:
  /// **'المبلغ'**
  String get amountLabel;

  /// No description provided for @amountRequired.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال مبلغ صحيح أكبر من صفر'**
  String get amountRequired;

  /// No description provided for @today.
  ///
  /// In ar, this message translates to:
  /// **'النهارده'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In ar, this message translates to:
  /// **'إمبارح'**
  String get yesterday;

  /// No description provided for @date.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ'**
  String get date;

  /// No description provided for @pickDate.
  ///
  /// In ar, this message translates to:
  /// **'تحديد التاريخ'**
  String get pickDate;

  /// No description provided for @paymentMethod.
  ///
  /// In ar, this message translates to:
  /// **'طريقة الدفع'**
  String get paymentMethod;

  /// No description provided for @methodCash.
  ///
  /// In ar, this message translates to:
  /// **'كاش'**
  String get methodCash;

  /// No description provided for @methodInstapay.
  ///
  /// In ar, this message translates to:
  /// **'إنستاباي'**
  String get methodInstapay;

  /// No description provided for @methodWallet.
  ///
  /// In ar, this message translates to:
  /// **'محفظة'**
  String get methodWallet;

  /// No description provided for @methodOther.
  ///
  /// In ar, this message translates to:
  /// **'أخرى'**
  String get methodOther;

  /// No description provided for @noteOptional.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة (اختياري: سكر، زيت، شحن...)'**
  String get noteOptional;

  /// No description provided for @voiceDictation.
  ///
  /// In ar, this message translates to:
  /// **'إملاء صوتي'**
  String get voiceDictation;

  /// No description provided for @listening.
  ///
  /// In ar, this message translates to:
  /// **'جاري الاستماع... تكلّم الآن'**
  String get listening;

  /// No description provided for @speechNotAvailable.
  ///
  /// In ar, this message translates to:
  /// **'الإملاء الصوتي غير متاح في هذا الجهاز'**
  String get speechNotAvailable;

  /// No description provided for @attachPhoto.
  ///
  /// In ar, this message translates to:
  /// **'إرفاق صورة'**
  String get attachPhoto;

  /// No description provided for @camera.
  ///
  /// In ar, this message translates to:
  /// **'الكاميرا'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In ar, this message translates to:
  /// **'المعرض'**
  String get gallery;

  /// No description provided for @removePhoto.
  ///
  /// In ar, this message translates to:
  /// **'حذف الصورة'**
  String get removePhoto;

  /// No description provided for @overpaymentTitle.
  ///
  /// In ar, this message translates to:
  /// **'المبلغ أكبر من اللي عليه!'**
  String get overpaymentTitle;

  /// No description provided for @overpaymentMessage.
  ///
  /// In ar, this message translates to:
  /// **'المبلغ المدفوع ({paidAmount}) أكبر من اللي عليه ({dueAmount}). هل تسجل الزيادة ({creditAmount}) كرصيد له في حسابه؟'**
  String overpaymentMessage(
    String paidAmount,
    String dueAmount,
    String creditAmount,
  );

  /// No description provided for @overpaymentConfirm.
  ///
  /// In ar, this message translates to:
  /// **'نعم، سجّل رصيد له'**
  String get overpaymentConfirm;

  /// No description provided for @transactionSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم تسجيل الحركة بنجاح'**
  String get transactionSaved;

  /// No description provided for @undo.
  ///
  /// In ar, this message translates to:
  /// **'تراجع'**
  String get undo;

  /// No description provided for @transactionUndone.
  ///
  /// In ar, this message translates to:
  /// **'تم التراجع عن تسجيل الحركة'**
  String get transactionUndone;

  /// No description provided for @transactionDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل المعاملة'**
  String get transactionDetails;

  /// No description provided for @editTransaction.
  ///
  /// In ar, this message translates to:
  /// **'تعديل المعاملة'**
  String get editTransaction;

  /// No description provided for @deleteTransaction.
  ///
  /// In ar, this message translates to:
  /// **'حذف المعاملة'**
  String get deleteTransaction;

  /// No description provided for @deleteTransactionConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من حذف هذه المعاملة؟'**
  String get deleteTransactionConfirm;

  /// No description provided for @transactionDeleted.
  ///
  /// In ar, this message translates to:
  /// **'تم حذف المعاملة بنجاح'**
  String get transactionDeleted;

  /// No description provided for @viewPhoto.
  ///
  /// In ar, this message translates to:
  /// **'عرض الصورة'**
  String get viewPhoto;

  /// No description provided for @creditLimitWarningTitle.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه حد الدين'**
  String get creditLimitWarningTitle;

  /// No description provided for @creditLimitExceededDialog.
  ///
  /// In ar, this message translates to:
  /// **'{customerName} كده هيبقى عليه {newTotal} — مع إن الحد بتاعه {limit}'**
  String creditLimitExceededDialog(
    String customerName,
    String newTotal,
    String limit,
  );

  /// No description provided for @saveAnyway.
  ///
  /// In ar, this message translates to:
  /// **'سجّل برضه'**
  String get saveAnyway;

  /// No description provided for @changeLimit.
  ///
  /// In ar, this message translates to:
  /// **'غيّر الحد'**
  String get changeLimit;

  /// No description provided for @newCreditLimit.
  ///
  /// In ar, this message translates to:
  /// **'حد الدين الجديد'**
  String get newCreditLimit;

  /// No description provided for @limitUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تعديل حد الدين بنجاح'**
  String get limitUpdated;

  /// No description provided for @totalPayablesTitle.
  ///
  /// In ar, this message translates to:
  /// **'عليك للموردين'**
  String get totalPayablesTitle;

  /// No description provided for @netMarketPosition.
  ///
  /// In ar, this message translates to:
  /// **'صافي الموقف المالي'**
  String get netMarketPosition;

  /// No description provided for @netReceivables.
  ///
  /// In ar, this message translates to:
  /// **'صافي ليك في السوق: {amount}'**
  String netReceivables(String amount);

  /// No description provided for @netPayables.
  ///
  /// In ar, this message translates to:
  /// **'عليك عجز إجمالي: {amount}'**
  String netPayables(String amount);

  /// No description provided for @netSettled.
  ///
  /// In ar, this message translates to:
  /// **'الحسابات متوازنة (0 جنيه)'**
  String get netSettled;

  /// No description provided for @addNewSupplier.
  ///
  /// In ar, this message translates to:
  /// **'مورد جديد'**
  String get addNewSupplier;

  /// No description provided for @addSupplier.
  ///
  /// In ar, this message translates to:
  /// **'إضافة مورد'**
  String get addSupplier;

  /// No description provided for @editSupplier.
  ///
  /// In ar, this message translates to:
  /// **'تعديل المورد'**
  String get editSupplier;

  /// No description provided for @supplierName.
  ///
  /// In ar, this message translates to:
  /// **'اسم المندوب / المورد'**
  String get supplierName;

  /// No description provided for @supplierNameHint.
  ///
  /// In ar, this message translates to:
  /// **'مثلاً: عماد مندوب جهينة'**
  String get supplierNameHint;

  /// No description provided for @supplierNameRequired.
  ///
  /// In ar, this message translates to:
  /// **'اسم المورد مطلوب'**
  String get supplierNameRequired;

  /// No description provided for @company.
  ///
  /// In ar, this message translates to:
  /// **'اسم الشركة / التوكيل'**
  String get company;

  /// No description provided for @companyHint.
  ///
  /// In ar, this message translates to:
  /// **'مثلاً: جهينة، شيبسي، الأهرام'**
  String get companyHint;

  /// No description provided for @visitDay.
  ///
  /// In ar, this message translates to:
  /// **'يوم الزيارة الأسبوعي'**
  String get visitDay;

  /// No description provided for @noSpecificDay.
  ///
  /// In ar, this message translates to:
  /// **'بدون يوم محدد'**
  String get noSpecificDay;

  /// No description provided for @supplierNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات'**
  String get supplierNotes;

  /// No description provided for @supplierNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'مثلاً: بيعدي الساعة 10 الصبح'**
  String get supplierNotesHint;

  /// No description provided for @noSuppliersTitle.
  ///
  /// In ar, this message translates to:
  /// **'دفتر الموردين فاضي!'**
  String get noSuppliersTitle;

  /// No description provided for @noSuppliersSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اضغط على الزرار تحت وضيف أول مورد أو شركة بتتعامل معاها'**
  String get noSuppliersSubtitle;

  /// No description provided for @noSupplierSearchResults.
  ///
  /// In ar, this message translates to:
  /// **'مفيش موردين بالاسم أو الشركة دي'**
  String get noSupplierSearchResults;

  /// No description provided for @searchSuppliersHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث باسم المندوب أو الشركة أو الرقم...'**
  String get searchSuppliersHint;

  /// No description provided for @supplierDetails.
  ///
  /// In ar, this message translates to:
  /// **'بيانات المورد'**
  String get supplierDetails;

  /// No description provided for @iOweHim.
  ///
  /// In ar, this message translates to:
  /// **'عليّا'**
  String get iOweHim;

  /// No description provided for @iPaidHim.
  ///
  /// In ar, this message translates to:
  /// **'دفعتله'**
  String get iPaidHim;

  /// No description provided for @deleteSupplier.
  ///
  /// In ar, this message translates to:
  /// **'حذف المورد'**
  String get deleteSupplier;

  /// No description provided for @deleteSupplierConfirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد حذف المورد'**
  String get deleteSupplierConfirm;

  /// No description provided for @deleteSupplierWarningDebt.
  ///
  /// In ar, this message translates to:
  /// **'انتبه! المورد ده لسه ليه حساب عندك قدره {amount}. متأكد إنك عاوز تحذفه؟'**
  String deleteSupplierWarningDebt(String amount);

  /// No description provided for @deleteSupplierSafeConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من حذف المورد {name}؟'**
  String deleteSupplierSafeConfirm(String name);

  /// No description provided for @supplierDeleted.
  ///
  /// In ar, this message translates to:
  /// **'تم حذف المورد بنجاح'**
  String get supplierDeleted;

  /// No description provided for @supplierSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم حفظ بيانات المورد بنجاح'**
  String get supplierSaved;

  /// No description provided for @visitDayPrefix.
  ///
  /// In ar, this message translates to:
  /// **'يوم الزيارة: {day}'**
  String visitDayPrefix(String day);

  /// No description provided for @sortCompany.
  ///
  /// In ar, this message translates to:
  /// **'الشركة'**
  String get sortCompany;

  /// No description provided for @sortVisitDay.
  ///
  /// In ar, this message translates to:
  /// **'يوم الزيارة'**
  String get sortVisitDay;

  /// No description provided for @dueCustomersTitle.
  ///
  /// In ar, this message translates to:
  /// **'عملاء مستحقين تحصيل'**
  String get dueCustomersTitle;

  /// No description provided for @totalDueTitle.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي المستحق'**
  String get totalDueTitle;

  /// No description provided for @dueCustomersCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} عميل'**
  String dueCustomersCount(int count);

  /// No description provided for @dueHeaderSummary.
  ///
  /// In ar, this message translates to:
  /// **'عندك {count} عملاء عليهم {amount}'**
  String dueHeaderSummary(int count, String amount);

  /// No description provided for @oldestDebtDays.
  ///
  /// In ar, this message translates to:
  /// **'أقدم دين من {days} يوم'**
  String oldestDebtDays(int days);

  /// No description provided for @oldestDebtToday.
  ///
  /// In ar, this message translates to:
  /// **'الدين مسجل اليوم'**
  String get oldestDebtToday;

  /// No description provided for @lastReminderDays.
  ///
  /// In ar, this message translates to:
  /// **'آخر تذكير: من {days} يوم'**
  String lastReminderDays(int days);

  /// No description provided for @lastReminderToday.
  ///
  /// In ar, this message translates to:
  /// **'آخر تذكير: اليوم'**
  String get lastReminderToday;

  /// No description provided for @neverReminded.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم التذكير بعد'**
  String get neverReminded;

  /// No description provided for @snoozedUntilDate.
  ///
  /// In ar, this message translates to:
  /// **'مؤجل حتى {date}'**
  String snoozedUntilDate(String date);

  /// No description provided for @sendWhatsApp.
  ///
  /// In ar, this message translates to:
  /// **'واتساب'**
  String get sendWhatsApp;

  /// No description provided for @sendSms.
  ///
  /// In ar, this message translates to:
  /// **'رسالة SMS'**
  String get sendSms;

  /// No description provided for @moreActions.
  ///
  /// In ar, this message translates to:
  /// **'المزيد'**
  String get moreActions;

  /// No description provided for @snooze3Days.
  ///
  /// In ar, this message translates to:
  /// **'تأجيل 3 أيام'**
  String get snooze3Days;

  /// No description provided for @snooze7Days.
  ///
  /// In ar, this message translates to:
  /// **'تأجيل أسبوع'**
  String get snooze7Days;

  /// No description provided for @cancelSnooze.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء التأجيل'**
  String get cancelSnooze;

  /// No description provided for @recordCollectionPayment.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل سداد'**
  String get recordCollectionPayment;

  /// No description provided for @didSendMessage.
  ///
  /// In ar, this message translates to:
  /// **'هل اتبعتت الرسالة؟'**
  String get didSendMessage;

  /// No description provided for @didSendMessageDesc.
  ///
  /// In ar, this message translates to:
  /// **'هل قمت بإرسال رسالة التذكير للعميل {name} عبر واتساب؟'**
  String didSendMessageDesc(String name);

  /// No description provided for @yesSent.
  ///
  /// In ar, this message translates to:
  /// **'أيوة اتبعتت'**
  String get yesSent;

  /// No description provided for @notSent.
  ///
  /// In ar, this message translates to:
  /// **'لأ، متبعتتش'**
  String get notSent;

  /// No description provided for @reminderMarkedSent.
  ///
  /// In ar, this message translates to:
  /// **'تم تسجيل التذكير بنجاح'**
  String get reminderMarkedSent;

  /// No description provided for @snoozedSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم تأجيل التذكير'**
  String get snoozedSuccess;

  /// No description provided for @noDueCustomersTitle.
  ///
  /// In ar, this message translates to:
  /// **'مفيش تحصيلات مستحقة النهاردة 🎉'**
  String get noDueCustomersTitle;

  /// No description provided for @noDueCustomersSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'كل الزباين حساباتهم مظبوطة أو تم تذكيرهم قريباً.'**
  String get noDueCustomersSubtitle;

  /// No description provided for @whatsAppNotInstalled.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق واتساب غير مثبت. هل تريد إرسال رسالة SMS بدلاً منه؟'**
  String get whatsAppNotInstalled;

  /// No description provided for @openSms.
  ///
  /// In ar, this message translates to:
  /// **'إرسال SMS'**
  String get openSms;

  /// No description provided for @growthFooter.
  ///
  /// In ar, this message translates to:
  /// **'\nتم الإرسال عبر تطبيق كشكول 📒'**
  String get growthFooter;

  /// No description provided for @statementTitle.
  ///
  /// In ar, this message translates to:
  /// **'كشف حساب'**
  String get statementTitle;

  /// No description provided for @generateStatement.
  ///
  /// In ar, this message translates to:
  /// **'استخراج كشف حساب'**
  String get generateStatement;

  /// No description provided for @statementAllTime.
  ///
  /// In ar, this message translates to:
  /// **'كل المعاملات'**
  String get statementAllTime;

  /// No description provided for @statementThisMonth.
  ///
  /// In ar, this message translates to:
  /// **'هذا الشهر'**
  String get statementThisMonth;

  /// No description provided for @statementCustomRange.
  ///
  /// In ar, this message translates to:
  /// **'فترة مخصصة'**
  String get statementCustomRange;

  /// No description provided for @statementFormatA4.
  ///
  /// In ar, this message translates to:
  /// **'ورقة A4'**
  String get statementFormatA4;

  /// No description provided for @statementFormatReceipt.
  ///
  /// In ar, this message translates to:
  /// **'إيصال حراري (80mm)'**
  String get statementFormatReceipt;

  /// No description provided for @dateCol.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ'**
  String get dateCol;

  /// No description provided for @descriptionCol.
  ///
  /// In ar, this message translates to:
  /// **'البيان'**
  String get descriptionCol;

  /// No description provided for @debtCol.
  ///
  /// In ar, this message translates to:
  /// **'عليه'**
  String get debtCol;

  /// No description provided for @paymentCol.
  ///
  /// In ar, this message translates to:
  /// **'دفع'**
  String get paymentCol;

  /// No description provided for @balanceCol.
  ///
  /// In ar, this message translates to:
  /// **'الرصيد'**
  String get balanceCol;

  /// No description provided for @startingBalance.
  ///
  /// In ar, this message translates to:
  /// **'رصيد ما قبل الفترة'**
  String get startingBalance;

  /// No description provided for @finalBalance.
  ///
  /// In ar, this message translates to:
  /// **'الرصيد النهائي'**
  String get finalBalance;

  /// No description provided for @periodLabel.
  ///
  /// In ar, this message translates to:
  /// **'الفترة: {period}'**
  String periodLabel(String period);

  /// No description provided for @statementGeneratedAt.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الاستخراج: {date}'**
  String statementGeneratedAt(String date);

  /// No description provided for @shareStatement.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة كشف الحساب'**
  String get shareStatement;

  /// No description provided for @printStatement.
  ///
  /// In ar, this message translates to:
  /// **'طباعة'**
  String get printStatement;

  /// No description provided for @statementShareSubject.
  ///
  /// In ar, this message translates to:
  /// **'كشف حساب - {name}'**
  String statementShareSubject(String name);

  /// No description provided for @totalDebits.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي المشتريات / السلف'**
  String get totalDebits;

  /// No description provided for @totalCredits.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي المسدد'**
  String get totalCredits;

  /// No description provided for @drawerTitle.
  ///
  /// In ar, this message translates to:
  /// **'تقفيل الدرج والخزينة'**
  String get drawerTitle;

  /// No description provided for @todayDrawer.
  ///
  /// In ar, this message translates to:
  /// **'درج اليوم'**
  String get todayDrawer;

  /// No description provided for @expectedInDrawer.
  ///
  /// In ar, this message translates to:
  /// **'المفروض في الدرج'**
  String get expectedInDrawer;

  /// No description provided for @openingCash.
  ///
  /// In ar, this message translates to:
  /// **'رصيد الافتتاح'**
  String get openingCash;

  /// No description provided for @openingCashHint.
  ///
  /// In ar, this message translates to:
  /// **'المبلغ اللي بدأت بيه اليوم'**
  String get openingCashHint;

  /// No description provided for @editOpeningCash.
  ///
  /// In ar, this message translates to:
  /// **'تعديل رصيد الافتتاح'**
  String get editOpeningCash;

  /// No description provided for @cashSales.
  ///
  /// In ar, this message translates to:
  /// **'مبيعات كاش'**
  String get cashSales;

  /// No description provided for @addCashSales.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل مبيعات كاش'**
  String get addCashSales;

  /// No description provided for @cashIn.
  ///
  /// In ar, this message translates to:
  /// **'داخل الدرج (كاش)'**
  String get cashIn;

  /// No description provided for @digitalIn.
  ///
  /// In ar, this message translates to:
  /// **'داخل إلكتروني'**
  String get digitalIn;

  /// No description provided for @cashOut.
  ///
  /// In ar, this message translates to:
  /// **'خارج من الدرج (كاش)'**
  String get cashOut;

  /// No description provided for @customerPaymentsCash.
  ///
  /// In ar, this message translates to:
  /// **'تحصيلات عملاء (كاش)'**
  String get customerPaymentsCash;

  /// No description provided for @customerPaymentsDigital.
  ///
  /// In ar, this message translates to:
  /// **'تحصيلات عملاء (إلكتروني)'**
  String get customerPaymentsDigital;

  /// No description provided for @supplierPaymentsCash.
  ///
  /// In ar, this message translates to:
  /// **'دفعات موردين (كاش)'**
  String get supplierPaymentsCash;

  /// No description provided for @expensesCash.
  ///
  /// In ar, this message translates to:
  /// **'مصاريف المحل (كاش)'**
  String get expensesCash;

  /// No description provided for @addExpense.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل مصروف'**
  String get addExpense;

  /// No description provided for @editExpense.
  ///
  /// In ar, this message translates to:
  /// **'تعديل المصروف'**
  String get editExpense;

  /// No description provided for @deleteExpense.
  ///
  /// In ar, this message translates to:
  /// **'حذف المصروف'**
  String get deleteExpense;

  /// No description provided for @deleteExpenseConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من حذف هذا المصروف؟'**
  String get deleteExpenseConfirm;

  /// No description provided for @expenseCategory.
  ///
  /// In ar, this message translates to:
  /// **'بند المصروف'**
  String get expenseCategory;

  /// No description provided for @catRent.
  ///
  /// In ar, this message translates to:
  /// **'إيجار'**
  String get catRent;

  /// No description provided for @catElectricity.
  ///
  /// In ar, this message translates to:
  /// **'كهرباء ومرافق'**
  String get catElectricity;

  /// No description provided for @catSalary.
  ///
  /// In ar, this message translates to:
  /// **'يوميات ومرتبات'**
  String get catSalary;

  /// No description provided for @catSupplies.
  ///
  /// In ar, this message translates to:
  /// **'بضاعة ومستلزمات'**
  String get catSupplies;

  /// No description provided for @catSupplierPayment.
  ///
  /// In ar, this message translates to:
  /// **'دفعة مورد'**
  String get catSupplierPayment;

  /// No description provided for @catOther.
  ///
  /// In ar, this message translates to:
  /// **'أخرى'**
  String get catOther;

  /// No description provided for @closeDay.
  ///
  /// In ar, this message translates to:
  /// **'قفّل اليوم'**
  String get closeDay;

  /// No description provided for @reopenDay.
  ///
  /// In ar, this message translates to:
  /// **'إعادة فتح اليوم'**
  String get reopenDay;

  /// No description provided for @reopenDayConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل تريد إعادة فتح هذا اليوم للتعديل عليه؟'**
  String get reopenDayConfirm;

  /// No description provided for @dayClosedSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم تقفيل اليوم بنجاح'**
  String get dayClosedSuccess;

  /// No description provided for @dayReopenedSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم إعادة فتح اليوم بنجاح'**
  String get dayReopenedSuccess;

  /// No description provided for @dayIsClosed.
  ///
  /// In ar, this message translates to:
  /// **'اليوم مقفول'**
  String get dayIsClosed;

  /// No description provided for @dayIsOpen.
  ///
  /// In ar, this message translates to:
  /// **'اليوم مفتوح'**
  String get dayIsOpen;

  /// No description provided for @actualCountLabel.
  ///
  /// In ar, this message translates to:
  /// **'المبلغ الفعلي في الدرج'**
  String get actualCountLabel;

  /// No description provided for @actualCountHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتب المبلغ اللي عديته في الدرج'**
  String get actualCountHint;

  /// No description provided for @drawerBalanced.
  ///
  /// In ar, this message translates to:
  /// **'الدرج مظبوط تمام 🎉'**
  String get drawerBalanced;

  /// No description provided for @drawerShortage.
  ///
  /// In ar, this message translates to:
  /// **'عجز في الدرج'**
  String get drawerShortage;

  /// No description provided for @drawerSurplus.
  ///
  /// In ar, this message translates to:
  /// **'زيادة في الدرج'**
  String get drawerSurplus;

  /// No description provided for @differenceAmount.
  ///
  /// In ar, this message translates to:
  /// **'الفرق: {amount}'**
  String differenceAmount(String amount);

  /// No description provided for @closeDaySummary.
  ///
  /// In ar, this message translates to:
  /// **'ملخص تقفيل اليوم'**
  String get closeDaySummary;

  /// No description provided for @confirmCloseDay.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد التقفيل'**
  String get confirmCloseDay;

  /// No description provided for @historyTab.
  ///
  /// In ar, this message translates to:
  /// **'سجل الأيام'**
  String get historyTab;

  /// No description provided for @todayTab.
  ///
  /// In ar, this message translates to:
  /// **'الدرج اليوم'**
  String get todayTab;

  /// No description provided for @monthlyTotals.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي الشهر'**
  String get monthlyTotals;

  /// No description provided for @monthlySales.
  ///
  /// In ar, this message translates to:
  /// **'مبيعات كاش'**
  String get monthlySales;

  /// No description provided for @monthlyExpenses.
  ///
  /// In ar, this message translates to:
  /// **'مصاريف كاش'**
  String get monthlyExpenses;

  /// No description provided for @monthlyNet.
  ///
  /// In ar, this message translates to:
  /// **'صافي الدرج'**
  String get monthlyNet;

  /// No description provided for @drawerNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات التقفيل (اختياري)'**
  String get drawerNotes;

  /// No description provided for @noExpensesYet.
  ///
  /// In ar, this message translates to:
  /// **'مفيش مصاريف متسجلة النهاردة'**
  String get noExpensesYet;

  /// No description provided for @noHistoryYet.
  ///
  /// In ar, this message translates to:
  /// **'مفيش أيام سابقة مسجلة'**
  String get noHistoryYet;

  /// No description provided for @expenseAddedSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم تسجيل المصروف بنجاح'**
  String get expenseAddedSuccess;

  /// No description provided for @cashSalesAddedSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم تسجيل المبيعات الكاش بنجاح'**
  String get cashSalesAddedSuccess;

  /// No description provided for @openingCashUpdatedSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم تعديل رصيد الافتتاح بنجاح'**
  String get openingCashUpdatedSuccess;

  /// No description provided for @dayDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل اليوم'**
  String get dayDetails;

  /// No description provided for @closedAtTime.
  ///
  /// In ar, this message translates to:
  /// **'تم التقفيل في: {time}'**
  String closedAtTime(String time);

  /// No description provided for @readOnlyDayNotice.
  ///
  /// In ar, this message translates to:
  /// **'هذا اليوم مقفول. لإجراء تعديلات اضغط على إعادة فتح اليوم.'**
  String get readOnlyDayNotice;

  /// No description provided for @privacyModeTitle.
  ///
  /// In ar, this message translates to:
  /// **'وضع الخصوصية'**
  String get privacyModeTitle;

  /// No description provided for @privacyModeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'إخفاء مبالغ الفلوس في الشاشة والودجت (••••••)'**
  String get privacyModeSubtitle;

  /// No description provided for @shareAppTitle.
  ///
  /// In ar, this message translates to:
  /// **'شارك التطبيق'**
  String get shareAppTitle;

  /// No description provided for @shareAppSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'ابعت كشكول لصحابك أصحاب المحلات'**
  String get shareAppSubtitle;

  /// No description provided for @shopCodeLabel.
  ///
  /// In ar, this message translates to:
  /// **'كود المحل: {code}'**
  String shopCodeLabel(String code);

  /// No description provided for @growthFooterToggleTitle.
  ///
  /// In ar, this message translates to:
  /// **'إخفاء توقيع كشكول من الرسائل'**
  String get growthFooterToggleTitle;

  /// No description provided for @growthFooterToggleSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'متاح في الباقة المدفوعة 🔒'**
  String get growthFooterToggleSubtitle;

  /// No description provided for @codeCopied.
  ///
  /// In ar, this message translates to:
  /// **'تم نسخ الكود'**
  String get codeCopied;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
