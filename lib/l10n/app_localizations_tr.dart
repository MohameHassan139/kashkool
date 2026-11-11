// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Kashkool';

  @override
  String get navCustomers => 'Müşteriler';

  @override
  String get navCollection => 'Tahsilat';

  @override
  String get navSuppliers => 'Tedarikçiler';

  @override
  String get navCashDrawer => 'Kasa';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get debt => 'Borç';

  @override
  String get payment => 'Ödeme';

  @override
  String get settled => 'Kapandı';

  @override
  String get currency => 'EGP';

  @override
  String get piaster => 'Kuruş';

  @override
  String get save => 'Kaydet';

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get search => 'Ara...';

  @override
  String placeholderScreen(String screenName) {
    return '$screenName ekranı';
  }

  @override
  String get comingSoon => 'Yakında';

  @override
  String get totalReceivablesTitle => 'Alacaklarınız';

  @override
  String get searchCustomersHint => 'İsim veya telefonla ara...';

  @override
  String get filterAll => 'Tümü';

  @override
  String get filterHasDebt => 'Borçlu';

  @override
  String get filterSettled => 'Kapananlar';

  @override
  String get filterLate => 'Gecikenler';

  @override
  String get sortHighestDebt => 'En yüksek borç';

  @override
  String get sortName => 'İsim';

  @override
  String get sortLastActivity => 'Son işlem';

  @override
  String get addNewCustomer => 'Yeni müşteri';

  @override
  String get addCustomer => 'Müşteri ekle';

  @override
  String get editCustomer => 'Müşteriyi düzenle';

  @override
  String get customerName => 'Müşteri adı';

  @override
  String get customerNameHint => 'örn. Bakkal Mehmet';

  @override
  String get customerNameRequired => 'Müşteri adı zorunlu';

  @override
  String get customerNameTooShort => 'İsim en az 2 karakter olmalı';

  @override
  String get customerPhone => 'Cep telefonu';

  @override
  String get customerPhoneHint => '010xxxxxxxx';

  @override
  String get customerPhoneInvalid => 'Geçersiz numara (010, 011, 012, 015)';

  @override
  String get customerNotes => 'Notlar';

  @override
  String get customerNotesHint => 'örn. 2. kattaki komşu';

  @override
  String get creditLimit => 'Borç limiti (isteğe bağlı)';

  @override
  String get creditLimitHint => 'örn. 1000';

  @override
  String get noCustomersTitle => 'Defteriniz boş!';

  @override
  String get noCustomersSubtitle =>
      'İlk müşterinizi eklemek ve hesaplarını kolayca takip etmek için aşağıdaki düğmeye dokunun';

  @override
  String get noSearchResults => 'Eşleşen müşteri yok';

  @override
  String get duplicateCustomerWarning =>
      'Uyarı: Aynı isim veya telefonla kayıtlı müşteri var';

  @override
  String get customerDetails => 'Müşteri bilgileri';

  @override
  String get callCustomer => 'Ara';

  @override
  String get deleteCustomer => 'Müşteriyi sil';

  @override
  String get deleteCustomerConfirm => 'Silmeyi onayla';

  @override
  String deleteCustomerWarningDebt(String amount) {
    return 'Dikkat! Bu müşterinin hâlâ $amount borcu var. Silmek istediğinize emin misiniz?';
  }

  @override
  String deleteCustomerSafeConfirm(String name) {
    return '$name adlı müşteriyi silmek istediğinize emin misiniz?';
  }

  @override
  String get customerDeleted => 'Müşteri silindi';

  @override
  String get customerSaved => 'Müşteri kaydedildi';

  @override
  String get lastActivityNever => 'Önceki işlem yok';

  @override
  String lastActivityDate(String date) {
    return 'Son işlem: $date';
  }

  @override
  String creditLimitLabel(String amount) {
    return 'Borç limiti: $amount';
  }

  @override
  String get creditLimitExceeded => 'Borç limiti aşıldı!';

  @override
  String get heOwes => 'Borçlu';

  @override
  String get hePaid => 'Alacaklı (fazla ödedi)';

  @override
  String get currentBalance => 'Güncel bakiye';

  @override
  String get noTransactionsYet => 'Henüz işlem yok';

  @override
  String get addDebtTitle => 'Borç kaydet';

  @override
  String get addPaymentTitle => 'Ödeme kaydet';

  @override
  String get amountLabel => 'Tutar';

  @override
  String get amountRequired => '0\'dan büyük geçerli bir tutar girin';

  @override
  String get today => 'Bugün';

  @override
  String get yesterday => 'Dün';

  @override
  String get date => 'Tarih';

  @override
  String get pickDate => 'Tarih seç';

  @override
  String get paymentMethod => 'Ödeme yöntemi';

  @override
  String get methodCash => 'Nakit';

  @override
  String get methodInstapay => 'InstaPay';

  @override
  String get methodWallet => 'Mobil cüzdan';

  @override
  String get methodOther => 'Diğer';

  @override
  String get noteOptional => 'Not (isteğe bağlı: şeker, yağ, kontör...)';

  @override
  String get voiceDictation => 'Sesle yazma';

  @override
  String get listening => 'Dinleniyor... Şimdi konuşun';

  @override
  String get speechNotAvailable => 'Bu cihazda sesle yazma yok';

  @override
  String get attachPhoto => 'Fotoğraf ekle';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galeri';

  @override
  String get removePhoto => 'Fotoğrafı kaldır';

  @override
  String get overpaymentTitle => 'Tutar borçtan fazla!';

  @override
  String overpaymentMessage(
    String paidAmount,
    String dueAmount,
    String creditAmount,
  ) {
    return 'Ödenen tutar ($paidAmount) borçtan ($dueAmount) fazla. Farkı ($creditAmount) müşteri alacağı olarak kaydedilsin mi?';
  }

  @override
  String get overpaymentConfirm => 'Evet, alacak kaydet';

  @override
  String get transactionSaved => 'İşlem kaydedildi';

  @override
  String get undo => 'Geri al';

  @override
  String get transactionUndone => 'İşlem geri alındı';

  @override
  String get transactionDetails => 'İşlem detayı';

  @override
  String get editTransaction => 'İşlemi düzenle';

  @override
  String get deleteTransaction => 'İşlemi sil';

  @override
  String get deleteTransactionConfirm =>
      'Bu işlemi silmek istediğinize emin misiniz?';

  @override
  String get transactionDeleted => 'İşlem silindi';

  @override
  String get viewPhoto => 'Fotoğrafı gör';

  @override
  String get creditLimitWarningTitle => 'Borç limiti uyarısı';

  @override
  String creditLimitExceededDialog(
    String customerName,
    String newTotal,
    String limit,
  ) {
    return '$customerName borcu $newTotal olacak, oysa limiti $limit';
  }

  @override
  String get saveAnyway => 'Yine de kaydet';

  @override
  String get changeLimit => 'Limiti değiştir';

  @override
  String get newCreditLimit => 'Yeni borç limiti';

  @override
  String get limitUpdated => 'Borç limiti güncellendi';

  @override
  String get totalPayablesTitle => 'Tedarikçilere borcunuz';

  @override
  String get netMarketPosition => 'Net durum';

  @override
  String netReceivables(String amount) {
    return 'Net alacak: $amount';
  }

  @override
  String netPayables(String amount) {
    return 'Net borç: $amount';
  }

  @override
  String get netSettled => 'Hesaplar dengede (0 EGP)';

  @override
  String get addNewSupplier => 'Yeni tedarikçi';

  @override
  String get addSupplier => 'Tedarikçi ekle';

  @override
  String get editSupplier => 'Tedarikçiyi düzenle';

  @override
  String get supplierName => 'Tedarikçi / temsilci adı';

  @override
  String get supplierNameHint => 'örn. Ahmet, Ülker temsilcisi';

  @override
  String get supplierNameRequired => 'Tedarikçi adı zorunlu';

  @override
  String get company => 'Şirket / marka';

  @override
  String get companyHint => 'örn. Ülker, Eti';

  @override
  String get visitDay => 'Haftalık ziyaret günü';

  @override
  String get noSpecificDay => 'Belirli gün yok';

  @override
  String get supplierNotes => 'Notlar';

  @override
  String get supplierNotesHint => 'örn. Sabah 10\'da uğrar';

  @override
  String get noSuppliersTitle => 'Tedarikçi defteri boş!';

  @override
  String get noSuppliersSubtitle =>
      'İlk tedarikçinizi eklemek için aşağıdaki düğmeye dokunun';

  @override
  String get noSupplierSearchResults => 'Tedarikçi bulunamadı';

  @override
  String get searchSuppliersHint => 'İsim, şirket veya telefonla ara...';

  @override
  String get supplierDetails => 'Tedarikçi bilgileri';

  @override
  String get iOweHim => 'Borçluyum';

  @override
  String get iPaidHim => 'Ödedim';

  @override
  String get deleteSupplier => 'Tedarikçiyi sil';

  @override
  String get deleteSupplierConfirm => 'Silmeyi onayla';

  @override
  String deleteSupplierWarningDebt(String amount) {
    return 'Dikkat! Bu tedarikçiye hâlâ $amount borcunuz var. Silmek istediğinize emin misiniz?';
  }

  @override
  String deleteSupplierSafeConfirm(String name) {
    return '$name adlı tedarikçiyi silmek istediğinize emin misiniz?';
  }

  @override
  String get supplierDeleted => 'Tedarikçi silindi';

  @override
  String get supplierSaved => 'Tedarikçi kaydedildi';

  @override
  String visitDayPrefix(String day) {
    return 'Ziyaret günü: $day';
  }

  @override
  String get sortCompany => 'Şirket';

  @override
  String get sortVisitDay => 'Ziyaret günü';

  @override
  String get dueCustomersTitle => 'Tahsilatı gelenler';

  @override
  String get totalDueTitle => 'Toplam alacak';

  @override
  String dueCustomersCount(int count) {
    return '$count müşteri';
  }

  @override
  String dueHeaderSummary(int count, String amount) {
    return '$count müşterinin $amount borcu var';
  }

  @override
  String oldestDebtDays(int days) {
    return 'En eski borç $days gün önce';
  }

  @override
  String get oldestDebtToday => 'Borç bugün kaydedildi';

  @override
  String lastReminderDays(int days) {
    return 'Son hatırlatma: $days gün önce';
  }

  @override
  String get lastReminderToday => 'Son hatırlatma: bugün';

  @override
  String get neverReminded => 'Henüz hatırlatılmadı';

  @override
  String snoozedUntilDate(String date) {
    return '$date tarihine ertelendi';
  }

  @override
  String get sendWhatsApp => 'WhatsApp';

  @override
  String get sendSms => 'SMS';

  @override
  String get moreActions => 'Daha fazla';

  @override
  String get snooze3Days => '3 gün ertele';

  @override
  String get snooze7Days => '1 hafta ertele';

  @override
  String get cancelSnooze => 'Ertelemeyi iptal et';

  @override
  String get recordCollectionPayment => 'Ödeme kaydet';

  @override
  String get didSendMessage => 'Mesaj gönderildi mi?';

  @override
  String didSendMessageDesc(String name) {
    return '$name adlı müşteriye WhatsApp ile hatırlatma gönderdiniz mi?';
  }

  @override
  String get yesSent => 'Evet, gönderildi';

  @override
  String get notSent => 'Hayır, gönderilmedi';

  @override
  String get reminderMarkedSent => 'Hatırlatma kaydedildi';

  @override
  String get snoozedSuccess => 'Hatırlatma ertelendi';

  @override
  String get noDueCustomersTitle => 'Bugün tahsilat yok 🎉';

  @override
  String get noDueCustomersSubtitle =>
      'Tüm müşteriler ödedi veya yakın zamanda hatırlatıldı.';

  @override
  String get whatsAppNotInstalled =>
      'WhatsApp yüklü değil. Bunun yerine SMS gönderilsin mi?';

  @override
  String get openSms => 'SMS gönder';

  @override
  String get growthFooter => '\nKashkool uygulamasıyla gönderildi 📒';

  @override
  String get statementTitle => 'Hesap ekstresi';

  @override
  String get generateStatement => 'Ekstre oluştur';

  @override
  String get statementAllTime => 'Tüm işlemler';

  @override
  String get statementThisMonth => 'Bu ay';

  @override
  String get statementCustomRange => 'Özel aralık';

  @override
  String get statementFormatA4 => 'A4 kâğıt';

  @override
  String get statementFormatReceipt => 'Termal fiş (80mm)';

  @override
  String get dateCol => 'Tarih';

  @override
  String get descriptionCol => 'Açıklama';

  @override
  String get debtCol => 'Borç';

  @override
  String get paymentCol => 'Ödeme';

  @override
  String get balanceCol => 'Bakiye';

  @override
  String get startingBalance => 'Açılış bakiyesi';

  @override
  String get finalBalance => 'Kapanış bakiyesi';

  @override
  String periodLabel(String period) {
    return 'Dönem: $period';
  }

  @override
  String statementGeneratedAt(String date) {
    return 'Oluşturulma: $date';
  }

  @override
  String get shareStatement => 'Ekstreyi paylaş';

  @override
  String get printStatement => 'Yazdır';

  @override
  String statementShareSubject(String name) {
    return 'Hesap ekstresi - $name';
  }

  @override
  String get totalDebits => 'Toplam alışveriş / borç';

  @override
  String get totalCredits => 'Toplam ödenen';

  @override
  String get drawerTitle => 'Kasa kapanışı';

  @override
  String get todayDrawer => 'Bugünün kasası';

  @override
  String get expectedInDrawer => 'Kasada olması gereken';

  @override
  String get openingCash => 'Açılış nakdi';

  @override
  String get openingCashHint => 'Güne başladığınız tutar';

  @override
  String get editOpeningCash => 'Açılış nakdini düzenle';

  @override
  String get cashSales => 'Nakit satış';

  @override
  String get addCashSales => 'Nakit satış kaydet';

  @override
  String get cashIn => 'Kasaya giren (nakit)';

  @override
  String get digitalIn => 'Dijital giriş';

  @override
  String get cashOut => 'Kasadan çıkan (nakit)';

  @override
  String get customerPaymentsCash => 'Müşteri tahsilatı (nakit)';

  @override
  String get customerPaymentsDigital => 'Müşteri tahsilatı (dijital)';

  @override
  String get supplierPaymentsCash => 'Tedarikçi ödemeleri (nakit)';

  @override
  String get expensesCash => 'Dükkân giderleri (nakit)';

  @override
  String get addExpense => 'Gider kaydet';

  @override
  String get editExpense => 'Gideri düzenle';

  @override
  String get deleteExpense => 'Gideri sil';

  @override
  String get deleteExpenseConfirm =>
      'Bu gideri silmek istediğinize emin misiniz?';

  @override
  String get expenseCategory => 'Gider kalemi';

  @override
  String get catRent => 'Kira';

  @override
  String get catElectricity => 'Elektrik ve faturalar';

  @override
  String get catSalary => 'Maaş ve yevmiye';

  @override
  String get catSupplies => 'Mal ve malzeme';

  @override
  String get catSupplierPayment => 'Tedarikçi ödemesi';

  @override
  String get catOther => 'Diğer';

  @override
  String get closeDay => 'Günü kapat';

  @override
  String get reopenDay => 'Günü yeniden aç';

  @override
  String get reopenDayConfirm =>
      'Bu günü düzenlemek için yeniden açmak istiyor musunuz?';

  @override
  String get dayClosedSuccess => 'Gün kapatıldı';

  @override
  String get dayReopenedSuccess => 'Gün yeniden açıldı';

  @override
  String get dayIsClosed => 'Gün kapalı';

  @override
  String get dayIsOpen => 'Gün açık';

  @override
  String get actualCountLabel => 'Kasada sayılan tutar';

  @override
  String get actualCountHint => 'Saydığınız tutarı yazın';

  @override
  String get drawerBalanced => 'Kasa tam tuttu 🎉';

  @override
  String get drawerShortage => 'Kasa açığı';

  @override
  String get drawerSurplus => 'Kasa fazlası';

  @override
  String differenceAmount(String amount) {
    return 'Fark: $amount';
  }

  @override
  String get closeDaySummary => 'Gün kapanış özeti';

  @override
  String get confirmCloseDay => 'Kapanışı onayla';

  @override
  String get historyTab => 'Geçmiş';

  @override
  String get todayTab => 'Bugünün kasası';

  @override
  String get monthlyTotals => 'Aylık toplam';

  @override
  String get monthlySales => 'Nakit satış';

  @override
  String get monthlyExpenses => 'Nakit gider';

  @override
  String get monthlyNet => 'Net kasa';

  @override
  String get drawerNotes => 'Kapanış notları (isteğe bağlı)';

  @override
  String get noExpensesYet => 'Bugün gider yok';

  @override
  String get noHistoryYet => 'Önceki gün yok';

  @override
  String get expenseAddedSuccess => 'Gider kaydedildi';

  @override
  String get cashSalesAddedSuccess => 'Nakit satış kaydedildi';

  @override
  String get openingCashUpdatedSuccess => 'Açılış nakdi güncellendi';

  @override
  String get dayDetails => 'Gün detayı';

  @override
  String closedAtTime(String time) {
    return 'Kapanış: $time';
  }

  @override
  String get readOnlyDayNotice =>
      'Bu gün kapalı. Değişiklik için Günü yeniden aç\'a dokunun.';

  @override
  String get privacyModeTitle => 'Gizlilik modu';

  @override
  String get privacyModeSubtitle =>
      'Tutarları ekranda ve widget\'ta gizle (••••••)';

  @override
  String get shareAppTitle => 'Uygulamayı paylaş';

  @override
  String get shareAppSubtitle => 'Kashkool\'u esnaf arkadaşlarınıza gönderin';

  @override
  String shopCodeLabel(String code) {
    return 'Dükkân kodu: $code';
  }

  @override
  String get growthFooterToggleTitle => 'Mesajlardan Kashkool imzasını gizle';

  @override
  String get growthFooterToggleSubtitle => 'Ücretli pakette 🔒';

  @override
  String get codeCopied => 'Kod kopyalandı';

  @override
  String get main1 => 'Kashkool';

  @override
  String get notebookImportButton1 => 'Defterinizi uygulamaya aktarın 📒';

  @override
  String get notebookImportButton2 =>
      'Tüm eski kayıtlar gerekmez: müşterinin adı ve şu anki borcu yeterli.';

  @override
  String get notebookImportButton3 => 'Müşteriler ve bakiyeler';

  @override
  String get notebookImportButton4 =>
      'Her müşteri için bir satır: ad, telefon ve borç';

  @override
  String get notebookImportButton5 => 'Eski taksit';

  @override
  String get notebookImportButton6 =>
      'Fiyat, ödenen, kalan taksitler ve sonraki tarih';

  @override
  String get notebookImportButton7 => 'Defterden aktar';

  @override
  String get oldInstallmentImportScreen1 => 'Sonraki taksit tarihi';

  @override
  String get oldInstallmentImportScreen2 => 'Taksit kaydedildi ✓';

  @override
  String oldInstallmentImportScreen3(
    Object remaining,
    Object countValue,
    Object nextDue,
  ) {
    return '$countValue taksitte $remaining kaldı, ilki $nextDue.';
  }

  @override
  String get oldInstallmentImportScreen4 => 'Bitti';

  @override
  String get oldInstallmentImportScreen5 => 'Bir taksit daha';

  @override
  String get oldInstallmentImportScreen6 =>
      'Kaydedilemedi, hiçbir şey kaydedilmedi';

  @override
  String get oldInstallmentImportScreen7 => ' aylık';

  @override
  String get oldInstallmentImportScreen8 => ' haftalık';

  @override
  String oldInstallmentImportScreen9(
    Object remaining,
    Object count,
    Object count2,
    Object monthly,
  ) {
    return '$remaining kaldı — $count taksit × yaklaşık $count2$monthly';
  }

  @override
  String get oldInstallmentImportScreen10 => 'Defterden eski taksit';

  @override
  String oldInstallmentImportScreen11(Object savedCount) {
    return 'Eski taksit ($savedCount)';
  }

  @override
  String get oldInstallmentImportScreen12 =>
      'Uygulamadan önce başlayan taksitler için: fiyatı, şimdiye kadar ödeneni ve kalan taksit sayısını yazın. Uygulama yalnızca kalan planı oluşturur, eski ödemeleri bugünün kasasına eklemez.';

  @override
  String get oldInstallmentImportScreen13 => 'Müşteri';

  @override
  String get oldInstallmentImportScreen14 => 'Müşteri adı';

  @override
  String get oldInstallmentImportScreen15 =>
      'Mevcut veya yeni müşteri adı yazın';

  @override
  String get oldInstallmentImportScreen16 => 'Müşteri adını yazın';

  @override
  String get oldInstallmentImportScreen17 =>
      'Müşteri telefonu (yeniyse — isteğe bağlı)';

  @override
  String get oldInstallmentImportScreen18 => 'Geçersiz numara';

  @override
  String get oldInstallmentImportScreen19 => 'Taksit';

  @override
  String get oldInstallmentImportScreen20 => 'Ürün';

  @override
  String get oldInstallmentImportScreen21 => 'örn. Arçelik buzdolabı';

  @override
  String get oldInstallmentImportScreen22 => 'Ürünü yazın';

  @override
  String get oldInstallmentImportScreen23 => 'Toplam fiyat';

  @override
  String get oldInstallmentImportScreen24 => 'EGP';

  @override
  String get oldInstallmentImportScreen25 => 'Zorunlu';

  @override
  String get oldInstallmentImportScreen26 => 'Geçersiz';

  @override
  String get oldInstallmentImportScreen27 => 'Şimdiye kadar ödenen';

  @override
  String get oldInstallmentImportScreen28 => 'Fiyattan az olmalı';

  @override
  String get oldInstallmentImportScreen29 => 'Kalan taksit sayısı';

  @override
  String get oldInstallmentImportScreen30 => '1 ile 120 arası';

  @override
  String oldInstallmentImportScreen31(Object nextDue) {
    return 'Sonraki: $nextDue';
  }

  @override
  String get oldInstallmentImportScreen32 => 'Aylık';

  @override
  String get oldInstallmentImportScreen33 => 'Haftalık';

  @override
  String get oldInstallmentImportScreen34 => 'Kefil (isteğe bağlı)';

  @override
  String get oldInstallmentImportScreen35 => 'Kefil adı';

  @override
  String get oldInstallmentImportScreen36 => 'Kefil telefonu';

  @override
  String get oldInstallmentImportScreen37 =>
      'Defter veya sözleşme fotoğrafları (isteğe bağlı — telefonda kalır)';

  @override
  String get oldInstallmentImportScreen38 =>
      'Birden çok fotoğraf ekleyebilirsiniz: defter sayfaları, sözleşme, kefilin kimliği…';

  @override
  String oldInstallmentImportScreen39(Object photosLength) {
    return '$photosLength fotoğraf — müşterinin fotoğraflarına kaydedilecek';
  }

  @override
  String get oldInstallmentImportScreen40 => 'Kaydediliyor…';

  @override
  String get oldInstallmentImportScreen41 => 'Taksiti kaydet';

  @override
  String get notebookImportScreen1 => 'Bakiyelerin tarihi';

  @override
  String notebookImportScreen2(Object firstError, Object error) {
    return 'Satır $firstError: $error';
  }

  @override
  String get notebookImportScreen3 => 'En az bir müşteri adı yazın';

  @override
  String get notebookImportScreen4 => 'Kaydedildi ✓';

  @override
  String notebookImportScreen5(Object newCustomers) {
    return '$newCustomers yeni müşteri';
  }

  @override
  String notebookImportScreen6(Object existingCustomers) {
    return '$existingCustomers mevcut müşteri — bakiyesine eklendi';
  }

  @override
  String notebookImportScreen7(Object totalPiasters) {
    return 'Toplam: $totalPiasters';
  }

  @override
  String get notebookImportScreen8 => 'Sonraki sayfa';

  @override
  String get notebookImportScreen9 => 'Kaydetmeden çıkılsın mı?';

  @override
  String get notebookImportScreen10 =>
      'Bu sayfada yazdıklarınız kaydedilmeyecek.';

  @override
  String get notebookImportScreen11 => 'Devam et';

  @override
  String get notebookImportScreen12 => 'Çık';

  @override
  String get notebookImportScreen13 => 'Defteri aktar 📒';

  @override
  String notebookImportScreen14(Object savedPages) {
    return 'Defteri aktar — sayfa $savedPages';
  }

  @override
  String get notebookImportScreen15 => 'Yeni satır';

  @override
  String notebookImportScreen16(Object validLength) {
    return '$validLength müşteri';
  }

  @override
  String get notebookImportScreen17 => 'Kaydet';

  @override
  String get notebookImportScreen18 =>
      'Her müşteriyi bir satıra yazın: ad, varsa telefon ve borç. Hızlı geçmek için klavyede \"İleri\"ye dokunun.';

  @override
  String get notebookImportScreen19 => 'Bugüne kadar';

  @override
  String notebookImportScreen20(Object asOf) {
    return '$asOf itibarıyla';
  }

  @override
  String get notebookImportScreen21 =>
      'Defter sayfası fotoğrafları (isteğe bağlı): sayfadaki her müşteriye kaydedilir';

  @override
  String notebookImportScreen22(Object pagePhotosLength) {
    return '$pagePhotosLength sayfa fotoğrafı — sayfadaki her müşteriye kaydedilecek';
  }

  @override
  String get notebookImportScreen23 => 'Sayfa';

  @override
  String get notebookImportScreen24 => 'Bu müşterinin fotoğrafları';

  @override
  String get notebookImportScreen25 => 'Satırı kaldır';

  @override
  String get notebookImportScreen26 => 'Telefon (isteğe bağlı)';

  @override
  String get notebookImportScreen27 => 'Tutar';

  @override
  String get notebookImportScreen28 => 'Aranıyor…';

  @override
  String notebookImportScreen29(Object name) {
    return '\"$name\" zaten kayıtlı — tutar bakiyesine eklenecek';
  }

  @override
  String get notebookImportScreen30 => 'Müşteri bu tutarı borçlu';

  @override
  String get notebookImportScreen31 => 'Müşteriye bu tutarı borçlusunuz';

  @override
  String get notebookImportScreen32 => 'Borçlu';

  @override
  String get notebookImportScreen33 => 'Alacaklı';

  @override
  String get notebookImportService1 => 'Defterden önceki bakiye';

  @override
  String get notebookImportService2 => 'Defter sayfası';

  @override
  String get notebookImportService3 => 'İsim eksik';

  @override
  String get notebookImportService4 => 'İsim çok uzun';

  @override
  String get notebookImportService5 => 'Geçersiz tutar';

  @override
  String get notebookImportService6 => 'Ödenen tutar negatif olamaz';

  @override
  String get notebookImportService7 => 'Ödenen tutar toplam fiyattan az olmalı';

  @override
  String get notebookImportService8 => 'En az 1 taksit kalmalı';

  @override
  String notebookImportService9(Object paidPiasters) {
    return 'Defterden aktarıldı — önceden ödenen: $paidPiasters';
  }

  @override
  String notebookImportService10(Object trim, Object totalPricePiasters) {
    return 'Eski taksit: $trim ($totalPricePiasters tutarın kalanı)';
  }

  @override
  String notebookImportService11(Object trim) {
    return 'Taksit: $trim';
  }

  @override
  String get installmentsScreen1 => 'Taksitler 📋';

  @override
  String get installmentsScreen2 => 'Müşteri, ürün, telefon veya kefil ara...';

  @override
  String get installmentsScreen3 => 'Toplam taksit';

  @override
  String get installmentsScreen4 => 'Gecikmiş taksitler';

  @override
  String get installmentsScreen5 => 'Aktif planlar';

  @override
  String get installmentsScreen6 => 'Tümü';

  @override
  String get installmentsScreen7 => 'Aktif ⏳';

  @override
  String get installmentsScreen8 => 'Tamamlanan ✓';

  @override
  String get installmentsScreen9 => 'İptal edilen';

  @override
  String installmentsScreen10(Object e) {
    return 'Taksitler yüklenemedi: $e';
  }

  @override
  String get installmentsScreen11 => 'Eşleşen taksit yok';

  @override
  String get installmentsScreen12 => 'Henüz taksit planı yok';

  @override
  String get installmentsScreen13 =>
      'Bir müşterinin ilk planını oluşturmak için (+ Yeni taksit planı) düğmesine dokunun.';

  @override
  String get installmentsScreen14 => 'Yeni taksit planı';

  @override
  String installmentPlanDetailsScreen1(Object instapay) {
    return 'InstaPay: $instapay';
  }

  @override
  String installmentPlanDetailsScreen2(Object wallet) {
    return 'Cüzdan / Vodafone Cash: $wallet';
  }

  @override
  String installmentPlanDetailsScreen3(Object phoneNum) {
    return 'Telefon: $phoneNum';
  }

  @override
  String get installmentPlanDetailsScreen4 => 'Taksit planını iptal et';

  @override
  String get installmentPlanDetailsScreen5 =>
      'Bu plan iptal edilsin mi? Hatırlatmalar durur, ödeme geçmişi korunur.';

  @override
  String get installmentPlanDetailsScreen6 => 'Geri';

  @override
  String get installmentPlanDetailsScreen7 => 'Planı iptal et';

  @override
  String get installmentPlanDetailsScreen8 => 'Taksit planı iptal edildi';

  @override
  String get installmentPlanDetailsScreen9 => 'Taksit planını sil';

  @override
  String get installmentPlanDetailsScreen10 => 'Bu taksit planı silinsin mi?';

  @override
  String get installmentPlanDetailsScreen11 => 'İptal';

  @override
  String get installmentPlanDetailsScreen12 => 'Sil';

  @override
  String get installmentPlanDetailsScreen13 => 'Taksit planı silindi';

  @override
  String get installmentPlanDetailsScreen14 => 'Taksit detayı';

  @override
  String installmentPlanDetailsScreen15(Object e) {
    return 'Hata: $e';
  }

  @override
  String get installmentPlanDetailsScreen16 =>
      'Taksit planı bulunamadı veya silindi';

  @override
  String get installmentPlanDetailsScreen17 => 'Planı sil';

  @override
  String get installmentPlanDetailsScreen18 => 'Toplam fiyat:';

  @override
  String get installmentPlanDetailsScreen19 => 'Peşinat:';

  @override
  String get installmentPlanDetailsScreen20 => 'Toplam ödenen:';

  @override
  String get installmentPlanDetailsScreen21 => 'Kalan:';

  @override
  String get installmentPlanDetailsScreen22 => 'Erken kapat (tamamı)';

  @override
  String installmentPlanDetailsScreen23(Object guarantorName) {
    return 'Kefil: $guarantorName';
  }

  @override
  String get installmentPlanDetailsScreen24 => 'Sözleşme / senet fotoğrafı';

  @override
  String get installmentPlanDetailsScreen25 =>
      'Belgeyi tam boyut görmek için dokunun';

  @override
  String get installmentPlanDetailsScreen26 => 'Taksit belgesi';

  @override
  String installmentPlanDetailsScreen27(Object installmentsLength) {
    return 'Taksit takvimi ($installmentsLength)';
  }

  @override
  String get installmentPlanDetailsScreen28 => 'Serbest ödeme';

  @override
  String installmentPlanDetailsScreen29(
    Object installmentIndex,
    Object dueDate,
  ) {
    return '$installmentIndex. taksit • $dueDate';
  }

  @override
  String installmentPlanDetailsScreen30(Object paidPiasters) {
    return 'Tamamı ödendi ✓ ($paidPiasters)';
  }

  @override
  String installmentPlanDetailsScreen31(
    Object paidPiasters,
    Object amountPiasters,
  ) {
    return '$amountPiasters tutarın $paidPiasters kadarı ödendi';
  }

  @override
  String get installmentPlanDetailsScreen32 => 'Gecikmiş ⚠️';

  @override
  String get installmentPlanDetailsScreen33 => 'Bugün ödenecek 🔔';

  @override
  String installmentPlanDetailsScreen34(Object amountPiasters) {
    return 'Yaklaşan • $amountPiasters';
  }

  @override
  String get installmentPlanDetailsScreen35 => 'WhatsApp hatırlatma';

  @override
  String get installmentPlanDetailsScreen36 => 'Öde';

  @override
  String get addInstallmentPlanScreen1 => 'Cep telefonu';

  @override
  String get addInstallmentPlanScreen2 => 'Televizyon';

  @override
  String get addInstallmentPlanScreen3 => 'Çamaşır makinesi';

  @override
  String get addInstallmentPlanScreen4 => 'Buzdolabı';

  @override
  String get addInstallmentPlanScreen5 => 'Ocak';

  @override
  String get addInstallmentPlanScreen6 => 'Dizüstü bilgisayar';

  @override
  String get addInstallmentPlanScreen7 => 'Motosiklet';

  @override
  String get addInstallmentPlanScreen8 => 'Mobilya';

  @override
  String get addInstallmentPlanScreen9 => 'Önce müşteri seçin';

  @override
  String get addInstallmentPlanScreen10 => 'Peşinat toplam fiyattan az olmalı';

  @override
  String get addInstallmentPlanScreen11 => 'Taksit planı oluşturuldu ✓';

  @override
  String addInstallmentPlanScreen12(Object e) {
    return 'Bir hata oluştu: $e';
  }

  @override
  String addInstallmentPlanScreen13(Object e) {
    return 'Müşteriler yüklenemedi: $e';
  }

  @override
  String get addInstallmentPlanScreen14 => 'Müşteri seç';

  @override
  String get addInstallmentPlanScreen15 => 'Lütfen müşteri seçin';

  @override
  String get addInstallmentPlanScreen16 => 'Ürün ve tutarlar';

  @override
  String get addInstallmentPlanScreen17 => 'Ürün adı *';

  @override
  String get addInstallmentPlanScreen18 => 'örn. Samsung A15 128GB';

  @override
  String get addInstallmentPlanScreen19 => 'Ürün adı en az 2 karakter olmalı';

  @override
  String get addInstallmentPlanScreen20 => 'Toplam fiyat (EGP) *';

  @override
  String get addInstallmentPlanScreen21 => 'örn. 12000';

  @override
  String get addInstallmentPlanScreen22 => 'Geçersiz tutar';

  @override
  String get addInstallmentPlanScreen23 => 'Peşinat (EGP)';

  @override
  String get addInstallmentPlanScreen24 => 'Taksitlendirilecek tutar:';

  @override
  String get addInstallmentPlanScreen25 => 'Süre ve sıklık';

  @override
  String addInstallmentPlanScreen26(Object count) {
    return '$count taksit';
  }

  @override
  String get addInstallmentPlanScreen27 => 'Taksit sayısı *';

  @override
  String get addInstallmentPlanScreen28 => 'Tam sayı girin';

  @override
  String get addInstallmentPlanScreen29 => 'Sıklık';

  @override
  String get addInstallmentPlanScreen30 => 'İlk taksit tarihi';

  @override
  String get addInstallmentPlanScreen31 => 'Tarihi değiştir';

  @override
  String get addInstallmentPlanScreen32 => 'Kefil ve belgeler (isteğe bağlı)';

  @override
  String get addInstallmentPlanScreen33 => 'örn. Mehmet Yılmaz';

  @override
  String get addInstallmentPlanScreen34 => 'Kefil telefonu';

  @override
  String get addInstallmentPlanScreen35 =>
      'Geçersiz numara (010, 011, 012, 015)';

  @override
  String get addInstallmentPlanScreen36 => 'Belge fotoğrafı çekildi ✓';

  @override
  String get addInstallmentPlanScreen37 =>
      'Sözleşme / senet / kimlik fotoğrafı çek';

  @override
  String get addInstallmentPlanScreen38 => 'Fotoğrafı değiştirmek için dokunun';

  @override
  String get addInstallmentPlanScreen39 => 'Sözleşmenin fotoğrafını saklayın';

  @override
  String get addInstallmentPlanScreen40 => 'Fotoğraf çek';

  @override
  String get addInstallmentPlanScreen41 => 'Ek notlar';

  @override
  String get addInstallmentPlanScreen42 => 'Müşteri hesabına bağla';

  @override
  String get addInstallmentPlanScreen43 =>
      'Toplam fiyatı borç, peşinatı ödeme olarak müşteri hesabına kaydet';

  @override
  String addInstallmentPlanScreen44(Object scheduleLength) {
    return 'Takvim önizleme ($scheduleLength taksit)';
  }

  @override
  String addInstallmentPlanScreen45(Object amountPiasters) {
    return 'Taksit tutarı: ~$amountPiasters';
  }

  @override
  String get addInstallmentPlanScreen46 => 'Planı ve takvimi kaydet';

  @override
  String installmentProgressBar1(
    Object paidCount,
    Object totalCount,
    Object percentInt,
  ) {
    return '$totalCount taksitten $paidCount ödendi (%$percentInt)';
  }

  @override
  String installmentProgressBar2(Object remainingPiasters) {
    return 'Kalan: $remainingPiasters';
  }

  @override
  String get installmentProgressBar3 => 'Tamamı ödendi ✓';

  @override
  String get payInstallmentDialog1 => 'Sıfırdan büyük geçerli bir tutar girin';

  @override
  String payInstallmentDialog2(Object amountPiasters) {
    return '$amountPiasters ödeme kaydedildi ✓';
  }

  @override
  String payInstallmentDialog3(Object e) {
    return 'Ödeme sırasında hata: $e';
  }

  @override
  String payInstallmentDialog4(Object installmentIndex) {
    return '$installmentIndex. taksiti öde';
  }

  @override
  String payInstallmentDialog5(Object itemDescription) {
    return 'Taksit ödemesi ($itemDescription)';
  }

  @override
  String get payInstallmentDialog6 => 'Ödenecek tutar:';

  @override
  String get payInstallmentDialog7 => 'Ödenen tutar (EGP)';

  @override
  String get payInstallmentDialog8 => 'Ödeme yöntemi';

  @override
  String get payInstallmentDialog9 => 'Nakit 💵';

  @override
  String get payInstallmentDialog10 => 'InstaPay ⚡';

  @override
  String get payInstallmentDialog11 => 'Cüzdan 📱';

  @override
  String get payInstallmentDialog12 => 'Ödeme tarihi';

  @override
  String get payInstallmentDialog13 => 'Değiştir';

  @override
  String get payInstallmentDialog14 => 'Not (isteğe bağlı)';

  @override
  String get payInstallmentDialog15 => 'örn. bir arkadaşla gönderdi';

  @override
  String get payInstallmentDialog16 => 'Müşteri hesabına kaydet';

  @override
  String get payInstallmentDialog17 => 'Müşterinin ana bakiyesinden düşülür';

  @override
  String get payInstallmentDialog18 => 'Ödemeyi onayla';

  @override
  String earlySettlementDialog1(Object itemDescription) {
    return '($itemDescription) taksiti kapatıldı ✓';
  }

  @override
  String earlySettlementDialog2(Object e) {
    return 'Kapatma sırasında hata: $e';
  }

  @override
  String get earlySettlementDialog3 => 'Erken kapatma';

  @override
  String get earlySettlementDialog4 => 'Kalan taksit toplamı:';

  @override
  String get earlySettlementDialog5 => 'Tahsil edilecek tutar:';

  @override
  String get earlySettlementDialog6 => 'Erken ödeme indirimi (EGP)';

  @override
  String get earlySettlementDialog7 => 'Şimdi kapat';

  @override
  String installmentPlanCard1(Object overdueCount) {
    return 'Gecikmiş ($overdueCount)';
  }

  @override
  String get installmentPlanCard2 => 'Tamamlandı ✓';

  @override
  String get installmentPlanCard3 => 'İptal';

  @override
  String installmentPlanCard4(Object dueDate, Object paidPiasters) {
    return 'Sonraki taksit: $dueDate ($paidPiasters)';
  }

  @override
  String installmentPlanCard5(Object totalPricePiasters) {
    return 'Toplam: $totalPricePiasters';
  }

  @override
  String get installmentRepository1 =>
      'Ürün açıklaması en az 2 karakter olmalı';

  @override
  String get installmentRepository2 => 'Toplam fiyat sıfırdan büyük olmalı';

  @override
  String get installmentRepository3 => 'Peşinat negatif olamaz';

  @override
  String get installmentRepository4 => 'Peşinat toplam fiyattan az olmalı';

  @override
  String get installmentRepository5 => 'Taksit sayısı sıfırdan büyük olmalı';

  @override
  String installmentRepository6(Object trim, Object installmentCount) {
    return 'Taksit: $trim ($installmentCount taksit)';
  }

  @override
  String installmentRepository7(Object trim) {
    return 'Peşinat: $trim';
  }

  @override
  String get installmentRepository8 => 'Ödeme tutarı sıfırdan büyük olmalı';

  @override
  String installmentRepository9(Object itemDescription, Object notes) {
    return 'Taksit ödemesi: $itemDescription$notes';
  }

  @override
  String get installmentRepository10 => 'Taksit planı bulunamadı';

  @override
  String installmentRepository11(Object itemDescription) {
    return 'Erken kapatma: $itemDescription';
  }

  @override
  String installmentRepository12(Object itemDescription) {
    return 'Erken ödeme indirimi: $itemDescription';
  }

  @override
  String get collectionScreen1 => 'Vadesi gelen taksitler';

  @override
  String get dueInstallmentsTab1 => 'Müşterinin kayıtlı telefonu yok';

  @override
  String get dueInstallmentsTab2 =>
      'Bugün vadesi gelen veya geciken taksit yok 🎉';

  @override
  String get dueInstallmentsTab3 =>
      'Tüm taksit müşterileri ödemelerini zamanında yapıyor.';

  @override
  String dueInstallmentsTab4(Object dueListLength) {
    return 'Tahsil edilecek $dueListLength taksit:';
  }

  @override
  String dueInstallmentsTab5(
    Object itemDescription,
    Object installmentIndex,
    Object installmentCount,
  ) {
    return '$itemDescription • $installmentCount taksitten $installmentIndex.';
  }

  @override
  String dueInstallmentsTab6(Object daysOverdue) {
    return '$daysOverdue gün gecikmiş';
  }

  @override
  String get dueInstallmentsTab7 => 'Bugün ödenecek 🔔';

  @override
  String get dueInstallmentsTab8 => 'Ara';

  @override
  String get dueInstallmentsTab9 => 'WhatsApp';

  @override
  String cashDrawerScreen1(Object err) {
    return 'Kasa yüklenemedi: $err';
  }

  @override
  String drawerLiveCard1(Object notes) {
    return 'Not: $notes';
  }

  @override
  String expensesListCard1(Object expensesLength) {
    return '$expensesLength gider';
  }

  @override
  String get expensesListCard2 => 'InstaPay';

  @override
  String get expensesListCard3 => 'Cüzdan';

  @override
  String get drawerFlowCard1 => '(InstaPay / cüzdan)';

  @override
  String addCashSalesBottomSheet1(Object currentSalesPiasters) {
    return 'Şimdiye kadarki satış: $currentSalesPiasters';
  }

  @override
  String get addCashSalesBottomSheet2 => 'Satışa ekle (+)';

  @override
  String get addCashSalesBottomSheet3 => 'Toplamı düzenle (=)';

  @override
  String get addCashSalesBottomSheet4 => 'Eklenecek tutar';

  @override
  String get addCashSalesBottomSheet5 => 'Yeni satış toplamı';

  @override
  String addCashSalesBottomSheet6(Object val) {
    return '+$val EGP';
  }

  @override
  String drawerHistoryTab1(
    Object cashSalesPiasters,
    Object openingCashPiasters,
  ) {
    return 'Nakit satış: $cashSalesPiasters · Açılış: $openingCashPiasters';
  }

  @override
  String drawerHistoryTab2(Object date) {
    return '$date günü detayı';
  }

  @override
  String get drawerHistoryTab3 => 'Fark';

  @override
  String get customersScreen1 => 'Taksitler';

  @override
  String get customersScreen2 => 'Gizlilik modu';

  @override
  String get customersScreen3 => 'Sırala';

  @override
  String get customerPhotosScreen1 => 'Fotoğraf eklendi';

  @override
  String customerPhotosScreen2(Object pathsLength) {
    return '$pathsLength fotoğraf eklendi';
  }

  @override
  String get customerPhotosScreen3 => 'Fotoğraf kaldırıldı';

  @override
  String get customerPhotosScreen4 => 'Geri getir';

  @override
  String customerPhotosScreen5(Object customerName) {
    return '$customerName fotoğrafları';
  }

  @override
  String get customerPhotosScreen6 => 'Fotoğraf ekle';

  @override
  String get customerPhotosScreen7 => 'Fotoğraflar yüklenemedi';

  @override
  String get customerPhotosScreen8 =>
      'Bu müşterinin henüz fotoğrafı yok.\nDefter sayfalarını veya belgelerini çekin — fotoğraflar yalnızca bu telefonda kalır.';

  @override
  String get customerPhotosScreen9 => 'Fotoğrafı kaldır';

  @override
  String customerDetailsScreen1(
    Object activePlansLength,
    Object remainingPiasters,
  ) {
    return 'Aktif taksitler ($activePlansLength) • Kalan: $remainingPiasters';
  }

  @override
  String get customerDetailsScreen2 => 'Bu müşteriye taksitle sat';

  @override
  String get customerDetailsScreen3 => 'Gör';

  @override
  String get customerDetailsScreen4 => 'Yeni taksit ekle';

  @override
  String get customerDetailsScreen5 => 'Müşteri fotoğrafları';

  @override
  String get photoStrip1 => 'Kamerayla çek';

  @override
  String get photoStrip2 => 'Galeriden seç';

  @override
  String get photoStrip3 => 'Birden çok fotoğraf seçebilirsiniz';

  @override
  String get photoStrip4 => 'Fotoğraf';

  @override
  String get photoStrip5 => 'Daha';

  @override
  String get photoStrip6 => 'Fotoğraf ekle';

  @override
  String get photoStrip7 => 'Fotoğraflar';

  @override
  String photoStrip8(Object title, Object index, Object count) {
    return '$title ($index/$count)';
  }

  @override
  String get photoStrip9 => 'Fotoğraf';

  @override
  String get photoStrip10 => 'Fotoğraf bu telefonda yok';

  @override
  String creditLimitProgressBar1(Object limitPiasters) {
    return 'Borç limiti: $limitPiasters';
  }

  @override
  String ratingExplanationBottomSheet1(Object customerName) {
    return 'Müşteri puanı: $customerName';
  }

  @override
  String get ratingExplanationBottomSheet2 => 'Bu puanın nedeni:';

  @override
  String get ratingExplanationBottomSheet3 => 'Puanlama nasıl çalışır?';

  @override
  String get ratingExplanationBottomSheet4 => 'Mükemmel';

  @override
  String get ratingExplanationBottomSheet5 =>
      'Borcu yok veya en eski borcu en fazla 14 gün.';

  @override
  String get ratingExplanationBottomSheet6 => 'Takip';

  @override
  String get ratingExplanationBottomSheet7 =>
      'En eski borç 15–45 gün arası (hatırlatma önerilir).';

  @override
  String get ratingExplanationBottomSheet8 => 'Gecikmiş';

  @override
  String get ratingExplanationBottomSheet9 =>
      'En eski borç 45 günü geçti veya borç limiti aşıldı.';

  @override
  String get ratingExplanationBottomSheet10 => 'Yeni';

  @override
  String get ratingExplanationBottomSheet11 => '3\'ten az işlemi olan müşteri.';

  @override
  String get ratingExplanationBottomSheet12 => 'Anladım';

  @override
  String get customerWithBalance1 => 'Yeni müşteri';

  @override
  String get settingsScreen1 => 'Dükkân bilgileri 🏪';

  @override
  String get settingsScreen2 => 'Güvenlik ve gizlilik 🔒';

  @override
  String get settingsScreen3 => 'Ana ekran widget\'ı 📱';

  @override
  String get settingsScreen4 => 'Hatırlatma mesajları 💬';

  @override
  String get settingsScreen5 => 'Yedekleme ve veriler 💾';

  @override
  String get settingsScreen6 => 'Uygulamayı paylaş 🚀';

  @override
  String get settingsScreen7 => 'Genel ⚙️';

  @override
  String get settingsScreen8 => 'Kashkool 📒';

  @override
  String get settingsScreen9 =>
      'İnternetsiz çalışan dükkân defteri (Offline-First)\nSürüm 1.0.0';

  @override
  String get settingsScreen10 => 'Genel mağaza';

  @override
  String get settingsScreen11 => 'Bakkal ve market 🛒';

  @override
  String get settingsScreen12 => 'Telefon ve aksesuar 📱';

  @override
  String get settingsScreen13 => 'Elektronik ve beyaz eşya ⚡';

  @override
  String get settingsScreen14 => 'Eczane ve kozmetik 💊';

  @override
  String get settingsScreen15 => 'Diğer işletmeler 🏪';

  @override
  String settingsScreen16(Object tradeName) {
    return '$tradeName • İşletme ve ödeme bilgilerini düzenle';
  }

  @override
  String get settingsScreen17 =>
      'Tutarları ekranda ve widget\'ta gizle (••••••)';

  @override
  String get settingsScreen18 => 'Uygulamayı PIN ile kilitle (4 hane)';

  @override
  String get settingsScreen19 => 'Açık ve korumalı (kapatmak için dokunun)';

  @override
  String get settingsScreen20 => 'Kapalı (ayarlamak için dokunun)';

  @override
  String get settingsScreen21 => 'Açık 🔒';

  @override
  String get settingsScreen22 => 'Ayarla';

  @override
  String get settingsScreen23 => 'Uygulama kilidi kapatıldı';

  @override
  String get settingsScreen24 => 'PIN ayarlandı 🔒';

  @override
  String get settingsScreen25 => 'Parmak izi / Face ID ile aç';

  @override
  String get settingsScreen26 => 'Her seferinde PIN yerine parmak izi kullan';

  @override
  String get settingsScreen27 =>
      'Cihazınız biyometrik doğrulamayı desteklemiyor';

  @override
  String get settingsScreen28 => '1 dakika';

  @override
  String get settingsScreen29 => '5 dakika';

  @override
  String get settingsScreen30 => '15 dakika';

  @override
  String get settingsScreen31 => 'Hemen';

  @override
  String get settingsScreen32 => 'Otomatik kilit süresi';

  @override
  String get settingsScreen33 => 'Uygulamadan çıkınca';

  @override
  String settingsScreen34(Object timeout) {
    return 'Çıktıktan $timeout dakika sonra';
  }

  @override
  String get settingsScreen35 => 'Çıkışta hemen';

  @override
  String get settingsScreen36 => '1 dakika sonra';

  @override
  String get settingsScreen37 => '5 dakika sonra';

  @override
  String get settingsScreen38 => '15 dakika sonra';

  @override
  String get settingsScreen39 => 'Hatırlatma mesajı';

  @override
  String get settingsScreen40 =>
      'Otomatik müşteri mesajını canlı önizlemeyle düzenle';

  @override
  String get settingsScreen41 => 'Hatırlatmaların arka planda kapanmasını önle';

  @override
  String get settingsScreen42 => 'Xiaomi, Realme ve Infinix için pratik rehber';

  @override
  String get settingsScreen43 => 'Henüz yedek alınmadı';

  @override
  String get settingsScreen44 => 'Son yedek';

  @override
  String get settingsScreen45 => 'Yedek dışa aktar (.kashkool)';

  @override
  String get settingsScreen46 =>
      'Defterin ve fotoğrafların kopyasını kaydedip WhatsApp veya Drive ile gönderin';

  @override
  String get settingsScreen47 => 'Yedek dışa aktarıldı 👍';

  @override
  String settingsScreen48(Object e) {
    return 'Dışa aktarma başarısız: $e';
  }

  @override
  String get settingsScreen49 => 'Yedeği geri yükle';

  @override
  String get settingsScreen50 =>
      'Kayıtlı .kashkool dosyasından hesapları ve fotoğrafları geri yükle';

  @override
  String get settingsScreen51 => 'Geçersiz dosya ❌';

  @override
  String get settingsScreen52 => 'Bu dosya geçerli bir Kashkool yedeği değil.';

  @override
  String get settingsScreen53 => 'Tamam';

  @override
  String get settingsScreen54 => 'Geri yüklemeyi onayla';

  @override
  String get settingsScreen55 =>
      'Dikkat: geri yükleme, uygulamadaki tüm mevcut verileri dosyadakilerle değiştirir.';

  @override
  String settingsScreen56(Object exportedAt) {
    return 'Yedek tarihi: $exportedAt';
  }

  @override
  String settingsScreen57(Object photosCount) {
    return 'Fotoğraf sayısı: $photosCount';
  }

  @override
  String settingsScreen58(Object fileSizeBytes) {
    return 'Dosya boyutu: $fileSizeBytes KB';
  }

  @override
  String get settingsScreen59 => 'Evet, değiştir ve geri yükle';

  @override
  String get settingsScreen60 => 'Geri yüklendi 🎉';

  @override
  String get settingsScreen61 =>
      'Tüm hesaplar, işlemler ve fotoğraflar geri yüklendi. Ekranları yenilemek için uygulamayı yeniden başlatın.';

  @override
  String get settingsScreen62 => 'Şimdi yeniden başlat';

  @override
  String settingsScreen63(Object e) {
    return 'Geri yükleme hatası: $e';
  }

  @override
  String get settingsScreen64 => 'Koyu 🌙';

  @override
  String get settingsScreen65 => 'Açık ☀️';

  @override
  String get settingsScreen66 => 'Otomatik';

  @override
  String get settingsScreen67 => 'Görünüm';

  @override
  String get settingsScreen68 => 'Otomatik (telefona göre)';

  @override
  String get settingsScreen69 => 'Belirlenmedi';

  @override
  String get settingsScreen70 => 'Yeni müşteri için varsayılan borç limiti';

  @override
  String get settingsScreen71 => 'WhatsApp\'tan bize ulaşın';

  @override
  String get settingsScreen72 => 'Öneriler ve doğrudan destek';

  @override
  String get settingsScreen73 =>
      'https://wa.me/201000000000?text=Merhaba%2C%20Kashkool%20hakk%C4%B1nda%20bir%20sorum%20var';

  @override
  String get settingsScreen74 => 'Gizlilik politikası ve kullanım koşulları';

  @override
  String get settingsScreen75 =>
      'Verileriniz sizindir ve yalnızca telefonunuzda, internetsiz saklanır';

  @override
  String get settingsScreen76 => 'Kashkool gizlilik politikası 🔒';

  @override
  String get settingsScreen77 =>
      '1. Kashkool tamamen internetsiz çalışır (Offline-First).\n\n2. Tüm hesaplar, isimler, telefon numaraları, fiş fotoğrafları ve işlemler yalnızca cihazınızda saklanır. Hiçbir veri dış sunucuya gönderilmez.\n\n3. Telefon değişir veya kaybolursa verileriniz korunsun diye düzenli yedek almak (Yedek dışa aktar) sizin sorumluluğunuzdadır.\n\n4. Kashkool, esnafın alacaklarını korumak ve borçları güvenle takip etmek için tasarlandı.';

  @override
  String get settingsScreen78 => 'Sistem (otomatik)';

  @override
  String get settingsScreen79 => 'Varsayılan borç limiti (EGP)';

  @override
  String get settingsScreen80 => 'EGP olarak tutar';

  @override
  String get settingsScreen81 => 'Limitsiz için boş bırakın';

  @override
  String get settingsScreen82 => 'Kaydet';

  @override
  String batteryGuideBottomSheet1(Object brandName) {
    return 'Bildirim rehberi ($brandName)';
  }

  @override
  String get batteryGuideBottomSheet2 => 'Hatırlatmaları açık tutma rehberi';

  @override
  String get batteryGuideBottomSheet3 =>
      'Bazı telefonlar (Xiaomi, Realme, Infinix, Huawei gibi) pil tasarrufu için uygulamaları arka planda durdurur. Hatırlatmaların zamanında gelmesi için şu adımları izleyin:';

  @override
  String get batteryGuideBottomSheet4 => 'Pil ayarlarını şimdi aç';

  @override
  String get backupReminderBanner1 => 'Yedek dışa aktarıldı 👍';

  @override
  String backupReminderBanner2(Object e) {
    return 'Yedekleme hatası: $e';
  }

  @override
  String get backupReminderBanner3 => 'Yedek alma zamanı ⚠️';

  @override
  String get backupReminderBanner4 =>
      'Son yedekten bu yana 7 günden fazla geçti. Telefon kaybolur veya değişirse bir şey kaybolmasın diye verilerinizi kaydedin.';

  @override
  String get backupReminderBanner5 => 'Şimdi değil';

  @override
  String get backupReminderBanner6 => 'Kaydediliyor...';

  @override
  String get backupReminderBanner7 => 'Şimdi yedekle';

  @override
  String get homeWidgetSettingsCard1 => 'Bakiyeleri ana ekranda göster';

  @override
  String get homeWidgetSettingsCard2 =>
      'Widget, alacaklarınızı ve bugünkü tahsilatı uygulamayı açmadan gösterir';

  @override
  String get homeWidgetSettingsCard3 => 'Widget kapalı, rakam göstermiyor';

  @override
  String get homeWidgetSettingsCard4 => 'Küçük widget\'ı ekle';

  @override
  String get homeWidgetSettingsCard5 => 'Yalnızca alacaklarınız';

  @override
  String get homeWidgetSettingsCard6 => 'Günlük özet widget\'ını ekle';

  @override
  String get homeWidgetSettingsCard7 =>
      'Alacaklar + bugünkü tahsilat + vadesi gelenler + tahsilat düğmesi';

  @override
  String get homeWidgetSettingsCard8 =>
      'Widget\'ın eklenmesi için çıkan mesajı onaylayın 👍';

  @override
  String get homeWidgetSettingsCard9 => 'Widget\'ı kendiniz ekleyin 📱';

  @override
  String get homeWidgetSettingsCard10 =>
      'Telefonunuz otomatik eklemeye izin vermiyor. Şunu yapın:\n\n1. Ana ekranda boş bir yere uzun basın\n2. \"Widget\'lar\"ı seçin\n3. \"Kashkool\"u bulup widget\'ı ekrana sürükleyin';

  @override
  String get messageTemplateEditorBottomSheet1 => 'Güven Bakkal';

  @override
  String get messageTemplateEditorBottomSheet2 => 'Vodafone Cash: 01012345678';

  @override
  String get messageTemplateEditorBottomSheet3 => 'Mehmet Ahmet';

  @override
  String get messageTemplateEditorBottomSheet4 => 'Mesaj şablonu kaydedildi 👍';

  @override
  String get messageTemplateEditorBottomSheet5 =>
      'Hatırlatma mesajını düzenle 💬';

  @override
  String get messageTemplateEditorBottomSheet6 => 'Hazır şablonlar: ';

  @override
  String get messageTemplateEditorBottomSheet7 => 'Samimi 😊';

  @override
  String get messageTemplateEditorBottomSheet8 => 'Resmî 👔';

  @override
  String get messageTemplateEditorBottomSheet9 => 'Dükkân adı';

  @override
  String get messageTemplateEditorBottomSheet10 => 'Ödeme bilgileri';

  @override
  String get messageTemplateEditorBottomSheet11 => 'Son işlem tarihi';

  @override
  String get messageTemplateEditorBottomSheet12 =>
      'Hatırlatma mesajını buraya yazın...';

  @override
  String get messageTemplateEditorBottomSheet13 =>
      'Müşterinin göreceği önizleme:';

  @override
  String get messageTemplateEditorBottomSheet14 => 'Şablonu kaydet';

  @override
  String shopProfileBottomSheet1(Object trim) {
    return 'Mobil cüzdan: $trim';
  }

  @override
  String get shopProfileBottomSheet2 => 'Dükkân bilgileri kaydedildi 👍';

  @override
  String get shopProfileBottomSheet3 => 'Dükkân adı *';

  @override
  String get shopProfileBottomSheet4 => 'örn. Güven Bakkal';

  @override
  String get shopProfileBottomSheet5 => 'Lütfen dükkân adını girin';

  @override
  String get shopProfileBottomSheet6 => 'Dükkân telefonu';

  @override
  String get shopProfileBottomSheet7 => 'örn. 010xxxxxxxx';

  @override
  String get shopProfileBottomSheet8 => 'Dükkân adresi';

  @override
  String get shopProfileBottomSheet9 =>
      'örn. Çarşı Caddesi, büyük caminin yanı';

  @override
  String get shopProfileBottomSheet10 => 'InstaPay hesabı';

  @override
  String get shopProfileBottomSheet11 => 'örn. name@instapay';

  @override
  String get shopProfileBottomSheet12 =>
      'Vodafone Cash / mobil cüzdan numarası';

  @override
  String get shopProfileBottomSheet13 => 'İşletme türü';

  @override
  String get shopProfileBottomSheet14 => 'Diğer işletme 🏪';

  @override
  String get shopProfileBottomSheet15 => 'Taksit sistemini aç';

  @override
  String get shopProfileBottomSheet16 =>
      'Taksit düğmesini ve ödeme takvimlerini göster';

  @override
  String get shopProfileBottomSheet17 => 'Değişiklikleri kaydet';

  @override
  String get cloudAccountButton1 => 'Hesabınız ve bulut yedekleme ☁️';

  @override
  String get cloudAccountButton2 => 'Bulut yedekleme';

  @override
  String get cloudAccountButton3 => 'Google ile giriş yap';

  @override
  String get cloudBackupCard1 => 'Bir saniye…';

  @override
  String get cloudBackupCard2 => 'Beklenmeyen bir sorun oldu, tekrar deneyin';

  @override
  String get cloudBackupCard3 => 'Google hesapları açılıyor…';

  @override
  String cloudBackupCard4(Object email) {
    return '$email ile giriş yapıldı ✓';
  }

  @override
  String get cloudBackupCard5 => 'Yedek uyarılarla yüklendi ⚠️';

  @override
  String cloudBackupCard6(Object uploaded, Object rejected, Object n) {
    return '$uploaded kayıt yüklendi, $rejected kayıt reddedildi:\n\n$n';
  }

  @override
  String get cloudBackupCard7 => 'Tüm verileriniz zaten bulutta ✓';

  @override
  String cloudBackupCard8(Object uploaded) {
    return '$uploaded kayıt buluta yüklendi ✓';
  }

  @override
  String get cloudBackupCard9 => 'Hesabınızdaki dükkânlar getiriliyor…';

  @override
  String get cloudBackupCard10 => 'Bu hesap için henüz bulut yedeği yok';

  @override
  String get cloudBackupCard11 => 'Dükkânı seçin';

  @override
  String get cloudBackupCard12 => ' (çalışan)';

  @override
  String get cloudBackupCard13 => 'Buluttan geri yüklensin mi?';

  @override
  String cloudBackupCard14(Object name) {
    return '\"$name\" yedeğini buluttan indirip bu telefona ekleyeceğiz.\n\n';
  }

  @override
  String get cloudBackupCard15 =>
      'Hiçbir şey silinmez: yalnızca bu telefonda olan veriler kalır, son yedekten sonra telefonda değişenler olduğu gibi korunur.';

  @override
  String get cloudBackupCard16 => 'Evet, geri yükle';

  @override
  String get cloudBackupCard17 => 'Geri yüklendi 🎉';

  @override
  String cloudBackupCard18(Object keptLocal) {
    return ', $keptLocal kayıt telefondaki daha yeni olduğu için korundu';
  }

  @override
  String cloudBackupCard19(Object records, Object keptLocal) {
    return '$records kayıt geri yüklendi$keptLocal.';
  }

  @override
  String get cloudBackupCard20 =>
      ' Tüm ekranların yenilenmesi için uygulamayı kapatıp açın.';

  @override
  String get cloudBackupCard21 => 'Uygulamayı kapat';

  @override
  String get cloudBackupCard22 => 'Çıkış yapılsın mı?';

  @override
  String get cloudBackupCard23 =>
      'Verileriniz telefonda ve bulutta kalır, ancak tekrar giriş yapana kadar yedekleme durur.';

  @override
  String get cloudBackupCard24 => 'Çıkış yap';

  @override
  String get cloudBackupCard25 => 'Bu sürümde kullanılamıyor';

  @override
  String get cloudBackupCard26 => 'Bulut yedekleme';

  @override
  String get cloudBackupCard27 =>
      'Verileriniz çevrimiçi saklansın diye Google ile giriş yapın. Telefon kaybolursa başka bir telefona geri yükleyin.';

  @override
  String get cloudBackupCard28 => 'Henüz yedek yok';

  @override
  String cloudBackupCard29(Object last) {
    return 'Son yedek: $last';
  }

  @override
  String get cloudBackupCard30 => 'Şimdi yükleniyor…';

  @override
  String get cloudBackupCard31 =>
      'İnternet bekleniyor — gelince otomatik yüklenecek';

  @override
  String get cloudBackupCard32 => 'Yükleme durdu, birazdan tekrar denenecek';

  @override
  String get cloudBackupCard33 => 'Her şey yüklendi ✓';

  @override
  String get cloudBackupCard34 => 'İnternet varken otomatik yüklenir';

  @override
  String get cloudBackupCard35 => 'Şimdi yedekle';

  @override
  String get cloudBackupCard36 => 'Verilerinizi bu telefona geri yükleyin';

  @override
  String get cloudBackupCard37 =>
      'Yeni telefon veya yeniden kurulum için — hiçbir şey silmez';

  @override
  String get cloudBackupCard38 => 'Çıkış yap';

  @override
  String get onboardingScreen1 => 'Dükkânım';

  @override
  String get onboardingScreen2 =>
      'Uygulamayı denemeniz için örnek müşteriler eklendi, istediğiniz zaman silebilirsiniz';

  @override
  String get onboardingScreen3 => 'Kashkool kurulumu';

  @override
  String get onboardingScreen4 => 'Sonraki: işletme türü';

  @override
  String get onboardingScreen5 => 'Kashkool\'a hoş geldiniz! 👋';

  @override
  String get onboardingScreen6 =>
      'Borçlar, WhatsApp hatırlatmaları ve taksitler için basit dijital defteriniz.';

  @override
  String get onboardingScreen7 => 'Dükkân adı *';

  @override
  String get onboardingScreen8 => 'örn. Güven Bakkal / Yıldız GSM';

  @override
  String get onboardingScreen9 => 'Dükkân adını yazın (en az 2 karakter)';

  @override
  String get onboardingScreen10 => 'Dükkân telefonu (isteğe bağlı)';

  @override
  String get onboardingScreen11 =>
      'Fişlerde, ekstrelerde ve WhatsApp mesajlarında görünür';

  @override
  String get onboardingScreen12 => 'Bakkal ve market';

  @override
  String get onboardingScreen13 => 'Günlük borçlar ve hızlı kasa kapanışı';

  @override
  String get onboardingScreen14 => 'Telefon ve aksesuar';

  @override
  String get onboardingScreen15 => 'Cihaz bilgileri, taksit otomatik açılır';

  @override
  String get onboardingScreen16 => 'Elektronik ve beyaz eşya';

  @override
  String get onboardingScreen17 =>
      'Vadeli satış sözleşmeleri, taksit otomatik açılır';

  @override
  String get onboardingScreen18 => 'Eczane ve kozmetik';

  @override
  String get onboardingScreen19 => 'Borç limitleri ve reçete borçları';

  @override
  String get onboardingScreen20 => 'Diğer işletmeler';

  @override
  String get onboardingScreen21 => 'Her tür işletmeye uygun esnek defter';

  @override
  String get onboardingScreen22 => 'İşletmenizin türü nedir?';

  @override
  String get onboardingScreen23 => 'Uygulamayı işinize göre ayarlayacağız.';

  @override
  String get onboardingScreen24 => 'Taksit destekli';

  @override
  String get onboardingScreen25 => 'Taksit planlarını aç';

  @override
  String get onboardingScreen26 =>
      'İstediğiniz zaman Ayarlar\'dan açıp kapatabilirsiniz';

  @override
  String get onboardingScreen27 => 'Hatırlatmaların size ulaşması 🔔';

  @override
  String get onboardingScreen28 =>
      'Kashkool\'un size her gün tahsilat ve taksitleri hatırlatabilmesi için:';

  @override
  String get onboardingScreen29 => 'Bildirim izni';

  @override
  String get onboardingScreen30 => 'Bildirimler açık ✅';

  @override
  String get onboardingScreen31 =>
      'Günlük tahsilat özetini göndermek için bildirim izni gerekiyor';

  @override
  String get onboardingScreen32 => 'Bildirimlere izin ver';

  @override
  String onboardingScreen33(Object brandName) {
    return 'Arka plan koruması ($brandName)';
  }

  @override
  String get onboardingScreen34 => 'Uygulamanın arka planda kapanmasını önle';

  @override
  String get onboardingScreen35 => 'Pil ayarlarını aç';

  @override
  String get onboardingScreen36 => 'Hazırsınız! 🚀';

  @override
  String get onboardingScreen37 =>
      'Dükkân bilgileriniz kaydedildi. Nasıl başlamak istersiniz?';

  @override
  String get onboardingScreen38 => '+ İlk gerçek müşterinizi ekleyin';

  @override
  String get onboardingScreen39 =>
      'Bir müşteri ekleyin ve hemen borç/ödeme kaydetmeye başlayın';

  @override
  String get onboardingScreen40 => 'Önce örnek verilerle deneyin 💡';

  @override
  String get onboardingScreen41 =>
      'Kashkool\'u keşfetmek için iki örnek müşteri ekler (tek dokunuşla silinir)';

  @override
  String get onboardingScreen42 => 'Atla ve ana ekrana git';

  @override
  String get shopRepository1 => 'Ahmet Mehmet (örnek)';

  @override
  String get shopRepository2 => 'Ev alışverişi';

  @override
  String get shopRepository3 => 'Mahmut İbrahim (örnek)';

  @override
  String get shopRepository4 => 'Ay başı malı';

  @override
  String get shopRepository5 => 'Hesaba nakit ödeme';

  @override
  String get supplierWithBalance1 => 'Cumartesi';

  @override
  String get supplierWithBalance2 => 'Pazar';

  @override
  String get supplierWithBalance3 => 'Pazartesi';

  @override
  String get supplierWithBalance4 => 'Salı';

  @override
  String get supplierWithBalance5 => 'Çarşamba';

  @override
  String get supplierWithBalance6 => 'Perşembe';

  @override
  String get supplierWithBalance7 => 'Cuma';

  @override
  String get trashScreen1 => 'Müşteriler';

  @override
  String get trashScreen2 => 'İşlemler';

  @override
  String get trashScreen3 => 'Tedarikçiler';

  @override
  String get trashScreen4 => 'Giderler';

  @override
  String get trashScreen5 => 'Taksitler';

  @override
  String trashScreen6(Object title) {
    return '\"$title\" geri getirildi ✓';
  }

  @override
  String get trashScreen7 => 'Geri getirilemedi, tekrar deneyin';

  @override
  String get trashScreen8 => 'Çöp kutusu 🗑️';

  @override
  String get trashScreen9 =>
      'Sildiğiniz her şey buraya gelir, kaybolmaz. İstediğiniz zaman geri getirebilirsiniz; buluttaki yedekte de geri gelir.';

  @override
  String get trashScreen10 => 'Silinenler yüklenemedi';

  @override
  String get trashScreen11 => 'Çöp kutusu boş ✨';

  @override
  String trashScreen12(Object deletedAt) {
    return 'Silinme: $deletedAt';
  }

  @override
  String get trashScreen13 => 'Geri getir';

  @override
  String get trashScreen14 => 'Çöp kutusu';

  @override
  String get trashScreen15 => 'Silinenleri gör ve geri getir';

  @override
  String trashScreen16(Object count) {
    return '$count öğe — geri getirebilirsiniz';
  }

  @override
  String get trashRepository1 => 'Kira';

  @override
  String get trashRepository2 => 'Elektrik';

  @override
  String get trashRepository3 => 'Maaşlar';

  @override
  String get trashRepository4 => 'Malzemeler';

  @override
  String get trashRepository5 => 'Tedarikçi ödemesi';

  @override
  String get trashRepository6 => 'Gider';

  @override
  String get trashRepository7 => 'Borcum';

  @override
  String get trashRepository8 => 'Ödeme';

  @override
  String get trashRepository9 => 'Ödedim';

  @override
  String get trashRepository10 => 'Bilinmiyor';

  @override
  String trashRepository11(Object itemDescription) {
    return 'Taksit: $itemDescription';
  }

  @override
  String pdfStatementService1(Object sanitizedName, Object dateStr) {
    return 'Ekstre_${sanitizedName}_$dateStr.pdf';
  }

  @override
  String get pdfStatementService2 => 'Müşteri hesap ekstresi';

  @override
  String pdfStatementService3(Object customerName) {
    return 'Müşteri: $customerName';
  }

  @override
  String pdfStatementService4(Object phone) {
    return 'Telefon: $phone';
  }

  @override
  String pdfStatementService5(Object periodDescription) {
    return 'Dönem: $periodDescription';
  }

  @override
  String get pdfStatementService6 => 'Bu dönemden önceki bakiye:';

  @override
  String get pdfStatementService7 => 'Tarih';

  @override
  String get pdfStatementService8 => 'Açıklama';

  @override
  String get pdfStatementService9 => 'Bakiye';

  @override
  String pdfStatementService10(Object periodDebitsPiasters) {
    return 'Toplam alışveriş / borç: $periodDebitsPiasters';
  }

  @override
  String pdfStatementService11(Object periodCreditsPiasters) {
    return 'Toplam ödenen: $periodCreditsPiasters';
  }

  @override
  String get pdfStatementService12 => 'Ödenecek son bakiye:';

  @override
  String pdfStatementService13(Object trim) {
    return 'Ödeme yolları: $trim';
  }

  @override
  String get pdfStatementService14 =>
      'Kashkool ile yapıldı — ücretsiz deneyin:';

  @override
  String get statementCalculator1 => 'Tüm işlemler';

  @override
  String get statementCalculator2 => 'Ocak';

  @override
  String get statementCalculator3 => 'Şubat';

  @override
  String get statementCalculator4 => 'Mart';

  @override
  String get statementCalculator5 => 'Nisan';

  @override
  String get statementCalculator6 => 'Mayıs';

  @override
  String get statementCalculator7 => 'Haziran';

  @override
  String get statementCalculator8 => 'Temmuz';

  @override
  String get statementCalculator9 => 'Ağustos';

  @override
  String get statementCalculator10 => 'Eylül';

  @override
  String get statementCalculator11 => 'Ekim';

  @override
  String get statementCalculator12 => 'Kasım';

  @override
  String get statementCalculator13 => 'Aralık';

  @override
  String statementCalculator14(Object startDate, Object endDate) {
    return '$startDate - $endDate';
  }

  @override
  String statementCalculator15(Object startDate) {
    return '$startDate tarihinden itibaren';
  }

  @override
  String statementCalculator16(Object endDate) {
    return '$endDate tarihine kadar';
  }

  @override
  String growthFooter1(Object shopCode) {
    return '—\nKashkool ile yapıldı 📒 Ücretsiz deneyin: $shopCode';
  }

  @override
  String growthFooter2(Object shopCode) {
    return 'Müşteri, tedarikçi ve kasa hesaplarını kâğıt defter olmadan Kashkool 📒 ile tutuyorum.\nÇok kolay ve internetsiz çalışıyor. Ücretsiz deneyin:\n$shopCode';
  }

  @override
  String get notificationService1 => 'Günlük tahsilat';

  @override
  String get notificationService2 =>
      'Ödemesi gelen müşteriler için hatırlatmalar';

  @override
  String notificationService3(Object dueCount, Object amountStr) {
    return '$dueCount müşterinin $amountStr borcu var — tahsil için dokunun';
  }

  @override
  String get notificationService4 => 'Günlük tahsilat hatırlatması 📒';

  @override
  String get backupService1 => 'Veritabanı dosyası bulunamadı';

  @override
  String backupService2(Object dateStr) {
    return 'Kashkool yedeği - $dateStr';
  }

  @override
  String get backupService3 => 'Seçilen dosya yok';

  @override
  String get backupService4 => 'Dosya bozuk veya eksik';

  @override
  String get backupService5 => 'Yanlış dosya biçimi (Kashkool dosyası değil)';

  @override
  String get backupService6 => 'Dosyada Kashkool veritabanı yok';

  @override
  String get backupService7 => 'Dosyadaki veritabanı bozuk';

  @override
  String get backupService8 => 'Geçerli bir SQLite veritabanı değil';

  @override
  String get backupService9 => 'Geçersiz yedek dosyası';

  @override
  String get backupService10 => 'Arşivde veritabanı dosyası yok';

  @override
  String get googleAuthService1 => 'Bulut yedekleme bu sürümde ayarlı değil';

  @override
  String get googleAuthService2 =>
      'Google giriş bilgisi döndürmedi, tekrar deneyin';

  @override
  String get googleAuthService3 => 'Giriş iptal edildi';

  @override
  String googleAuthService4(Object codeName) {
    return 'Google ile giriş yapılamadı ($codeName)';
  }

  @override
  String get cloudApi1 => 'Sunucu adresi bu sürümde ayarlı değil';

  @override
  String get cloudApi2 => 'Önce Google ile giriş yapın';

  @override
  String get cloudApi3 => 'İnternet bağlantısı yok, tekrar deneyin';

  @override
  String get cloudApi4 => 'Sunucu geç yanıt verdi, tekrar deneyin';

  @override
  String get cloudApi5 => 'Oturum süresi doldu, Google ile tekrar giriş yapın';

  @override
  String get cloudApi6 => 'Bu dükkân başka bir Google hesabına kayıtlı';

  @override
  String get cloudApi7 => 'Bu özellik abonelik gerektirir';

  @override
  String get cloudApi8 => 'Çok fazla deneme, biraz bekleyip tekrar deneyin';

  @override
  String get cloudApi9 => 'Google ile tekrar giriş yapın';

  @override
  String get cloudApi10 => 'Google girişi sunucuda ayarlı değil';

  @override
  String get cloudApi11 => 'Sunucu sorunu, biraz sonra deneyin';

  @override
  String cloudApi12(Object code) {
    return 'Bir sorun oluştu ($code)';
  }

  @override
  String get cloudBackupService1 => 'Google girişi kullanılamıyor';

  @override
  String get cloudBackupService2 =>
      'Önce Ayarlar\'dan dükkân bilgilerini tamamlayın';

  @override
  String get cloudBackupService3 => 'Dükkân verileri hazırlanıyor…';

  @override
  String cloudBackupService4(Object length, Object changesLength) {
    return '$changesLength kaydın $length kadarı yükleniyor…';
  }

  @override
  String get cloudBackupService5 => 'Tamamlandı ✓';

  @override
  String cloudBackupService6(Object changesLength) {
    return 'Veriler indiriliyor… ($changesLength)';
  }

  @override
  String cloudBackupService7(Object changesLength) {
    return '$changesLength kayıt telefona kaydediliyor…';
  }

  @override
  String get cloudBackupService8 => 'Dükkân';

  @override
  String autoBackupCoordinator1(Object rejected) {
    return '$rejected kayıt yüklenemedi';
  }

  @override
  String get autoBackupCoordinator2 =>
      'Bir sorun oldu, birazdan tekrar denenecek';

  @override
  String get customerRating1 => 'Yeni müşteri (3\'ten az işlem)';

  @override
  String get customerRating2 => 'Borcu yok, zamanında ödüyor';

  @override
  String customerRating3(Object oldestUnpaidAgeDays) {
    return 'Gecikmiş: en eski borç $oldestUnpaidAgeDays günlük ve limit aşıldı';
  }

  @override
  String get customerRating4 => 'Müşterinin borç limiti aşıldı';

  @override
  String get customerRating5 => 'Yalnızca bugün borç aldı, hesabı düzenli';

  @override
  String customerRating6(Object oldestUnpaidAgeDays) {
    return 'En eski borç yalnızca $oldestUnpaidAgeDays günlük (güvenli aralık)';
  }

  @override
  String customerRating7(Object oldestUnpaidAgeDays) {
    return 'En eski borç $oldestUnpaidAgeDays günlük (45 günden fazla gecikme)';
  }

  @override
  String customerRating8(Object oldestUnpaidAgeDays) {
    return 'En eski borç $oldestUnpaidAgeDays günlük (takip gerekli)';
  }

  @override
  String get whatsappTemplate1 =>
      'Merhaba {customer_name} 👋\nBen {shop_name}.\nGüncel bakiyeniz: {balance}\nSon işlem: {last_transaction_date} - {last_transaction_amount}\nÖdeme için: {payment_info}\nBizi tercih ettiğiniz için teşekkürler 🙏';

  @override
  String get whatsappTemplate2 =>
      'Sayın {customer_name},\n{shop_name} nezdindeki güncel bakiyenizin {balance} olduğunu hatırlatırız.\nSon kayıtlı işlem: {last_transaction_date} ({last_transaction_amount})\nÖdeme seçenekleri: {payment_info}\nSaygılarımızla.';

  @override
  String get whatsappTemplate3 =>
      'Merhaba {customer_name} 👋\nBen {shop_name}.\n({item}) için taksit tarihiniz yaklaştı — {installment_count} taksitten {installment_number}.:\nÖdenecek tutar: {amount}\nVade tarihi: {due_date}\nKalan toplam: {remaining_total}\nÖdeme seçenekleri: {payment_info}\nDüzenli ödemeniz için teşekkürler 🙏';

  @override
  String get whatsappTemplate4 => 'Dükkânda nakit veya havale';

  @override
  String get money1 => 'EGP';

  @override
  String get batteryOptimizationHelper1 => 'XOS / HiOS';

  @override
  String get batteryOptimizationHelper2 => 'Phone Master uygulamasını açın.';

  @override
  String get batteryOptimizationHelper3 =>
      '\"Otomatik başlatma\" bölümüne girip Kashkool\'u açın.';

  @override
  String get batteryOptimizationHelper4 =>
      'Uygulama ayarlarında \"Pil\"e girip \"Kısıtlamasız\"ı seçin.';

  @override
  String get batteryOptimizationHelper5 =>
      'Son uygulamalarda uygulamayı aşağı çekerek kilitleyin 🔒.';

  @override
  String get batteryOptimizationHelper6 => 'MIUI / HyperOS';

  @override
  String get batteryOptimizationHelper7 =>
      'Uygulama ayarlarını açıp \"Otomatik başlat\"ı etkinleştirin.';

  @override
  String get batteryOptimizationHelper8 =>
      '\"Pil tasarrufu\"nda \"Kısıtlama yok\"u seçin.';

  @override
  String get batteryOptimizationHelper9 =>
      'Son uygulamalarda Kashkool\'a uzun basıp kilit simgesine dokunun 🔒.';

  @override
  String get batteryOptimizationHelper10 => 'ColorOS / Realme UI';

  @override
  String get batteryOptimizationHelper11 =>
      'Uygulama ayarları -> Pil kullanımı, \"Arka plan etkinliğine izin ver\"i açın.';

  @override
  String get batteryOptimizationHelper12 => '\"Otomatik başlatma\"yı açın.';

  @override
  String get batteryOptimizationHelper13 =>
      'Son uygulamalarda üç noktaya dokunup \"Kilitle\"yi seçin.';

  @override
  String get batteryOptimizationHelper14 => 'One UI';

  @override
  String get batteryOptimizationHelper15 =>
      'Ayarlar -> Cihaz bakımı -> Pil\'e gidin.';

  @override
  String get batteryOptimizationHelper16 =>
      '\"Arka plan kullanım sınırları\"nı açın.';

  @override
  String get batteryOptimizationHelper17 =>
      'Kashkool\'u \"Hiç uyumayan uygulamalar\"a ekleyin.';

  @override
  String get batteryOptimizationHelper18 => 'EMUI / MagicOS';

  @override
  String get batteryOptimizationHelper19 =>
      'Ayarlar -> Pil -> Uygulama başlatma\'ya gidin.';

  @override
  String get batteryOptimizationHelper20 =>
      '\"Kashkool\"u bulun, manuele alın ve Otomatik başlatma + Arka planda çalışma\'yı açın.';

  @override
  String get batteryOptimizationHelper21 => 'Sistem ayarları';

  @override
  String get batteryOptimizationHelper22 => 'Sistem bildirimlerini koru';

  @override
  String get batteryOptimizationHelper23 =>
      'Telefon ayarlarında uygulama bilgisini açın.';

  @override
  String get batteryOptimizationHelper24 =>
      '\"Pil\"i açıp \"Kısıtlamasız\"ı seçin.';

  @override
  String get batteryOptimizationHelper25 =>
      'Hatırlatmaların gelmesi için ultra güç tasarrufu modunun kapalı olduğundan emin olun.';

  @override
  String get homeWidgetService1 => 'Yok';

  @override
  String get homeWidgetService2 => '1 müşteri';

  @override
  String get homeWidgetService3 => '2 müşteri';

  @override
  String homeWidgetService4(Object count) {
    return '$count müşteri';
  }

  @override
  String get pinLockScreen1 => 'Yanlış PIN, tekrar deneyin';

  @override
  String get pinLockScreen2 => 'PIN\'ler eşleşmiyor, tekrar deneyin';

  @override
  String get pinLockScreen3 => 'Parmak izi yok veya cihazda ayarlı değil';

  @override
  String get pinLockScreen4 => 'Kashkool\'a hoş geldiniz 📒';

  @override
  String get pinLockScreen5 => 'Yeni PIN belirle';

  @override
  String get pinLockScreen6 => 'Onaylamak için PIN\'i tekrar girin';

  @override
  String get pinLockScreen7 => '4 haneli PIN\'inizi girin';

  @override
  String get pinLockScreen8 =>
      'Uygulamayı kilitlemek için hatırlayacağınız 4 rakam yazın';

  @override
  String get pinLockScreen9 => 'Aynı rakamları tekrar yazın';

  @override
  String get pinLockScreen10 => 'Parmak izi';

  @override
  String get pinLockScreen11 => 'Sil';

  @override
  String get securityService1 =>
      'Kashkool\'u açmak için kimliğinizi doğrulayın';

  @override
  String get settingsLanguageTitle => 'Dil';

  @override
  String get settingsLanguageSystem => 'Telefon dili (otomatik)';

  @override
  String get cloudDeleteAccountTitle => 'Bulut hesabımı sil';

  @override
  String get cloudDeleteAccountSubtitle =>
      'Bulut yedeklerinizi ve hesabınızı kalıcı olarak siler — telefondaki veriler kalır';

  @override
  String get cloudDeleteAccountConfirmTitle =>
      'Hesabınız kalıcı olarak silinsin mi?';

  @override
  String get cloudDeleteAccountConfirmBody =>
      'Hesabınızı ve sahibi olduğunuz dükkânların tüm bulut yedeklerini sileceğiz. Bu geri alınamaz. Bu telefondaki veriler olduğu gibi kalır.';

  @override
  String get cloudDeleteAccountConfirmButton => 'Kalıcı olarak sil';

  @override
  String get cloudDeleteAccountDone => 'Bulut hesabınız silindi';

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
