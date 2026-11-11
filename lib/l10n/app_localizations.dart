import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';

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
    Locale('ar', 'EG'),
    Locale('en'),
    Locale('fa'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('tr'),
    Locale('ur'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'كشكول'**
  String get appTitle;

  /// No description provided for @navCustomers.
  ///
  /// In ar_EG, this message translates to:
  /// **'العملاء'**
  String get navCustomers;

  /// No description provided for @navCollection.
  ///
  /// In ar_EG, this message translates to:
  /// **'التحصيل'**
  String get navCollection;

  /// No description provided for @navSuppliers.
  ///
  /// In ar_EG, this message translates to:
  /// **'الموردين'**
  String get navSuppliers;

  /// No description provided for @navCashDrawer.
  ///
  /// In ar_EG, this message translates to:
  /// **'الدرج'**
  String get navCashDrawer;

  /// No description provided for @navSettings.
  ///
  /// In ar_EG, this message translates to:
  /// **'الإعدادات'**
  String get navSettings;

  /// No description provided for @debt.
  ///
  /// In ar_EG, this message translates to:
  /// **'عليه'**
  String get debt;

  /// No description provided for @payment.
  ///
  /// In ar_EG, this message translates to:
  /// **'دفع'**
  String get payment;

  /// No description provided for @settled.
  ///
  /// In ar_EG, this message translates to:
  /// **'خالصين'**
  String get settled;

  /// No description provided for @currency.
  ///
  /// In ar_EG, this message translates to:
  /// **'جنيه'**
  String get currency;

  /// No description provided for @piaster.
  ///
  /// In ar_EG, this message translates to:
  /// **'قرش'**
  String get piaster;

  /// No description provided for @save.
  ///
  /// In ar_EG, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In ar_EG, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In ar_EG, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @search.
  ///
  /// In ar_EG, this message translates to:
  /// **'بحث...'**
  String get search;

  /// No description provided for @placeholderScreen.
  ///
  /// In ar_EG, this message translates to:
  /// **'شاشة {screenName}'**
  String placeholderScreen(String screenName);

  /// No description provided for @comingSoon.
  ///
  /// In ar_EG, this message translates to:
  /// **'هتتوفر في الخطوة القادمة إن شاء الله'**
  String get comingSoon;

  /// No description provided for @totalReceivablesTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'ليك عند الناس'**
  String get totalReceivablesTitle;

  /// No description provided for @searchCustomersHint.
  ///
  /// In ar_EG, this message translates to:
  /// **'ابحث بالاسم أو رقم التليفون...'**
  String get searchCustomersHint;

  /// No description provided for @filterAll.
  ///
  /// In ar_EG, this message translates to:
  /// **'الكل'**
  String get filterAll;

  /// No description provided for @filterHasDebt.
  ///
  /// In ar_EG, this message translates to:
  /// **'عليهم فلوس'**
  String get filterHasDebt;

  /// No description provided for @filterSettled.
  ///
  /// In ar_EG, this message translates to:
  /// **'خالصين'**
  String get filterSettled;

  /// No description provided for @filterLate.
  ///
  /// In ar_EG, this message translates to:
  /// **'متأخرين'**
  String get filterLate;

  /// No description provided for @sortHighestDebt.
  ///
  /// In ar_EG, this message translates to:
  /// **'أعلى دين'**
  String get sortHighestDebt;

  /// No description provided for @sortName.
  ///
  /// In ar_EG, this message translates to:
  /// **'الاسم'**
  String get sortName;

  /// No description provided for @sortLastActivity.
  ///
  /// In ar_EG, this message translates to:
  /// **'آخر نشاط'**
  String get sortLastActivity;

  /// No description provided for @addNewCustomer.
  ///
  /// In ar_EG, this message translates to:
  /// **'عميل جديد'**
  String get addNewCustomer;

  /// No description provided for @addCustomer.
  ///
  /// In ar_EG, this message translates to:
  /// **'إضافة عميل'**
  String get addCustomer;

  /// No description provided for @editCustomer.
  ///
  /// In ar_EG, this message translates to:
  /// **'تعديل العميل'**
  String get editCustomer;

  /// No description provided for @customerName.
  ///
  /// In ar_EG, this message translates to:
  /// **'اسم العميل'**
  String get customerName;

  /// No description provided for @customerNameHint.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثلاً: عم محمد البقال'**
  String get customerNameHint;

  /// No description provided for @customerNameRequired.
  ///
  /// In ar_EG, this message translates to:
  /// **'اسم العميل مطلوب'**
  String get customerNameRequired;

  /// No description provided for @customerNameTooShort.
  ///
  /// In ar_EG, this message translates to:
  /// **'الاسم يجب ألا يقل عن حرفين'**
  String get customerNameTooShort;

  /// No description provided for @customerPhone.
  ///
  /// In ar_EG, this message translates to:
  /// **'رقم الموبايل'**
  String get customerPhone;

  /// No description provided for @customerPhoneHint.
  ///
  /// In ar_EG, this message translates to:
  /// **'010xxxxxxxx'**
  String get customerPhoneHint;

  /// No description provided for @customerPhoneInvalid.
  ///
  /// In ar_EG, this message translates to:
  /// **'رقم الموبايل غير صحيح (010, 011, 012, 015)'**
  String get customerPhoneInvalid;

  /// No description provided for @customerNotes.
  ///
  /// In ar_EG, this message translates to:
  /// **'ملاحظات'**
  String get customerNotes;

  /// No description provided for @customerNotesHint.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثلاً: جار الدور التاني'**
  String get customerNotesHint;

  /// No description provided for @creditLimit.
  ///
  /// In ar_EG, this message translates to:
  /// **'حد الدين (اختياري)'**
  String get creditLimit;

  /// No description provided for @creditLimitHint.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثلاً: 1000'**
  String get creditLimitHint;

  /// No description provided for @noCustomersTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'دفترك فاضي!'**
  String get noCustomersTitle;

  /// No description provided for @noCustomersSubtitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'اضغط على الزرار تحت وضيف أول عميل عشان تبدأ تتابع حساباته بسهولة'**
  String get noCustomersSubtitle;

  /// No description provided for @noSearchResults.
  ///
  /// In ar_EG, this message translates to:
  /// **'مفيش عملاء بالاسم أو الرقم ده'**
  String get noSearchResults;

  /// No description provided for @duplicateCustomerWarning.
  ///
  /// In ar_EG, this message translates to:
  /// **'تنبيه: يوجد عميل مسجل بالفعل بنفس الاسم أو رقم التليفون'**
  String get duplicateCustomerWarning;

  /// No description provided for @customerDetails.
  ///
  /// In ar_EG, this message translates to:
  /// **'بيانات العميل'**
  String get customerDetails;

  /// No description provided for @callCustomer.
  ///
  /// In ar_EG, this message translates to:
  /// **'اتصال'**
  String get callCustomer;

  /// No description provided for @deleteCustomer.
  ///
  /// In ar_EG, this message translates to:
  /// **'حذف العميل'**
  String get deleteCustomer;

  /// No description provided for @deleteCustomerConfirm.
  ///
  /// In ar_EG, this message translates to:
  /// **'تأكيد حذف العميل'**
  String get deleteCustomerConfirm;

  /// No description provided for @deleteCustomerWarningDebt.
  ///
  /// In ar_EG, this message translates to:
  /// **'انتبه! العميل ده لسه عليه حساب قدره {amount}. متأكد إنك عاوز تحذفه؟'**
  String deleteCustomerWarningDebt(String amount);

  /// No description provided for @deleteCustomerSafeConfirm.
  ///
  /// In ar_EG, this message translates to:
  /// **'هل أنت متأكد من حذف العميل {name}؟'**
  String deleteCustomerSafeConfirm(String name);

  /// No description provided for @customerDeleted.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم حذف العميل بنجاح'**
  String get customerDeleted;

  /// No description provided for @customerSaved.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم حفظ بيانات العميل بنجاح'**
  String get customerSaved;

  /// No description provided for @lastActivityNever.
  ///
  /// In ar_EG, this message translates to:
  /// **'مفيش حركات سابقة'**
  String get lastActivityNever;

  /// No description provided for @lastActivityDate.
  ///
  /// In ar_EG, this message translates to:
  /// **'آخر حركة: {date}'**
  String lastActivityDate(String date);

  /// No description provided for @creditLimitLabel.
  ///
  /// In ar_EG, this message translates to:
  /// **'حد الدين: {amount}'**
  String creditLimitLabel(String amount);

  /// No description provided for @creditLimitExceeded.
  ///
  /// In ar_EG, this message translates to:
  /// **'تعدى حد الدين!'**
  String get creditLimitExceeded;

  /// No description provided for @heOwes.
  ///
  /// In ar_EG, this message translates to:
  /// **'عليه'**
  String get heOwes;

  /// No description provided for @hePaid.
  ///
  /// In ar_EG, this message translates to:
  /// **'له (دافع زيادة)'**
  String get hePaid;

  /// No description provided for @currentBalance.
  ///
  /// In ar_EG, this message translates to:
  /// **'الرصيد الحالي'**
  String get currentBalance;

  /// No description provided for @noTransactionsYet.
  ///
  /// In ar_EG, this message translates to:
  /// **'لا توجد معاملات مسجلة حتى الآن'**
  String get noTransactionsYet;

  /// No description provided for @addDebtTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'تسجيل دين جديد (عليه)'**
  String get addDebtTitle;

  /// No description provided for @addPaymentTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'تسجيل سداد (دفع)'**
  String get addPaymentTitle;

  /// No description provided for @amountLabel.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبلغ'**
  String get amountLabel;

  /// No description provided for @amountRequired.
  ///
  /// In ar_EG, this message translates to:
  /// **'يرجى إدخال مبلغ صحيح أكبر من صفر'**
  String get amountRequired;

  /// No description provided for @today.
  ///
  /// In ar_EG, this message translates to:
  /// **'النهارده'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In ar_EG, this message translates to:
  /// **'إمبارح'**
  String get yesterday;

  /// No description provided for @date.
  ///
  /// In ar_EG, this message translates to:
  /// **'التاريخ'**
  String get date;

  /// No description provided for @pickDate.
  ///
  /// In ar_EG, this message translates to:
  /// **'تحديد التاريخ'**
  String get pickDate;

  /// No description provided for @paymentMethod.
  ///
  /// In ar_EG, this message translates to:
  /// **'طريقة الدفع'**
  String get paymentMethod;

  /// No description provided for @methodCash.
  ///
  /// In ar_EG, this message translates to:
  /// **'كاش'**
  String get methodCash;

  /// No description provided for @methodInstapay.
  ///
  /// In ar_EG, this message translates to:
  /// **'إنستاباي'**
  String get methodInstapay;

  /// No description provided for @methodWallet.
  ///
  /// In ar_EG, this message translates to:
  /// **'محفظة'**
  String get methodWallet;

  /// No description provided for @methodOther.
  ///
  /// In ar_EG, this message translates to:
  /// **'أخرى'**
  String get methodOther;

  /// No description provided for @noteOptional.
  ///
  /// In ar_EG, this message translates to:
  /// **'ملاحظة (اختياري: سكر، زيت، شحن...)'**
  String get noteOptional;

  /// No description provided for @voiceDictation.
  ///
  /// In ar_EG, this message translates to:
  /// **'إملاء صوتي'**
  String get voiceDictation;

  /// No description provided for @listening.
  ///
  /// In ar_EG, this message translates to:
  /// **'جاري الاستماع... تكلّم الآن'**
  String get listening;

  /// No description provided for @speechNotAvailable.
  ///
  /// In ar_EG, this message translates to:
  /// **'الإملاء الصوتي غير متاح في هذا الجهاز'**
  String get speechNotAvailable;

  /// No description provided for @attachPhoto.
  ///
  /// In ar_EG, this message translates to:
  /// **'إرفاق صورة'**
  String get attachPhoto;

  /// No description provided for @camera.
  ///
  /// In ar_EG, this message translates to:
  /// **'الكاميرا'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In ar_EG, this message translates to:
  /// **'المعرض'**
  String get gallery;

  /// No description provided for @removePhoto.
  ///
  /// In ar_EG, this message translates to:
  /// **'حذف الصورة'**
  String get removePhoto;

  /// No description provided for @overpaymentTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبلغ أكبر من اللي عليه!'**
  String get overpaymentTitle;

  /// No description provided for @overpaymentMessage.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبلغ المدفوع ({paidAmount}) أكبر من اللي عليه ({dueAmount}). هل تسجل الزيادة ({creditAmount}) كرصيد له في حسابه؟'**
  String overpaymentMessage(
    String paidAmount,
    String dueAmount,
    String creditAmount,
  );

  /// No description provided for @overpaymentConfirm.
  ///
  /// In ar_EG, this message translates to:
  /// **'نعم، سجّل رصيد له'**
  String get overpaymentConfirm;

  /// No description provided for @transactionSaved.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم تسجيل الحركة بنجاح'**
  String get transactionSaved;

  /// No description provided for @undo.
  ///
  /// In ar_EG, this message translates to:
  /// **'تراجع'**
  String get undo;

  /// No description provided for @transactionUndone.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم التراجع عن تسجيل الحركة'**
  String get transactionUndone;

  /// No description provided for @transactionDetails.
  ///
  /// In ar_EG, this message translates to:
  /// **'تفاصيل المعاملة'**
  String get transactionDetails;

  /// No description provided for @editTransaction.
  ///
  /// In ar_EG, this message translates to:
  /// **'تعديل المعاملة'**
  String get editTransaction;

  /// No description provided for @deleteTransaction.
  ///
  /// In ar_EG, this message translates to:
  /// **'حذف المعاملة'**
  String get deleteTransaction;

  /// No description provided for @deleteTransactionConfirm.
  ///
  /// In ar_EG, this message translates to:
  /// **'هل أنت متأكد من حذف هذه المعاملة؟'**
  String get deleteTransactionConfirm;

  /// No description provided for @transactionDeleted.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم حذف المعاملة بنجاح'**
  String get transactionDeleted;

  /// No description provided for @viewPhoto.
  ///
  /// In ar_EG, this message translates to:
  /// **'عرض الصورة'**
  String get viewPhoto;

  /// No description provided for @creditLimitWarningTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'تنبيه حد الدين'**
  String get creditLimitWarningTitle;

  /// No description provided for @creditLimitExceededDialog.
  ///
  /// In ar_EG, this message translates to:
  /// **'{customerName} كده هيبقى عليه {newTotal} — مع إن الحد بتاعه {limit}'**
  String creditLimitExceededDialog(
    String customerName,
    String newTotal,
    String limit,
  );

  /// No description provided for @saveAnyway.
  ///
  /// In ar_EG, this message translates to:
  /// **'سجّل برضه'**
  String get saveAnyway;

  /// No description provided for @changeLimit.
  ///
  /// In ar_EG, this message translates to:
  /// **'غيّر الحد'**
  String get changeLimit;

  /// No description provided for @newCreditLimit.
  ///
  /// In ar_EG, this message translates to:
  /// **'حد الدين الجديد'**
  String get newCreditLimit;

  /// No description provided for @limitUpdated.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم تعديل حد الدين بنجاح'**
  String get limitUpdated;

  /// No description provided for @totalPayablesTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'عليك للموردين'**
  String get totalPayablesTitle;

  /// No description provided for @netMarketPosition.
  ///
  /// In ar_EG, this message translates to:
  /// **'صافي الموقف المالي'**
  String get netMarketPosition;

  /// No description provided for @netReceivables.
  ///
  /// In ar_EG, this message translates to:
  /// **'صافي ليك في السوق: {amount}'**
  String netReceivables(String amount);

  /// No description provided for @netPayables.
  ///
  /// In ar_EG, this message translates to:
  /// **'عليك عجز إجمالي: {amount}'**
  String netPayables(String amount);

  /// No description provided for @netSettled.
  ///
  /// In ar_EG, this message translates to:
  /// **'الحسابات متوازنة (0 جنيه)'**
  String get netSettled;

  /// No description provided for @addNewSupplier.
  ///
  /// In ar_EG, this message translates to:
  /// **'مورد جديد'**
  String get addNewSupplier;

  /// No description provided for @addSupplier.
  ///
  /// In ar_EG, this message translates to:
  /// **'إضافة مورد'**
  String get addSupplier;

  /// No description provided for @editSupplier.
  ///
  /// In ar_EG, this message translates to:
  /// **'تعديل المورد'**
  String get editSupplier;

  /// No description provided for @supplierName.
  ///
  /// In ar_EG, this message translates to:
  /// **'اسم المندوب / المورد'**
  String get supplierName;

  /// No description provided for @supplierNameHint.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثلاً: عماد مندوب جهينة'**
  String get supplierNameHint;

  /// No description provided for @supplierNameRequired.
  ///
  /// In ar_EG, this message translates to:
  /// **'اسم المورد مطلوب'**
  String get supplierNameRequired;

  /// No description provided for @company.
  ///
  /// In ar_EG, this message translates to:
  /// **'اسم الشركة / التوكيل'**
  String get company;

  /// No description provided for @companyHint.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثلاً: جهينة، شيبسي، الأهرام'**
  String get companyHint;

  /// No description provided for @visitDay.
  ///
  /// In ar_EG, this message translates to:
  /// **'يوم الزيارة الأسبوعي'**
  String get visitDay;

  /// No description provided for @noSpecificDay.
  ///
  /// In ar_EG, this message translates to:
  /// **'بدون يوم محدد'**
  String get noSpecificDay;

  /// No description provided for @supplierNotes.
  ///
  /// In ar_EG, this message translates to:
  /// **'ملاحظات'**
  String get supplierNotes;

  /// No description provided for @supplierNotesHint.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثلاً: بيعدي الساعة 10 الصبح'**
  String get supplierNotesHint;

  /// No description provided for @noSuppliersTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'دفتر الموردين فاضي!'**
  String get noSuppliersTitle;

  /// No description provided for @noSuppliersSubtitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'اضغط على الزرار تحت وضيف أول مورد أو شركة بتتعامل معاها'**
  String get noSuppliersSubtitle;

  /// No description provided for @noSupplierSearchResults.
  ///
  /// In ar_EG, this message translates to:
  /// **'مفيش موردين بالاسم أو الشركة دي'**
  String get noSupplierSearchResults;

  /// No description provided for @searchSuppliersHint.
  ///
  /// In ar_EG, this message translates to:
  /// **'ابحث باسم المندوب أو الشركة أو الرقم...'**
  String get searchSuppliersHint;

  /// No description provided for @supplierDetails.
  ///
  /// In ar_EG, this message translates to:
  /// **'بيانات المورد'**
  String get supplierDetails;

  /// No description provided for @iOweHim.
  ///
  /// In ar_EG, this message translates to:
  /// **'عليّا'**
  String get iOweHim;

  /// No description provided for @iPaidHim.
  ///
  /// In ar_EG, this message translates to:
  /// **'دفعتله'**
  String get iPaidHim;

  /// No description provided for @deleteSupplier.
  ///
  /// In ar_EG, this message translates to:
  /// **'حذف المورد'**
  String get deleteSupplier;

  /// No description provided for @deleteSupplierConfirm.
  ///
  /// In ar_EG, this message translates to:
  /// **'تأكيد حذف المورد'**
  String get deleteSupplierConfirm;

  /// No description provided for @deleteSupplierWarningDebt.
  ///
  /// In ar_EG, this message translates to:
  /// **'انتبه! المورد ده لسه ليه حساب عندك قدره {amount}. متأكد إنك عاوز تحذفه؟'**
  String deleteSupplierWarningDebt(String amount);

  /// No description provided for @deleteSupplierSafeConfirm.
  ///
  /// In ar_EG, this message translates to:
  /// **'هل أنت متأكد من حذف المورد {name}؟'**
  String deleteSupplierSafeConfirm(String name);

  /// No description provided for @supplierDeleted.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم حذف المورد بنجاح'**
  String get supplierDeleted;

  /// No description provided for @supplierSaved.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم حفظ بيانات المورد بنجاح'**
  String get supplierSaved;

  /// No description provided for @visitDayPrefix.
  ///
  /// In ar_EG, this message translates to:
  /// **'يوم الزيارة: {day}'**
  String visitDayPrefix(String day);

  /// No description provided for @sortCompany.
  ///
  /// In ar_EG, this message translates to:
  /// **'الشركة'**
  String get sortCompany;

  /// No description provided for @sortVisitDay.
  ///
  /// In ar_EG, this message translates to:
  /// **'يوم الزيارة'**
  String get sortVisitDay;

  /// No description provided for @dueCustomersTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'عملاء مستحقين تحصيل'**
  String get dueCustomersTitle;

  /// No description provided for @totalDueTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'إجمالي المستحق'**
  String get totalDueTitle;

  /// No description provided for @dueCustomersCount.
  ///
  /// In ar_EG, this message translates to:
  /// **'{count} عميل'**
  String dueCustomersCount(int count);

  /// No description provided for @dueHeaderSummary.
  ///
  /// In ar_EG, this message translates to:
  /// **'عندك {count} عملاء عليهم {amount}'**
  String dueHeaderSummary(int count, String amount);

  /// No description provided for @oldestDebtDays.
  ///
  /// In ar_EG, this message translates to:
  /// **'أقدم دين من {days} يوم'**
  String oldestDebtDays(int days);

  /// No description provided for @oldestDebtToday.
  ///
  /// In ar_EG, this message translates to:
  /// **'الدين مسجل اليوم'**
  String get oldestDebtToday;

  /// No description provided for @lastReminderDays.
  ///
  /// In ar_EG, this message translates to:
  /// **'آخر تذكير: من {days} يوم'**
  String lastReminderDays(int days);

  /// No description provided for @lastReminderToday.
  ///
  /// In ar_EG, this message translates to:
  /// **'آخر تذكير: اليوم'**
  String get lastReminderToday;

  /// No description provided for @neverReminded.
  ///
  /// In ar_EG, this message translates to:
  /// **'لم يتم التذكير بعد'**
  String get neverReminded;

  /// No description provided for @snoozedUntilDate.
  ///
  /// In ar_EG, this message translates to:
  /// **'مؤجل حتى {date}'**
  String snoozedUntilDate(String date);

  /// No description provided for @sendWhatsApp.
  ///
  /// In ar_EG, this message translates to:
  /// **'واتساب'**
  String get sendWhatsApp;

  /// No description provided for @sendSms.
  ///
  /// In ar_EG, this message translates to:
  /// **'رسالة SMS'**
  String get sendSms;

  /// No description provided for @moreActions.
  ///
  /// In ar_EG, this message translates to:
  /// **'المزيد'**
  String get moreActions;

  /// No description provided for @snooze3Days.
  ///
  /// In ar_EG, this message translates to:
  /// **'تأجيل 3 أيام'**
  String get snooze3Days;

  /// No description provided for @snooze7Days.
  ///
  /// In ar_EG, this message translates to:
  /// **'تأجيل أسبوع'**
  String get snooze7Days;

  /// No description provided for @cancelSnooze.
  ///
  /// In ar_EG, this message translates to:
  /// **'إلغاء التأجيل'**
  String get cancelSnooze;

  /// No description provided for @recordCollectionPayment.
  ///
  /// In ar_EG, this message translates to:
  /// **'تسجيل سداد'**
  String get recordCollectionPayment;

  /// No description provided for @didSendMessage.
  ///
  /// In ar_EG, this message translates to:
  /// **'هل اتبعتت الرسالة؟'**
  String get didSendMessage;

  /// No description provided for @didSendMessageDesc.
  ///
  /// In ar_EG, this message translates to:
  /// **'هل قمت بإرسال رسالة التذكير للعميل {name} عبر واتساب؟'**
  String didSendMessageDesc(String name);

  /// No description provided for @yesSent.
  ///
  /// In ar_EG, this message translates to:
  /// **'أيوة اتبعتت'**
  String get yesSent;

  /// No description provided for @notSent.
  ///
  /// In ar_EG, this message translates to:
  /// **'لأ، متبعتتش'**
  String get notSent;

  /// No description provided for @reminderMarkedSent.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم تسجيل التذكير بنجاح'**
  String get reminderMarkedSent;

  /// No description provided for @snoozedSuccess.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم تأجيل التذكير'**
  String get snoozedSuccess;

  /// No description provided for @noDueCustomersTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'مفيش تحصيلات مستحقة النهاردة 🎉'**
  String get noDueCustomersTitle;

  /// No description provided for @noDueCustomersSubtitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'كل الزباين حساباتهم مظبوطة أو تم تذكيرهم قريباً.'**
  String get noDueCustomersSubtitle;

  /// No description provided for @whatsAppNotInstalled.
  ///
  /// In ar_EG, this message translates to:
  /// **'تطبيق واتساب غير مثبت. هل تريد إرسال رسالة SMS بدلاً منه؟'**
  String get whatsAppNotInstalled;

  /// No description provided for @openSms.
  ///
  /// In ar_EG, this message translates to:
  /// **'إرسال SMS'**
  String get openSms;

  /// No description provided for @growthFooter.
  ///
  /// In ar_EG, this message translates to:
  /// **'\nتم الإرسال عبر تطبيق كشكول 📒'**
  String get growthFooter;

  /// No description provided for @statementTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'كشف حساب'**
  String get statementTitle;

  /// No description provided for @generateStatement.
  ///
  /// In ar_EG, this message translates to:
  /// **'استخراج كشف حساب'**
  String get generateStatement;

  /// No description provided for @statementAllTime.
  ///
  /// In ar_EG, this message translates to:
  /// **'كل المعاملات'**
  String get statementAllTime;

  /// No description provided for @statementThisMonth.
  ///
  /// In ar_EG, this message translates to:
  /// **'هذا الشهر'**
  String get statementThisMonth;

  /// No description provided for @statementCustomRange.
  ///
  /// In ar_EG, this message translates to:
  /// **'فترة مخصصة'**
  String get statementCustomRange;

  /// No description provided for @statementFormatA4.
  ///
  /// In ar_EG, this message translates to:
  /// **'ورقة A4'**
  String get statementFormatA4;

  /// No description provided for @statementFormatReceipt.
  ///
  /// In ar_EG, this message translates to:
  /// **'إيصال حراري (80mm)'**
  String get statementFormatReceipt;

  /// No description provided for @dateCol.
  ///
  /// In ar_EG, this message translates to:
  /// **'التاريخ'**
  String get dateCol;

  /// No description provided for @descriptionCol.
  ///
  /// In ar_EG, this message translates to:
  /// **'البيان'**
  String get descriptionCol;

  /// No description provided for @debtCol.
  ///
  /// In ar_EG, this message translates to:
  /// **'عليه'**
  String get debtCol;

  /// No description provided for @paymentCol.
  ///
  /// In ar_EG, this message translates to:
  /// **'دفع'**
  String get paymentCol;

  /// No description provided for @balanceCol.
  ///
  /// In ar_EG, this message translates to:
  /// **'الرصيد'**
  String get balanceCol;

  /// No description provided for @startingBalance.
  ///
  /// In ar_EG, this message translates to:
  /// **'رصيد ما قبل الفترة'**
  String get startingBalance;

  /// No description provided for @finalBalance.
  ///
  /// In ar_EG, this message translates to:
  /// **'الرصيد النهائي'**
  String get finalBalance;

  /// No description provided for @periodLabel.
  ///
  /// In ar_EG, this message translates to:
  /// **'الفترة: {period}'**
  String periodLabel(String period);

  /// No description provided for @statementGeneratedAt.
  ///
  /// In ar_EG, this message translates to:
  /// **'تاريخ الاستخراج: {date}'**
  String statementGeneratedAt(String date);

  /// No description provided for @shareStatement.
  ///
  /// In ar_EG, this message translates to:
  /// **'مشاركة كشف الحساب'**
  String get shareStatement;

  /// No description provided for @printStatement.
  ///
  /// In ar_EG, this message translates to:
  /// **'طباعة'**
  String get printStatement;

  /// No description provided for @statementShareSubject.
  ///
  /// In ar_EG, this message translates to:
  /// **'كشف حساب - {name}'**
  String statementShareSubject(String name);

  /// No description provided for @totalDebits.
  ///
  /// In ar_EG, this message translates to:
  /// **'إجمالي المشتريات / السلف'**
  String get totalDebits;

  /// No description provided for @totalCredits.
  ///
  /// In ar_EG, this message translates to:
  /// **'إجمالي المسدد'**
  String get totalCredits;

  /// No description provided for @drawerTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'تقفيل الدرج والخزينة'**
  String get drawerTitle;

  /// No description provided for @todayDrawer.
  ///
  /// In ar_EG, this message translates to:
  /// **'درج اليوم'**
  String get todayDrawer;

  /// No description provided for @expectedInDrawer.
  ///
  /// In ar_EG, this message translates to:
  /// **'المفروض في الدرج'**
  String get expectedInDrawer;

  /// No description provided for @openingCash.
  ///
  /// In ar_EG, this message translates to:
  /// **'رصيد الافتتاح'**
  String get openingCash;

  /// No description provided for @openingCashHint.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبلغ اللي بدأت بيه اليوم'**
  String get openingCashHint;

  /// No description provided for @editOpeningCash.
  ///
  /// In ar_EG, this message translates to:
  /// **'تعديل رصيد الافتتاح'**
  String get editOpeningCash;

  /// No description provided for @cashSales.
  ///
  /// In ar_EG, this message translates to:
  /// **'مبيعات كاش'**
  String get cashSales;

  /// No description provided for @addCashSales.
  ///
  /// In ar_EG, this message translates to:
  /// **'تسجيل مبيعات كاش'**
  String get addCashSales;

  /// No description provided for @cashIn.
  ///
  /// In ar_EG, this message translates to:
  /// **'داخل الدرج (كاش)'**
  String get cashIn;

  /// No description provided for @digitalIn.
  ///
  /// In ar_EG, this message translates to:
  /// **'داخل إلكتروني'**
  String get digitalIn;

  /// No description provided for @cashOut.
  ///
  /// In ar_EG, this message translates to:
  /// **'خارج من الدرج (كاش)'**
  String get cashOut;

  /// No description provided for @customerPaymentsCash.
  ///
  /// In ar_EG, this message translates to:
  /// **'تحصيلات عملاء (كاش)'**
  String get customerPaymentsCash;

  /// No description provided for @customerPaymentsDigital.
  ///
  /// In ar_EG, this message translates to:
  /// **'تحصيلات عملاء (إلكتروني)'**
  String get customerPaymentsDigital;

  /// No description provided for @supplierPaymentsCash.
  ///
  /// In ar_EG, this message translates to:
  /// **'دفعات موردين (كاش)'**
  String get supplierPaymentsCash;

  /// No description provided for @expensesCash.
  ///
  /// In ar_EG, this message translates to:
  /// **'مصاريف المحل (كاش)'**
  String get expensesCash;

  /// No description provided for @addExpense.
  ///
  /// In ar_EG, this message translates to:
  /// **'تسجيل مصروف'**
  String get addExpense;

  /// No description provided for @editExpense.
  ///
  /// In ar_EG, this message translates to:
  /// **'تعديل المصروف'**
  String get editExpense;

  /// No description provided for @deleteExpense.
  ///
  /// In ar_EG, this message translates to:
  /// **'حذف المصروف'**
  String get deleteExpense;

  /// No description provided for @deleteExpenseConfirm.
  ///
  /// In ar_EG, this message translates to:
  /// **'هل أنت متأكد من حذف هذا المصروف؟'**
  String get deleteExpenseConfirm;

  /// No description provided for @expenseCategory.
  ///
  /// In ar_EG, this message translates to:
  /// **'بند المصروف'**
  String get expenseCategory;

  /// No description provided for @catRent.
  ///
  /// In ar_EG, this message translates to:
  /// **'إيجار'**
  String get catRent;

  /// No description provided for @catElectricity.
  ///
  /// In ar_EG, this message translates to:
  /// **'كهرباء ومرافق'**
  String get catElectricity;

  /// No description provided for @catSalary.
  ///
  /// In ar_EG, this message translates to:
  /// **'يوميات ومرتبات'**
  String get catSalary;

  /// No description provided for @catSupplies.
  ///
  /// In ar_EG, this message translates to:
  /// **'بضاعة ومستلزمات'**
  String get catSupplies;

  /// No description provided for @catSupplierPayment.
  ///
  /// In ar_EG, this message translates to:
  /// **'دفعة مورد'**
  String get catSupplierPayment;

  /// No description provided for @catOther.
  ///
  /// In ar_EG, this message translates to:
  /// **'أخرى'**
  String get catOther;

  /// No description provided for @closeDay.
  ///
  /// In ar_EG, this message translates to:
  /// **'قفّل اليوم'**
  String get closeDay;

  /// No description provided for @reopenDay.
  ///
  /// In ar_EG, this message translates to:
  /// **'إعادة فتح اليوم'**
  String get reopenDay;

  /// No description provided for @reopenDayConfirm.
  ///
  /// In ar_EG, this message translates to:
  /// **'هل تريد إعادة فتح هذا اليوم للتعديل عليه؟'**
  String get reopenDayConfirm;

  /// No description provided for @dayClosedSuccess.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم تقفيل اليوم بنجاح'**
  String get dayClosedSuccess;

  /// No description provided for @dayReopenedSuccess.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم إعادة فتح اليوم بنجاح'**
  String get dayReopenedSuccess;

  /// No description provided for @dayIsClosed.
  ///
  /// In ar_EG, this message translates to:
  /// **'اليوم مقفول'**
  String get dayIsClosed;

  /// No description provided for @dayIsOpen.
  ///
  /// In ar_EG, this message translates to:
  /// **'اليوم مفتوح'**
  String get dayIsOpen;

  /// No description provided for @actualCountLabel.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبلغ الفعلي في الدرج'**
  String get actualCountLabel;

  /// No description provided for @actualCountHint.
  ///
  /// In ar_EG, this message translates to:
  /// **'اكتب المبلغ اللي عديته في الدرج'**
  String get actualCountHint;

  /// No description provided for @drawerBalanced.
  ///
  /// In ar_EG, this message translates to:
  /// **'الدرج مظبوط تمام 🎉'**
  String get drawerBalanced;

  /// No description provided for @drawerShortage.
  ///
  /// In ar_EG, this message translates to:
  /// **'عجز في الدرج'**
  String get drawerShortage;

  /// No description provided for @drawerSurplus.
  ///
  /// In ar_EG, this message translates to:
  /// **'زيادة في الدرج'**
  String get drawerSurplus;

  /// No description provided for @differenceAmount.
  ///
  /// In ar_EG, this message translates to:
  /// **'الفرق: {amount}'**
  String differenceAmount(String amount);

  /// No description provided for @closeDaySummary.
  ///
  /// In ar_EG, this message translates to:
  /// **'ملخص تقفيل اليوم'**
  String get closeDaySummary;

  /// No description provided for @confirmCloseDay.
  ///
  /// In ar_EG, this message translates to:
  /// **'تأكيد التقفيل'**
  String get confirmCloseDay;

  /// No description provided for @historyTab.
  ///
  /// In ar_EG, this message translates to:
  /// **'سجل الأيام'**
  String get historyTab;

  /// No description provided for @todayTab.
  ///
  /// In ar_EG, this message translates to:
  /// **'الدرج اليوم'**
  String get todayTab;

  /// No description provided for @monthlyTotals.
  ///
  /// In ar_EG, this message translates to:
  /// **'إجمالي الشهر'**
  String get monthlyTotals;

  /// No description provided for @monthlySales.
  ///
  /// In ar_EG, this message translates to:
  /// **'مبيعات كاش'**
  String get monthlySales;

  /// No description provided for @monthlyExpenses.
  ///
  /// In ar_EG, this message translates to:
  /// **'مصاريف كاش'**
  String get monthlyExpenses;

  /// No description provided for @monthlyNet.
  ///
  /// In ar_EG, this message translates to:
  /// **'صافي الدرج'**
  String get monthlyNet;

  /// No description provided for @drawerNotes.
  ///
  /// In ar_EG, this message translates to:
  /// **'ملاحظات التقفيل (اختياري)'**
  String get drawerNotes;

  /// No description provided for @noExpensesYet.
  ///
  /// In ar_EG, this message translates to:
  /// **'مفيش مصاريف متسجلة النهاردة'**
  String get noExpensesYet;

  /// No description provided for @noHistoryYet.
  ///
  /// In ar_EG, this message translates to:
  /// **'مفيش أيام سابقة مسجلة'**
  String get noHistoryYet;

  /// No description provided for @expenseAddedSuccess.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم تسجيل المصروف بنجاح'**
  String get expenseAddedSuccess;

  /// No description provided for @cashSalesAddedSuccess.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم تسجيل المبيعات الكاش بنجاح'**
  String get cashSalesAddedSuccess;

  /// No description provided for @openingCashUpdatedSuccess.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم تعديل رصيد الافتتاح بنجاح'**
  String get openingCashUpdatedSuccess;

  /// No description provided for @dayDetails.
  ///
  /// In ar_EG, this message translates to:
  /// **'تفاصيل اليوم'**
  String get dayDetails;

  /// No description provided for @closedAtTime.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم التقفيل في: {time}'**
  String closedAtTime(String time);

  /// No description provided for @readOnlyDayNotice.
  ///
  /// In ar_EG, this message translates to:
  /// **'هذا اليوم مقفول. لإجراء تعديلات اضغط على إعادة فتح اليوم.'**
  String get readOnlyDayNotice;

  /// No description provided for @privacyModeTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'وضع الخصوصية'**
  String get privacyModeTitle;

  /// No description provided for @privacyModeSubtitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'إخفاء مبالغ الفلوس في الشاشة والودجت (••••••)'**
  String get privacyModeSubtitle;

  /// No description provided for @shareAppTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'شارك التطبيق'**
  String get shareAppTitle;

  /// No description provided for @shareAppSubtitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'ابعت كشكول لصحابك أصحاب المحلات'**
  String get shareAppSubtitle;

  /// No description provided for @shopCodeLabel.
  ///
  /// In ar_EG, this message translates to:
  /// **'كود المحل: {code}'**
  String shopCodeLabel(String code);

  /// No description provided for @growthFooterToggleTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'إخفاء توقيع كشكول من الرسائل'**
  String get growthFooterToggleTitle;

  /// No description provided for @growthFooterToggleSubtitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'متاح في الباقة المدفوعة 🔒'**
  String get growthFooterToggleSubtitle;

  /// No description provided for @codeCopied.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم نسخ الكود'**
  String get codeCopied;

  /// No description provided for @main1.
  ///
  /// In ar_EG, this message translates to:
  /// **'كشكول'**
  String get main1;

  /// No description provided for @notebookImportButton1.
  ///
  /// In ar_EG, this message translates to:
  /// **'انقل حساباتك من الكشكول 📒'**
  String get notebookImportButton1;

  /// No description provided for @notebookImportButton2.
  ///
  /// In ar_EG, this message translates to:
  /// **'مش لازم تنقل كل حركة قديمة: كفاية اسم العميل واللي عليه دلوقتي.'**
  String get notebookImportButton2;

  /// No description provided for @notebookImportButton3.
  ///
  /// In ar_EG, this message translates to:
  /// **'العملاء وحساباتهم'**
  String get notebookImportButton3;

  /// No description provided for @notebookImportButton4.
  ///
  /// In ar_EG, this message translates to:
  /// **'سطر لكل عميل: الاسم والموبايل والمبلغ اللي عليه'**
  String get notebookImportButton4;

  /// No description provided for @notebookImportButton5.
  ///
  /// In ar_EG, this message translates to:
  /// **'قسط قديم'**
  String get notebookImportButton5;

  /// No description provided for @notebookImportButton6.
  ///
  /// In ar_EG, this message translates to:
  /// **'السعر، واللي اتدفع، والأقساط الباقية وميعاد الجاي'**
  String get notebookImportButton6;

  /// No description provided for @notebookImportButton7.
  ///
  /// In ar_EG, this message translates to:
  /// **'انقل من الكشكول'**
  String get notebookImportButton7;

  /// No description provided for @oldInstallmentImportScreen1.
  ///
  /// In ar_EG, this message translates to:
  /// **'ميعاد القسط الجاي'**
  String get oldInstallmentImportScreen1;

  /// No description provided for @oldInstallmentImportScreen2.
  ///
  /// In ar_EG, this message translates to:
  /// **'اتحفظ القسط ✓'**
  String get oldInstallmentImportScreen2;

  /// No description provided for @oldInstallmentImportScreen3.
  ///
  /// In ar_EG, this message translates to:
  /// **'فاضل {remaining} على {countValue} قسط، أولهم يوم {nextDue}.'**
  String oldInstallmentImportScreen3(
    Object remaining,
    Object countValue,
    Object nextDue,
  );

  /// No description provided for @oldInstallmentImportScreen4.
  ///
  /// In ar_EG, this message translates to:
  /// **'خلصت'**
  String get oldInstallmentImportScreen4;

  /// No description provided for @oldInstallmentImportScreen5.
  ///
  /// In ar_EG, this message translates to:
  /// **'قسط تاني'**
  String get oldInstallmentImportScreen5;

  /// No description provided for @oldInstallmentImportScreen6.
  ///
  /// In ar_EG, this message translates to:
  /// **'حصلت مشكلة في الحفظ، مفيش حاجة اتحفظت'**
  String get oldInstallmentImportScreen6;

  /// No description provided for @oldInstallmentImportScreen7.
  ///
  /// In ar_EG, this message translates to:
  /// **' شهرياً'**
  String get oldInstallmentImportScreen7;

  /// No description provided for @oldInstallmentImportScreen8.
  ///
  /// In ar_EG, this message translates to:
  /// **' أسبوعياً'**
  String get oldInstallmentImportScreen8;

  /// No description provided for @oldInstallmentImportScreen9.
  ///
  /// In ar_EG, this message translates to:
  /// **'فاضل {remaining} — {count} قسط × حوالي {count2}{monthly}'**
  String oldInstallmentImportScreen9(
    Object remaining,
    Object count,
    Object count2,
    Object monthly,
  );

  /// No description provided for @oldInstallmentImportScreen10.
  ///
  /// In ar_EG, this message translates to:
  /// **'قسط قديم من الكشكول'**
  String get oldInstallmentImportScreen10;

  /// No description provided for @oldInstallmentImportScreen11.
  ///
  /// In ar_EG, this message translates to:
  /// **'قسط قديم ({savedCount})'**
  String oldInstallmentImportScreen11(Object savedCount);

  /// No description provided for @oldInstallmentImportScreen12.
  ///
  /// In ar_EG, this message translates to:
  /// **'للأقساط اللي بدأت قبل التطبيق: اكتب السعر، واللي اتدفع لحد دلوقتي، وعدد الأقساط الباقية. التطبيق هيعمل جدول الباقي بس، ومش هيحسب المدفوع قبل كده في درج النهارده.'**
  String get oldInstallmentImportScreen12;

  /// No description provided for @oldInstallmentImportScreen13.
  ///
  /// In ar_EG, this message translates to:
  /// **'العميل'**
  String get oldInstallmentImportScreen13;

  /// No description provided for @oldInstallmentImportScreen14.
  ///
  /// In ar_EG, this message translates to:
  /// **'اسم العميل'**
  String get oldInstallmentImportScreen14;

  /// No description provided for @oldInstallmentImportScreen15.
  ///
  /// In ar_EG, this message translates to:
  /// **'اكتب اسم عميل موجود أو جديد'**
  String get oldInstallmentImportScreen15;

  /// No description provided for @oldInstallmentImportScreen16.
  ///
  /// In ar_EG, this message translates to:
  /// **'اكتب اسم العميل'**
  String get oldInstallmentImportScreen16;

  /// No description provided for @oldInstallmentImportScreen17.
  ///
  /// In ar_EG, this message translates to:
  /// **'موبايل العميل (لو جديد — اختياري)'**
  String get oldInstallmentImportScreen17;

  /// No description provided for @oldInstallmentImportScreen18.
  ///
  /// In ar_EG, this message translates to:
  /// **'رقم الموبايل غلط'**
  String get oldInstallmentImportScreen18;

  /// No description provided for @oldInstallmentImportScreen19.
  ///
  /// In ar_EG, this message translates to:
  /// **'القسط'**
  String get oldInstallmentImportScreen19;

  /// No description provided for @oldInstallmentImportScreen20.
  ///
  /// In ar_EG, this message translates to:
  /// **'السلعة'**
  String get oldInstallmentImportScreen20;

  /// No description provided for @oldInstallmentImportScreen21.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثلاً: تلاجة توشيبا'**
  String get oldInstallmentImportScreen21;

  /// No description provided for @oldInstallmentImportScreen22.
  ///
  /// In ar_EG, this message translates to:
  /// **'اكتب اسم السلعة'**
  String get oldInstallmentImportScreen22;

  /// No description provided for @oldInstallmentImportScreen23.
  ///
  /// In ar_EG, this message translates to:
  /// **'السعر الإجمالي'**
  String get oldInstallmentImportScreen23;

  /// No description provided for @oldInstallmentImportScreen24.
  ///
  /// In ar_EG, this message translates to:
  /// **'ج'**
  String get oldInstallmentImportScreen24;

  /// No description provided for @oldInstallmentImportScreen25.
  ///
  /// In ar_EG, this message translates to:
  /// **'مطلوب'**
  String get oldInstallmentImportScreen25;

  /// No description provided for @oldInstallmentImportScreen26.
  ///
  /// In ar_EG, this message translates to:
  /// **'غلط'**
  String get oldInstallmentImportScreen26;

  /// No description provided for @oldInstallmentImportScreen27.
  ///
  /// In ar_EG, this message translates to:
  /// **'اتدفع لحد دلوقتي'**
  String get oldInstallmentImportScreen27;

  /// No description provided for @oldInstallmentImportScreen28.
  ///
  /// In ar_EG, this message translates to:
  /// **'لازم يكون أقل من السعر'**
  String get oldInstallmentImportScreen28;

  /// No description provided for @oldInstallmentImportScreen29.
  ///
  /// In ar_EG, this message translates to:
  /// **'عدد الأقساط الباقية'**
  String get oldInstallmentImportScreen29;

  /// No description provided for @oldInstallmentImportScreen30.
  ///
  /// In ar_EG, this message translates to:
  /// **'من 1 لـ 120'**
  String get oldInstallmentImportScreen30;

  /// No description provided for @oldInstallmentImportScreen31.
  ///
  /// In ar_EG, this message translates to:
  /// **'الجاي: {nextDue}'**
  String oldInstallmentImportScreen31(Object nextDue);

  /// No description provided for @oldInstallmentImportScreen32.
  ///
  /// In ar_EG, this message translates to:
  /// **'شهري'**
  String get oldInstallmentImportScreen32;

  /// No description provided for @oldInstallmentImportScreen33.
  ///
  /// In ar_EG, this message translates to:
  /// **'أسبوعي'**
  String get oldInstallmentImportScreen33;

  /// No description provided for @oldInstallmentImportScreen34.
  ///
  /// In ar_EG, this message translates to:
  /// **'الضامن (اختياري)'**
  String get oldInstallmentImportScreen34;

  /// No description provided for @oldInstallmentImportScreen35.
  ///
  /// In ar_EG, this message translates to:
  /// **'اسم الضامن'**
  String get oldInstallmentImportScreen35;

  /// No description provided for @oldInstallmentImportScreen36.
  ///
  /// In ar_EG, this message translates to:
  /// **'موبايل الضامن'**
  String get oldInstallmentImportScreen36;

  /// No description provided for @oldInstallmentImportScreen37.
  ///
  /// In ar_EG, this message translates to:
  /// **'صور من الكشكول أو العقد (اختياري — بتفضل على الموبايل)'**
  String get oldInstallmentImportScreen37;

  /// No description provided for @oldInstallmentImportScreen38.
  ///
  /// In ar_EG, this message translates to:
  /// **'تقدر تضيف كذا صورة: صفحات الكشكول، العقد، بطاقة الضامن…'**
  String get oldInstallmentImportScreen38;

  /// No description provided for @oldInstallmentImportScreen39.
  ///
  /// In ar_EG, this message translates to:
  /// **'{photosLength} صورة — هتتحفظ في صور العميل'**
  String oldInstallmentImportScreen39(Object photosLength);

  /// No description provided for @oldInstallmentImportScreen40.
  ///
  /// In ar_EG, this message translates to:
  /// **'بيحفظ…'**
  String get oldInstallmentImportScreen40;

  /// No description provided for @oldInstallmentImportScreen41.
  ///
  /// In ar_EG, this message translates to:
  /// **'احفظ القسط'**
  String get oldInstallmentImportScreen41;

  /// No description provided for @notebookImportScreen1.
  ///
  /// In ar_EG, this message translates to:
  /// **'الحسابات دي لحد يوم'**
  String get notebookImportScreen1;

  /// No description provided for @notebookImportScreen2.
  ///
  /// In ar_EG, this message translates to:
  /// **'سطر {firstError}: {error}'**
  String notebookImportScreen2(Object firstError, Object error);

  /// No description provided for @notebookImportScreen3.
  ///
  /// In ar_EG, this message translates to:
  /// **'اكتب اسم عميل واحد على الأقل'**
  String get notebookImportScreen3;

  /// No description provided for @notebookImportScreen4.
  ///
  /// In ar_EG, this message translates to:
  /// **'اتحفظ ✓'**
  String get notebookImportScreen4;

  /// No description provided for @notebookImportScreen5.
  ///
  /// In ar_EG, this message translates to:
  /// **'{newCustomers} عميل جديد'**
  String notebookImportScreen5(Object newCustomers);

  /// No description provided for @notebookImportScreen6.
  ///
  /// In ar_EG, this message translates to:
  /// **'{existingCustomers} عميل موجود اتضاف على حسابه'**
  String notebookImportScreen6(Object existingCustomers);

  /// No description provided for @notebookImportScreen7.
  ///
  /// In ar_EG, this message translates to:
  /// **'إجمالي: {totalPiasters}'**
  String notebookImportScreen7(Object totalPiasters);

  /// No description provided for @notebookImportScreen8.
  ///
  /// In ar_EG, this message translates to:
  /// **'صفحة تانية'**
  String get notebookImportScreen8;

  /// No description provided for @notebookImportScreen9.
  ///
  /// In ar_EG, this message translates to:
  /// **'تخرج من غير ما تحفظ؟'**
  String get notebookImportScreen9;

  /// No description provided for @notebookImportScreen10.
  ///
  /// In ar_EG, this message translates to:
  /// **'اللي كتبته في الصفحة دي مش هيتحفظ.'**
  String get notebookImportScreen10;

  /// No description provided for @notebookImportScreen11.
  ///
  /// In ar_EG, this message translates to:
  /// **'كمّل'**
  String get notebookImportScreen11;

  /// No description provided for @notebookImportScreen12.
  ///
  /// In ar_EG, this message translates to:
  /// **'اخرج'**
  String get notebookImportScreen12;

  /// No description provided for @notebookImportScreen13.
  ///
  /// In ar_EG, this message translates to:
  /// **'انقل الكشكول 📒'**
  String get notebookImportScreen13;

  /// No description provided for @notebookImportScreen14.
  ///
  /// In ar_EG, this message translates to:
  /// **'انقل الكشكول — صفحة {savedPages}'**
  String notebookImportScreen14(Object savedPages);

  /// No description provided for @notebookImportScreen15.
  ///
  /// In ar_EG, this message translates to:
  /// **'سطر جديد'**
  String get notebookImportScreen15;

  /// No description provided for @notebookImportScreen16.
  ///
  /// In ar_EG, this message translates to:
  /// **'{validLength} عميل'**
  String notebookImportScreen16(Object validLength);

  /// No description provided for @notebookImportScreen17.
  ///
  /// In ar_EG, this message translates to:
  /// **'احفظ'**
  String get notebookImportScreen17;

  /// No description provided for @notebookImportScreen18.
  ///
  /// In ar_EG, this message translates to:
  /// **'اكتب كل عميل في سطر: الاسم، والموبايل لو موجود، والمبلغ اللي عليه. دوس \"التالي\" في الكيبورد عشان تنقل بسرعة.'**
  String get notebookImportScreen18;

  /// No description provided for @notebookImportScreen19.
  ///
  /// In ar_EG, this message translates to:
  /// **'الحساب لحد النهارده'**
  String get notebookImportScreen19;

  /// No description provided for @notebookImportScreen20.
  ///
  /// In ar_EG, this message translates to:
  /// **'لحد {asOf}'**
  String notebookImportScreen20(Object asOf);

  /// No description provided for @notebookImportScreen21.
  ///
  /// In ar_EG, this message translates to:
  /// **'صور صفحة الكشكول (اختياري): بتتحفظ مع كل العملاء اللي في الصفحة'**
  String get notebookImportScreen21;

  /// No description provided for @notebookImportScreen22.
  ///
  /// In ar_EG, this message translates to:
  /// **'{pagePhotosLength} صورة للصفحة — هتتحفظ مع كل العملاء اللي في الصفحة'**
  String notebookImportScreen22(Object pagePhotosLength);

  /// No description provided for @notebookImportScreen23.
  ///
  /// In ar_EG, this message translates to:
  /// **'الصفحة'**
  String get notebookImportScreen23;

  /// No description provided for @notebookImportScreen24.
  ///
  /// In ar_EG, this message translates to:
  /// **'صور للعميل ده'**
  String get notebookImportScreen24;

  /// No description provided for @notebookImportScreen25.
  ///
  /// In ar_EG, this message translates to:
  /// **'شيل السطر'**
  String get notebookImportScreen25;

  /// No description provided for @notebookImportScreen26.
  ///
  /// In ar_EG, this message translates to:
  /// **'الموبايل (اختياري)'**
  String get notebookImportScreen26;

  /// No description provided for @notebookImportScreen27.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبلغ'**
  String get notebookImportScreen27;

  /// No description provided for @notebookImportScreen28.
  ///
  /// In ar_EG, this message translates to:
  /// **'بيدوّر…'**
  String get notebookImportScreen28;

  /// No description provided for @notebookImportScreen29.
  ///
  /// In ar_EG, this message translates to:
  /// **'موجود عندك \"{name}\" — المبلغ هيتضاف على حسابه'**
  String notebookImportScreen29(Object name);

  /// No description provided for @notebookImportScreen30.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبلغ عليه (العميل مديون)'**
  String get notebookImportScreen30;

  /// No description provided for @notebookImportScreen31.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبلغ له (انت مديون للعميل)'**
  String get notebookImportScreen31;

  /// No description provided for @notebookImportScreen32.
  ///
  /// In ar_EG, this message translates to:
  /// **'عليه'**
  String get notebookImportScreen32;

  /// No description provided for @notebookImportScreen33.
  ///
  /// In ar_EG, this message translates to:
  /// **'له'**
  String get notebookImportScreen33;

  /// No description provided for @notebookImportService1.
  ///
  /// In ar_EG, this message translates to:
  /// **'رصيد سابق من الكشكول'**
  String get notebookImportService1;

  /// No description provided for @notebookImportService2.
  ///
  /// In ar_EG, this message translates to:
  /// **'صفحة من الكشكول'**
  String get notebookImportService2;

  /// No description provided for @notebookImportService3.
  ///
  /// In ar_EG, this message translates to:
  /// **'الاسم ناقص'**
  String get notebookImportService3;

  /// No description provided for @notebookImportService4.
  ///
  /// In ar_EG, this message translates to:
  /// **'الاسم طويل جداً'**
  String get notebookImportService4;

  /// No description provided for @notebookImportService5.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبلغ غلط'**
  String get notebookImportService5;

  /// No description provided for @notebookImportService6.
  ///
  /// In ar_EG, this message translates to:
  /// **'المدفوع مينفعش يبقى بالسالب'**
  String get notebookImportService6;

  /// No description provided for @notebookImportService7.
  ///
  /// In ar_EG, this message translates to:
  /// **'المدفوع لازم يكون أقل من السعر الإجمالي'**
  String get notebookImportService7;

  /// No description provided for @notebookImportService8.
  ///
  /// In ar_EG, this message translates to:
  /// **'عدد الأقساط الباقية لازم يكون 1 على الأقل'**
  String get notebookImportService8;

  /// No description provided for @notebookImportService9.
  ///
  /// In ar_EG, this message translates to:
  /// **'مستورد من الكشكول — مدفوع قبل كده {paidPiasters}'**
  String notebookImportService9(Object paidPiasters);

  /// No description provided for @notebookImportService10.
  ///
  /// In ar_EG, this message translates to:
  /// **'قسط قديم: {trim} (الباقي من {totalPricePiasters})'**
  String notebookImportService10(Object trim, Object totalPricePiasters);

  /// No description provided for @notebookImportService11.
  ///
  /// In ar_EG, this message translates to:
  /// **'قسط: {trim}'**
  String notebookImportService11(Object trim);

  /// No description provided for @installmentsScreen1.
  ///
  /// In ar_EG, this message translates to:
  /// **'نظام الأقساط 📋'**
  String get installmentsScreen1;

  /// No description provided for @installmentsScreen2.
  ///
  /// In ar_EG, this message translates to:
  /// **'ابحث باسم العميل، السلعة، الموبايل، أو الضامن...'**
  String get installmentsScreen2;

  /// No description provided for @installmentsScreen3.
  ///
  /// In ar_EG, this message translates to:
  /// **'إجمالي الأقساط'**
  String get installmentsScreen3;

  /// No description provided for @installmentsScreen4.
  ///
  /// In ar_EG, this message translates to:
  /// **'أقساط متأخرة'**
  String get installmentsScreen4;

  /// No description provided for @installmentsScreen5.
  ///
  /// In ar_EG, this message translates to:
  /// **'خطط نشطة'**
  String get installmentsScreen5;

  /// No description provided for @installmentsScreen6.
  ///
  /// In ar_EG, this message translates to:
  /// **'الكل'**
  String get installmentsScreen6;

  /// No description provided for @installmentsScreen7.
  ///
  /// In ar_EG, this message translates to:
  /// **'النشطة ⏳'**
  String get installmentsScreen7;

  /// No description provided for @installmentsScreen8.
  ///
  /// In ar_EG, this message translates to:
  /// **'المكتملة ✓'**
  String get installmentsScreen8;

  /// No description provided for @installmentsScreen9.
  ///
  /// In ar_EG, this message translates to:
  /// **'الملغية'**
  String get installmentsScreen9;

  /// No description provided for @installmentsScreen10.
  ///
  /// In ar_EG, this message translates to:
  /// **'خطأ في تحميل الأقساط: {e}'**
  String installmentsScreen10(Object e);

  /// No description provided for @installmentsScreen11.
  ///
  /// In ar_EG, this message translates to:
  /// **'مفيش أقساط مطابقة للبحث'**
  String get installmentsScreen11;

  /// No description provided for @installmentsScreen12.
  ///
  /// In ar_EG, this message translates to:
  /// **'مفيش خطط أقساط حالياً'**
  String get installmentsScreen12;

  /// No description provided for @installmentsScreen13.
  ///
  /// In ar_EG, this message translates to:
  /// **'اضغط على زرار (+ خطة قسط جديدة) لإنشاء وجدولة أول قسط لعميل.'**
  String get installmentsScreen13;

  /// No description provided for @installmentsScreen14.
  ///
  /// In ar_EG, this message translates to:
  /// **'خطة قسط جديدة'**
  String get installmentsScreen14;

  /// No description provided for @installmentPlanDetailsScreen1.
  ///
  /// In ar_EG, this message translates to:
  /// **'إنستاباي: {instapay}'**
  String installmentPlanDetailsScreen1(Object instapay);

  /// No description provided for @installmentPlanDetailsScreen2.
  ///
  /// In ar_EG, this message translates to:
  /// **'محفظة/فودافون كاش: {wallet}'**
  String installmentPlanDetailsScreen2(Object wallet);

  /// No description provided for @installmentPlanDetailsScreen3.
  ///
  /// In ar_EG, this message translates to:
  /// **'تليفون: {phoneNum}'**
  String installmentPlanDetailsScreen3(Object phoneNum);

  /// No description provided for @installmentPlanDetailsScreen4.
  ///
  /// In ar_EG, this message translates to:
  /// **'إلغاء خطة القسط'**
  String get installmentPlanDetailsScreen4;

  /// No description provided for @installmentPlanDetailsScreen5.
  ///
  /// In ar_EG, this message translates to:
  /// **'هل أنت متأكد من رغبتك في إلغاء هذه الخطة؟ سيتم إيقاف التنبيهات مع الاحتفاظ بسجل المدفوعات.'**
  String get installmentPlanDetailsScreen5;

  /// No description provided for @installmentPlanDetailsScreen6.
  ///
  /// In ar_EG, this message translates to:
  /// **'رجوع'**
  String get installmentPlanDetailsScreen6;

  /// No description provided for @installmentPlanDetailsScreen7.
  ///
  /// In ar_EG, this message translates to:
  /// **'إلغاء الخطة'**
  String get installmentPlanDetailsScreen7;

  /// No description provided for @installmentPlanDetailsScreen8.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم إلغاء خطة القسط'**
  String get installmentPlanDetailsScreen8;

  /// No description provided for @installmentPlanDetailsScreen9.
  ///
  /// In ar_EG, this message translates to:
  /// **'حذف خطة القسط'**
  String get installmentPlanDetailsScreen9;

  /// No description provided for @installmentPlanDetailsScreen10.
  ///
  /// In ar_EG, this message translates to:
  /// **'هل أنت متأكد من حذف خطة القسط نهائياً؟'**
  String get installmentPlanDetailsScreen10;

  /// No description provided for @installmentPlanDetailsScreen11.
  ///
  /// In ar_EG, this message translates to:
  /// **'إلغاء'**
  String get installmentPlanDetailsScreen11;

  /// No description provided for @installmentPlanDetailsScreen12.
  ///
  /// In ar_EG, this message translates to:
  /// **'حذف نهائي'**
  String get installmentPlanDetailsScreen12;

  /// No description provided for @installmentPlanDetailsScreen13.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم حذف خطة القسط'**
  String get installmentPlanDetailsScreen13;

  /// No description provided for @installmentPlanDetailsScreen14.
  ///
  /// In ar_EG, this message translates to:
  /// **'تفاصيل القسط'**
  String get installmentPlanDetailsScreen14;

  /// No description provided for @installmentPlanDetailsScreen15.
  ///
  /// In ar_EG, this message translates to:
  /// **'خطأ: {e}'**
  String installmentPlanDetailsScreen15(Object e);

  /// No description provided for @installmentPlanDetailsScreen16.
  ///
  /// In ar_EG, this message translates to:
  /// **'خطة القسط غير موجودة أو تم حذفها'**
  String get installmentPlanDetailsScreen16;

  /// No description provided for @installmentPlanDetailsScreen17.
  ///
  /// In ar_EG, this message translates to:
  /// **'حذف الخطة'**
  String get installmentPlanDetailsScreen17;

  /// No description provided for @installmentPlanDetailsScreen18.
  ///
  /// In ar_EG, this message translates to:
  /// **'السعر الإجمالي:'**
  String get installmentPlanDetailsScreen18;

  /// No description provided for @installmentPlanDetailsScreen19.
  ///
  /// In ar_EG, this message translates to:
  /// **'المقدم:'**
  String get installmentPlanDetailsScreen19;

  /// No description provided for @installmentPlanDetailsScreen20.
  ///
  /// In ar_EG, this message translates to:
  /// **'إجمالي المدفوع:'**
  String get installmentPlanDetailsScreen20;

  /// No description provided for @installmentPlanDetailsScreen21.
  ///
  /// In ar_EG, this message translates to:
  /// **'المتبقي:'**
  String get installmentPlanDetailsScreen21;

  /// No description provided for @installmentPlanDetailsScreen22.
  ///
  /// In ar_EG, this message translates to:
  /// **'سداد مبكر وتصفية بالكامل'**
  String get installmentPlanDetailsScreen22;

  /// No description provided for @installmentPlanDetailsScreen23.
  ///
  /// In ar_EG, this message translates to:
  /// **'الضامن: {guarantorName}'**
  String installmentPlanDetailsScreen23(Object guarantorName);

  /// No description provided for @installmentPlanDetailsScreen24.
  ///
  /// In ar_EG, this message translates to:
  /// **'صورة العقد / إيصال الأمانة'**
  String get installmentPlanDetailsScreen24;

  /// No description provided for @installmentPlanDetailsScreen25.
  ///
  /// In ar_EG, this message translates to:
  /// **'اضغط لعرض المستند بالحجم الكامل'**
  String get installmentPlanDetailsScreen25;

  /// No description provided for @installmentPlanDetailsScreen26.
  ///
  /// In ar_EG, this message translates to:
  /// **'مستند القسط'**
  String get installmentPlanDetailsScreen26;

  /// No description provided for @installmentPlanDetailsScreen27.
  ///
  /// In ar_EG, this message translates to:
  /// **'جدول الأقساط ({installmentsLength})'**
  String installmentPlanDetailsScreen27(Object installmentsLength);

  /// No description provided for @installmentPlanDetailsScreen28.
  ///
  /// In ar_EG, this message translates to:
  /// **'سداد دفعة حرة'**
  String get installmentPlanDetailsScreen28;

  /// No description provided for @installmentPlanDetailsScreen29.
  ///
  /// In ar_EG, this message translates to:
  /// **'القسط رقم {installmentIndex} • {dueDate}'**
  String installmentPlanDetailsScreen29(
    Object installmentIndex,
    Object dueDate,
  );

  /// No description provided for @installmentPlanDetailsScreen30.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم السداد بالكامل ✓ ({paidPiasters})'**
  String installmentPlanDetailsScreen30(Object paidPiasters);

  /// No description provided for @installmentPlanDetailsScreen31.
  ///
  /// In ar_EG, this message translates to:
  /// **'مدفوع {paidPiasters} من {amountPiasters}'**
  String installmentPlanDetailsScreen31(
    Object paidPiasters,
    Object amountPiasters,
  );

  /// No description provided for @installmentPlanDetailsScreen32.
  ///
  /// In ar_EG, this message translates to:
  /// **'متأخر عن ميعاده ⚠️'**
  String get installmentPlanDetailsScreen32;

  /// No description provided for @installmentPlanDetailsScreen33.
  ///
  /// In ar_EG, this message translates to:
  /// **'مستحق السداد اليوم 🔔'**
  String get installmentPlanDetailsScreen33;

  /// No description provided for @installmentPlanDetailsScreen34.
  ///
  /// In ar_EG, this message translates to:
  /// **'قادم • {amountPiasters}'**
  String installmentPlanDetailsScreen34(Object amountPiasters);

  /// No description provided for @installmentPlanDetailsScreen35.
  ///
  /// In ar_EG, this message translates to:
  /// **'تذكير واتساب'**
  String get installmentPlanDetailsScreen35;

  /// No description provided for @installmentPlanDetailsScreen36.
  ///
  /// In ar_EG, this message translates to:
  /// **'سداد'**
  String get installmentPlanDetailsScreen36;

  /// No description provided for @addInstallmentPlanScreen1.
  ///
  /// In ar_EG, this message translates to:
  /// **'موبايل'**
  String get addInstallmentPlanScreen1;

  /// No description provided for @addInstallmentPlanScreen2.
  ///
  /// In ar_EG, this message translates to:
  /// **'شاشة تلفزيون'**
  String get addInstallmentPlanScreen2;

  /// No description provided for @addInstallmentPlanScreen3.
  ///
  /// In ar_EG, this message translates to:
  /// **'غسالة'**
  String get addInstallmentPlanScreen3;

  /// No description provided for @addInstallmentPlanScreen4.
  ///
  /// In ar_EG, this message translates to:
  /// **'ثلاجة'**
  String get addInstallmentPlanScreen4;

  /// No description provided for @addInstallmentPlanScreen5.
  ///
  /// In ar_EG, this message translates to:
  /// **'بوتاجاز'**
  String get addInstallmentPlanScreen5;

  /// No description provided for @addInstallmentPlanScreen6.
  ///
  /// In ar_EG, this message translates to:
  /// **'لابتوب'**
  String get addInstallmentPlanScreen6;

  /// No description provided for @addInstallmentPlanScreen7.
  ///
  /// In ar_EG, this message translates to:
  /// **'موتوسيكل'**
  String get addInstallmentPlanScreen7;

  /// No description provided for @addInstallmentPlanScreen8.
  ///
  /// In ar_EG, this message translates to:
  /// **'أثاث / مفروشات'**
  String get addInstallmentPlanScreen8;

  /// No description provided for @addInstallmentPlanScreen9.
  ///
  /// In ar_EG, this message translates to:
  /// **'برجاء اختيار العميل أولاً'**
  String get addInstallmentPlanScreen9;

  /// No description provided for @addInstallmentPlanScreen10.
  ///
  /// In ar_EG, this message translates to:
  /// **'المقدم يجب أن يكون أقل من إجمالي السعر'**
  String get addInstallmentPlanScreen10;

  /// No description provided for @addInstallmentPlanScreen11.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم إنشاء خطة القسط وجدولة الأقساط بنجاح ✓'**
  String get addInstallmentPlanScreen11;

  /// No description provided for @addInstallmentPlanScreen12.
  ///
  /// In ar_EG, this message translates to:
  /// **'حدث خطأ: {e}'**
  String addInstallmentPlanScreen12(Object e);

  /// No description provided for @addInstallmentPlanScreen13.
  ///
  /// In ar_EG, this message translates to:
  /// **'خطأ في تحميل العملاء: {e}'**
  String addInstallmentPlanScreen13(Object e);

  /// No description provided for @addInstallmentPlanScreen14.
  ///
  /// In ar_EG, this message translates to:
  /// **'اختر العميل'**
  String get addInstallmentPlanScreen14;

  /// No description provided for @addInstallmentPlanScreen15.
  ///
  /// In ar_EG, this message translates to:
  /// **'برجاء اختيار العميل'**
  String get addInstallmentPlanScreen15;

  /// No description provided for @addInstallmentPlanScreen16.
  ///
  /// In ar_EG, this message translates to:
  /// **'بيانات السلعة والمبالغ'**
  String get addInstallmentPlanScreen16;

  /// No description provided for @addInstallmentPlanScreen17.
  ///
  /// In ar_EG, this message translates to:
  /// **'اسم السلعة أو المنتج *'**
  String get addInstallmentPlanScreen17;

  /// No description provided for @addInstallmentPlanScreen18.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثلاً: سامسونج A15 128GB'**
  String get addInstallmentPlanScreen18;

  /// No description provided for @addInstallmentPlanScreen19.
  ///
  /// In ar_EG, this message translates to:
  /// **'اسم السلعة يجب ألا يقل عن حرفين'**
  String get addInstallmentPlanScreen19;

  /// No description provided for @addInstallmentPlanScreen20.
  ///
  /// In ar_EG, this message translates to:
  /// **'السعر الإجمالي (جنيه) *'**
  String get addInstallmentPlanScreen20;

  /// No description provided for @addInstallmentPlanScreen21.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثلاً: 12000'**
  String get addInstallmentPlanScreen21;

  /// No description provided for @addInstallmentPlanScreen22.
  ///
  /// In ar_EG, this message translates to:
  /// **'مبلغ غير صحيح'**
  String get addInstallmentPlanScreen22;

  /// No description provided for @addInstallmentPlanScreen23.
  ///
  /// In ar_EG, this message translates to:
  /// **'المقدم (جنيه)'**
  String get addInstallmentPlanScreen23;

  /// No description provided for @addInstallmentPlanScreen24.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبلغ المتبقي للتقسيط:'**
  String get addInstallmentPlanScreen24;

  /// No description provided for @addInstallmentPlanScreen25.
  ///
  /// In ar_EG, this message translates to:
  /// **'المدة ودورية السداد'**
  String get addInstallmentPlanScreen25;

  /// No description provided for @addInstallmentPlanScreen26.
  ///
  /// In ar_EG, this message translates to:
  /// **'{count} قسط'**
  String addInstallmentPlanScreen26(Object count);

  /// No description provided for @addInstallmentPlanScreen27.
  ///
  /// In ar_EG, this message translates to:
  /// **'عدد الأقساط *'**
  String get addInstallmentPlanScreen27;

  /// No description provided for @addInstallmentPlanScreen28.
  ///
  /// In ar_EG, this message translates to:
  /// **'أدخل عدداً صحيحاً'**
  String get addInstallmentPlanScreen28;

  /// No description provided for @addInstallmentPlanScreen29.
  ///
  /// In ar_EG, this message translates to:
  /// **'الدورية'**
  String get addInstallmentPlanScreen29;

  /// No description provided for @addInstallmentPlanScreen30.
  ///
  /// In ar_EG, this message translates to:
  /// **'تاريخ استحقاق أول قسط'**
  String get addInstallmentPlanScreen30;

  /// No description provided for @addInstallmentPlanScreen31.
  ///
  /// In ar_EG, this message translates to:
  /// **'تغيير التاريخ'**
  String get addInstallmentPlanScreen31;

  /// No description provided for @addInstallmentPlanScreen32.
  ///
  /// In ar_EG, this message translates to:
  /// **'الضامن والمستندات (اختياري)'**
  String get addInstallmentPlanScreen32;

  /// No description provided for @addInstallmentPlanScreen33.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثلاً: محمد السيد إبراهيم'**
  String get addInstallmentPlanScreen33;

  /// No description provided for @addInstallmentPlanScreen34.
  ///
  /// In ar_EG, this message translates to:
  /// **'رقم موبايل الضامن'**
  String get addInstallmentPlanScreen34;

  /// No description provided for @addInstallmentPlanScreen35.
  ///
  /// In ar_EG, this message translates to:
  /// **'رقم الموبايل غير صحيح (010, 011, 012, 015)'**
  String get addInstallmentPlanScreen35;

  /// No description provided for @addInstallmentPlanScreen36.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم التقاط صورة المستند ✓'**
  String get addInstallmentPlanScreen36;

  /// No description provided for @addInstallmentPlanScreen37.
  ///
  /// In ar_EG, this message translates to:
  /// **'تصوير العقد / إيصال الأمانة / البطاقة'**
  String get addInstallmentPlanScreen37;

  /// No description provided for @addInstallmentPlanScreen38.
  ///
  /// In ar_EG, this message translates to:
  /// **'اضغط لتغيير الصورة'**
  String get addInstallmentPlanScreen38;

  /// No description provided for @addInstallmentPlanScreen39.
  ///
  /// In ar_EG, this message translates to:
  /// **'حفظ صورة العقد للرجوع إليها في أي وقت'**
  String get addInstallmentPlanScreen39;

  /// No description provided for @addInstallmentPlanScreen40.
  ///
  /// In ar_EG, this message translates to:
  /// **'تصوير'**
  String get addInstallmentPlanScreen40;

  /// No description provided for @addInstallmentPlanScreen41.
  ///
  /// In ar_EG, this message translates to:
  /// **'ملاحظات إضافية'**
  String get addInstallmentPlanScreen41;

  /// No description provided for @addInstallmentPlanScreen42.
  ///
  /// In ar_EG, this message translates to:
  /// **'ربط بكشكول العميل تلقائياً'**
  String get addInstallmentPlanScreen42;

  /// No description provided for @addInstallmentPlanScreen43.
  ///
  /// In ar_EG, this message translates to:
  /// **'تسجيل السعر الإجمالي كدين والمقدم كدفعة في حساب العميل العام'**
  String get addInstallmentPlanScreen43;

  /// No description provided for @addInstallmentPlanScreen44.
  ///
  /// In ar_EG, this message translates to:
  /// **'معاينة جدول الأقساط ({scheduleLength} أقساط)'**
  String addInstallmentPlanScreen44(Object scheduleLength);

  /// No description provided for @addInstallmentPlanScreen45.
  ///
  /// In ar_EG, this message translates to:
  /// **'قيمة القسط: ~{amountPiasters}'**
  String addInstallmentPlanScreen45(Object amountPiasters);

  /// No description provided for @addInstallmentPlanScreen46.
  ///
  /// In ar_EG, this message translates to:
  /// **'حفظ خطة القسط والجدولة'**
  String get addInstallmentPlanScreen46;

  /// No description provided for @installmentProgressBar1.
  ///
  /// In ar_EG, this message translates to:
  /// **'سداد {paidCount} من {totalCount} قسط ({percentInt}%)'**
  String installmentProgressBar1(
    Object paidCount,
    Object totalCount,
    Object percentInt,
  );

  /// No description provided for @installmentProgressBar2.
  ///
  /// In ar_EG, this message translates to:
  /// **'باقي: {remainingPiasters}'**
  String installmentProgressBar2(Object remainingPiasters);

  /// No description provided for @installmentProgressBar3.
  ///
  /// In ar_EG, this message translates to:
  /// **'خالص بالكامل ✓'**
  String get installmentProgressBar3;

  /// No description provided for @payInstallmentDialog1.
  ///
  /// In ar_EG, this message translates to:
  /// **'برجاء كتابة مبلغ سداد صحيح أكبر من صفر'**
  String get payInstallmentDialog1;

  /// No description provided for @payInstallmentDialog2.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم تسجيل سداد {amountPiasters} بنجاح ✓'**
  String payInstallmentDialog2(Object amountPiasters);

  /// No description provided for @payInstallmentDialog3.
  ///
  /// In ar_EG, this message translates to:
  /// **'حدث خطأ أثناء السداد: {e}'**
  String payInstallmentDialog3(Object e);

  /// No description provided for @payInstallmentDialog4.
  ///
  /// In ar_EG, this message translates to:
  /// **'سداد القسط رقم {installmentIndex}'**
  String payInstallmentDialog4(Object installmentIndex);

  /// No description provided for @payInstallmentDialog5.
  ///
  /// In ar_EG, this message translates to:
  /// **'سداد قسط ({itemDescription})'**
  String payInstallmentDialog5(Object itemDescription);

  /// No description provided for @payInstallmentDialog6.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبلغ المطلوب للقسط:'**
  String get payInstallmentDialog6;

  /// No description provided for @payInstallmentDialog7.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبلغ المدفوع (جنيه)'**
  String get payInstallmentDialog7;

  /// No description provided for @payInstallmentDialog8.
  ///
  /// In ar_EG, this message translates to:
  /// **'طريقة الدفع'**
  String get payInstallmentDialog8;

  /// No description provided for @payInstallmentDialog9.
  ///
  /// In ar_EG, this message translates to:
  /// **'كاش 💵'**
  String get payInstallmentDialog9;

  /// No description provided for @payInstallmentDialog10.
  ///
  /// In ar_EG, this message translates to:
  /// **'إنستاباي ⚡'**
  String get payInstallmentDialog10;

  /// No description provided for @payInstallmentDialog11.
  ///
  /// In ar_EG, this message translates to:
  /// **'محفظة 📱'**
  String get payInstallmentDialog11;

  /// No description provided for @payInstallmentDialog12.
  ///
  /// In ar_EG, this message translates to:
  /// **'تاريخ السداد'**
  String get payInstallmentDialog12;

  /// No description provided for @payInstallmentDialog13.
  ///
  /// In ar_EG, this message translates to:
  /// **'تغيير'**
  String get payInstallmentDialog13;

  /// No description provided for @payInstallmentDialog14.
  ///
  /// In ar_EG, this message translates to:
  /// **'ملاحظة (اختياري)'**
  String get payInstallmentDialog14;

  /// No description provided for @payInstallmentDialog15.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثلاً: تحويل مع فلان'**
  String get payInstallmentDialog15;

  /// No description provided for @payInstallmentDialog16.
  ///
  /// In ar_EG, this message translates to:
  /// **'تسجيل في كشف حساب العميل'**
  String get payInstallmentDialog16;

  /// No description provided for @payInstallmentDialog17.
  ///
  /// In ar_EG, this message translates to:
  /// **'يخصم المبلغ تلقائياً من رصيد العميل العام'**
  String get payInstallmentDialog17;

  /// No description provided for @payInstallmentDialog18.
  ///
  /// In ar_EG, this message translates to:
  /// **'تأكيد السداد'**
  String get payInstallmentDialog18;

  /// No description provided for @earlySettlementDialog1.
  ///
  /// In ar_EG, this message translates to:
  /// **'تمت تسوية وتصفية قسط ({itemDescription}) بنجاح ✓'**
  String earlySettlementDialog1(Object itemDescription);

  /// No description provided for @earlySettlementDialog2.
  ///
  /// In ar_EG, this message translates to:
  /// **'حدث خطأ أثناء التسوية: {e}'**
  String earlySettlementDialog2(Object e);

  /// No description provided for @earlySettlementDialog3.
  ///
  /// In ar_EG, this message translates to:
  /// **'سداد مبكر وتصفية القسط'**
  String get earlySettlementDialog3;

  /// No description provided for @earlySettlementDialog4.
  ///
  /// In ar_EG, this message translates to:
  /// **'إجمالي باقي الأقساط:'**
  String get earlySettlementDialog4;

  /// No description provided for @earlySettlementDialog5.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبلغ المطلوب تحصيله:'**
  String get earlySettlementDialog5;

  /// No description provided for @earlySettlementDialog6.
  ///
  /// In ar_EG, this message translates to:
  /// **'خصم تعجيل سداد (جنيه)'**
  String get earlySettlementDialog6;

  /// No description provided for @earlySettlementDialog7.
  ///
  /// In ar_EG, this message translates to:
  /// **'تصفية القسط الآن'**
  String get earlySettlementDialog7;

  /// No description provided for @installmentPlanCard1.
  ///
  /// In ar_EG, this message translates to:
  /// **'متأخر ({overdueCount})'**
  String installmentPlanCard1(Object overdueCount);

  /// No description provided for @installmentPlanCard2.
  ///
  /// In ar_EG, this message translates to:
  /// **'مكتمل ✓'**
  String get installmentPlanCard2;

  /// No description provided for @installmentPlanCard3.
  ///
  /// In ar_EG, this message translates to:
  /// **'ملغي'**
  String get installmentPlanCard3;

  /// No description provided for @installmentPlanCard4.
  ///
  /// In ar_EG, this message translates to:
  /// **'القسط القادم: {dueDate} ({paidPiasters})'**
  String installmentPlanCard4(Object dueDate, Object paidPiasters);

  /// No description provided for @installmentPlanCard5.
  ///
  /// In ar_EG, this message translates to:
  /// **'الإجمالي: {totalPricePiasters}'**
  String installmentPlanCard5(Object totalPricePiasters);

  /// No description provided for @installmentRepository1.
  ///
  /// In ar_EG, this message translates to:
  /// **'وصف السلعة يجب ألا يقل عن حرفين'**
  String get installmentRepository1;

  /// No description provided for @installmentRepository2.
  ///
  /// In ar_EG, this message translates to:
  /// **'السعر الإجمالي يجب أن يكون أكبر من صفر'**
  String get installmentRepository2;

  /// No description provided for @installmentRepository3.
  ///
  /// In ar_EG, this message translates to:
  /// **'المقدم لا يمكن أن يكون بالسالب'**
  String get installmentRepository3;

  /// No description provided for @installmentRepository4.
  ///
  /// In ar_EG, this message translates to:
  /// **'المقدم يجب أن يكون أقل من السعر الإجمالي'**
  String get installmentRepository4;

  /// No description provided for @installmentRepository5.
  ///
  /// In ar_EG, this message translates to:
  /// **'عدد الأقساط يجب أن يكون أكبر من صفر'**
  String get installmentRepository5;

  /// No description provided for @installmentRepository6.
  ///
  /// In ar_EG, this message translates to:
  /// **'قسط: {trim} ({installmentCount} أقساط)'**
  String installmentRepository6(Object trim, Object installmentCount);

  /// No description provided for @installmentRepository7.
  ///
  /// In ar_EG, this message translates to:
  /// **'مقدم قسط: {trim}'**
  String installmentRepository7(Object trim);

  /// No description provided for @installmentRepository8.
  ///
  /// In ar_EG, this message translates to:
  /// **'مبلغ السداد يجب أن يكون أكبر من صفر'**
  String get installmentRepository8;

  /// No description provided for @installmentRepository9.
  ///
  /// In ar_EG, this message translates to:
  /// **'سداد قسط: {itemDescription}{notes}'**
  String installmentRepository9(Object itemDescription, Object notes);

  /// No description provided for @installmentRepository10.
  ///
  /// In ar_EG, this message translates to:
  /// **'خطة القسط غير موجودة'**
  String get installmentRepository10;

  /// No description provided for @installmentRepository11.
  ///
  /// In ar_EG, this message translates to:
  /// **'سداد مبكر لقسط: {itemDescription}'**
  String installmentRepository11(Object itemDescription);

  /// No description provided for @installmentRepository12.
  ///
  /// In ar_EG, this message translates to:
  /// **'خصم تعجيل سداد: {itemDescription}'**
  String installmentRepository12(Object itemDescription);

  /// No description provided for @collectionScreen1.
  ///
  /// In ar_EG, this message translates to:
  /// **'أقساط مستحقة'**
  String get collectionScreen1;

  /// No description provided for @dueInstallmentsTab1.
  ///
  /// In ar_EG, this message translates to:
  /// **'العميل ليس لديه رقم تليفون مسجل'**
  String get dueInstallmentsTab1;

  /// No description provided for @dueInstallmentsTab2.
  ///
  /// In ar_EG, this message translates to:
  /// **'مفيش أقساط مستحقة أو متأخرة اليوم 🎉'**
  String get dueInstallmentsTab2;

  /// No description provided for @dueInstallmentsTab3.
  ///
  /// In ar_EG, this message translates to:
  /// **'كل عملاء الأقساط منتظمين في السداد حتى الآن.'**
  String get dueInstallmentsTab3;

  /// No description provided for @dueInstallmentsTab4.
  ///
  /// In ar_EG, this message translates to:
  /// **'مطلوب تحصيل ({dueListLength}) قسط:'**
  String dueInstallmentsTab4(Object dueListLength);

  /// No description provided for @dueInstallmentsTab5.
  ///
  /// In ar_EG, this message translates to:
  /// **'{itemDescription} • القسط ({installmentIndex} من {installmentCount})'**
  String dueInstallmentsTab5(
    Object itemDescription,
    Object installmentIndex,
    Object installmentCount,
  );

  /// No description provided for @dueInstallmentsTab6.
  ///
  /// In ar_EG, this message translates to:
  /// **'متأخر {daysOverdue} يوم'**
  String dueInstallmentsTab6(Object daysOverdue);

  /// No description provided for @dueInstallmentsTab7.
  ///
  /// In ar_EG, this message translates to:
  /// **'مستحق اليوم 🔔'**
  String get dueInstallmentsTab7;

  /// No description provided for @dueInstallmentsTab8.
  ///
  /// In ar_EG, this message translates to:
  /// **'اتصال'**
  String get dueInstallmentsTab8;

  /// No description provided for @dueInstallmentsTab9.
  ///
  /// In ar_EG, this message translates to:
  /// **'واتساب'**
  String get dueInstallmentsTab9;

  /// No description provided for @cashDrawerScreen1.
  ///
  /// In ar_EG, this message translates to:
  /// **'حدث خطأ في تحميل بيانات الدرج: {err}'**
  String cashDrawerScreen1(Object err);

  /// No description provided for @drawerLiveCard1.
  ///
  /// In ar_EG, this message translates to:
  /// **'ملاحظة: {notes}'**
  String drawerLiveCard1(Object notes);

  /// No description provided for @expensesListCard1.
  ///
  /// In ar_EG, this message translates to:
  /// **'{expensesLength} مصروف'**
  String expensesListCard1(Object expensesLength);

  /// No description provided for @expensesListCard2.
  ///
  /// In ar_EG, this message translates to:
  /// **'إنستاباي'**
  String get expensesListCard2;

  /// No description provided for @expensesListCard3.
  ///
  /// In ar_EG, this message translates to:
  /// **'محفظة'**
  String get expensesListCard3;

  /// No description provided for @drawerFlowCard1.
  ///
  /// In ar_EG, this message translates to:
  /// **'(إنستاباي / محفظة)'**
  String get drawerFlowCard1;

  /// No description provided for @addCashSalesBottomSheet1.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبيعات المسجلة حتى الآن: {currentSalesPiasters}'**
  String addCashSalesBottomSheet1(Object currentSalesPiasters);

  /// No description provided for @addCashSalesBottomSheet2.
  ///
  /// In ar_EG, this message translates to:
  /// **'إضافة للمبيعات (+)'**
  String get addCashSalesBottomSheet2;

  /// No description provided for @addCashSalesBottomSheet3.
  ///
  /// In ar_EG, this message translates to:
  /// **'تعديل الإجمالي (=)'**
  String get addCashSalesBottomSheet3;

  /// No description provided for @addCashSalesBottomSheet4.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبلغ المراد إضافته'**
  String get addCashSalesBottomSheet4;

  /// No description provided for @addCashSalesBottomSheet5.
  ///
  /// In ar_EG, this message translates to:
  /// **'إجمالي المبيعات الجديد'**
  String get addCashSalesBottomSheet5;

  /// No description provided for @addCashSalesBottomSheet6.
  ///
  /// In ar_EG, this message translates to:
  /// **'+{val} جنيه'**
  String addCashSalesBottomSheet6(Object val);

  /// No description provided for @drawerHistoryTab1.
  ///
  /// In ar_EG, this message translates to:
  /// **'مبيعات كاش: {cashSalesPiasters} · افتتاح: {openingCashPiasters}'**
  String drawerHistoryTab1(
    Object cashSalesPiasters,
    Object openingCashPiasters,
  );

  /// No description provided for @drawerHistoryTab2.
  ///
  /// In ar_EG, this message translates to:
  /// **'تفاصيل يوم {date}'**
  String drawerHistoryTab2(Object date);

  /// No description provided for @drawerHistoryTab3.
  ///
  /// In ar_EG, this message translates to:
  /// **'الفرق'**
  String get drawerHistoryTab3;

  /// No description provided for @customersScreen1.
  ///
  /// In ar_EG, this message translates to:
  /// **'نظام الأقساط'**
  String get customersScreen1;

  /// No description provided for @customersScreen2.
  ///
  /// In ar_EG, this message translates to:
  /// **'وضع الخصوصية'**
  String get customersScreen2;

  /// No description provided for @customersScreen3.
  ///
  /// In ar_EG, this message translates to:
  /// **'الترتيب'**
  String get customersScreen3;

  /// No description provided for @customerPhotosScreen1.
  ///
  /// In ar_EG, this message translates to:
  /// **'الصورة اتضافت'**
  String get customerPhotosScreen1;

  /// No description provided for @customerPhotosScreen2.
  ///
  /// In ar_EG, this message translates to:
  /// **'{pathsLength} صور اتضافوا'**
  String customerPhotosScreen2(Object pathsLength);

  /// No description provided for @customerPhotosScreen3.
  ///
  /// In ar_EG, this message translates to:
  /// **'الصورة اتشالت'**
  String get customerPhotosScreen3;

  /// No description provided for @customerPhotosScreen4.
  ///
  /// In ar_EG, this message translates to:
  /// **'رجّعها'**
  String get customerPhotosScreen4;

  /// No description provided for @customerPhotosScreen5.
  ///
  /// In ar_EG, this message translates to:
  /// **'صور {customerName}'**
  String customerPhotosScreen5(Object customerName);

  /// No description provided for @customerPhotosScreen6.
  ///
  /// In ar_EG, this message translates to:
  /// **'ضيف صور'**
  String get customerPhotosScreen6;

  /// No description provided for @customerPhotosScreen7.
  ///
  /// In ar_EG, this message translates to:
  /// **'حصلت مشكلة في تحميل الصور'**
  String get customerPhotosScreen7;

  /// No description provided for @customerPhotosScreen8.
  ///
  /// In ar_EG, this message translates to:
  /// **'مفيش صور للعميل ده لسه.\nصوّر صفحاته من الكشكول أو أي ورقة تخصه — الصور بتفضل على الموبايل بس.'**
  String get customerPhotosScreen8;

  /// No description provided for @customerPhotosScreen9.
  ///
  /// In ar_EG, this message translates to:
  /// **'شيل الصورة'**
  String get customerPhotosScreen9;

  /// No description provided for @customerDetailsScreen1.
  ///
  /// In ar_EG, this message translates to:
  /// **'أقساط نشطة ({activePlansLength}) • باقي: {remainingPiasters}'**
  String customerDetailsScreen1(
    Object activePlansLength,
    Object remainingPiasters,
  );

  /// No description provided for @customerDetailsScreen2.
  ///
  /// In ar_EG, this message translates to:
  /// **'بيع بالتقسيط للعميل'**
  String get customerDetailsScreen2;

  /// No description provided for @customerDetailsScreen3.
  ///
  /// In ar_EG, this message translates to:
  /// **'عرض'**
  String get customerDetailsScreen3;

  /// No description provided for @customerDetailsScreen4.
  ///
  /// In ar_EG, this message translates to:
  /// **'إضافة قسط جديد'**
  String get customerDetailsScreen4;

  /// No description provided for @customerDetailsScreen5.
  ///
  /// In ar_EG, this message translates to:
  /// **'صور العميل'**
  String get customerDetailsScreen5;

  /// No description provided for @photoStrip1.
  ///
  /// In ar_EG, this message translates to:
  /// **'صوّر بالكاميرا'**
  String get photoStrip1;

  /// No description provided for @photoStrip2.
  ///
  /// In ar_EG, this message translates to:
  /// **'اختار من المعرض'**
  String get photoStrip2;

  /// No description provided for @photoStrip3.
  ///
  /// In ar_EG, this message translates to:
  /// **'تقدر تختار كذا صورة مرة واحدة'**
  String get photoStrip3;

  /// No description provided for @photoStrip4.
  ///
  /// In ar_EG, this message translates to:
  /// **'صورة'**
  String get photoStrip4;

  /// No description provided for @photoStrip5.
  ///
  /// In ar_EG, this message translates to:
  /// **'كمان'**
  String get photoStrip5;

  /// No description provided for @photoStrip6.
  ///
  /// In ar_EG, this message translates to:
  /// **'ضيف صورة'**
  String get photoStrip6;

  /// No description provided for @photoStrip7.
  ///
  /// In ar_EG, this message translates to:
  /// **'الصور'**
  String get photoStrip7;

  /// No description provided for @photoStrip8.
  ///
  /// In ar_EG, this message translates to:
  /// **'{title} ({index} من {count})'**
  String photoStrip8(Object title, Object index, Object count);

  /// No description provided for @photoStrip9.
  ///
  /// In ar_EG, this message translates to:
  /// **'الصورة'**
  String get photoStrip9;

  /// No description provided for @photoStrip10.
  ///
  /// In ar_EG, this message translates to:
  /// **'الصورة مش موجودة على الموبايل'**
  String get photoStrip10;

  /// No description provided for @creditLimitProgressBar1.
  ///
  /// In ar_EG, this message translates to:
  /// **'حد الدين: {limitPiasters}'**
  String creditLimitProgressBar1(Object limitPiasters);

  /// No description provided for @ratingExplanationBottomSheet1.
  ///
  /// In ar_EG, this message translates to:
  /// **'تقييم العميل: {customerName}'**
  String ratingExplanationBottomSheet1(Object customerName);

  /// No description provided for @ratingExplanationBottomSheet2.
  ///
  /// In ar_EG, this message translates to:
  /// **'سبب التقييم الحالي:'**
  String get ratingExplanationBottomSheet2;

  /// No description provided for @ratingExplanationBottomSheet3.
  ///
  /// In ar_EG, this message translates to:
  /// **'كيف يعمل نظام التقييم؟'**
  String get ratingExplanationBottomSheet3;

  /// No description provided for @ratingExplanationBottomSheet4.
  ///
  /// In ar_EG, this message translates to:
  /// **'ممتاز'**
  String get ratingExplanationBottomSheet4;

  /// No description provided for @ratingExplanationBottomSheet5.
  ///
  /// In ar_EG, this message translates to:
  /// **'حسابه خالص أو أقدم دين عليه لم يتجاوز 14 يوماً.'**
  String get ratingExplanationBottomSheet5;

  /// No description provided for @ratingExplanationBottomSheet6.
  ///
  /// In ar_EG, this message translates to:
  /// **'متابعة'**
  String get ratingExplanationBottomSheet6;

  /// No description provided for @ratingExplanationBottomSheet7.
  ///
  /// In ar_EG, this message translates to:
  /// **'أقدم دين عليه بين 15 و 45 يوماً (يستحسن تذكيره بالدفع).'**
  String get ratingExplanationBottomSheet7;

  /// No description provided for @ratingExplanationBottomSheet8.
  ///
  /// In ar_EG, this message translates to:
  /// **'متأخر'**
  String get ratingExplanationBottomSheet8;

  /// No description provided for @ratingExplanationBottomSheet9.
  ///
  /// In ar_EG, this message translates to:
  /// **'أقدم دين عليه تجاوز 45 يوماً أو تخطى حد الدين المحدد له.'**
  String get ratingExplanationBottomSheet9;

  /// No description provided for @ratingExplanationBottomSheet10.
  ///
  /// In ar_EG, this message translates to:
  /// **'جديد'**
  String get ratingExplanationBottomSheet10;

  /// No description provided for @ratingExplanationBottomSheet11.
  ///
  /// In ar_EG, this message translates to:
  /// **'عميل مسجل له أقل من 3 معاملات.'**
  String get ratingExplanationBottomSheet11;

  /// No description provided for @ratingExplanationBottomSheet12.
  ///
  /// In ar_EG, this message translates to:
  /// **'فهمت'**
  String get ratingExplanationBottomSheet12;

  /// No description provided for @customerWithBalance1.
  ///
  /// In ar_EG, this message translates to:
  /// **'عميل جديد'**
  String get customerWithBalance1;

  /// No description provided for @settingsScreen1.
  ///
  /// In ar_EG, this message translates to:
  /// **'بيانات المحل 🏪'**
  String get settingsScreen1;

  /// No description provided for @settingsScreen2.
  ///
  /// In ar_EG, this message translates to:
  /// **'الحماية والخصوصية 🔒'**
  String get settingsScreen2;

  /// No description provided for @settingsScreen3.
  ///
  /// In ar_EG, this message translates to:
  /// **'ويدجت الشاشة الرئيسية 📱'**
  String get settingsScreen3;

  /// No description provided for @settingsScreen4.
  ///
  /// In ar_EG, this message translates to:
  /// **'رسائل التذكير والتحصيل 💬'**
  String get settingsScreen4;

  /// No description provided for @settingsScreen5.
  ///
  /// In ar_EG, this message translates to:
  /// **'النسخ الاحتياطي والبيانات 💾'**
  String get settingsScreen5;

  /// No description provided for @settingsScreen6.
  ///
  /// In ar_EG, this message translates to:
  /// **'مشاركة التطبيق 🚀'**
  String get settingsScreen6;

  /// No description provided for @settingsScreen7.
  ///
  /// In ar_EG, this message translates to:
  /// **'عام ⚙️'**
  String get settingsScreen7;

  /// No description provided for @settingsScreen8.
  ///
  /// In ar_EG, this message translates to:
  /// **'كشكول 📒'**
  String get settingsScreen8;

  /// No description provided for @settingsScreen9.
  ///
  /// In ar_EG, this message translates to:
  /// **'دفتر حسابات المحل بدون نت (Offline-First)\nالإصدار 1.0.0'**
  String get settingsScreen9;

  /// No description provided for @settingsScreen10.
  ///
  /// In ar_EG, this message translates to:
  /// **'متجر عام'**
  String get settingsScreen10;

  /// No description provided for @settingsScreen11.
  ///
  /// In ar_EG, this message translates to:
  /// **'بقالة وسوبرماركت 🛒'**
  String get settingsScreen11;

  /// No description provided for @settingsScreen12.
  ///
  /// In ar_EG, this message translates to:
  /// **'موبايلات وإكسسوارات 📱'**
  String get settingsScreen12;

  /// No description provided for @settingsScreen13.
  ///
  /// In ar_EG, this message translates to:
  /// **'أجهزة كهربائية ومنزلية ⚡'**
  String get settingsScreen13;

  /// No description provided for @settingsScreen14.
  ///
  /// In ar_EG, this message translates to:
  /// **'صيدلية ومستحضرات 💊'**
  String get settingsScreen14;

  /// No description provided for @settingsScreen15.
  ///
  /// In ar_EG, this message translates to:
  /// **'أنشطة وتجارة حرة 🏪'**
  String get settingsScreen15;

  /// No description provided for @settingsScreen16.
  ///
  /// In ar_EG, this message translates to:
  /// **'{tradeName} • تعديل النشاط وبيانات الدفع'**
  String settingsScreen16(Object tradeName);

  /// No description provided for @settingsScreen17.
  ///
  /// In ar_EG, this message translates to:
  /// **'إخفاء مبالغ الفلوس في الشاشة والودجت (••••••)'**
  String get settingsScreen17;

  /// No description provided for @settingsScreen18.
  ///
  /// In ar_EG, this message translates to:
  /// **'قفل التطبيق برمز PIN (4 أرقام)'**
  String get settingsScreen18;

  /// No description provided for @settingsScreen19.
  ///
  /// In ar_EG, this message translates to:
  /// **'مفعّل ومحمي (اضغط للإلغاء)'**
  String get settingsScreen19;

  /// No description provided for @settingsScreen20.
  ///
  /// In ar_EG, this message translates to:
  /// **'غير مفعّل (اضغط للتعيين)'**
  String get settingsScreen20;

  /// No description provided for @settingsScreen21.
  ///
  /// In ar_EG, this message translates to:
  /// **'مفعّل 🔒'**
  String get settingsScreen21;

  /// No description provided for @settingsScreen22.
  ///
  /// In ar_EG, this message translates to:
  /// **'إعداد'**
  String get settingsScreen22;

  /// No description provided for @settingsScreen23.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم إلغاء قفل التطبيق بنجاح'**
  String get settingsScreen23;

  /// No description provided for @settingsScreen24.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم تعيين رمز الدخول بنجاح 🔒'**
  String get settingsScreen24;

  /// No description provided for @settingsScreen25.
  ///
  /// In ar_EG, this message translates to:
  /// **'فتح بالبصمة / Face ID'**
  String get settingsScreen25;

  /// No description provided for @settingsScreen26.
  ///
  /// In ar_EG, this message translates to:
  /// **'استخدام البصمة بدلاً من كتابة الرمز كل مرة'**
  String get settingsScreen26;

  /// No description provided for @settingsScreen27.
  ///
  /// In ar_EG, this message translates to:
  /// **'جهازك لا يدعم التحقق بالبصمة حالياً'**
  String get settingsScreen27;

  /// No description provided for @settingsScreen28.
  ///
  /// In ar_EG, this message translates to:
  /// **'دقيقة واحدة'**
  String get settingsScreen28;

  /// No description provided for @settingsScreen29.
  ///
  /// In ar_EG, this message translates to:
  /// **'5 دقائق'**
  String get settingsScreen29;

  /// No description provided for @settingsScreen30.
  ///
  /// In ar_EG, this message translates to:
  /// **'15 دقيقة'**
  String get settingsScreen30;

  /// No description provided for @settingsScreen31.
  ///
  /// In ar_EG, this message translates to:
  /// **'فوراً'**
  String get settingsScreen31;

  /// No description provided for @settingsScreen32.
  ///
  /// In ar_EG, this message translates to:
  /// **'مدة القفل التلقائي'**
  String get settingsScreen32;

  /// No description provided for @settingsScreen33.
  ///
  /// In ar_EG, this message translates to:
  /// **'فور الخروج من التطبيق'**
  String get settingsScreen33;

  /// No description provided for @settingsScreen34.
  ///
  /// In ar_EG, this message translates to:
  /// **'بعد {timeout} دقيقة من الخروج'**
  String settingsScreen34(Object timeout);

  /// No description provided for @settingsScreen35.
  ///
  /// In ar_EG, this message translates to:
  /// **'فوراً عند الخروج'**
  String get settingsScreen35;

  /// No description provided for @settingsScreen36.
  ///
  /// In ar_EG, this message translates to:
  /// **'بعد دقيقة واحدة'**
  String get settingsScreen36;

  /// No description provided for @settingsScreen37.
  ///
  /// In ar_EG, this message translates to:
  /// **'بعد 5 دقائق'**
  String get settingsScreen37;

  /// No description provided for @settingsScreen38.
  ///
  /// In ar_EG, this message translates to:
  /// **'بعد 15 دقيقة'**
  String get settingsScreen38;

  /// No description provided for @settingsScreen39.
  ///
  /// In ar_EG, this message translates to:
  /// **'صيغة رسالة التذكير'**
  String get settingsScreen39;

  /// No description provided for @settingsScreen40.
  ///
  /// In ar_EG, this message translates to:
  /// **'تعديل نص الرسالة التلقائية للعملاء والمعاينة الحية'**
  String get settingsScreen40;

  /// No description provided for @settingsScreen41.
  ///
  /// In ar_EG, this message translates to:
  /// **'حماية التنبيهات من الإغلاق في الخلفية'**
  String get settingsScreen41;

  /// No description provided for @settingsScreen42.
  ///
  /// In ar_EG, this message translates to:
  /// **'دليل عملي لضمان وصول التذكيرات لأجهزة شاومي، ريلمي، وإنفينيكس'**
  String get settingsScreen42;

  /// No description provided for @settingsScreen43.
  ///
  /// In ar_EG, this message translates to:
  /// **'لم يتم تصدير نسخة حتى الآن'**
  String get settingsScreen43;

  /// No description provided for @settingsScreen44.
  ///
  /// In ar_EG, this message translates to:
  /// **'آخر نسخة احتياطية'**
  String get settingsScreen44;

  /// No description provided for @settingsScreen45.
  ///
  /// In ar_EG, this message translates to:
  /// **'تصدير نسخة احتياطية (.kashkool)'**
  String get settingsScreen45;

  /// No description provided for @settingsScreen46.
  ///
  /// In ar_EG, this message translates to:
  /// **'حفظ نسخة من الدفتر والصور وإرسالها على الواتساب أو درايف'**
  String get settingsScreen46;

  /// No description provided for @settingsScreen47.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم تصدير النسخة بنجاح 👍'**
  String get settingsScreen47;

  /// No description provided for @settingsScreen48.
  ///
  /// In ar_EG, this message translates to:
  /// **'فشل التصدير: {e}'**
  String settingsScreen48(Object e);

  /// No description provided for @settingsScreen49.
  ///
  /// In ar_EG, this message translates to:
  /// **'استعادة نسخة احتياطية'**
  String get settingsScreen49;

  /// No description provided for @settingsScreen50.
  ///
  /// In ar_EG, this message translates to:
  /// **'استرجاع الحسابات والصور من ملف .kashkool تم حفظه مسبقاً'**
  String get settingsScreen50;

  /// No description provided for @settingsScreen51.
  ///
  /// In ar_EG, this message translates to:
  /// **'الملف غير صالح ❌'**
  String get settingsScreen51;

  /// No description provided for @settingsScreen52.
  ///
  /// In ar_EG, this message translates to:
  /// **'الملف المحدد ليس نسخة صالحة لتطبيق كشكول.'**
  String get settingsScreen52;

  /// No description provided for @settingsScreen53.
  ///
  /// In ar_EG, this message translates to:
  /// **'حسناً'**
  String get settingsScreen53;

  /// No description provided for @settingsScreen54.
  ///
  /// In ar_EG, this message translates to:
  /// **'تأكيد استعادة النسخة'**
  String get settingsScreen54;

  /// No description provided for @settingsScreen55.
  ///
  /// In ar_EG, this message translates to:
  /// **'انتبه: الاستعادة ستستبدل كل البيانات الحالية المسجلة في التطبيق بالبيانات الموجودة في الملف.'**
  String get settingsScreen55;

  /// No description provided for @settingsScreen56.
  ///
  /// In ar_EG, this message translates to:
  /// **'تاريخ النسخة: {exportedAt}'**
  String settingsScreen56(Object exportedAt);

  /// No description provided for @settingsScreen57.
  ///
  /// In ar_EG, this message translates to:
  /// **'عدد الصور المرفقة: {photosCount}'**
  String settingsScreen57(Object photosCount);

  /// No description provided for @settingsScreen58.
  ///
  /// In ar_EG, this message translates to:
  /// **'حجم الملف: {fileSizeBytes} ك.ب'**
  String settingsScreen58(Object fileSizeBytes);

  /// No description provided for @settingsScreen59.
  ///
  /// In ar_EG, this message translates to:
  /// **'نعم، استبدل واسترجع البيانات'**
  String get settingsScreen59;

  /// No description provided for @settingsScreen60.
  ///
  /// In ar_EG, this message translates to:
  /// **'تمت الاستعادة بنجاح 🎉'**
  String get settingsScreen60;

  /// No description provided for @settingsScreen61.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم استرجاع جميع الحسابات والمعاملات والصور بنجاح. يرجى إعادة تشغيل التطبيق لتحديث كل الشاشات.'**
  String get settingsScreen61;

  /// No description provided for @settingsScreen62.
  ///
  /// In ar_EG, this message translates to:
  /// **'إعادة التشغيل الآن'**
  String get settingsScreen62;

  /// No description provided for @settingsScreen63.
  ///
  /// In ar_EG, this message translates to:
  /// **'خطأ في الاستعادة: {e}'**
  String settingsScreen63(Object e);

  /// No description provided for @settingsScreen64.
  ///
  /// In ar_EG, this message translates to:
  /// **'داكن 🌙'**
  String get settingsScreen64;

  /// No description provided for @settingsScreen65.
  ///
  /// In ar_EG, this message translates to:
  /// **'فاتح ☀️'**
  String get settingsScreen65;

  /// No description provided for @settingsScreen66.
  ///
  /// In ar_EG, this message translates to:
  /// **'تلقائي'**
  String get settingsScreen66;

  /// No description provided for @settingsScreen67.
  ///
  /// In ar_EG, this message translates to:
  /// **'مظهر التطبيق'**
  String get settingsScreen67;

  /// No description provided for @settingsScreen68.
  ///
  /// In ar_EG, this message translates to:
  /// **'تلقائي (حسب نظام الجهاز)'**
  String get settingsScreen68;

  /// No description provided for @settingsScreen69.
  ///
  /// In ar_EG, this message translates to:
  /// **'غير محدد'**
  String get settingsScreen69;

  /// No description provided for @settingsScreen70.
  ///
  /// In ar_EG, this message translates to:
  /// **'حد الدين الافتراضي للعميل الجديد'**
  String get settingsScreen70;

  /// No description provided for @settingsScreen71.
  ///
  /// In ar_EG, this message translates to:
  /// **'تواصل معنا عبر واتساب'**
  String get settingsScreen71;

  /// No description provided for @settingsScreen72.
  ///
  /// In ar_EG, this message translates to:
  /// **'للاقتراحات والمساعدة الفنية المباشرة'**
  String get settingsScreen72;

  /// No description provided for @settingsScreen73.
  ///
  /// In ar_EG, this message translates to:
  /// **'https://wa.me/201000000000?text=السلام%20عليكم%20عندي%20استفسار%20عن%20تطبيق%20كشكول'**
  String get settingsScreen73;

  /// No description provided for @settingsScreen74.
  ///
  /// In ar_EG, this message translates to:
  /// **'سياسة الخصوصية وشروط الاستخدام'**
  String get settingsScreen74;

  /// No description provided for @settingsScreen75.
  ///
  /// In ar_EG, this message translates to:
  /// **'بياناتك ملكك بالكامل ومتخزنة على تليفونك فقط بدون إنترنت'**
  String get settingsScreen75;

  /// No description provided for @settingsScreen76.
  ///
  /// In ar_EG, this message translates to:
  /// **'سياسة الخصوصية في كشكول 🔒'**
  String get settingsScreen76;

  /// No description provided for @settingsScreen77.
  ///
  /// In ar_EG, this message translates to:
  /// **'1. تطبيق كشكول هو تطبيق يعمل بالكامل بدون اتصال بالإنترنت (Offline-First).\n\n2. جميع الحسابات والأسماء وأرقام الهواتف وصور الفواتير والمعاملات مخزنة محلياً على جهازك فقط، ولا يتم إرسال أي بيانات لأي خادم خارجي.\n\n3. أنت المسؤول الأول عن عمل نسخة احتياطية بشكل دوري عبر خيار (تصدير نسخة احتياطية) لحفظ بياناتك في حال تغيير أو فقدان الهاتف.\n\n4. كشكول صُمم لخدمة أصحاب المحلات والتجار لحفظ حقوقهم وتسهيل متابعة ديونهم بكل أمان.'**
  String get settingsScreen77;

  /// No description provided for @settingsScreen78.
  ///
  /// In ar_EG, this message translates to:
  /// **'نظام الجهاز (تلقائي)'**
  String get settingsScreen78;

  /// No description provided for @settingsScreen79.
  ///
  /// In ar_EG, this message translates to:
  /// **'حد الدين الافتراضي (جنيه)'**
  String get settingsScreen79;

  /// No description provided for @settingsScreen80.
  ///
  /// In ar_EG, this message translates to:
  /// **'المبلغ بالجنيه'**
  String get settingsScreen80;

  /// No description provided for @settingsScreen81.
  ///
  /// In ar_EG, this message translates to:
  /// **'اتركه فارغاً لجعله غير محدد'**
  String get settingsScreen81;

  /// No description provided for @settingsScreen82.
  ///
  /// In ar_EG, this message translates to:
  /// **'حفظ'**
  String get settingsScreen82;

  /// No description provided for @batteryGuideBottomSheet1.
  ///
  /// In ar_EG, this message translates to:
  /// **'دليل حماية الإشعارات ({brandName})'**
  String batteryGuideBottomSheet1(Object brandName);

  /// No description provided for @batteryGuideBottomSheet2.
  ///
  /// In ar_EG, this message translates to:
  /// **'دليل حماية التنبيهات من الإغلاق'**
  String get batteryGuideBottomSheet2;

  /// No description provided for @batteryGuideBottomSheet3.
  ///
  /// In ar_EG, this message translates to:
  /// **'تقوم بعض الهواتف (مثل شاومي، ريلمي، إنفينيكس، وهواوي) بإيقاف التطبيقات في الخلفية لتوفير البطارية. لضمان وصول تذكير التحصيل اليومي ومواعيد الأقساط بدقة، يُرجى تطبيق الخطوات التالية:'**
  String get batteryGuideBottomSheet3;

  /// No description provided for @batteryGuideBottomSheet4.
  ///
  /// In ar_EG, this message translates to:
  /// **'فتح إعدادات بطارية الهاتف الآن'**
  String get batteryGuideBottomSheet4;

  /// No description provided for @backupReminderBanner1.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم تصدير النسخة الاحتياطية بنجاح 👍'**
  String get backupReminderBanner1;

  /// No description provided for @backupReminderBanner2.
  ///
  /// In ar_EG, this message translates to:
  /// **'حدث خطأ أثناء النسخ: {e}'**
  String backupReminderBanner2(Object e);

  /// No description provided for @backupReminderBanner3.
  ///
  /// In ar_EG, this message translates to:
  /// **'تنبيه: محتاج تعمل نسخة احتياطية ⚠️'**
  String get backupReminderBanner3;

  /// No description provided for @backupReminderBanner4.
  ///
  /// In ar_EG, this message translates to:
  /// **'فات أكثر من 7 أيام من آخر نسخة. احفظ بياناتك عشان لو التليفون ضاع أو اتغير مفيش أي حساب يضيع.'**
  String get backupReminderBanner4;

  /// No description provided for @backupReminderBanner5.
  ///
  /// In ar_EG, this message translates to:
  /// **'تجاهل مؤقتاً'**
  String get backupReminderBanner5;

  /// No description provided for @backupReminderBanner6.
  ///
  /// In ar_EG, this message translates to:
  /// **'جاري الحفظ...'**
  String get backupReminderBanner6;

  /// No description provided for @backupReminderBanner7.
  ///
  /// In ar_EG, this message translates to:
  /// **'نسخ احتياطي الآن'**
  String get backupReminderBanner7;

  /// No description provided for @homeWidgetSettingsCard1.
  ///
  /// In ar_EG, this message translates to:
  /// **'عرض حساباتك على الشاشة الرئيسية'**
  String get homeWidgetSettingsCard1;

  /// No description provided for @homeWidgetSettingsCard2.
  ///
  /// In ar_EG, this message translates to:
  /// **'الويدجت بتعرض ليك عند الناس والمحصّل النهارده من غير ما تفتح التطبيق'**
  String get homeWidgetSettingsCard2;

  /// No description provided for @homeWidgetSettingsCard3.
  ///
  /// In ar_EG, this message translates to:
  /// **'الويدجت متوقفة ومش بتعرض أي أرقام'**
  String get homeWidgetSettingsCard3;

  /// No description provided for @homeWidgetSettingsCard4.
  ///
  /// In ar_EG, this message translates to:
  /// **'ضيف الويدجت الصغيرة'**
  String get homeWidgetSettingsCard4;

  /// No description provided for @homeWidgetSettingsCard5.
  ///
  /// In ar_EG, this message translates to:
  /// **'ليك عند الناس بس'**
  String get homeWidgetSettingsCard5;

  /// No description provided for @homeWidgetSettingsCard6.
  ///
  /// In ar_EG, this message translates to:
  /// **'ضيف ويدجت ملخص اليوم'**
  String get homeWidgetSettingsCard6;

  /// No description provided for @homeWidgetSettingsCard7.
  ///
  /// In ar_EG, this message translates to:
  /// **'ليك عند الناس + المحصّل النهارده + المستحقين + زرار تحصيل'**
  String get homeWidgetSettingsCard7;

  /// No description provided for @homeWidgetSettingsCard8.
  ///
  /// In ar_EG, this message translates to:
  /// **'وافق على الرسالة اللي ظهرت عشان الويدجت تتضاف للشاشة 👍'**
  String get homeWidgetSettingsCard8;

  /// No description provided for @homeWidgetSettingsCard9.
  ///
  /// In ar_EG, this message translates to:
  /// **'ضيف الويدجت بإيدك 📱'**
  String get homeWidgetSettingsCard9;

  /// No description provided for @homeWidgetSettingsCard10.
  ///
  /// In ar_EG, this message translates to:
  /// **'موبايلك مش بيسمح للتطبيق يضيفها لوحده. اعمل كده:\n\n1. اضغط ضغطة طويلة على مكان فاضي في الشاشة الرئيسية\n2. اختار \"الأدوات\" أو \"Widgets\"\n3. دوّر على \"كشكول\" واسحب الويدجت للشاشة'**
  String get homeWidgetSettingsCard10;

  /// No description provided for @messageTemplateEditorBottomSheet1.
  ///
  /// In ar_EG, this message translates to:
  /// **'بقالة الأمانة'**
  String get messageTemplateEditorBottomSheet1;

  /// No description provided for @messageTemplateEditorBottomSheet2.
  ///
  /// In ar_EG, this message translates to:
  /// **'فودافون كاش: 01012345678'**
  String get messageTemplateEditorBottomSheet2;

  /// No description provided for @messageTemplateEditorBottomSheet3.
  ///
  /// In ar_EG, this message translates to:
  /// **'محمد أحمد'**
  String get messageTemplateEditorBottomSheet3;

  /// No description provided for @messageTemplateEditorBottomSheet4.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم حفظ نموذج الرسالة بنجاح 👍'**
  String get messageTemplateEditorBottomSheet4;

  /// No description provided for @messageTemplateEditorBottomSheet5.
  ///
  /// In ar_EG, this message translates to:
  /// **'تعديل رسالة التذكير 💬'**
  String get messageTemplateEditorBottomSheet5;

  /// No description provided for @messageTemplateEditorBottomSheet6.
  ///
  /// In ar_EG, this message translates to:
  /// **'نماذج جاهزة: '**
  String get messageTemplateEditorBottomSheet6;

  /// No description provided for @messageTemplateEditorBottomSheet7.
  ///
  /// In ar_EG, this message translates to:
  /// **'ودّي 😊'**
  String get messageTemplateEditorBottomSheet7;

  /// No description provided for @messageTemplateEditorBottomSheet8.
  ///
  /// In ar_EG, this message translates to:
  /// **'رسمي 👔'**
  String get messageTemplateEditorBottomSheet8;

  /// No description provided for @messageTemplateEditorBottomSheet9.
  ///
  /// In ar_EG, this message translates to:
  /// **'اسم المحل'**
  String get messageTemplateEditorBottomSheet9;

  /// No description provided for @messageTemplateEditorBottomSheet10.
  ///
  /// In ar_EG, this message translates to:
  /// **'بيانات الدفع'**
  String get messageTemplateEditorBottomSheet10;

  /// No description provided for @messageTemplateEditorBottomSheet11.
  ///
  /// In ar_EG, this message translates to:
  /// **'تاريخ آخر حركة'**
  String get messageTemplateEditorBottomSheet11;

  /// No description provided for @messageTemplateEditorBottomSheet12.
  ///
  /// In ar_EG, this message translates to:
  /// **'اكتب نص رسالة التذكير هنا...'**
  String get messageTemplateEditorBottomSheet12;

  /// No description provided for @messageTemplateEditorBottomSheet13.
  ///
  /// In ar_EG, this message translates to:
  /// **'معاينة الرسالة كما ستصل للعميل:'**
  String get messageTemplateEditorBottomSheet13;

  /// No description provided for @messageTemplateEditorBottomSheet14.
  ///
  /// In ar_EG, this message translates to:
  /// **'حفظ النموذج'**
  String get messageTemplateEditorBottomSheet14;

  /// No description provided for @shopProfileBottomSheet1.
  ///
  /// In ar_EG, this message translates to:
  /// **'محفظة كاش: {trim}'**
  String shopProfileBottomSheet1(Object trim);

  /// No description provided for @shopProfileBottomSheet2.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم حفظ بيانات المحل بنجاح 👍'**
  String get shopProfileBottomSheet2;

  /// No description provided for @shopProfileBottomSheet3.
  ///
  /// In ar_EG, this message translates to:
  /// **'اسم المحل *'**
  String get shopProfileBottomSheet3;

  /// No description provided for @shopProfileBottomSheet4.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثلاً: بقالة الأمانة'**
  String get shopProfileBottomSheet4;

  /// No description provided for @shopProfileBottomSheet5.
  ///
  /// In ar_EG, this message translates to:
  /// **'يرجى إدخال اسم المحل'**
  String get shopProfileBottomSheet5;

  /// No description provided for @shopProfileBottomSheet6.
  ///
  /// In ar_EG, this message translates to:
  /// **'رقم هاتف المحل'**
  String get shopProfileBottomSheet6;

  /// No description provided for @shopProfileBottomSheet7.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثلاً: 010xxxxxxxx'**
  String get shopProfileBottomSheet7;

  /// No description provided for @shopProfileBottomSheet8.
  ///
  /// In ar_EG, this message translates to:
  /// **'عنوان المحل'**
  String get shopProfileBottomSheet8;

  /// No description provided for @shopProfileBottomSheet9.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثلاً: شارع السوق، بجوار المسجد الكبير'**
  String get shopProfileBottomSheet9;

  /// No description provided for @shopProfileBottomSheet10.
  ///
  /// In ar_EG, this message translates to:
  /// **'حساب إنستاباي (InstaPay)'**
  String get shopProfileBottomSheet10;

  /// No description provided for @shopProfileBottomSheet11.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثلاً: name@instapay'**
  String get shopProfileBottomSheet11;

  /// No description provided for @shopProfileBottomSheet12.
  ///
  /// In ar_EG, this message translates to:
  /// **'رقم فودافون كاش / المحفظة الذكية'**
  String get shopProfileBottomSheet12;

  /// No description provided for @shopProfileBottomSheet13.
  ///
  /// In ar_EG, this message translates to:
  /// **'نوع النشاط التجاري'**
  String get shopProfileBottomSheet13;

  /// No description provided for @shopProfileBottomSheet14.
  ///
  /// In ar_EG, this message translates to:
  /// **'نشاط وتجارة أخرى 🏪'**
  String get shopProfileBottomSheet14;

  /// No description provided for @shopProfileBottomSheet15.
  ///
  /// In ar_EG, this message translates to:
  /// **'تفعيل نظام الأقساط'**
  String get shopProfileBottomSheet15;

  /// No description provided for @shopProfileBottomSheet16.
  ///
  /// In ar_EG, this message translates to:
  /// **'إظهار زر الأقساط وجداول السداد في التطبيق'**
  String get shopProfileBottomSheet16;

  /// No description provided for @shopProfileBottomSheet17.
  ///
  /// In ar_EG, this message translates to:
  /// **'حفظ التعديلات'**
  String get shopProfileBottomSheet17;

  /// No description provided for @cloudAccountButton1.
  ///
  /// In ar_EG, this message translates to:
  /// **'حسابك والنسخ على السحابة ☁️'**
  String get cloudAccountButton1;

  /// No description provided for @cloudAccountButton2.
  ///
  /// In ar_EG, this message translates to:
  /// **'النسخ على السحابة'**
  String get cloudAccountButton2;

  /// No description provided for @cloudAccountButton3.
  ///
  /// In ar_EG, this message translates to:
  /// **'سجّل دخول بحساب جوجل'**
  String get cloudAccountButton3;

  /// No description provided for @cloudBackupCard1.
  ///
  /// In ar_EG, this message translates to:
  /// **'لحظة…'**
  String get cloudBackupCard1;

  /// No description provided for @cloudBackupCard2.
  ///
  /// In ar_EG, this message translates to:
  /// **'حصلت مشكلة غير متوقعة، جرّب تاني'**
  String get cloudBackupCard2;

  /// No description provided for @cloudBackupCard3.
  ///
  /// In ar_EG, this message translates to:
  /// **'بنفتح حسابات جوجل…'**
  String get cloudBackupCard3;

  /// No description provided for @cloudBackupCard4.
  ///
  /// In ar_EG, this message translates to:
  /// **'اتسجّل الدخول بـ {email} ✓'**
  String cloudBackupCard4(Object email);

  /// No description provided for @cloudBackupCard5.
  ///
  /// In ar_EG, this message translates to:
  /// **'النسخة اترفعت مع ملاحظات ⚠️'**
  String get cloudBackupCard5;

  /// No description provided for @cloudBackupCard6.
  ///
  /// In ar_EG, this message translates to:
  /// **'اترفع {uploaded} سجل، و {rejected} سجل اترفض:\n\n{n}'**
  String cloudBackupCard6(Object uploaded, Object rejected, Object n);

  /// No description provided for @cloudBackupCard7.
  ///
  /// In ar_EG, this message translates to:
  /// **'كل بياناتك متخزنة على السحابة بالفعل ✓'**
  String get cloudBackupCard7;

  /// No description provided for @cloudBackupCard8.
  ///
  /// In ar_EG, this message translates to:
  /// **'اترفع {uploaded} سجل على السحابة ✓'**
  String cloudBackupCard8(Object uploaded);

  /// No description provided for @cloudBackupCard9.
  ///
  /// In ar_EG, this message translates to:
  /// **'بنجيب المحلات اللي على حسابك…'**
  String get cloudBackupCard9;

  /// No description provided for @cloudBackupCard10.
  ///
  /// In ar_EG, this message translates to:
  /// **'مفيش نسخة على السحابة للحساب ده لسه'**
  String get cloudBackupCard10;

  /// No description provided for @cloudBackupCard11.
  ///
  /// In ar_EG, this message translates to:
  /// **'اختار المحل'**
  String get cloudBackupCard11;

  /// No description provided for @cloudBackupCard12.
  ///
  /// In ar_EG, this message translates to:
  /// **' (عامل)'**
  String get cloudBackupCard12;

  /// No description provided for @cloudBackupCard13.
  ///
  /// In ar_EG, this message translates to:
  /// **'استرجاع من السحابة؟'**
  String get cloudBackupCard13;

  /// No description provided for @cloudBackupCard14.
  ///
  /// In ar_EG, this message translates to:
  /// **'هننزّل نسخة \"{name}\" اللي على السحابة ونضيفها على الموبايل ده.\n\n'**
  String cloudBackupCard14(Object name);

  /// No description provided for @cloudBackupCard15.
  ///
  /// In ar_EG, this message translates to:
  /// **'مش هنمسح أي حاجة: البيانات اللي على الموبايل بس هتفضل، ولو حاجة اتعدلت على الموبايل بعد آخر نسخة هنسيبها زي ما هي.'**
  String get cloudBackupCard15;

  /// No description provided for @cloudBackupCard16.
  ///
  /// In ar_EG, this message translates to:
  /// **'أيوه، استرجع'**
  String get cloudBackupCard16;

  /// No description provided for @cloudBackupCard17.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم الاسترجاع 🎉'**
  String get cloudBackupCard17;

  /// No description provided for @cloudBackupCard18.
  ///
  /// In ar_EG, this message translates to:
  /// **'، واتساب {keptLocal} سجل زي ما هو لأن نسخة الموبايل أحدث'**
  String cloudBackupCard18(Object keptLocal);

  /// No description provided for @cloudBackupCard19.
  ///
  /// In ar_EG, this message translates to:
  /// **'اترجع {records} سجل{keptLocal}.'**
  String cloudBackupCard19(Object records, Object keptLocal);

  /// No description provided for @cloudBackupCard20.
  ///
  /// In ar_EG, this message translates to:
  /// **' اقفل التطبيق وافتحه تاني عشان كل الشاشات تتحدث.'**
  String get cloudBackupCard20;

  /// No description provided for @cloudBackupCard21.
  ///
  /// In ar_EG, this message translates to:
  /// **'اقفل التطبيق'**
  String get cloudBackupCard21;

  /// No description provided for @cloudBackupCard22.
  ///
  /// In ar_EG, this message translates to:
  /// **'تسجيل خروج؟'**
  String get cloudBackupCard22;

  /// No description provided for @cloudBackupCard23.
  ///
  /// In ar_EG, this message translates to:
  /// **'بياناتك هتفضل على الموبايل وعلى السحابة. بس النسخ هيقف لحد ما تسجّل دخول تاني.'**
  String get cloudBackupCard23;

  /// No description provided for @cloudBackupCard24.
  ///
  /// In ar_EG, this message translates to:
  /// **'خروج'**
  String get cloudBackupCard24;

  /// No description provided for @cloudBackupCard25.
  ///
  /// In ar_EG, this message translates to:
  /// **'مش متاح في النسخة دي من التطبيق'**
  String get cloudBackupCard25;

  /// No description provided for @cloudBackupCard26.
  ///
  /// In ar_EG, this message translates to:
  /// **'النسخ الاحتياطي على السحابة'**
  String get cloudBackupCard26;

  /// No description provided for @cloudBackupCard27.
  ///
  /// In ar_EG, this message translates to:
  /// **'سجّل بحساب جوجل وبياناتك تتحفظ أونلاين. لو الموبايل ضاع، ترجّعها على أي موبايل تاني.'**
  String get cloudBackupCard27;

  /// No description provided for @cloudBackupCard28.
  ///
  /// In ar_EG, this message translates to:
  /// **'لسه مفيش نسخة'**
  String get cloudBackupCard28;

  /// No description provided for @cloudBackupCard29.
  ///
  /// In ar_EG, this message translates to:
  /// **'آخر نسخة: {last}'**
  String cloudBackupCard29(Object last);

  /// No description provided for @cloudBackupCard30.
  ///
  /// In ar_EG, this message translates to:
  /// **'بيرفع دلوقتي…'**
  String get cloudBackupCard30;

  /// No description provided for @cloudBackupCard31.
  ///
  /// In ar_EG, this message translates to:
  /// **'مستني النت — هيرفع لوحده أول ما يرجع'**
  String get cloudBackupCard31;

  /// No description provided for @cloudBackupCard32.
  ///
  /// In ar_EG, this message translates to:
  /// **'الرفع وقف، هنحاول تاني بعد شوية'**
  String get cloudBackupCard32;

  /// No description provided for @cloudBackupCard33.
  ///
  /// In ar_EG, this message translates to:
  /// **'كله مرفوع ✓'**
  String get cloudBackupCard33;

  /// No description provided for @cloudBackupCard34.
  ///
  /// In ar_EG, this message translates to:
  /// **'الرفع تلقائي لما النت يكون شغال'**
  String get cloudBackupCard34;

  /// No description provided for @cloudBackupCard35.
  ///
  /// In ar_EG, this message translates to:
  /// **'ارفع نسخة احتياطية دلوقتي'**
  String get cloudBackupCard35;

  /// No description provided for @cloudBackupCard36.
  ///
  /// In ar_EG, this message translates to:
  /// **'استرجع بياناتك على الموبايل ده'**
  String get cloudBackupCard36;

  /// No description provided for @cloudBackupCard37.
  ///
  /// In ar_EG, this message translates to:
  /// **'لموبايل جديد أو بعد مسح التطبيق — مش بيمسح حاجة'**
  String get cloudBackupCard37;

  /// No description provided for @cloudBackupCard38.
  ///
  /// In ar_EG, this message translates to:
  /// **'تسجيل خروج'**
  String get cloudBackupCard38;

  /// No description provided for @onboardingScreen1.
  ///
  /// In ar_EG, this message translates to:
  /// **'محلي'**
  String get onboardingScreen1;

  /// No description provided for @onboardingScreen2.
  ///
  /// In ar_EG, this message translates to:
  /// **'تمت إضافة عملاء تجريبيين لتجربة التطبيق، يمكنك حذفهم في أي وقت'**
  String get onboardingScreen2;

  /// No description provided for @onboardingScreen3.
  ///
  /// In ar_EG, this message translates to:
  /// **'تهيئة كشكول لأول مرة'**
  String get onboardingScreen3;

  /// No description provided for @onboardingScreen4.
  ///
  /// In ar_EG, this message translates to:
  /// **'متابعة نوع النشاط'**
  String get onboardingScreen4;

  /// No description provided for @onboardingScreen5.
  ///
  /// In ar_EG, this message translates to:
  /// **'أهلاً بك في كشكول! 👋'**
  String get onboardingScreen5;

  /// No description provided for @onboardingScreen6.
  ///
  /// In ar_EG, this message translates to:
  /// **'دفترك الإلكتروني لحسابات الديون، التحصيل بالواتساب، والأقساط بدون تعقيد.'**
  String get onboardingScreen6;

  /// No description provided for @onboardingScreen7.
  ///
  /// In ar_EG, this message translates to:
  /// **'اسم المحل أو الكشكول *'**
  String get onboardingScreen7;

  /// No description provided for @onboardingScreen8.
  ///
  /// In ar_EG, this message translates to:
  /// **'مثال: بقالة الأمانة / موبايلات النجم'**
  String get onboardingScreen8;

  /// No description provided for @onboardingScreen9.
  ///
  /// In ar_EG, this message translates to:
  /// **'يرجى كتابة اسم المحل (حرفين على الأقل)'**
  String get onboardingScreen9;

  /// No description provided for @onboardingScreen10.
  ///
  /// In ar_EG, this message translates to:
  /// **'رقم هاتف المحل (اختياري)'**
  String get onboardingScreen10;

  /// No description provided for @onboardingScreen11.
  ///
  /// In ar_EG, this message translates to:
  /// **'يظهر في فواتير وكشوفات الحساب وتذييل رسائل الواتساب'**
  String get onboardingScreen11;

  /// No description provided for @onboardingScreen12.
  ///
  /// In ar_EG, this message translates to:
  /// **'بقالة وسوبرماركت'**
  String get onboardingScreen12;

  /// No description provided for @onboardingScreen13.
  ///
  /// In ar_EG, this message translates to:
  /// **'حسابات الديون اليومية وسرعة إغلاق الدرج'**
  String get onboardingScreen13;

  /// No description provided for @onboardingScreen14.
  ///
  /// In ar_EG, this message translates to:
  /// **'موبايلات وإكسسوارات'**
  String get onboardingScreen14;

  /// No description provided for @onboardingScreen15.
  ///
  /// In ar_EG, this message translates to:
  /// **'بيانات الأجهزة ويفعّل نظام الأقساط تلقائياً'**
  String get onboardingScreen15;

  /// No description provided for @onboardingScreen16.
  ///
  /// In ar_EG, this message translates to:
  /// **'أجهزة كهربائية ومنزلية'**
  String get onboardingScreen16;

  /// No description provided for @onboardingScreen17.
  ///
  /// In ar_EG, this message translates to:
  /// **'عقود بيع بالآجل ويفعّل نظام الأقساط تلقائياً'**
  String get onboardingScreen17;

  /// No description provided for @onboardingScreen18.
  ///
  /// In ar_EG, this message translates to:
  /// **'صيدلية ومستحضرات'**
  String get onboardingScreen18;

  /// No description provided for @onboardingScreen19.
  ///
  /// In ar_EG, this message translates to:
  /// **'حدود الائتمان ومتابعة ديون الروشتات'**
  String get onboardingScreen19;

  /// No description provided for @onboardingScreen20.
  ///
  /// In ar_EG, this message translates to:
  /// **'أنشطة وتجارة أخرى'**
  String get onboardingScreen20;

  /// No description provided for @onboardingScreen21.
  ///
  /// In ar_EG, this message translates to:
  /// **'دفتر مرن ومناسب لجميع أنواع التجارة الحرة'**
  String get onboardingScreen21;

  /// No description provided for @onboardingScreen22.
  ///
  /// In ar_EG, this message translates to:
  /// **'ما هو نوع نشاطك التجاري؟'**
  String get onboardingScreen22;

  /// No description provided for @onboardingScreen23.
  ///
  /// In ar_EG, this message translates to:
  /// **'سنقوم بتهيئة واجهة التطبيق والأقسام بناءً على طبيعة شغلك.'**
  String get onboardingScreen23;

  /// No description provided for @onboardingScreen24.
  ///
  /// In ar_EG, this message translates to:
  /// **'يدعم الأقساط'**
  String get onboardingScreen24;

  /// No description provided for @onboardingScreen25.
  ///
  /// In ar_EG, this message translates to:
  /// **'تفعيل نظام وجداول الأقساط'**
  String get onboardingScreen25;

  /// No description provided for @onboardingScreen26.
  ///
  /// In ar_EG, this message translates to:
  /// **'يمكنك تشغيله أو إيقافه في أي وقت من الإعدادات'**
  String get onboardingScreen26;

  /// No description provided for @onboardingScreen27.
  ///
  /// In ar_EG, this message translates to:
  /// **'ضمان وصول الإشعارات والتذكيرات 🔔'**
  String get onboardingScreen27;

  /// No description provided for @onboardingScreen28.
  ///
  /// In ar_EG, this message translates to:
  /// **'حتى يعمل كشكول في موعده اليومي لتنبيهك بالتحصيلات ومواعيد الأقساط:'**
  String get onboardingScreen28;

  /// No description provided for @onboardingScreen29.
  ///
  /// In ar_EG, this message translates to:
  /// **'إذن إرسال الإشعارات'**
  String get onboardingScreen29;

  /// No description provided for @onboardingScreen30.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم تفعيل الإشعارات بنجاح ✅'**
  String get onboardingScreen30;

  /// No description provided for @onboardingScreen31.
  ///
  /// In ar_EG, this message translates to:
  /// **'محتاجين إذن الإشعارات عشان نبعتلك ملخص التحصيل اليومي'**
  String get onboardingScreen31;

  /// No description provided for @onboardingScreen32.
  ///
  /// In ar_EG, this message translates to:
  /// **'السماح بالإشعارات الآن'**
  String get onboardingScreen32;

  /// No description provided for @onboardingScreen33.
  ///
  /// In ar_EG, this message translates to:
  /// **'حماية التطبيق في الخلفية ({brandName})'**
  String onboardingScreen33(Object brandName);

  /// No description provided for @onboardingScreen34.
  ///
  /// In ar_EG, this message translates to:
  /// **'حماية التطبيق من الإغلاق في الخلفية'**
  String get onboardingScreen34;

  /// No description provided for @onboardingScreen35.
  ///
  /// In ar_EG, this message translates to:
  /// **'فتح إعدادات بطارية الهاتف'**
  String get onboardingScreen35;

  /// No description provided for @onboardingScreen36.
  ///
  /// In ar_EG, this message translates to:
  /// **'جاهز للانطلاق! 🚀'**
  String get onboardingScreen36;

  /// No description provided for @onboardingScreen37.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم حفظ بيانات محلك. كيف تود أن تبدأ الآن؟'**
  String get onboardingScreen37;

  /// No description provided for @onboardingScreen38.
  ///
  /// In ar_EG, this message translates to:
  /// **'+ إضافة أول عميل حقيقي'**
  String get onboardingScreen38;

  /// No description provided for @onboardingScreen39.
  ///
  /// In ar_EG, this message translates to:
  /// **'سجل أول عميل وابدأ تدوين الديون والدفعات مباشرة'**
  String get onboardingScreen39;

  /// No description provided for @onboardingScreen40.
  ///
  /// In ar_EG, this message translates to:
  /// **'جرب ببيانات تجريبية أولاً 💡'**
  String get onboardingScreen40;

  /// No description provided for @onboardingScreen41.
  ///
  /// In ar_EG, this message translates to:
  /// **'إضافة عميلين وحسابات تجريبية لاكتشاف مميزات كشكول (يمكن حذفهم بضغطة زر)'**
  String get onboardingScreen41;

  /// No description provided for @onboardingScreen42.
  ///
  /// In ar_EG, this message translates to:
  /// **'تخطي والذهاب إلى الشاشة الرئيسية'**
  String get onboardingScreen42;

  /// No description provided for @shopRepository1.
  ///
  /// In ar_EG, this message translates to:
  /// **'أحمد محمد (تجريبي)'**
  String get shopRepository1;

  /// No description provided for @shopRepository2.
  ///
  /// In ar_EG, this message translates to:
  /// **'مشتريات طلبات منزلية'**
  String get shopRepository2;

  /// No description provided for @shopRepository3.
  ///
  /// In ar_EG, this message translates to:
  /// **'محمود إبراهيم (تجريبي)'**
  String get shopRepository3;

  /// No description provided for @shopRepository4.
  ///
  /// In ar_EG, this message translates to:
  /// **'بضاعة أول الشهر'**
  String get shopRepository4;

  /// No description provided for @shopRepository5.
  ///
  /// In ar_EG, this message translates to:
  /// **'دفعة نقدية على الحساب'**
  String get shopRepository5;

  /// No description provided for @supplierWithBalance1.
  ///
  /// In ar_EG, this message translates to:
  /// **'السبت'**
  String get supplierWithBalance1;

  /// No description provided for @supplierWithBalance2.
  ///
  /// In ar_EG, this message translates to:
  /// **'الأحد'**
  String get supplierWithBalance2;

  /// No description provided for @supplierWithBalance3.
  ///
  /// In ar_EG, this message translates to:
  /// **'الإثنين'**
  String get supplierWithBalance3;

  /// No description provided for @supplierWithBalance4.
  ///
  /// In ar_EG, this message translates to:
  /// **'الثلاثاء'**
  String get supplierWithBalance4;

  /// No description provided for @supplierWithBalance5.
  ///
  /// In ar_EG, this message translates to:
  /// **'الأربعاء'**
  String get supplierWithBalance5;

  /// No description provided for @supplierWithBalance6.
  ///
  /// In ar_EG, this message translates to:
  /// **'الخميس'**
  String get supplierWithBalance6;

  /// No description provided for @supplierWithBalance7.
  ///
  /// In ar_EG, this message translates to:
  /// **'الجمعة'**
  String get supplierWithBalance7;

  /// No description provided for @trashScreen1.
  ///
  /// In ar_EG, this message translates to:
  /// **'عملاء'**
  String get trashScreen1;

  /// No description provided for @trashScreen2.
  ///
  /// In ar_EG, this message translates to:
  /// **'عمليات'**
  String get trashScreen2;

  /// No description provided for @trashScreen3.
  ///
  /// In ar_EG, this message translates to:
  /// **'موردين'**
  String get trashScreen3;

  /// No description provided for @trashScreen4.
  ///
  /// In ar_EG, this message translates to:
  /// **'مصاريف'**
  String get trashScreen4;

  /// No description provided for @trashScreen5.
  ///
  /// In ar_EG, this message translates to:
  /// **'أقساط'**
  String get trashScreen5;

  /// No description provided for @trashScreen6.
  ///
  /// In ar_EG, this message translates to:
  /// **'رجع \"{title}\" ✓'**
  String trashScreen6(Object title);

  /// No description provided for @trashScreen7.
  ///
  /// In ar_EG, this message translates to:
  /// **'مقدرناش نرجّعه، جرّب تاني'**
  String get trashScreen7;

  /// No description provided for @trashScreen8.
  ///
  /// In ar_EG, this message translates to:
  /// **'سلة المحذوفات 🗑️'**
  String get trashScreen8;

  /// No description provided for @trashScreen9.
  ///
  /// In ar_EG, this message translates to:
  /// **'أي حاجة بتمسحها بتتنقل هنا ومش بتضيع. تقدر ترجّعها في أي وقت، وهترجع كمان في النسخة اللي على السحابة.'**
  String get trashScreen9;

  /// No description provided for @trashScreen10.
  ///
  /// In ar_EG, this message translates to:
  /// **'حصلت مشكلة في تحميل المحذوفات'**
  String get trashScreen10;

  /// No description provided for @trashScreen11.
  ///
  /// In ar_EG, this message translates to:
  /// **'السلة فاضية ✨'**
  String get trashScreen11;

  /// No description provided for @trashScreen12.
  ///
  /// In ar_EG, this message translates to:
  /// **'اتمسح {deletedAt}'**
  String trashScreen12(Object deletedAt);

  /// No description provided for @trashScreen13.
  ///
  /// In ar_EG, this message translates to:
  /// **'رجّع'**
  String get trashScreen13;

  /// No description provided for @trashScreen14.
  ///
  /// In ar_EG, this message translates to:
  /// **'سلة المحذوفات'**
  String get trashScreen14;

  /// No description provided for @trashScreen15.
  ///
  /// In ar_EG, this message translates to:
  /// **'شوف اللي اتمسح ورجّعه'**
  String get trashScreen15;

  /// No description provided for @trashScreen16.
  ///
  /// In ar_EG, this message translates to:
  /// **'فيها {count} حاجة — تقدر ترجّعها'**
  String trashScreen16(Object count);

  /// No description provided for @trashRepository1.
  ///
  /// In ar_EG, this message translates to:
  /// **'إيجار'**
  String get trashRepository1;

  /// No description provided for @trashRepository2.
  ///
  /// In ar_EG, this message translates to:
  /// **'كهربا'**
  String get trashRepository2;

  /// No description provided for @trashRepository3.
  ///
  /// In ar_EG, this message translates to:
  /// **'مرتبات'**
  String get trashRepository3;

  /// No description provided for @trashRepository4.
  ///
  /// In ar_EG, this message translates to:
  /// **'مستلزمات'**
  String get trashRepository4;

  /// No description provided for @trashRepository5.
  ///
  /// In ar_EG, this message translates to:
  /// **'دفع لمورد'**
  String get trashRepository5;

  /// No description provided for @trashRepository6.
  ///
  /// In ar_EG, this message translates to:
  /// **'مصروف'**
  String get trashRepository6;

  /// No description provided for @trashRepository7.
  ///
  /// In ar_EG, this message translates to:
  /// **'عليّا'**
  String get trashRepository7;

  /// No description provided for @trashRepository8.
  ///
  /// In ar_EG, this message translates to:
  /// **'دفع'**
  String get trashRepository8;

  /// No description provided for @trashRepository9.
  ///
  /// In ar_EG, this message translates to:
  /// **'دفعتله'**
  String get trashRepository9;

  /// No description provided for @trashRepository10.
  ///
  /// In ar_EG, this message translates to:
  /// **'غير معروف'**
  String get trashRepository10;

  /// No description provided for @trashRepository11.
  ///
  /// In ar_EG, this message translates to:
  /// **'تقسيط: {itemDescription}'**
  String trashRepository11(Object itemDescription);

  /// No description provided for @pdfStatementService1.
  ///
  /// In ar_EG, this message translates to:
  /// **'كشف_حساب_{sanitizedName}_{dateStr}.pdf'**
  String pdfStatementService1(Object sanitizedName, Object dateStr);

  /// No description provided for @pdfStatementService2.
  ///
  /// In ar_EG, this message translates to:
  /// **'كشف حساب عميل'**
  String get pdfStatementService2;

  /// No description provided for @pdfStatementService3.
  ///
  /// In ar_EG, this message translates to:
  /// **'العميل: {customerName}'**
  String pdfStatementService3(Object customerName);

  /// No description provided for @pdfStatementService4.
  ///
  /// In ar_EG, this message translates to:
  /// **'التليفون: {phone}'**
  String pdfStatementService4(Object phone);

  /// No description provided for @pdfStatementService5.
  ///
  /// In ar_EG, this message translates to:
  /// **'الفترة: {periodDescription}'**
  String pdfStatementService5(Object periodDescription);

  /// No description provided for @pdfStatementService6.
  ///
  /// In ar_EG, this message translates to:
  /// **'رصيد ما قبل هذه الفترة:'**
  String get pdfStatementService6;

  /// No description provided for @pdfStatementService7.
  ///
  /// In ar_EG, this message translates to:
  /// **'التاريخ'**
  String get pdfStatementService7;

  /// No description provided for @pdfStatementService8.
  ///
  /// In ar_EG, this message translates to:
  /// **'البيان'**
  String get pdfStatementService8;

  /// No description provided for @pdfStatementService9.
  ///
  /// In ar_EG, this message translates to:
  /// **'الرصيد'**
  String get pdfStatementService9;

  /// No description provided for @pdfStatementService10.
  ///
  /// In ar_EG, this message translates to:
  /// **'إجمالي المشتريات / السلف: {periodDebitsPiasters}'**
  String pdfStatementService10(Object periodDebitsPiasters);

  /// No description provided for @pdfStatementService11.
  ///
  /// In ar_EG, this message translates to:
  /// **'إجمالي المسدد: {periodCreditsPiasters}'**
  String pdfStatementService11(Object periodCreditsPiasters);

  /// No description provided for @pdfStatementService12.
  ///
  /// In ar_EG, this message translates to:
  /// **'الرصيد النهائي المطلوب:'**
  String get pdfStatementService12;

  /// No description provided for @pdfStatementService13.
  ///
  /// In ar_EG, this message translates to:
  /// **'طرق الدفع المتاحة: {trim}'**
  String pdfStatementService13(Object trim);

  /// No description provided for @pdfStatementService14.
  ///
  /// In ar_EG, this message translates to:
  /// **'اتعمل بكشكول — جرّبه ببلاش:'**
  String get pdfStatementService14;

  /// No description provided for @statementCalculator1.
  ///
  /// In ar_EG, this message translates to:
  /// **'كل المعاملات'**
  String get statementCalculator1;

  /// No description provided for @statementCalculator2.
  ///
  /// In ar_EG, this message translates to:
  /// **'يناير'**
  String get statementCalculator2;

  /// No description provided for @statementCalculator3.
  ///
  /// In ar_EG, this message translates to:
  /// **'فبراير'**
  String get statementCalculator3;

  /// No description provided for @statementCalculator4.
  ///
  /// In ar_EG, this message translates to:
  /// **'مارس'**
  String get statementCalculator4;

  /// No description provided for @statementCalculator5.
  ///
  /// In ar_EG, this message translates to:
  /// **'أبريل'**
  String get statementCalculator5;

  /// No description provided for @statementCalculator6.
  ///
  /// In ar_EG, this message translates to:
  /// **'مايو'**
  String get statementCalculator6;

  /// No description provided for @statementCalculator7.
  ///
  /// In ar_EG, this message translates to:
  /// **'يونيو'**
  String get statementCalculator7;

  /// No description provided for @statementCalculator8.
  ///
  /// In ar_EG, this message translates to:
  /// **'يوليو'**
  String get statementCalculator8;

  /// No description provided for @statementCalculator9.
  ///
  /// In ar_EG, this message translates to:
  /// **'أغسطس'**
  String get statementCalculator9;

  /// No description provided for @statementCalculator10.
  ///
  /// In ar_EG, this message translates to:
  /// **'سبتمبر'**
  String get statementCalculator10;

  /// No description provided for @statementCalculator11.
  ///
  /// In ar_EG, this message translates to:
  /// **'أكتوبر'**
  String get statementCalculator11;

  /// No description provided for @statementCalculator12.
  ///
  /// In ar_EG, this message translates to:
  /// **'نوفمبر'**
  String get statementCalculator12;

  /// No description provided for @statementCalculator13.
  ///
  /// In ar_EG, this message translates to:
  /// **'ديسمبر'**
  String get statementCalculator13;

  /// No description provided for @statementCalculator14.
  ///
  /// In ar_EG, this message translates to:
  /// **'من {startDate} إلى {endDate}'**
  String statementCalculator14(Object startDate, Object endDate);

  /// No description provided for @statementCalculator15.
  ///
  /// In ar_EG, this message translates to:
  /// **'من {startDate}'**
  String statementCalculator15(Object startDate);

  /// No description provided for @statementCalculator16.
  ///
  /// In ar_EG, this message translates to:
  /// **'حتى {endDate}'**
  String statementCalculator16(Object endDate);

  /// No description provided for @growthFooter1.
  ///
  /// In ar_EG, this message translates to:
  /// **'—\nاتعمل بكشكول 📒 جرّبه ببلاش: {shopCode}'**
  String growthFooter1(Object shopCode);

  /// No description provided for @growthFooter2.
  ///
  /// In ar_EG, this message translates to:
  /// **'أنا بستخدم كشكول 📒 عشان أتابع حسابات الزباين والموردين والدرج من غير دفتر ورق.\nسهل جداً وشغال من غير نت. جرّبه ببلاش:\n{shopCode}'**
  String growthFooter2(Object shopCode);

  /// No description provided for @notificationService1.
  ///
  /// In ar_EG, this message translates to:
  /// **'التحصيل اليومي'**
  String get notificationService1;

  /// No description provided for @notificationService2.
  ///
  /// In ar_EG, this message translates to:
  /// **'تذكير بالعملاء المستحقين للتحصيل ومواعيد دفعهم'**
  String get notificationService2;

  /// No description provided for @notificationService3.
  ///
  /// In ar_EG, this message translates to:
  /// **'عندك {dueCount} عملاء عليهم {amountStr} — اضغط للتحصيل'**
  String notificationService3(Object dueCount, Object amountStr);

  /// No description provided for @notificationService4.
  ///
  /// In ar_EG, this message translates to:
  /// **'تذكير التحصيل اليومي 📒'**
  String get notificationService4;

  /// No description provided for @backupService1.
  ///
  /// In ar_EG, this message translates to:
  /// **'ملف قاعدة البيانات غير موجود'**
  String get backupService1;

  /// No description provided for @backupService2.
  ///
  /// In ar_EG, this message translates to:
  /// **'نسخة احتياطية لتطبيق كشكول - {dateStr}'**
  String backupService2(Object dateStr);

  /// No description provided for @backupService3.
  ///
  /// In ar_EG, this message translates to:
  /// **'الملف المحدد غير موجود'**
  String get backupService3;

  /// No description provided for @backupService4.
  ///
  /// In ar_EG, this message translates to:
  /// **'الملف تالف أو غير مكتمل'**
  String get backupService4;

  /// No description provided for @backupService5.
  ///
  /// In ar_EG, this message translates to:
  /// **'صيغة الملف غير صحيحة (ليست ملف كشكول صالح)'**
  String get backupService5;

  /// No description provided for @backupService6.
  ///
  /// In ar_EG, this message translates to:
  /// **'الملف لا يحتوي على قاعدة بيانات كشكول'**
  String get backupService6;

  /// No description provided for @backupService7.
  ///
  /// In ar_EG, this message translates to:
  /// **'قاعدة البيانات داخل الملف تالفة'**
  String get backupService7;

  /// No description provided for @backupService8.
  ///
  /// In ar_EG, this message translates to:
  /// **'الملف ليس قاعدة بيانات SQLite صالحة'**
  String get backupService8;

  /// No description provided for @backupService9.
  ///
  /// In ar_EG, this message translates to:
  /// **'ملف النسخة الاحتياطية غير صالح'**
  String get backupService9;

  /// No description provided for @backupService10.
  ///
  /// In ar_EG, this message translates to:
  /// **'ملف قاعدة البيانات مفقود داخل الأرشيف'**
  String get backupService10;

  /// No description provided for @googleAuthService1.
  ///
  /// In ar_EG, this message translates to:
  /// **'النسخ على السحابة مش متظبط في النسخة دي من التطبيق'**
  String get googleAuthService1;

  /// No description provided for @googleAuthService2.
  ///
  /// In ar_EG, this message translates to:
  /// **'جوجل مارجعش بيانات الدخول، جرّب تاني'**
  String get googleAuthService2;

  /// No description provided for @googleAuthService3.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم إلغاء تسجيل الدخول'**
  String get googleAuthService3;

  /// No description provided for @googleAuthService4.
  ///
  /// In ar_EG, this message translates to:
  /// **'مقدرناش نسجّل دخول بجوجل ({codeName})'**
  String googleAuthService4(Object codeName);

  /// No description provided for @cloudApi1.
  ///
  /// In ar_EG, this message translates to:
  /// **'عنوان السيرفر مش متظبط في النسخة دي من التطبيق'**
  String get cloudApi1;

  /// No description provided for @cloudApi2.
  ///
  /// In ar_EG, this message translates to:
  /// **'سجّل دخول بحساب جوجل الأول'**
  String get cloudApi2;

  /// No description provided for @cloudApi3.
  ///
  /// In ar_EG, this message translates to:
  /// **'مفيش اتصال بالإنترنت، جرّب تاني'**
  String get cloudApi3;

  /// No description provided for @cloudApi4.
  ///
  /// In ar_EG, this message translates to:
  /// **'السيرفر اتأخر في الرد، جرّب تاني'**
  String get cloudApi4;

  /// No description provided for @cloudApi5.
  ///
  /// In ar_EG, this message translates to:
  /// **'انتهت صلاحية الدخول، سجّل دخول بحساب جوجل تاني'**
  String get cloudApi5;

  /// No description provided for @cloudApi6.
  ///
  /// In ar_EG, this message translates to:
  /// **'المحل ده متسجل على حساب جوجل تاني'**
  String get cloudApi6;

  /// No description provided for @cloudApi7.
  ///
  /// In ar_EG, this message translates to:
  /// **'الميزة دي محتاجة اشتراك'**
  String get cloudApi7;

  /// No description provided for @cloudApi8.
  ///
  /// In ar_EG, this message translates to:
  /// **'محاولات كتير، استنى شوية وجرّب تاني'**
  String get cloudApi8;

  /// No description provided for @cloudApi9.
  ///
  /// In ar_EG, this message translates to:
  /// **'سجّل دخول بحساب جوجل تاني'**
  String get cloudApi9;

  /// No description provided for @cloudApi10.
  ///
  /// In ar_EG, this message translates to:
  /// **'تسجيل الدخول بجوجل مش متظبط على السيرفر'**
  String get cloudApi10;

  /// No description provided for @cloudApi11.
  ///
  /// In ar_EG, this message translates to:
  /// **'حصلت مشكلة في السيرفر، جرّب بعد شوية'**
  String get cloudApi11;

  /// No description provided for @cloudApi12.
  ///
  /// In ar_EG, this message translates to:
  /// **'حصلت مشكلة ({code})'**
  String cloudApi12(Object code);

  /// No description provided for @cloudBackupService1.
  ///
  /// In ar_EG, this message translates to:
  /// **'تسجيل الدخول بجوجل مش متاح'**
  String get cloudBackupService1;

  /// No description provided for @cloudBackupService2.
  ///
  /// In ar_EG, this message translates to:
  /// **'كمّل بيانات المحل الأول من الإعدادات'**
  String get cloudBackupService2;

  /// No description provided for @cloudBackupService3.
  ///
  /// In ar_EG, this message translates to:
  /// **'بنجهّز بيانات المحل…'**
  String get cloudBackupService3;

  /// No description provided for @cloudBackupService4.
  ///
  /// In ar_EG, this message translates to:
  /// **'بنرفع {length} من {changesLength}…'**
  String cloudBackupService4(Object length, Object changesLength);

  /// No description provided for @cloudBackupService5.
  ///
  /// In ar_EG, this message translates to:
  /// **'خلصنا ✓'**
  String get cloudBackupService5;

  /// No description provided for @cloudBackupService6.
  ///
  /// In ar_EG, this message translates to:
  /// **'بننزّل البيانات… ({changesLength})'**
  String cloudBackupService6(Object changesLength);

  /// No description provided for @cloudBackupService7.
  ///
  /// In ar_EG, this message translates to:
  /// **'بنحفظ {changesLength} سجل على الموبايل…'**
  String cloudBackupService7(Object changesLength);

  /// No description provided for @cloudBackupService8.
  ///
  /// In ar_EG, this message translates to:
  /// **'المحل'**
  String get cloudBackupService8;

  /// No description provided for @autoBackupCoordinator1.
  ///
  /// In ar_EG, this message translates to:
  /// **'{rejected} سجل مترفعش'**
  String autoBackupCoordinator1(Object rejected);

  /// No description provided for @autoBackupCoordinator2.
  ///
  /// In ar_EG, this message translates to:
  /// **'حصلت مشكلة، هنحاول تاني بعد شوية'**
  String get autoBackupCoordinator2;

  /// No description provided for @customerRating1.
  ///
  /// In ar_EG, this message translates to:
  /// **'عميل جديد (سجل أقل من 3 معاملات)'**
  String get customerRating1;

  /// No description provided for @customerRating2.
  ///
  /// In ar_EG, this message translates to:
  /// **'حسابه خالص وبيدفع في مواعيده بانتظام'**
  String get customerRating2;

  /// No description provided for @customerRating3.
  ///
  /// In ar_EG, this message translates to:
  /// **'متأخر: أقدم دين عليه من {oldestUnpaidAgeDays} يوم وتخطى حد الدين'**
  String customerRating3(Object oldestUnpaidAgeDays);

  /// No description provided for @customerRating4.
  ///
  /// In ar_EG, this message translates to:
  /// **'تعدى حد الدين المحدد للعميل'**
  String get customerRating4;

  /// No description provided for @customerRating5.
  ///
  /// In ar_EG, this message translates to:
  /// **'سجل ديناً اليوم فقط وحسابه منتظم'**
  String get customerRating5;

  /// No description provided for @customerRating6.
  ///
  /// In ar_EG, this message translates to:
  /// **'أقدم مبلغ عليه من {oldestUnpaidAgeDays} يوم فقط (في نطاق الأمان)'**
  String customerRating6(Object oldestUnpaidAgeDays);

  /// No description provided for @customerRating7.
  ///
  /// In ar_EG, this message translates to:
  /// **'أقدم مبلغ عليه من {oldestUnpaidAgeDays} يوم (متأخر عن 45 يوم)'**
  String customerRating7(Object oldestUnpaidAgeDays);

  /// No description provided for @customerRating8.
  ///
  /// In ar_EG, this message translates to:
  /// **'أقدم مبلغ عليه من {oldestUnpaidAgeDays} يوم (يحتاج متابعة)'**
  String customerRating8(Object oldestUnpaidAgeDays);

  /// No description provided for @whatsappTemplate1.
  ///
  /// In ar_EG, this message translates to:
  /// **'السلام عليكم أ/ \'{\'customer_name\'}\' 👋\nمعاك \'{\'shop_name\'}\'.\nرصيدك الحالي: \'{\'balance\'}\'\nآخر عملية: \'{\'last_transaction_date\'}\' - \'{\'last_transaction_amount\'}\'\nللدفع: \'{\'payment_info\'}\'\nشكراً لتعاملك معانا 🙏'**
  String get whatsappTemplate1;

  /// No description provided for @whatsappTemplate2.
  ///
  /// In ar_EG, this message translates to:
  /// **'تحية طيبة أ/ \'{\'customer_name\'}\'\nنود تذكيركم بأن الحساب الحالي لدى \'{\'shop_name\'}\' يبلغ \'{\'balance\'}\'.\nآخر عملية مسجلة: \'{\'last_transaction_date\'}\' (\'{\'last_transaction_amount\'}\')\nطرق السداد المتاحة: \'{\'payment_info\'}\'\nمع خالص الشكر والتقدير.'**
  String get whatsappTemplate2;

  /// No description provided for @whatsappTemplate3.
  ///
  /// In ar_EG, this message translates to:
  /// **'السلام عليكم أ/ \'{\'customer_name\'}\' 👋\nمعاك \'{\'shop_name\'}\'.\nبنفكرك بميعاد استحقاق قسط (\'{\'item\'}\') - القسط رقم \'{\'installment_number\'}\' من \'{\'installment_count\'}\':\nالمبلغ المستحق: \'{\'amount\'}\'\nتاريخ الاستحقاق: \'{\'due_date\'}\'\nإجمالي المتبقي من الأقساط: \'{\'remaining_total\'}\'\nطرق السداد المتاحة: \'{\'payment_info\'}\'\nشكراً لالتزامك معانا 🙏'**
  String get whatsappTemplate3;

  /// No description provided for @whatsappTemplate4.
  ///
  /// In ar_EG, this message translates to:
  /// **'كاش في المحل أو التحويل المتاح'**
  String get whatsappTemplate4;

  /// No description provided for @money1.
  ///
  /// In ar_EG, this message translates to:
  /// **'جنيه'**
  String get money1;

  /// No description provided for @batteryOptimizationHelper1.
  ///
  /// In ar_EG, this message translates to:
  /// **'نظام XOS / HiOS'**
  String get batteryOptimizationHelper1;

  /// No description provided for @batteryOptimizationHelper2.
  ///
  /// In ar_EG, this message translates to:
  /// **'افتح تطبيق Phone Master (مدير الهاتف) الموجود على جهازك.'**
  String get batteryOptimizationHelper2;

  /// No description provided for @batteryOptimizationHelper3.
  ///
  /// In ar_EG, this message translates to:
  /// **'ادخل على \"إدارة التشغيل التلقائي (Auto-start)\" وفعّل تطبيق كشكول.'**
  String get batteryOptimizationHelper3;

  /// No description provided for @batteryOptimizationHelper4.
  ///
  /// In ar_EG, this message translates to:
  /// **'في إعدادات التطبيق، ادخل على \"البطارية\" واختر \"بلا قيود (Unrestricted)\".'**
  String get batteryOptimizationHelper4;

  /// No description provided for @batteryOptimizationHelper5.
  ///
  /// In ar_EG, this message translates to:
  /// **'في شاشة التطبيقات المفتوحة، اسحب التطبيق لأسفل لتثبيته بالقفل 🔒.'**
  String get batteryOptimizationHelper5;

  /// No description provided for @batteryOptimizationHelper6.
  ///
  /// In ar_EG, this message translates to:
  /// **'نظام MIUI / HyperOS'**
  String get batteryOptimizationHelper6;

  /// No description provided for @batteryOptimizationHelper7.
  ///
  /// In ar_EG, this message translates to:
  /// **'ادخل على إعدادات التطبيق وفعّل \"التشغيل التلقائي (Autostart)\".'**
  String get batteryOptimizationHelper7;

  /// No description provided for @batteryOptimizationHelper8.
  ///
  /// In ar_EG, this message translates to:
  /// **'من \"موفر البطارية (Battery Saver)\"، اختر \"بلا قيود (No Restrictions)\".'**
  String get batteryOptimizationHelper8;

  /// No description provided for @batteryOptimizationHelper9.
  ///
  /// In ar_EG, this message translates to:
  /// **'من شاشة التطبيقات الحديثة، اضغط ضغطة مطولة على كشكول واختر أيقونة القفل 🔒.'**
  String get batteryOptimizationHelper9;

  /// No description provided for @batteryOptimizationHelper10.
  ///
  /// In ar_EG, this message translates to:
  /// **'نظام ColorOS / Realme UI'**
  String get batteryOptimizationHelper10;

  /// No description provided for @batteryOptimizationHelper11.
  ///
  /// In ar_EG, this message translates to:
  /// **'من إعدادات التطبيق -> استخدام البطارية، فعّل \"السماح بالنشاط في الخلفية\".'**
  String get batteryOptimizationHelper11;

  /// No description provided for @batteryOptimizationHelper12.
  ///
  /// In ar_EG, this message translates to:
  /// **'فعّل خيار \"التشغيل التلقائي (Auto-launch)\".'**
  String get batteryOptimizationHelper12;

  /// No description provided for @batteryOptimizationHelper13.
  ///
  /// In ar_EG, this message translates to:
  /// **'في قائمة التطبيقات المفتوحة، اضغط على النقاط الثلاث واختر \"تثبيت (Lock)\".'**
  String get batteryOptimizationHelper13;

  /// No description provided for @batteryOptimizationHelper14.
  ///
  /// In ar_EG, this message translates to:
  /// **'نظام One UI'**
  String get batteryOptimizationHelper14;

  /// No description provided for @batteryOptimizationHelper15.
  ///
  /// In ar_EG, this message translates to:
  /// **'ادخل على الإعدادات -> العناية بالجهاز (Device Care) -> البطارية.'**
  String get batteryOptimizationHelper15;

  /// No description provided for @batteryOptimizationHelper16.
  ///
  /// In ar_EG, this message translates to:
  /// **'ادخل على \"حدود استخدام الخلفية (Background usage limits)\".'**
  String get batteryOptimizationHelper16;

  /// No description provided for @batteryOptimizationHelper17.
  ///
  /// In ar_EG, this message translates to:
  /// **'أضف كشكول إلى قائمة \"التطبيقات التي لا تنام أبداً (Never sleeping apps)\".'**
  String get batteryOptimizationHelper17;

  /// No description provided for @batteryOptimizationHelper18.
  ///
  /// In ar_EG, this message translates to:
  /// **'نظام EMUI / MagicOS'**
  String get batteryOptimizationHelper18;

  /// No description provided for @batteryOptimizationHelper19.
  ///
  /// In ar_EG, this message translates to:
  /// **'ادخل على الإعدادات -> البطارية -> بدء تشغيل التطبيقات (App Launch).'**
  String get batteryOptimizationHelper19;

  /// No description provided for @batteryOptimizationHelper20.
  ///
  /// In ar_EG, this message translates to:
  /// **'ابحث عن \"كشكول\"، حوّل الإدارة إلى يدوية، وفعّل (التشغيل التلقائي + العمل في الخلفية).'**
  String get batteryOptimizationHelper20;

  /// No description provided for @batteryOptimizationHelper21.
  ///
  /// In ar_EG, this message translates to:
  /// **'إعدادات النظام'**
  String get batteryOptimizationHelper21;

  /// No description provided for @batteryOptimizationHelper22.
  ///
  /// In ar_EG, this message translates to:
  /// **'حماية إشعارات النظام'**
  String get batteryOptimizationHelper22;

  /// No description provided for @batteryOptimizationHelper23.
  ///
  /// In ar_EG, this message translates to:
  /// **'ادخل على معلومات التطبيق في إعدادات الهاتف.'**
  String get batteryOptimizationHelper23;

  /// No description provided for @batteryOptimizationHelper24.
  ///
  /// In ar_EG, this message translates to:
  /// **'ادخل على قسم \"البطارية (Battery)\" واختر \"غير مقيد (Unrestricted)\".'**
  String get batteryOptimizationHelper24;

  /// No description provided for @batteryOptimizationHelper25.
  ///
  /// In ar_EG, this message translates to:
  /// **'تأكد من عدم تفعيل وضع توفير الطاقة الفائق على الهاتف لضمان وصول تنبيهات التحصيل.'**
  String get batteryOptimizationHelper25;

  /// No description provided for @homeWidgetService1.
  ///
  /// In ar_EG, this message translates to:
  /// **'مفيش'**
  String get homeWidgetService1;

  /// No description provided for @homeWidgetService2.
  ///
  /// In ar_EG, this message translates to:
  /// **'عميل واحد'**
  String get homeWidgetService2;

  /// No description provided for @homeWidgetService3.
  ///
  /// In ar_EG, this message translates to:
  /// **'عميلين'**
  String get homeWidgetService3;

  /// No description provided for @homeWidgetService4.
  ///
  /// In ar_EG, this message translates to:
  /// **'{count} عملاء'**
  String homeWidgetService4(Object count);

  /// No description provided for @pinLockScreen1.
  ///
  /// In ar_EG, this message translates to:
  /// **'رمز الدخول غير صحيح، حاول تاني'**
  String get pinLockScreen1;

  /// No description provided for @pinLockScreen2.
  ///
  /// In ar_EG, this message translates to:
  /// **'الرمزان غير متطابقين، حاول من جديد'**
  String get pinLockScreen2;

  /// No description provided for @pinLockScreen3.
  ///
  /// In ar_EG, this message translates to:
  /// **'البصمة غير متاحة أو غير مفعّلة في إعدادات جهازك'**
  String get pinLockScreen3;

  /// No description provided for @pinLockScreen4.
  ///
  /// In ar_EG, this message translates to:
  /// **'أهلاً بيك في كشكول 📒'**
  String get pinLockScreen4;

  /// No description provided for @pinLockScreen5.
  ///
  /// In ar_EG, this message translates to:
  /// **'تعيين رمز دخول جديد'**
  String get pinLockScreen5;

  /// No description provided for @pinLockScreen6.
  ///
  /// In ar_EG, this message translates to:
  /// **'أعد كتابة الرمز للتأكيد'**
  String get pinLockScreen6;

  /// No description provided for @pinLockScreen7.
  ///
  /// In ar_EG, this message translates to:
  /// **'أدخل رمز الدخول المكون من 4 أرقام'**
  String get pinLockScreen7;

  /// No description provided for @pinLockScreen8.
  ///
  /// In ar_EG, this message translates to:
  /// **'اكتب 4 أرقام تفتكرهم عشان تقفل بيهم التطبيق'**
  String get pinLockScreen8;

  /// No description provided for @pinLockScreen9.
  ///
  /// In ar_EG, this message translates to:
  /// **'اكتب نفس الأرقام مرة تانية'**
  String get pinLockScreen9;

  /// No description provided for @pinLockScreen10.
  ///
  /// In ar_EG, this message translates to:
  /// **'بصمة الإصبع'**
  String get pinLockScreen10;

  /// No description provided for @pinLockScreen11.
  ///
  /// In ar_EG, this message translates to:
  /// **'مسح'**
  String get pinLockScreen11;

  /// No description provided for @securityService1.
  ///
  /// In ar_EG, this message translates to:
  /// **'تأكيد الهوية لفتح كشكول'**
  String get securityService1;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'اللغة'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In ar_EG, this message translates to:
  /// **'لغة الموبايل (تلقائي)'**
  String get settingsLanguageSystem;

  /// No description provided for @cloudDeleteAccountTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'احذف حسابي على السحابة'**
  String get cloudDeleteAccountTitle;

  /// No description provided for @cloudDeleteAccountSubtitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'بيمسح نسخ السحابة وحسابك نهائي — بياناتك على الموبايل مش هتتمسح'**
  String get cloudDeleteAccountSubtitle;

  /// No description provided for @cloudDeleteAccountConfirmTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'تمسح حسابك نهائي؟'**
  String get cloudDeleteAccountConfirmTitle;

  /// No description provided for @cloudDeleteAccountConfirmBody.
  ///
  /// In ar_EG, this message translates to:
  /// **'هنمسح حسابك وكل النسخ اللي على السحابة للمحلات اللي إنت صاحبها، ومش هينفع نرجّعهم. البيانات اللي على الموبايل ده هتفضل زي ما هي.'**
  String get cloudDeleteAccountConfirmBody;

  /// No description provided for @cloudDeleteAccountConfirmButton.
  ///
  /// In ar_EG, this message translates to:
  /// **'امسح نهائي'**
  String get cloudDeleteAccountConfirmButton;

  /// No description provided for @cloudDeleteAccountDone.
  ///
  /// In ar_EG, this message translates to:
  /// **'اتمسح حسابك من السحابة'**
  String get cloudDeleteAccountDone;

  /// No description provided for @authFirstTimeTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'أهلاً بك في كشكول! 👋'**
  String get authFirstTimeTitle;

  /// No description provided for @authFirstTimeQuestion.
  ///
  /// In ar_EG, this message translates to:
  /// **'هل عندك حساب بالفعل ولا مستخدم جديد؟'**
  String get authFirstTimeQuestion;

  /// No description provided for @authHaveAccount.
  ///
  /// In ar_EG, this message translates to:
  /// **'عندي حساب بالفعل'**
  String get authHaveAccount;

  /// No description provided for @authHaveAccountSubtitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'سجّل دخولك وهنرجعلك كل بيانات محلك فوراً'**
  String get authHaveAccountSubtitle;

  /// No description provided for @authNewUser.
  ///
  /// In ar_EG, this message translates to:
  /// **'مستخدم جديد'**
  String get authNewUser;

  /// No description provided for @authNewUserSubtitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'ابدأ كشكول جديد وجهّز محلك خطوة بخطوة'**
  String get authNewUserSubtitle;

  /// No description provided for @authContinueGuest.
  ///
  /// In ar_EG, this message translates to:
  /// **'المتابعة كضيف (بدون حساب)'**
  String get authContinueGuest;

  /// No description provided for @authContinueGuestSubtitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'استخدم التطبيق محلياً بدون إنترنت خالص'**
  String get authContinueGuestSubtitle;

  /// No description provided for @authLogin.
  ///
  /// In ar_EG, this message translates to:
  /// **'تسجيل الدخول'**
  String get authLogin;

  /// No description provided for @authRegister.
  ///
  /// In ar_EG, this message translates to:
  /// **'إنشاء حساب جديد'**
  String get authRegister;

  /// No description provided for @authEmail.
  ///
  /// In ar_EG, this message translates to:
  /// **'البريد الإلكتروني'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In ar_EG, this message translates to:
  /// **'كلمة المرور'**
  String get authPassword;

  /// No description provided for @authPasswordConfirm.
  ///
  /// In ar_EG, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get authPasswordConfirm;

  /// No description provided for @authNameOptional.
  ///
  /// In ar_EG, this message translates to:
  /// **'الاسم (اختياري)'**
  String get authNameOptional;

  /// No description provided for @authLoginButton.
  ///
  /// In ar_EG, this message translates to:
  /// **'تسجيل الدخول'**
  String get authLoginButton;

  /// No description provided for @authRegisterButton.
  ///
  /// In ar_EG, this message translates to:
  /// **'إنشاء حساب'**
  String get authRegisterButton;

  /// No description provided for @authOrGoogle.
  ///
  /// In ar_EG, this message translates to:
  /// **'أو المتابعة بحساب Google'**
  String get authOrGoogle;

  /// No description provided for @authSignInWithGoogle.
  ///
  /// In ar_EG, this message translates to:
  /// **'تسجيل الدخول بحساب Google'**
  String get authSignInWithGoogle;

  /// No description provided for @authSignInWithGoogleSubtitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'مزامنة سحابية واسترجاع بيانات محلك تلقائياً'**
  String get authSignInWithGoogleSubtitle;

  /// No description provided for @authSwitchAccount.
  ///
  /// In ar_EG, this message translates to:
  /// **'تبديل الحساب'**
  String get authSwitchAccount;

  /// No description provided for @authSwitchAccountSubtitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'اختر حساباً آخر أو سجّل دخول بحساب جديد'**
  String get authSwitchAccountSubtitle;

  /// No description provided for @authAddAccount.
  ///
  /// In ar_EG, this message translates to:
  /// **'+ تسجيل الدخول بحساب آخر'**
  String get authAddAccount;

  /// No description provided for @authCurrentAccount.
  ///
  /// In ar_EG, this message translates to:
  /// **'الحساب النشط حالياً'**
  String get authCurrentAccount;

  /// No description provided for @authPasswordsDontMatch.
  ///
  /// In ar_EG, this message translates to:
  /// **'كلمتا المرور غير متطابقتين'**
  String get authPasswordsDontMatch;

  /// No description provided for @authPasswordTooShort.
  ///
  /// In ar_EG, this message translates to:
  /// **'كلمة المرور لازم تكون 6 أحرف على الأقل'**
  String get authPasswordTooShort;

  /// No description provided for @authInvalidEmail.
  ///
  /// In ar_EG, this message translates to:
  /// **'اكتب بريد إلكتروني صحيح'**
  String get authInvalidEmail;

  /// No description provided for @authLoginSuccess.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم تسجيل الدخول بنجاح 🎉'**
  String get authLoginSuccess;

  /// No description provided for @authRegisterSuccess.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم إنشاء الحساب بنجاح 🎉'**
  String get authRegisterSuccess;

  /// No description provided for @authSwitchedTo.
  ///
  /// In ar_EG, this message translates to:
  /// **'تم التبديل إلى حساب: {email}'**
  String authSwitchedTo(Object email);

  /// No description provided for @cloudApiEmailTaken.
  ///
  /// In ar_EG, this message translates to:
  /// **'البريد ده مسجل قبل كده، جرّب تسجّل دخول'**
  String get cloudApiEmailTaken;

  /// No description provided for @cloudApiInvalidCredentials.
  ///
  /// In ar_EG, this message translates to:
  /// **'البريد أو كلمة المرور مش صحيحة'**
  String get cloudApiInvalidCredentials;

  /// No description provided for @authBackupBeforeSwitchTitle.
  ///
  /// In ar_EG, this message translates to:
  /// **'تنبيه: بيانات غير محفوظة!'**
  String get authBackupBeforeSwitchTitle;

  /// No description provided for @authBackupBeforeSwitchBody.
  ///
  /// In ar_EG, this message translates to:
  /// **'يوجد بيانات لم يتم حفظ نسخة منها على السحابة لهذا الحساب. لو بدّلت الحساب دلوقتي، البيانات المحلية هتتمسح ومش هتعرف ترجعها إلا لو عملت نسخة أولاً.'**
  String get authBackupBeforeSwitchBody;

  /// No description provided for @authBackupFirst.
  ///
  /// In ar_EG, this message translates to:
  /// **'اعمل نسخة احتياطية أولاً'**
  String get authBackupFirst;

  /// No description provided for @authSwitchWithoutBackup.
  ///
  /// In ar_EG, this message translates to:
  /// **'تبديل ومسح البيانات المحلية'**
  String get authSwitchWithoutBackup;

  /// No description provided for @authFetchingData.
  ///
  /// In ar_EG, this message translates to:
  /// **'جاري جلب بياناتك من السحابة…'**
  String get authFetchingData;

  /// No description provided for @authEmailLoginButton.
  ///
  /// In ar_EG, this message translates to:
  /// **'تسجيل الدخول بالبريد الإلكتروني'**
  String get authEmailLoginButton;

  /// No description provided for @authEmailRegisterButton.
  ///
  /// In ar_EG, this message translates to:
  /// **'إنشاء حساب جديد بالبريد'**
  String get authEmailRegisterButton;

  /// No description provided for @authWipingData.
  ///
  /// In ar_EG, this message translates to:
  /// **'جاري مسح البيانات المحلية وتبديل الحساب…'**
  String get authWipingData;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'en',
    'fa',
    'fr',
    'hi',
    'id',
    'tr',
    'ur',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'ar':
      {
        switch (locale.countryCode) {
          case 'EG':
            return AppLocalizationsArEg();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
