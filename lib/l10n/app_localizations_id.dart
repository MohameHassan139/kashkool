// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Kashkool';

  @override
  String get navCustomers => 'Pelanggan';

  @override
  String get navCollection => 'Penagihan';

  @override
  String get navSuppliers => 'Pemasok';

  @override
  String get navCashDrawer => 'Laci Kas';

  @override
  String get navSettings => 'Pengaturan';

  @override
  String get debt => 'Utang';

  @override
  String get payment => 'Pembayaran';

  @override
  String get settled => 'Lunas';

  @override
  String get currency => 'EGP';

  @override
  String get piaster => 'Pt';

  @override
  String get save => 'Simpan';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get search => 'Cari...';

  @override
  String placeholderScreen(String screenName) {
    return 'Layar $screenName';
  }

  @override
  String get comingSoon => 'Segera hadir';

  @override
  String get totalReceivablesTitle => 'Piutang Anda';

  @override
  String get searchCustomersHint => 'Cari nama atau telepon...';

  @override
  String get filterAll => 'Semua';

  @override
  String get filterHasDebt => 'Berutang';

  @override
  String get filterSettled => 'Lunas';

  @override
  String get filterLate => 'Terlambat';

  @override
  String get sortHighestDebt => 'Utang tertinggi';

  @override
  String get sortName => 'Nama';

  @override
  String get sortLastActivity => 'Aktivitas terakhir';

  @override
  String get addNewCustomer => 'Pelanggan baru';

  @override
  String get addCustomer => 'Tambah pelanggan';

  @override
  String get editCustomer => 'Ubah pelanggan';

  @override
  String get customerName => 'Nama pelanggan';

  @override
  String get customerNameHint => 'mis. Pak Budi warung';

  @override
  String get customerNameRequired => 'Nama pelanggan wajib diisi';

  @override
  String get customerNameTooShort => 'Nama minimal 2 karakter';

  @override
  String get customerPhone => 'Nomor HP';

  @override
  String get customerPhoneHint => '+2010xxxxxxxx';

  @override
  String get customerPhoneInvalid => 'Masukkan nomor telepon yang valid';

  @override
  String get customerNotes => 'Catatan';

  @override
  String get customerNotesHint => 'mis. tetangga lantai 2';

  @override
  String get creditLimit => 'Batas utang (opsional)';

  @override
  String get creditLimitHint => 'mis. 1000';

  @override
  String get noCustomersTitle => 'Buku Anda masih kosong!';

  @override
  String get noCustomersSubtitle =>
      'Ketuk tombol di bawah untuk menambah pelanggan pertama dan mulai mencatat dengan mudah';

  @override
  String get noSearchResults => 'Pelanggan tidak ditemukan';

  @override
  String get duplicateCustomerWarning =>
      'Peringatan: pelanggan dengan nama atau nomor yang sama sudah ada';

  @override
  String get customerDetails => 'Detail pelanggan';

  @override
  String get callCustomer => 'Telepon';

  @override
  String get deleteCustomer => 'Hapus pelanggan';

  @override
  String get deleteCustomerConfirm => 'Konfirmasi hapus pelanggan';

  @override
  String deleteCustomerWarningDebt(String amount) {
    return 'Perhatian! Pelanggan ini masih berutang $amount. Yakin ingin menghapus?';
  }

  @override
  String deleteCustomerSafeConfirm(String name) {
    return 'Yakin ingin menghapus pelanggan $name?';
  }

  @override
  String get customerDeleted => 'Pelanggan dihapus';

  @override
  String get customerSaved => 'Pelanggan disimpan';

  @override
  String get lastActivityNever => 'Belum ada transaksi';

  @override
  String lastActivityDate(String date) {
    return 'Transaksi terakhir: $date';
  }

  @override
  String creditLimitLabel(String amount) {
    return 'Batas utang: $amount';
  }

  @override
  String get creditLimitExceeded => 'Batas utang terlampaui!';

  @override
  String get heOwes => 'Berutang';

  @override
  String get hePaid => 'Saldo lebih (bayar lebih)';

  @override
  String get currentBalance => 'Saldo saat ini';

  @override
  String get noTransactionsYet => 'Belum ada transaksi';

  @override
  String get addDebtTitle => 'Catat utang';

  @override
  String get addPaymentTitle => 'Catat pembayaran';

  @override
  String get amountLabel => 'Jumlah';

  @override
  String get amountRequired => 'Masukkan jumlah yang valid lebih dari 0';

  @override
  String get today => 'Hari ini';

  @override
  String get yesterday => 'Kemarin';

  @override
  String get date => 'Tanggal';

  @override
  String get pickDate => 'Pilih tanggal';

  @override
  String get paymentMethod => 'Metode pembayaran';

  @override
  String get methodCash => 'Tunai';

  @override
  String get methodInstapay => 'InstaPay';

  @override
  String get methodWallet => 'Dompet digital';

  @override
  String get methodOther => 'Lainnya';

  @override
  String get noteOptional => 'Catatan (opsional: gula, minyak, pulsa...)';

  @override
  String get voiceDictation => 'Dikte suara';

  @override
  String get listening => 'Mendengarkan... Silakan bicara';

  @override
  String get speechNotAvailable =>
      'Dikte suara tidak tersedia di perangkat ini';

  @override
  String get attachPhoto => 'Lampirkan foto';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galeri';

  @override
  String get removePhoto => 'Hapus foto';

  @override
  String get overpaymentTitle => 'Jumlah melebihi utang!';

  @override
  String overpaymentMessage(
    String paidAmount,
    String dueAmount,
    String creditAmount,
  ) {
    return 'Jumlah dibayar ($paidAmount) melebihi utang ($dueAmount). Catat selisih ($creditAmount) sebagai saldo pelanggan?';
  }

  @override
  String get overpaymentConfirm => 'Ya, catat saldo';

  @override
  String get transactionSaved => 'Transaksi dicatat';

  @override
  String get undo => 'Urungkan';

  @override
  String get transactionUndone => 'Transaksi dibatalkan';

  @override
  String get transactionDetails => 'Detail transaksi';

  @override
  String get editTransaction => 'Ubah transaksi';

  @override
  String get deleteTransaction => 'Hapus transaksi';

  @override
  String get deleteTransactionConfirm => 'Yakin ingin menghapus transaksi ini?';

  @override
  String get transactionDeleted => 'Transaksi dihapus';

  @override
  String get viewPhoto => 'Lihat foto';

  @override
  String get creditLimitWarningTitle => 'Peringatan batas utang';

  @override
  String creditLimitExceededDialog(
    String customerName,
    String newTotal,
    String limit,
  ) {
    return 'Utang $customerName akan menjadi $newTotal, padahal batasnya $limit';
  }

  @override
  String get saveAnyway => 'Tetap simpan';

  @override
  String get changeLimit => 'Ubah batas';

  @override
  String get newCreditLimit => 'Batas utang baru';

  @override
  String get limitUpdated => 'Batas utang diperbarui';

  @override
  String get totalPayablesTitle => 'Utang Anda ke pemasok';

  @override
  String get netMarketPosition => 'Posisi bersih';

  @override
  String netReceivables(String amount) {
    return 'Piutang bersih: $amount';
  }

  @override
  String netPayables(String amount) {
    return 'Utang bersih: $amount';
  }

  @override
  String get netSettled => 'Seimbang (0 EGP)';

  @override
  String get addNewSupplier => 'Pemasok baru';

  @override
  String get addSupplier => 'Tambah pemasok';

  @override
  String get editSupplier => 'Ubah pemasok';

  @override
  String get supplierName => 'Nama pemasok / sales';

  @override
  String get supplierNameHint => 'mis. Budi, sales Indomie';

  @override
  String get supplierNameRequired => 'Nama pemasok wajib diisi';

  @override
  String get company => 'Perusahaan / merek';

  @override
  String get companyHint => 'mis. Indofood, Wings';

  @override
  String get visitDay => 'Hari kunjungan mingguan';

  @override
  String get noSpecificDay => 'Tidak ada hari tetap';

  @override
  String get supplierNotes => 'Catatan';

  @override
  String get supplierNotesHint => 'mis. datang sekitar jam 10 pagi';

  @override
  String get noSuppliersTitle => 'Buku pemasok kosong!';

  @override
  String get noSuppliersSubtitle =>
      'Ketuk tombol di bawah untuk menambah pemasok pertama';

  @override
  String get noSupplierSearchResults => 'Pemasok tidak ditemukan';

  @override
  String get searchSuppliersHint => 'Cari nama, perusahaan, atau nomor...';

  @override
  String get supplierDetails => 'Detail pemasok';

  @override
  String get iOweHim => 'Saya berutang';

  @override
  String get iPaidHim => 'Saya bayar';

  @override
  String get deleteSupplier => 'Hapus pemasok';

  @override
  String get deleteSupplierConfirm => 'Konfirmasi hapus pemasok';

  @override
  String deleteSupplierWarningDebt(String amount) {
    return 'Perhatian! Anda masih berutang $amount ke pemasok ini. Yakin ingin menghapus?';
  }

  @override
  String deleteSupplierSafeConfirm(String name) {
    return 'Yakin ingin menghapus pemasok $name?';
  }

  @override
  String get supplierDeleted => 'Pemasok dihapus';

  @override
  String get supplierSaved => 'Pemasok disimpan';

  @override
  String visitDayPrefix(String day) {
    return 'Hari kunjungan: $day';
  }

  @override
  String get sortCompany => 'Perusahaan';

  @override
  String get sortVisitDay => 'Hari kunjungan';

  @override
  String get dueCustomersTitle => 'Pelanggan jatuh tempo';

  @override
  String get totalDueTitle => 'Total jatuh tempo';

  @override
  String dueCustomersCount(int count) {
    return '$count pelanggan';
  }

  @override
  String dueHeaderSummary(int count, String amount) {
    return '$count pelanggan berutang $amount';
  }

  @override
  String oldestDebtDays(int days) {
    return 'Utang terlama $days hari lalu';
  }

  @override
  String get oldestDebtToday => 'Utang dicatat hari ini';

  @override
  String lastReminderDays(int days) {
    return 'Pengingat terakhir: $days hari lalu';
  }

  @override
  String get lastReminderToday => 'Pengingat terakhir: hari ini';

  @override
  String get neverReminded => 'Belum pernah diingatkan';

  @override
  String snoozedUntilDate(String date) {
    return 'Ditunda sampai $date';
  }

  @override
  String get sendWhatsApp => 'WhatsApp';

  @override
  String get sendSms => 'SMS';

  @override
  String get moreActions => 'Lainnya';

  @override
  String get snooze3Days => 'Tunda 3 hari';

  @override
  String get snooze7Days => 'Tunda 1 minggu';

  @override
  String get cancelSnooze => 'Batalkan penundaan';

  @override
  String get recordCollectionPayment => 'Catat pembayaran';

  @override
  String get didSendMessage => 'Pesan sudah terkirim?';

  @override
  String didSendMessageDesc(String name) {
    return 'Apakah pengingat ke $name sudah dikirim via WhatsApp?';
  }

  @override
  String get yesSent => 'Ya, terkirim';

  @override
  String get notSent => 'Tidak, belum';

  @override
  String get reminderMarkedSent => 'Pengingat dicatat';

  @override
  String get snoozedSuccess => 'Pengingat ditunda';

  @override
  String get noDueCustomersTitle => 'Tidak ada tagihan hari ini 🎉';

  @override
  String get noDueCustomersSubtitle =>
      'Semua pelanggan lunas atau baru saja diingatkan.';

  @override
  String get whatsAppNotInstalled =>
      'WhatsApp tidak terpasang. Kirim SMS saja?';

  @override
  String get openSms => 'Kirim SMS';

  @override
  String get growthFooter => '\nDikirim lewat aplikasi Kashkool 📒';

  @override
  String get statementTitle => 'Laporan rekening';

  @override
  String get generateStatement => 'Buat laporan';

  @override
  String get statementAllTime => 'Semua transaksi';

  @override
  String get statementThisMonth => 'Bulan ini';

  @override
  String get statementCustomRange => 'Rentang khusus';

  @override
  String get statementFormatA4 => 'Kertas A4';

  @override
  String get statementFormatReceipt => 'Struk termal (80mm)';

  @override
  String get dateCol => 'Tanggal';

  @override
  String get descriptionCol => 'Keterangan';

  @override
  String get debtCol => 'Utang';

  @override
  String get paymentCol => 'Bayar';

  @override
  String get balanceCol => 'Saldo';

  @override
  String get startingBalance => 'Saldo awal';

  @override
  String get finalBalance => 'Saldo akhir';

  @override
  String periodLabel(String period) {
    return 'Periode: $period';
  }

  @override
  String statementGeneratedAt(String date) {
    return 'Dibuat: $date';
  }

  @override
  String get shareStatement => 'Bagikan laporan';

  @override
  String get printStatement => 'Cetak';

  @override
  String statementShareSubject(String name) {
    return 'Laporan rekening - $name';
  }

  @override
  String get totalDebits => 'Total belanja / utang';

  @override
  String get totalCredits => 'Total dibayar';

  @override
  String get drawerTitle => 'Tutup laci kas';

  @override
  String get todayDrawer => 'Laci kas hari ini';

  @override
  String get expectedInDrawer => 'Seharusnya di laci';

  @override
  String get openingCash => 'Kas awal';

  @override
  String get openingCashHint => 'Uang di laci saat buka';

  @override
  String get editOpeningCash => 'Ubah kas awal';

  @override
  String get cashSales => 'Penjualan tunai';

  @override
  String get addCashSales => 'Catat penjualan tunai';

  @override
  String get cashIn => 'Kas masuk (tunai)';

  @override
  String get digitalIn => 'Masuk digital';

  @override
  String get cashOut => 'Kas keluar (tunai)';

  @override
  String get customerPaymentsCash => 'Bayaran pelanggan (tunai)';

  @override
  String get customerPaymentsDigital => 'Bayaran pelanggan (digital)';

  @override
  String get supplierPaymentsCash => 'Bayar pemasok (tunai)';

  @override
  String get expensesCash => 'Biaya toko (tunai)';

  @override
  String get addExpense => 'Catat pengeluaran';

  @override
  String get editExpense => 'Ubah pengeluaran';

  @override
  String get deleteExpense => 'Hapus pengeluaran';

  @override
  String get deleteExpenseConfirm => 'Yakin ingin menghapus pengeluaran ini?';

  @override
  String get expenseCategory => 'Kategori';

  @override
  String get catRent => 'Sewa';

  @override
  String get catElectricity => 'Listrik & utilitas';

  @override
  String get catSalary => 'Gaji & upah';

  @override
  String get catSupplies => 'Barang & perlengkapan';

  @override
  String get catSupplierPayment => 'Bayar pemasok';

  @override
  String get catOther => 'Lainnya';

  @override
  String get closeDay => 'Tutup hari';

  @override
  String get reopenDay => 'Buka kembali hari';

  @override
  String get reopenDayConfirm => 'Buka kembali hari ini untuk diubah?';

  @override
  String get dayClosedSuccess => 'Hari ditutup';

  @override
  String get dayReopenedSuccess => 'Hari dibuka kembali';

  @override
  String get dayIsClosed => 'Hari sudah ditutup';

  @override
  String get dayIsOpen => 'Hari masih buka';

  @override
  String get actualCountLabel => 'Uang tunai terhitung';

  @override
  String get actualCountHint => 'Tulis jumlah yang Anda hitung';

  @override
  String get drawerBalanced => 'Laci kas pas 🎉';

  @override
  String get drawerShortage => 'Kas kurang';

  @override
  String get drawerSurplus => 'Kas lebih';

  @override
  String differenceAmount(String amount) {
    return 'Selisih: $amount';
  }

  @override
  String get closeDaySummary => 'Ringkasan tutup hari';

  @override
  String get confirmCloseDay => 'Konfirmasi tutup';

  @override
  String get historyTab => 'Riwayat';

  @override
  String get todayTab => 'Laci hari ini';

  @override
  String get monthlyTotals => 'Total bulan ini';

  @override
  String get monthlySales => 'Penjualan tunai';

  @override
  String get monthlyExpenses => 'Pengeluaran tunai';

  @override
  String get monthlyNet => 'Kas bersih';

  @override
  String get drawerNotes => 'Catatan penutupan (opsional)';

  @override
  String get noExpensesYet => 'Belum ada pengeluaran hari ini';

  @override
  String get noHistoryYet => 'Belum ada hari sebelumnya';

  @override
  String get expenseAddedSuccess => 'Pengeluaran dicatat';

  @override
  String get cashSalesAddedSuccess => 'Penjualan tunai dicatat';

  @override
  String get openingCashUpdatedSuccess => 'Kas awal diperbarui';

  @override
  String get dayDetails => 'Detail hari';

  @override
  String closedAtTime(String time) {
    return 'Ditutup pukul: $time';
  }

  @override
  String get readOnlyDayNotice =>
      'Hari ini sudah ditutup. Ketuk Buka kembali hari untuk mengubah.';

  @override
  String get privacyModeTitle => 'Mode privasi';

  @override
  String get privacyModeSubtitle =>
      'Sembunyikan jumlah di layar & widget (••••••)';

  @override
  String get shareAppTitle => 'Bagikan aplikasi';

  @override
  String get shareAppSubtitle => 'Kirim Kashkool ke sesama pemilik toko';

  @override
  String shopCodeLabel(String code) {
    return 'Kode toko: $code';
  }

  @override
  String get growthFooterToggleTitle =>
      'Sembunyikan tanda tangan Kashkool di pesan';

  @override
  String get growthFooterToggleSubtitle => 'Tersedia di paket berbayar 🔒';

  @override
  String get codeCopied => 'Kode disalin';

  @override
  String get main1 => 'Kashkool';

  @override
  String get notebookImportButton1 =>
      'Pindahkan buku catatan Anda ke aplikasi 📒';

  @override
  String get notebookImportButton2 =>
      'Tidak perlu semua catatan lama: cukup nama pelanggan dan utangnya sekarang.';

  @override
  String get notebookImportButton3 => 'Pelanggan dan saldo';

  @override
  String get notebookImportButton4 =>
      'Satu baris per pelanggan: nama, telepon, dan utang';

  @override
  String get notebookImportButton5 => 'Cicilan lama';

  @override
  String get notebookImportButton6 =>
      'Harga, yang sudah dibayar, sisa cicilan, dan jatuh tempo berikutnya';

  @override
  String get notebookImportButton7 => 'Impor dari buku';

  @override
  String get oldInstallmentImportScreen1 => 'Tanggal cicilan berikutnya';

  @override
  String get oldInstallmentImportScreen2 => 'Cicilan disimpan ✓';

  @override
  String oldInstallmentImportScreen3(
    Object remaining,
    Object countValue,
    Object nextDue,
  ) {
    return 'Sisa $remaining dalam $countValue cicilan, pertama pada $nextDue.';
  }

  @override
  String get oldInstallmentImportScreen4 => 'Selesai';

  @override
  String get oldInstallmentImportScreen5 => 'Cicilan lain';

  @override
  String get oldInstallmentImportScreen6 =>
      'Gagal menyimpan, tidak ada yang tersimpan';

  @override
  String get oldInstallmentImportScreen7 => ' per bulan';

  @override
  String get oldInstallmentImportScreen8 => ' per minggu';

  @override
  String oldInstallmentImportScreen9(
    Object remaining,
    Object count,
    Object count2,
    Object monthly,
  ) {
    return 'Sisa $remaining — $count cicilan × sekitar $count2$monthly';
  }

  @override
  String get oldInstallmentImportScreen10 => 'Cicilan lama dari buku';

  @override
  String oldInstallmentImportScreen11(Object savedCount) {
    return 'Cicilan lama ($savedCount)';
  }

  @override
  String get oldInstallmentImportScreen12 =>
      'Untuk cicilan yang dimulai sebelum aplikasi: isi harga, yang sudah dibayar, dan jumlah cicilan tersisa. Aplikasi hanya membuat jadwal sisa dan tidak menghitung pembayaran lama di laci kas hari ini.';

  @override
  String get oldInstallmentImportScreen13 => 'Pelanggan';

  @override
  String get oldInstallmentImportScreen14 => 'Nama pelanggan';

  @override
  String get oldInstallmentImportScreen15 =>
      'Ketik nama pelanggan lama atau baru';

  @override
  String get oldInstallmentImportScreen16 => 'Isi nama pelanggan';

  @override
  String get oldInstallmentImportScreen17 =>
      'HP pelanggan (jika baru — opsional)';

  @override
  String get oldInstallmentImportScreen18 => 'Nomor tidak valid';

  @override
  String get oldInstallmentImportScreen19 => 'Cicilan';

  @override
  String get oldInstallmentImportScreen20 => 'Barang';

  @override
  String get oldInstallmentImportScreen21 => 'mis. kulkas Samsung';

  @override
  String get oldInstallmentImportScreen22 => 'Isi nama barang';

  @override
  String get oldInstallmentImportScreen23 => 'Harga total';

  @override
  String get oldInstallmentImportScreen24 => 'EGP';

  @override
  String get oldInstallmentImportScreen25 => 'Wajib';

  @override
  String get oldInstallmentImportScreen26 => 'Tidak valid';

  @override
  String get oldInstallmentImportScreen27 => 'Sudah dibayar';

  @override
  String get oldInstallmentImportScreen28 => 'Harus kurang dari harga';

  @override
  String get oldInstallmentImportScreen29 => 'Sisa cicilan';

  @override
  String get oldInstallmentImportScreen30 => 'Dari 1 sampai 120';

  @override
  String oldInstallmentImportScreen31(Object nextDue) {
    return 'Berikutnya: $nextDue';
  }

  @override
  String get oldInstallmentImportScreen32 => 'Bulanan';

  @override
  String get oldInstallmentImportScreen33 => 'Mingguan';

  @override
  String get oldInstallmentImportScreen34 => 'Penjamin (opsional)';

  @override
  String get oldInstallmentImportScreen35 => 'Nama penjamin';

  @override
  String get oldInstallmentImportScreen36 => 'HP penjamin';

  @override
  String get oldInstallmentImportScreen37 =>
      'Foto buku atau kontrak (opsional — tetap di HP ini)';

  @override
  String get oldInstallmentImportScreen38 =>
      'Anda bisa menambah beberapa foto: halaman buku, kontrak, KTP penjamin…';

  @override
  String oldInstallmentImportScreen39(Object photosLength) {
    return '$photosLength foto — disimpan di foto pelanggan';
  }

  @override
  String get oldInstallmentImportScreen40 => 'Menyimpan…';

  @override
  String get oldInstallmentImportScreen41 => 'Simpan cicilan';

  @override
  String get notebookImportScreen1 => 'Saldo per tanggal';

  @override
  String notebookImportScreen2(Object firstError, Object error) {
    return 'Baris $firstError: $error';
  }

  @override
  String get notebookImportScreen3 => 'Isi minimal satu nama pelanggan';

  @override
  String get notebookImportScreen4 => 'Tersimpan ✓';

  @override
  String notebookImportScreen5(Object newCustomers) {
    return '$newCustomers pelanggan baru';
  }

  @override
  String notebookImportScreen6(Object existingCustomers) {
    return '$existingCustomers pelanggan lama — ditambahkan ke saldonya';
  }

  @override
  String notebookImportScreen7(Object totalPiasters) {
    return 'Total: $totalPiasters';
  }

  @override
  String get notebookImportScreen8 => 'Halaman berikutnya';

  @override
  String get notebookImportScreen9 => 'Keluar tanpa menyimpan?';

  @override
  String get notebookImportScreen10 =>
      'Yang Anda tulis di halaman ini tidak akan disimpan.';

  @override
  String get notebookImportScreen11 => 'Lanjutkan';

  @override
  String get notebookImportScreen12 => 'Keluar';

  @override
  String get notebookImportScreen13 => 'Impor buku 📒';

  @override
  String notebookImportScreen14(Object savedPages) {
    return 'Impor buku — halaman $savedPages';
  }

  @override
  String get notebookImportScreen15 => 'Baris baru';

  @override
  String notebookImportScreen16(Object validLength) {
    return '$validLength pelanggan';
  }

  @override
  String get notebookImportScreen17 => 'Simpan';

  @override
  String get notebookImportScreen18 =>
      'Tulis satu pelanggan per baris: nama, HP jika ada, dan jumlah utangnya. Ketuk \"Berikutnya\" di keyboard agar cepat.';

  @override
  String get notebookImportScreen19 => 'Saldo per hari ini';

  @override
  String notebookImportScreen20(Object asOf) {
    return 'Per $asOf';
  }

  @override
  String get notebookImportScreen21 =>
      'Foto halaman buku (opsional): disimpan untuk semua pelanggan di halaman itu';

  @override
  String notebookImportScreen22(Object pagePhotosLength) {
    return '$pagePhotosLength foto halaman — disimpan untuk semua pelanggan di halaman';
  }

  @override
  String get notebookImportScreen23 => 'Halaman';

  @override
  String get notebookImportScreen24 => 'Foto pelanggan ini';

  @override
  String get notebookImportScreen25 => 'Hapus baris';

  @override
  String get notebookImportScreen26 => 'HP (opsional)';

  @override
  String get notebookImportScreen27 => 'Jumlah';

  @override
  String get notebookImportScreen28 => 'Memeriksa…';

  @override
  String notebookImportScreen29(Object name) {
    return '\"$name\" sudah ada — jumlah akan ditambahkan ke saldonya';
  }

  @override
  String get notebookImportScreen30 => 'Pelanggan berutang jumlah ini';

  @override
  String get notebookImportScreen31 => 'Anda berutang jumlah ini ke pelanggan';

  @override
  String get notebookImportScreen32 => 'Utang';

  @override
  String get notebookImportScreen33 => 'Saldo';

  @override
  String get notebookImportService1 => 'Saldo lama dari buku';

  @override
  String get notebookImportService2 => 'Halaman buku';

  @override
  String get notebookImportService3 => 'Nama kosong';

  @override
  String get notebookImportService4 => 'Nama terlalu panjang';

  @override
  String get notebookImportService5 => 'Jumlah tidak valid';

  @override
  String get notebookImportService6 => 'Jumlah dibayar tidak boleh negatif';

  @override
  String get notebookImportService7 =>
      'Jumlah dibayar harus kurang dari harga total';

  @override
  String get notebookImportService8 => 'Minimal 1 cicilan tersisa';

  @override
  String notebookImportService9(Object paidPiasters) {
    return 'Diimpor dari buku — sudah dibayar: $paidPiasters';
  }

  @override
  String notebookImportService10(Object trim, Object totalPricePiasters) {
    return 'Cicilan lama: $trim (sisa dari $totalPricePiasters)';
  }

  @override
  String notebookImportService11(Object trim) {
    return 'Cicilan: $trim';
  }

  @override
  String get installmentsScreen1 => 'Cicilan 📋';

  @override
  String get installmentsScreen2 =>
      'Cari pelanggan, barang, HP, atau penjamin...';

  @override
  String get installmentsScreen3 => 'Total cicilan';

  @override
  String get installmentsScreen4 => 'Terlambat';

  @override
  String get installmentsScreen5 => 'Rencana aktif';

  @override
  String get installmentsScreen6 => 'Semua';

  @override
  String get installmentsScreen7 => 'Aktif ⏳';

  @override
  String get installmentsScreen8 => 'Selesai ✓';

  @override
  String get installmentsScreen9 => 'Dibatalkan';

  @override
  String installmentsScreen10(Object e) {
    return 'Gagal memuat cicilan: $e';
  }

  @override
  String get installmentsScreen11 => 'Tidak ada cicilan yang cocok';

  @override
  String get installmentsScreen12 => 'Belum ada rencana cicilan';

  @override
  String get installmentsScreen13 =>
      'Ketuk (+ Rencana cicilan baru) untuk membuat jadwal cicilan pertama.';

  @override
  String get installmentsScreen14 => 'Rencana cicilan baru';

  @override
  String installmentPlanDetailsScreen1(Object instapay) {
    return 'InstaPay: $instapay';
  }

  @override
  String installmentPlanDetailsScreen2(Object wallet) {
    return 'Dompet / Vodafone Cash: $wallet';
  }

  @override
  String installmentPlanDetailsScreen3(Object phoneNum) {
    return 'Telepon: $phoneNum';
  }

  @override
  String get installmentPlanDetailsScreen4 => 'Batalkan rencana cicilan';

  @override
  String get installmentPlanDetailsScreen5 =>
      'Batalkan rencana ini? Pengingat berhenti dan riwayat pembayaran tetap disimpan.';

  @override
  String get installmentPlanDetailsScreen6 => 'Kembali';

  @override
  String get installmentPlanDetailsScreen7 => 'Batalkan rencana';

  @override
  String get installmentPlanDetailsScreen8 => 'Rencana cicilan dibatalkan';

  @override
  String get installmentPlanDetailsScreen9 => 'Hapus rencana cicilan';

  @override
  String get installmentPlanDetailsScreen10 => 'Hapus rencana cicilan ini?';

  @override
  String get installmentPlanDetailsScreen11 => 'Batal';

  @override
  String get installmentPlanDetailsScreen12 => 'Hapus';

  @override
  String get installmentPlanDetailsScreen13 => 'Rencana cicilan dihapus';

  @override
  String get installmentPlanDetailsScreen14 => 'Detail cicilan';

  @override
  String installmentPlanDetailsScreen15(Object e) {
    return 'Kesalahan: $e';
  }

  @override
  String get installmentPlanDetailsScreen16 =>
      'Rencana cicilan tidak ada atau sudah dihapus';

  @override
  String get installmentPlanDetailsScreen17 => 'Hapus rencana';

  @override
  String get installmentPlanDetailsScreen18 => 'Harga total:';

  @override
  String get installmentPlanDetailsScreen19 => 'Uang muka:';

  @override
  String get installmentPlanDetailsScreen20 => 'Total dibayar:';

  @override
  String get installmentPlanDetailsScreen21 => 'Sisa:';

  @override
  String get installmentPlanDetailsScreen22 => 'Lunasi lebih awal';

  @override
  String installmentPlanDetailsScreen23(Object guarantorName) {
    return 'Penjamin: $guarantorName';
  }

  @override
  String get installmentPlanDetailsScreen24 => 'Foto kontrak / surat utang';

  @override
  String get installmentPlanDetailsScreen25 =>
      'Ketuk untuk melihat dokumen penuh';

  @override
  String get installmentPlanDetailsScreen26 => 'Dokumen cicilan';

  @override
  String installmentPlanDetailsScreen27(Object installmentsLength) {
    return 'Jadwal cicilan ($installmentsLength)';
  }

  @override
  String get installmentPlanDetailsScreen28 => 'Bayar bebas';

  @override
  String installmentPlanDetailsScreen29(
    Object installmentIndex,
    Object dueDate,
  ) {
    return 'Cicilan ke-$installmentIndex • $dueDate';
  }

  @override
  String installmentPlanDetailsScreen30(Object paidPiasters) {
    return 'Lunas ✓ ($paidPiasters)';
  }

  @override
  String installmentPlanDetailsScreen31(
    Object paidPiasters,
    Object amountPiasters,
  ) {
    return 'Dibayar $paidPiasters dari $amountPiasters';
  }

  @override
  String get installmentPlanDetailsScreen32 => 'Terlambat ⚠️';

  @override
  String get installmentPlanDetailsScreen33 => 'Jatuh tempo hari ini 🔔';

  @override
  String installmentPlanDetailsScreen34(Object amountPiasters) {
    return 'Mendatang • $amountPiasters';
  }

  @override
  String get installmentPlanDetailsScreen35 => 'Pengingat WhatsApp';

  @override
  String get installmentPlanDetailsScreen36 => 'Bayar';

  @override
  String get addInstallmentPlanScreen1 => 'HP';

  @override
  String get addInstallmentPlanScreen2 => 'TV';

  @override
  String get addInstallmentPlanScreen3 => 'Mesin cuci';

  @override
  String get addInstallmentPlanScreen4 => 'Kulkas';

  @override
  String get addInstallmentPlanScreen5 => 'Kompor';

  @override
  String get addInstallmentPlanScreen6 => 'Laptop';

  @override
  String get addInstallmentPlanScreen7 => 'Sepeda motor';

  @override
  String get addInstallmentPlanScreen8 => 'Furnitur';

  @override
  String get addInstallmentPlanScreen9 => 'Pilih pelanggan dulu';

  @override
  String get addInstallmentPlanScreen10 =>
      'Uang muka harus kurang dari harga total';

  @override
  String get addInstallmentPlanScreen11 =>
      'Rencana cicilan dibuat dan dijadwalkan ✓';

  @override
  String addInstallmentPlanScreen12(Object e) {
    return 'Terjadi kesalahan: $e';
  }

  @override
  String addInstallmentPlanScreen13(Object e) {
    return 'Gagal memuat pelanggan: $e';
  }

  @override
  String get addInstallmentPlanScreen14 => 'Pilih pelanggan';

  @override
  String get addInstallmentPlanScreen15 => 'Silakan pilih pelanggan';

  @override
  String get addInstallmentPlanScreen16 => 'Barang dan jumlah';

  @override
  String get addInstallmentPlanScreen17 => 'Nama barang *';

  @override
  String get addInstallmentPlanScreen18 => 'mis. Samsung A15 128GB';

  @override
  String get addInstallmentPlanScreen19 => 'Nama barang minimal 2 karakter';

  @override
  String get addInstallmentPlanScreen20 => 'Harga total (EGP) *';

  @override
  String get addInstallmentPlanScreen21 => 'mis. 12000';

  @override
  String get addInstallmentPlanScreen22 => 'Jumlah tidak valid';

  @override
  String get addInstallmentPlanScreen23 => 'Uang muka (EGP)';

  @override
  String get addInstallmentPlanScreen24 => 'Jumlah yang dicicil:';

  @override
  String get addInstallmentPlanScreen25 => 'Durasi dan frekuensi';

  @override
  String addInstallmentPlanScreen26(Object count) {
    return '$count cicilan';
  }

  @override
  String get addInstallmentPlanScreen27 => 'Jumlah cicilan *';

  @override
  String get addInstallmentPlanScreen28 => 'Masukkan bilangan bulat';

  @override
  String get addInstallmentPlanScreen29 => 'Frekuensi';

  @override
  String get addInstallmentPlanScreen30 => 'Jatuh tempo cicilan pertama';

  @override
  String get addInstallmentPlanScreen31 => 'Ubah tanggal';

  @override
  String get addInstallmentPlanScreen32 => 'Penjamin dan dokumen (opsional)';

  @override
  String get addInstallmentPlanScreen33 => 'mis. Budi Santoso';

  @override
  String get addInstallmentPlanScreen34 => 'Nomor HP penjamin';

  @override
  String get addInstallmentPlanScreen35 =>
      'Nomor tidak valid (010, 011, 012, 015)';

  @override
  String get addInstallmentPlanScreen36 => 'Foto dokumen diambil ✓';

  @override
  String get addInstallmentPlanScreen37 => 'Foto kontrak / surat utang / KTP';

  @override
  String get addInstallmentPlanScreen38 => 'Ketuk untuk mengganti foto';

  @override
  String get addInstallmentPlanScreen39 => 'Simpan foto kontrak untuk nanti';

  @override
  String get addInstallmentPlanScreen40 => 'Ambil foto';

  @override
  String get addInstallmentPlanScreen41 => 'Catatan tambahan';

  @override
  String get addInstallmentPlanScreen42 => 'Hubungkan ke buku pelanggan';

  @override
  String get addInstallmentPlanScreen43 =>
      'Catat harga total sebagai utang dan uang muka sebagai pembayaran di buku pelanggan';

  @override
  String addInstallmentPlanScreen44(Object scheduleLength) {
    return 'Pratinjau jadwal ($scheduleLength cicilan)';
  }

  @override
  String addInstallmentPlanScreen45(Object amountPiasters) {
    return 'Nilai cicilan: ~$amountPiasters';
  }

  @override
  String get addInstallmentPlanScreen46 => 'Simpan rencana dan jadwal';

  @override
  String installmentProgressBar1(
    Object paidCount,
    Object totalCount,
    Object percentInt,
  ) {
    return '$paidCount dari $totalCount dibayar ($percentInt%)';
  }

  @override
  String installmentProgressBar2(Object remainingPiasters) {
    return 'Sisa: $remainingPiasters';
  }

  @override
  String get installmentProgressBar3 => 'Lunas ✓';

  @override
  String get payInstallmentDialog1 => 'Masukkan jumlah valid lebih dari nol';

  @override
  String payInstallmentDialog2(Object amountPiasters) {
    return 'Pembayaran $amountPiasters dicatat ✓';
  }

  @override
  String payInstallmentDialog3(Object e) {
    return 'Pembayaran gagal: $e';
  }

  @override
  String payInstallmentDialog4(Object installmentIndex) {
    return 'Bayar cicilan ke-$installmentIndex';
  }

  @override
  String payInstallmentDialog5(Object itemDescription) {
    return 'Bayar cicilan ($itemDescription)';
  }

  @override
  String get payInstallmentDialog6 => 'Jumlah tagihan:';

  @override
  String get payInstallmentDialog7 => 'Jumlah dibayar (EGP)';

  @override
  String get payInstallmentDialog8 => 'Metode pembayaran';

  @override
  String get payInstallmentDialog9 => 'Tunai 💵';

  @override
  String get payInstallmentDialog10 => 'InstaPay ⚡';

  @override
  String get payInstallmentDialog11 => 'Dompet 📱';

  @override
  String get payInstallmentDialog12 => 'Tanggal bayar';

  @override
  String get payInstallmentDialog13 => 'Ubah';

  @override
  String get payInstallmentDialog14 => 'Catatan (opsional)';

  @override
  String get payInstallmentDialog15 => 'mis. dititipkan lewat teman';

  @override
  String get payInstallmentDialog16 => 'Catat di buku pelanggan';

  @override
  String get payInstallmentDialog17 => 'Dikurangi dari saldo utama pelanggan';

  @override
  String get payInstallmentDialog18 => 'Konfirmasi pembayaran';

  @override
  String earlySettlementDialog1(Object itemDescription) {
    return 'Cicilan ($itemDescription) dilunasi ✓';
  }

  @override
  String earlySettlementDialog2(Object e) {
    return 'Pelunasan gagal: $e';
  }

  @override
  String get earlySettlementDialog3 => 'Pelunasan awal';

  @override
  String get earlySettlementDialog4 => 'Total sisa cicilan:';

  @override
  String get earlySettlementDialog5 => 'Jumlah yang ditagih:';

  @override
  String get earlySettlementDialog6 => 'Diskon pelunasan awal (EGP)';

  @override
  String get earlySettlementDialog7 => 'Lunasi sekarang';

  @override
  String installmentPlanCard1(Object overdueCount) {
    return 'Terlambat ($overdueCount)';
  }

  @override
  String get installmentPlanCard2 => 'Selesai ✓';

  @override
  String get installmentPlanCard3 => 'Dibatalkan';

  @override
  String installmentPlanCard4(Object dueDate, Object paidPiasters) {
    return 'Berikutnya: $dueDate ($paidPiasters)';
  }

  @override
  String installmentPlanCard5(Object totalPricePiasters) {
    return 'Total: $totalPricePiasters';
  }

  @override
  String get installmentRepository1 => 'Deskripsi barang minimal 2 karakter';

  @override
  String get installmentRepository2 => 'Harga total harus lebih dari nol';

  @override
  String get installmentRepository3 => 'Uang muka tidak boleh negatif';

  @override
  String get installmentRepository4 =>
      'Uang muka harus kurang dari harga total';

  @override
  String get installmentRepository5 => 'Jumlah cicilan harus lebih dari nol';

  @override
  String installmentRepository6(Object trim, Object installmentCount) {
    return 'Cicilan: $trim ($installmentCount kali)';
  }

  @override
  String installmentRepository7(Object trim) {
    return 'Uang muka: $trim';
  }

  @override
  String get installmentRepository8 => 'Jumlah pembayaran harus lebih dari nol';

  @override
  String installmentRepository9(Object itemDescription, Object notes) {
    return 'Bayar cicilan: $itemDescription$notes';
  }

  @override
  String get installmentRepository10 => 'Rencana cicilan tidak ditemukan';

  @override
  String installmentRepository11(Object itemDescription) {
    return 'Pelunasan awal: $itemDescription';
  }

  @override
  String installmentRepository12(Object itemDescription) {
    return 'Diskon pelunasan awal: $itemDescription';
  }

  @override
  String get collectionScreen1 => 'Cicilan jatuh tempo';

  @override
  String get dueInstallmentsTab1 => 'Pelanggan tidak punya nomor telepon';

  @override
  String get dueInstallmentsTab2 => 'Tidak ada cicilan jatuh tempo hari ini 🎉';

  @override
  String get dueInstallmentsTab3 =>
      'Semua pelanggan cicilan membayar tepat waktu.';

  @override
  String dueInstallmentsTab4(Object dueListLength) {
    return '$dueListLength cicilan perlu ditagih:';
  }

  @override
  String dueInstallmentsTab5(
    Object itemDescription,
    Object installmentIndex,
    Object installmentCount,
  ) {
    return '$itemDescription • cicilan $installmentIndex dari $installmentCount';
  }

  @override
  String dueInstallmentsTab6(Object daysOverdue) {
    return 'Terlambat $daysOverdue hari';
  }

  @override
  String get dueInstallmentsTab7 => 'Jatuh tempo hari ini 🔔';

  @override
  String get dueInstallmentsTab8 => 'Telepon';

  @override
  String get dueInstallmentsTab9 => 'WhatsApp';

  @override
  String cashDrawerScreen1(Object err) {
    return 'Gagal memuat laci kas: $err';
  }

  @override
  String drawerLiveCard1(Object notes) {
    return 'Catatan: $notes';
  }

  @override
  String expensesListCard1(Object expensesLength) {
    return '$expensesLength pengeluaran';
  }

  @override
  String get expensesListCard2 => 'InstaPay';

  @override
  String get expensesListCard3 => 'Dompet';

  @override
  String get drawerFlowCard1 => '(InstaPay / dompet)';

  @override
  String addCashSalesBottomSheet1(Object currentSalesPiasters) {
    return 'Penjualan tercatat: $currentSalesPiasters';
  }

  @override
  String get addCashSalesBottomSheet2 => 'Tambah ke penjualan (+)';

  @override
  String get addCashSalesBottomSheet3 => 'Ubah total (=)';

  @override
  String get addCashSalesBottomSheet4 => 'Jumlah yang ditambah';

  @override
  String get addCashSalesBottomSheet5 => 'Total penjualan baru';

  @override
  String addCashSalesBottomSheet6(Object val) {
    return '+$val EGP';
  }

  @override
  String drawerHistoryTab1(
    Object cashSalesPiasters,
    Object openingCashPiasters,
  ) {
    return 'Penjualan tunai: $cashSalesPiasters · Kas awal: $openingCashPiasters';
  }

  @override
  String drawerHistoryTab2(Object date) {
    return 'Detail $date';
  }

  @override
  String get drawerHistoryTab3 => 'Selisih';

  @override
  String get customersScreen1 => 'Cicilan';

  @override
  String get customersScreen2 => 'Mode privasi';

  @override
  String get customersScreen3 => 'Urutkan';

  @override
  String get customerPhotosScreen1 => 'Foto ditambahkan';

  @override
  String customerPhotosScreen2(Object pathsLength) {
    return '$pathsLength foto ditambahkan';
  }

  @override
  String get customerPhotosScreen3 => 'Foto dihapus';

  @override
  String get customerPhotosScreen4 => 'Kembalikan';

  @override
  String customerPhotosScreen5(Object customerName) {
    return 'Foto $customerName';
  }

  @override
  String get customerPhotosScreen6 => 'Tambah foto';

  @override
  String get customerPhotosScreen7 => 'Gagal memuat foto';

  @override
  String get customerPhotosScreen8 =>
      'Belum ada foto untuk pelanggan ini.\nFoto halaman buku atau dokumennya — foto hanya disimpan di HP ini.';

  @override
  String get customerPhotosScreen9 => 'Hapus foto';

  @override
  String customerDetailsScreen1(
    Object activePlansLength,
    Object remainingPiasters,
  ) {
    return 'Cicilan aktif ($activePlansLength) • Sisa: $remainingPiasters';
  }

  @override
  String get customerDetailsScreen2 => 'Jual cicilan ke pelanggan ini';

  @override
  String get customerDetailsScreen3 => 'Lihat';

  @override
  String get customerDetailsScreen4 => 'Tambah cicilan baru';

  @override
  String get customerDetailsScreen5 => 'Foto pelanggan';

  @override
  String get photoStrip1 => 'Ambil dengan kamera';

  @override
  String get photoStrip2 => 'Pilih dari galeri';

  @override
  String get photoStrip3 => 'Bisa pilih beberapa foto sekaligus';

  @override
  String get photoStrip4 => 'Foto';

  @override
  String get photoStrip5 => 'Lagi';

  @override
  String get photoStrip6 => 'Tambah foto';

  @override
  String get photoStrip7 => 'Foto';

  @override
  String photoStrip8(Object title, Object index, Object count) {
    return '$title ($index dari $count)';
  }

  @override
  String get photoStrip9 => 'Foto';

  @override
  String get photoStrip10 => 'Foto tidak ada di HP ini';

  @override
  String creditLimitProgressBar1(Object limitPiasters) {
    return 'Batas utang: $limitPiasters';
  }

  @override
  String ratingExplanationBottomSheet1(Object customerName) {
    return 'Penilaian pelanggan: $customerName';
  }

  @override
  String get ratingExplanationBottomSheet2 => 'Alasan penilaian:';

  @override
  String get ratingExplanationBottomSheet3 => 'Bagaimana penilaian bekerja?';

  @override
  String get ratingExplanationBottomSheet4 => 'Sangat baik';

  @override
  String get ratingExplanationBottomSheet5 =>
      'Lunas, atau utang terlama maksimal 14 hari.';

  @override
  String get ratingExplanationBottomSheet6 => 'Perlu dipantau';

  @override
  String get ratingExplanationBottomSheet7 =>
      'Utang terlama 15–45 hari (sebaiknya diingatkan).';

  @override
  String get ratingExplanationBottomSheet8 => 'Terlambat';

  @override
  String get ratingExplanationBottomSheet9 =>
      'Utang terlama lebih dari 45 hari, atau batas utang terlampaui.';

  @override
  String get ratingExplanationBottomSheet10 => 'Baru';

  @override
  String get ratingExplanationBottomSheet11 =>
      'Pelanggan dengan kurang dari 3 transaksi.';

  @override
  String get ratingExplanationBottomSheet12 => 'Mengerti';

  @override
  String get customerWithBalance1 => 'Pelanggan baru';

  @override
  String get settingsScreen1 => 'Info toko 🏪';

  @override
  String get settingsScreen2 => 'Keamanan & privasi 🔒';

  @override
  String get settingsScreen3 => 'Widget layar utama 📱';

  @override
  String get settingsScreen4 => 'Pesan pengingat 💬';

  @override
  String get settingsScreen5 => 'Cadangan & data 💾';

  @override
  String get settingsScreen6 => 'Bagikan aplikasi 🚀';

  @override
  String get settingsScreen7 => 'Umum ⚙️';

  @override
  String get settingsScreen8 => 'Kashkool 📒';

  @override
  String get settingsScreen9 =>
      'Buku kas toko tanpa internet (Offline-First)\nVersi 1.0.0';

  @override
  String get settingsScreen10 => 'Toko umum';

  @override
  String get settingsScreen11 => 'Toko kelontong & swalayan 🛒';

  @override
  String get settingsScreen12 => 'HP & aksesori 📱';

  @override
  String get settingsScreen13 => 'Elektronik & peralatan rumah ⚡';

  @override
  String get settingsScreen14 => 'Apotek & kosmetik 💊';

  @override
  String get settingsScreen15 => 'Usaha lainnya 🏪';

  @override
  String settingsScreen16(Object tradeName) {
    return '$tradeName • Ubah usaha & info pembayaran';
  }

  @override
  String get settingsScreen17 =>
      'Sembunyikan jumlah di layar & widget (••••••)';

  @override
  String get settingsScreen18 => 'Kunci aplikasi dengan PIN (4 digit)';

  @override
  String get settingsScreen19 => 'Aktif & terlindungi (ketuk untuk mematikan)';

  @override
  String get settingsScreen20 => 'Nonaktif (ketuk untuk mengatur)';

  @override
  String get settingsScreen21 => 'Aktif 🔒';

  @override
  String get settingsScreen22 => 'Atur';

  @override
  String get settingsScreen23 => 'Kunci aplikasi dimatikan';

  @override
  String get settingsScreen24 => 'PIN diatur 🔒';

  @override
  String get settingsScreen25 => 'Buka dengan sidik jari / Face ID';

  @override
  String get settingsScreen26 => 'Pakai sidik jari, tidak perlu ketik PIN';

  @override
  String get settingsScreen27 => 'Perangkat Anda tidak mendukung biometrik';

  @override
  String get settingsScreen28 => '1 menit';

  @override
  String get settingsScreen29 => '5 menit';

  @override
  String get settingsScreen30 => '15 menit';

  @override
  String get settingsScreen31 => 'Langsung';

  @override
  String get settingsScreen32 => 'Kunci otomatis setelah';

  @override
  String get settingsScreen33 => 'Begitu keluar aplikasi';

  @override
  String settingsScreen34(Object timeout) {
    return '$timeout menit setelah keluar';
  }

  @override
  String get settingsScreen35 => 'Langsung saat keluar';

  @override
  String get settingsScreen36 => 'Setelah 1 menit';

  @override
  String get settingsScreen37 => 'Setelah 5 menit';

  @override
  String get settingsScreen38 => 'Setelah 15 menit';

  @override
  String get settingsScreen39 => 'Pesan pengingat';

  @override
  String get settingsScreen40 =>
      'Ubah pesan otomatis dengan pratinjau langsung';

  @override
  String get settingsScreen41 => 'Cegah pengingat dimatikan di latar belakang';

  @override
  String get settingsScreen42 => 'Panduan untuk HP Xiaomi, Realme, dan Infinix';

  @override
  String get settingsScreen43 => 'Belum ada cadangan';

  @override
  String get settingsScreen44 => 'Cadangan terakhir';

  @override
  String get settingsScreen45 => 'Ekspor cadangan (.kashkool)';

  @override
  String get settingsScreen46 =>
      'Simpan salinan buku dan foto lalu kirim via WhatsApp atau Drive';

  @override
  String get settingsScreen47 => 'Cadangan diekspor 👍';

  @override
  String settingsScreen48(Object e) {
    return 'Ekspor gagal: $e';
  }

  @override
  String get settingsScreen49 => 'Pulihkan cadangan';

  @override
  String get settingsScreen50 => 'Pulihkan akun dan foto dari file .kashkool';

  @override
  String get settingsScreen51 => 'File tidak valid ❌';

  @override
  String get settingsScreen52 => 'File ini bukan cadangan Kashkool yang valid.';

  @override
  String get settingsScreen53 => 'OK';

  @override
  String get settingsScreen54 => 'Konfirmasi pemulihan';

  @override
  String get settingsScreen55 =>
      'Perhatian: pemulihan mengganti semua data saat ini dengan data dari file.';

  @override
  String settingsScreen56(Object exportedAt) {
    return 'Tanggal cadangan: $exportedAt';
  }

  @override
  String settingsScreen57(Object photosCount) {
    return 'Jumlah foto: $photosCount';
  }

  @override
  String settingsScreen58(Object fileSizeBytes) {
    return 'Ukuran file: $fileSizeBytes KB';
  }

  @override
  String get settingsScreen59 => 'Ya, ganti dan pulihkan';

  @override
  String get settingsScreen60 => 'Berhasil dipulihkan 🎉';

  @override
  String get settingsScreen61 =>
      'Semua akun, transaksi, dan foto dipulihkan. Mulai ulang aplikasi untuk memperbarui layar.';

  @override
  String get settingsScreen62 => 'Mulai ulang sekarang';

  @override
  String settingsScreen63(Object e) {
    return 'Pemulihan gagal: $e';
  }

  @override
  String get settingsScreen64 => 'Gelap 🌙';

  @override
  String get settingsScreen65 => 'Terang ☀️';

  @override
  String get settingsScreen66 => 'Otomatis';

  @override
  String get settingsScreen67 => 'Tampilan';

  @override
  String get settingsScreen68 => 'Otomatis (ikut HP)';

  @override
  String get settingsScreen69 => 'Belum diatur';

  @override
  String get settingsScreen70 => 'Batas utang default pelanggan baru';

  @override
  String get settingsScreen71 => 'Hubungi kami via WhatsApp';

  @override
  String get settingsScreen72 => 'Saran dan bantuan langsung';

  @override
  String get settingsScreen73 =>
      'https://wa.me/201000000000?text=Halo%2C%20saya%20punya%20pertanyaan%20tentang%20Kashkool';

  @override
  String get settingsScreen74 => 'Kebijakan privasi & ketentuan';

  @override
  String get settingsScreen75 =>
      'Data milik Anda dan hanya ada di HP Anda, tanpa internet';

  @override
  String get settingsScreen76 => 'Kebijakan privasi Kashkool 🔒';

  @override
  String get settingsScreen77 =>
      '1. Kashkool bekerja sepenuhnya tanpa internet (Offline-First).\n\n2. Semua akun, nama, nomor telepon, foto nota, dan transaksi hanya disimpan di perangkat Anda. Tidak ada data yang dikirim ke server luar.\n\n3. Anda bertanggung jawab membuat cadangan rutin (Ekspor cadangan) agar data aman jika HP diganti atau hilang.\n\n4. Kashkool dibuat untuk pemilik toko dan pedagang agar hak mereka terjaga dan utang tercatat dengan aman.';

  @override
  String get settingsScreen78 => 'Sistem (otomatis)';

  @override
  String get settingsScreen79 => 'Batas utang default (EGP)';

  @override
  String get settingsScreen80 => 'Jumlah dalam EGP';

  @override
  String get settingsScreen81 => 'Kosongkan jika tanpa batas';

  @override
  String get settingsScreen82 => 'Simpan';

  @override
  String batteryGuideBottomSheet1(Object brandName) {
    return 'Panduan notifikasi ($brandName)';
  }

  @override
  String get batteryGuideBottomSheet2 => 'Panduan agar pengingat tetap jalan';

  @override
  String get batteryGuideBottomSheet3 =>
      'Beberapa HP (seperti Xiaomi, Realme, Infinix, dan Huawei) menghentikan aplikasi di latar belakang untuk menghemat baterai. Agar pengingat tagihan dan cicilan tepat waktu, ikuti langkah berikut:';

  @override
  String get batteryGuideBottomSheet4 => 'Buka pengaturan baterai sekarang';

  @override
  String get backupReminderBanner1 => 'Cadangan diekspor 👍';

  @override
  String backupReminderBanner2(Object e) {
    return 'Pencadangan gagal: $e';
  }

  @override
  String get backupReminderBanner3 => 'Saatnya membuat cadangan ⚠️';

  @override
  String get backupReminderBanner4 =>
      'Sudah lebih dari 7 hari sejak cadangan terakhir. Simpan data agar tidak hilang jika HP hilang atau diganti.';

  @override
  String get backupReminderBanner5 => 'Nanti saja';

  @override
  String get backupReminderBanner6 => 'Menyimpan...';

  @override
  String get backupReminderBanner7 => 'Cadangkan sekarang';

  @override
  String get homeWidgetSettingsCard1 => 'Tampilkan saldo di layar utama';

  @override
  String get homeWidgetSettingsCard2 =>
      'Widget menampilkan piutang dan tagihan hari ini tanpa membuka aplikasi';

  @override
  String get homeWidgetSettingsCard3 =>
      'Widget nonaktif dan tidak menampilkan angka';

  @override
  String get homeWidgetSettingsCard4 => 'Tambah widget kecil';

  @override
  String get homeWidgetSettingsCard5 => 'Hanya piutang Anda';

  @override
  String get homeWidgetSettingsCard6 => 'Tambah widget ringkasan hari ini';

  @override
  String get homeWidgetSettingsCard7 =>
      'Piutang + tagihan hari ini + jatuh tempo + tombol tagih';

  @override
  String get homeWidgetSettingsCard8 =>
      'Setujui pesan yang muncul agar widget ditambahkan 👍';

  @override
  String get homeWidgetSettingsCard9 => 'Tambahkan widget sendiri 📱';

  @override
  String get homeWidgetSettingsCard10 =>
      'HP Anda tidak mengizinkan aplikasi menambahkannya otomatis. Lakukan ini:\n\n1. Tekan lama area kosong di layar utama\n2. Pilih \"Widget\"\n3. Cari \"Kashkool\" lalu seret widget ke layar';

  @override
  String get messageTemplateEditorBottomSheet1 => 'Toko Amanah';

  @override
  String get messageTemplateEditorBottomSheet2 => 'Vodafone Cash: 01012345678';

  @override
  String get messageTemplateEditorBottomSheet3 => 'Budi Santoso';

  @override
  String get messageTemplateEditorBottomSheet4 => 'Template pesan disimpan 👍';

  @override
  String get messageTemplateEditorBottomSheet5 => 'Ubah pesan pengingat 💬';

  @override
  String get messageTemplateEditorBottomSheet6 => 'Template siap: ';

  @override
  String get messageTemplateEditorBottomSheet7 => 'Ramah 😊';

  @override
  String get messageTemplateEditorBottomSheet8 => 'Formal 👔';

  @override
  String get messageTemplateEditorBottomSheet9 => 'Nama toko';

  @override
  String get messageTemplateEditorBottomSheet10 => 'Info pembayaran';

  @override
  String get messageTemplateEditorBottomSheet11 => 'Tanggal transaksi terakhir';

  @override
  String get messageTemplateEditorBottomSheet12 =>
      'Tulis pesan pengingat di sini...';

  @override
  String get messageTemplateEditorBottomSheet13 =>
      'Pratinjau seperti yang diterima pelanggan:';

  @override
  String get messageTemplateEditorBottomSheet14 => 'Simpan template';

  @override
  String shopProfileBottomSheet1(Object trim) {
    return 'Dompet digital: $trim';
  }

  @override
  String get shopProfileBottomSheet2 => 'Info toko disimpan 👍';

  @override
  String get shopProfileBottomSheet3 => 'Nama toko *';

  @override
  String get shopProfileBottomSheet4 => 'mis. Toko Amanah';

  @override
  String get shopProfileBottomSheet5 => 'Silakan isi nama toko';

  @override
  String get shopProfileBottomSheet6 => 'Telepon toko';

  @override
  String get shopProfileBottomSheet7 => 'mis. +2010xxxxxxxx';

  @override
  String get shopProfileBottomSheet8 => 'Alamat toko';

  @override
  String get shopProfileBottomSheet9 => 'mis. Jl. Pasar, sebelah masjid besar';

  @override
  String get shopProfileBottomSheet10 => 'Akun InstaPay';

  @override
  String get shopProfileBottomSheet11 => 'mis. name@instapay';

  @override
  String get shopProfileBottomSheet12 => 'Nomor Vodafone Cash / dompet digital';

  @override
  String get shopProfileBottomSheet13 => 'Jenis usaha';

  @override
  String get shopProfileBottomSheet14 => 'Usaha lainnya 🏪';

  @override
  String get shopProfileBottomSheet15 => 'Aktifkan cicilan';

  @override
  String get shopProfileBottomSheet16 =>
      'Tampilkan tombol cicilan & jadwal bayar';

  @override
  String get shopProfileBottomSheet17 => 'Simpan perubahan';

  @override
  String get cloudAccountButton1 => 'Akun & cadangan cloud ☁️';

  @override
  String get cloudAccountButton2 => 'Cadangan cloud';

  @override
  String get cloudAccountButton3 => 'Masuk dengan Google';

  @override
  String get cloudSyncRunning => 'جاري المزامنة…';

  @override
  String get emailAuthTitleLogin => 'تسجيل الدخول بالبريد الإلكتروني';

  @override
  String get emailAuthTitleRegister => 'إنشاء حساب بالبريد الإلكتروني';

  @override
  String get emailAuthName => 'الاسم';

  @override
  String get emailAuthNameRequired => 'اكتب اسمك';

  @override
  String get emailAuthEmail => 'البريد الإلكتروني';

  @override
  String get emailAuthPassword => 'كلمة المرور';

  @override
  String get emailAuthInvalidEmail => 'اكتب بريدًا إلكترونيًا صحيحًا';

  @override
  String get emailAuthShortPassword => 'كلمة المرور لازم تكون 8 أحرف على الأقل';

  @override
  String get emailAuthGoToRegister => 'مستخدم جديد؟ أنشئ حسابًا';

  @override
  String get emailAuthGoToLogin => 'لديك حساب؟ سجّل الدخول';

  @override
  String get emailAuthRegister => 'إنشاء حساب';

  @override
  String get emailAuthLogin => 'تسجيل الدخول بالبريد';

  @override
  String get emailAuthCancel => 'إلغاء';

  @override
  String get emailAuthSigningIn => 'جارٍ تسجيل الدخول…';

  @override
  String get accountSwitchTitle => 'تبديل الحساب';

  @override
  String get accountSwitchWarning =>
      'بيانات المحل الموجودة على هذا الجهاز هتتمسح عند تبديل الحساب، وبعدها هنحمّل بيانات الحساب الجديد من السحابة.';

  @override
  String get accountSwitchUnbackedWarning =>
      'في بيانات على الجهاز مش موجودة في آخر نسخة احتياطية. اعمل نسخة قبل التبديل؛ لو كملت، هتتمسح البيانات المحلية ومش هتقدر تسترجع غير اللي اتنسخ للسحابة.';

  @override
  String get accountSwitchCancel => 'إلغاء التبديل';

  @override
  String get accountSwitchContinue => 'متابعة ومسح البيانات';

  @override
  String get accountSwitchChooseMethod =>
      'اختار طريقة تسجيل الدخول للحساب الجديد';

  @override
  String get accountSwitchFileCleanupWarning =>
      'الحساب اتبدّل، لكن بعض ملفات الصور المحلية ما اتمسحتش.';

  @override
  String get cloudBackupCard1 => 'Sebentar…';

  @override
  String get cloudBackupCard2 => 'Terjadi masalah, coba lagi';

  @override
  String get cloudBackupCard3 => 'Membuka akun Google…';

  @override
  String cloudBackupCard4(Object email) {
    return 'Masuk sebagai $email ✓';
  }

  @override
  String get cloudBackupCard5 => 'Cadangan diunggah dengan catatan ⚠️';

  @override
  String cloudBackupCard6(Object uploaded, Object rejected, Object n) {
    return '$uploaded data diunggah, $rejected ditolak:\n\n$n';
  }

  @override
  String get cloudBackupCard7 => 'Semua data sudah ada di cloud ✓';

  @override
  String cloudBackupCard8(Object uploaded) {
    return '$uploaded data diunggah ke cloud ✓';
  }

  @override
  String get cloudBackupCard9 => 'Memuat toko di akun Anda…';

  @override
  String get cloudBackupCard10 => 'Belum ada cadangan cloud untuk akun ini';

  @override
  String get cloudBackupCard11 => 'Pilih toko';

  @override
  String get cloudBackupCard12 => ' (karyawan)';

  @override
  String get cloudBackupCard13 => 'Pulihkan dari cloud?';

  @override
  String cloudBackupCard14(Object name) {
    return 'Kami akan mengunduh cadangan \"$name\" dari cloud dan menambahkannya ke HP ini.\n\n';
  }

  @override
  String get cloudBackupCard15 =>
      'Tidak ada yang dihapus: data yang hanya ada di HP ini tetap ada, dan perubahan setelah cadangan terakhir dibiarkan.';

  @override
  String get cloudBackupCard16 => 'Ya, pulihkan';

  @override
  String get cloudBackupCard17 => 'Dipulihkan 🎉';

  @override
  String cloudBackupCard18(Object keptLocal) {
    return ', dan $keptLocal data dibiarkan karena versi HP lebih baru';
  }

  @override
  String cloudBackupCard19(Object records, Object keptLocal) {
    return '$records data dipulihkan$keptLocal.';
  }

  @override
  String get cloudBackupCard20 =>
      ' Tutup dan buka lagi aplikasi untuk memperbarui layar.';

  @override
  String get cloudBackupCard21 => 'Tutup aplikasi';

  @override
  String get cloudBackupCard22 => 'Keluar dari akun?';

  @override
  String get cloudBackupCard23 =>
      'Data tetap di HP dan cloud, tetapi pencadangan berhenti sampai Anda masuk lagi.';

  @override
  String get cloudBackupCard24 => 'Keluar';

  @override
  String get cloudBackupCard25 => 'Tidak tersedia di versi ini';

  @override
  String get cloudBackupCard26 => 'Cadangan cloud';

  @override
  String get cloudBackupCard27 =>
      'Masuk dengan Google agar data tersimpan online. Jika HP hilang, pulihkan di HP lain.';

  @override
  String get cloudBackupCard28 => 'Belum ada cadangan';

  @override
  String cloudBackupCard29(Object last) {
    return 'Cadangan terakhir: $last';
  }

  @override
  String get cloudBackupCard30 => 'Mengunggah…';

  @override
  String get cloudBackupCard31 => 'Menunggu internet — akan diunggah otomatis';

  @override
  String get cloudBackupCard32 => 'Unggahan berhenti, akan dicoba lagi';

  @override
  String get cloudBackupCard33 => 'Semua sudah diunggah ✓';

  @override
  String get cloudBackupCard34 => 'Diunggah otomatis saat online';

  @override
  String get cloudBackupCard35 => 'Cadangkan sekarang';

  @override
  String get cloudBackupCard36 => 'Pulihkan data di HP ini';

  @override
  String get cloudBackupCard37 =>
      'Untuk HP baru atau setelah instal ulang — tidak menghapus apa pun';

  @override
  String get cloudBackupCard38 => 'Keluar';

  @override
  String get onboardingScreen1 => 'Toko saya';

  @override
  String get onboardingScreen3 => 'Menyiapkan Kashkool';

  @override
  String get onboardingScreen4 => 'Lanjut: jenis usaha';

  @override
  String get onboardingScreen5 => 'Selamat datang di Kashkool! 👋';

  @override
  String get onboardingScreen6 =>
      'Buku digital untuk utang, pengingat WhatsApp, dan cicilan — tanpa ribet.';

  @override
  String get onboardingScreen7 => 'Nama toko *';

  @override
  String get onboardingScreen8 => 'mis. Toko Amanah / Bintang Ponsel';

  @override
  String get onboardingScreen9 => 'Isi nama toko (minimal 2 karakter)';

  @override
  String get onboardingScreen10 => 'Telepon toko (opsional)';

  @override
  String get onboardingScreen11 =>
      'Tampil di nota, laporan, dan pesan WhatsApp';

  @override
  String get onboardingScreen12 => 'Toko kelontong & swalayan';

  @override
  String get onboardingScreen13 => 'Utang harian & tutup kas cepat';

  @override
  String get onboardingScreen14 => 'HP & aksesori';

  @override
  String get onboardingScreen15 => 'Data perangkat, cicilan aktif otomatis';

  @override
  String get onboardingScreen16 => 'Elektronik & peralatan rumah';

  @override
  String get onboardingScreen17 =>
      'Kontrak jual kredit, cicilan aktif otomatis';

  @override
  String get onboardingScreen18 => 'Apotek & kosmetik';

  @override
  String get onboardingScreen19 => 'Batas utang & utang resep';

  @override
  String get onboardingScreen20 => 'Usaha lainnya';

  @override
  String get onboardingScreen21 => 'Buku fleksibel untuk semua jenis usaha';

  @override
  String get onboardingScreen22 => 'Apa jenis usaha Anda?';

  @override
  String get onboardingScreen23 =>
      'Kami akan menyesuaikan aplikasi dengan usaha Anda.';

  @override
  String get onboardingScreen24 => 'Mendukung cicilan';

  @override
  String get onboardingScreen25 => 'Aktifkan rencana cicilan';

  @override
  String get onboardingScreen26 =>
      'Bisa diaktifkan/nonaktifkan kapan saja di Pengaturan';

  @override
  String get onboardingScreen27 => 'Pastikan pengingat sampai 🔔';

  @override
  String get onboardingScreen28 =>
      'Agar Kashkool bisa mengingatkan tagihan dan cicilan setiap hari:';

  @override
  String get onboardingScreen29 => 'Izin notifikasi';

  @override
  String get onboardingScreen30 => 'Notifikasi aktif ✅';

  @override
  String get onboardingScreen31 =>
      'Kami perlu izin notifikasi untuk mengirim ringkasan tagihan harian';

  @override
  String get onboardingScreen32 => 'Izinkan notifikasi';

  @override
  String onboardingScreen33(Object brandName) {
    return 'Perlindungan latar belakang ($brandName)';
  }

  @override
  String get onboardingScreen34 => 'Cegah aplikasi dimatikan di latar belakang';

  @override
  String get onboardingScreen35 => 'Buka pengaturan baterai';

  @override
  String get onboardingScreen36 => 'Siap mulai! 🚀';

  @override
  String get onboardingScreen37 => 'Info toko disimpan. Mau mulai dari mana?';

  @override
  String get onboardingScreen38 => '+ Tambah pelanggan pertama';

  @override
  String get onboardingScreen39 =>
      'Catat pelanggan pertama dan langsung catat utang serta pembayaran';

  @override
  String get onboardingScreen42 => 'Lewati ke layar utama';

  @override
  String get supplierWithBalance1 => 'Sabtu';

  @override
  String get supplierWithBalance2 => 'Minggu';

  @override
  String get supplierWithBalance3 => 'Senin';

  @override
  String get supplierWithBalance4 => 'Selasa';

  @override
  String get supplierWithBalance5 => 'Rabu';

  @override
  String get supplierWithBalance6 => 'Kamis';

  @override
  String get supplierWithBalance7 => 'Jumat';

  @override
  String get trashScreen1 => 'Pelanggan';

  @override
  String get trashScreen2 => 'Transaksi';

  @override
  String get trashScreen3 => 'Pemasok';

  @override
  String get trashScreen4 => 'Pengeluaran';

  @override
  String get trashScreen5 => 'Cicilan';

  @override
  String trashScreen6(Object title) {
    return '\"$title\" dikembalikan ✓';
  }

  @override
  String get trashScreen7 => 'Gagal mengembalikan, coba lagi';

  @override
  String get trashScreen8 => 'Sampah 🗑️';

  @override
  String get trashScreen9 =>
      'Apa pun yang dihapus masuk ke sini dan tidak hilang. Bisa dikembalikan kapan saja, termasuk di cadangan cloud.';

  @override
  String get trashScreen10 => 'Gagal memuat item terhapus';

  @override
  String get trashScreen11 => 'Sampah kosong ✨';

  @override
  String trashScreen12(Object deletedAt) {
    return 'Dihapus $deletedAt';
  }

  @override
  String get trashScreen13 => 'Kembalikan';

  @override
  String get trashScreen14 => 'Sampah';

  @override
  String get trashScreen15 => 'Lihat dan kembalikan item terhapus';

  @override
  String trashScreen16(Object count) {
    return '$count item — bisa dikembalikan';
  }

  @override
  String get trashRepository1 => 'Sewa';

  @override
  String get trashRepository2 => 'Listrik';

  @override
  String get trashRepository3 => 'Gaji';

  @override
  String get trashRepository4 => 'Perlengkapan';

  @override
  String get trashRepository5 => 'Bayar pemasok';

  @override
  String get trashRepository6 => 'Pengeluaran';

  @override
  String get trashRepository7 => 'Saya berutang';

  @override
  String get trashRepository8 => 'Pembayaran';

  @override
  String get trashRepository9 => 'Saya bayar';

  @override
  String get trashRepository10 => 'Tidak diketahui';

  @override
  String trashRepository11(Object itemDescription) {
    return 'Cicilan: $itemDescription';
  }

  @override
  String pdfStatementService1(Object sanitizedName, Object dateStr) {
    return 'Laporan_${sanitizedName}_$dateStr.pdf';
  }

  @override
  String get pdfStatementService2 => 'Laporan rekening pelanggan';

  @override
  String pdfStatementService3(Object customerName) {
    return 'Pelanggan: $customerName';
  }

  @override
  String pdfStatementService4(Object phone) {
    return 'Telepon: $phone';
  }

  @override
  String pdfStatementService5(Object periodDescription) {
    return 'Periode: $periodDescription';
  }

  @override
  String get pdfStatementService6 => 'Saldo sebelum periode ini:';

  @override
  String get pdfStatementService7 => 'Tanggal';

  @override
  String get pdfStatementService8 => 'Keterangan';

  @override
  String get pdfStatementService9 => 'Saldo';

  @override
  String pdfStatementService10(Object periodDebitsPiasters) {
    return 'Total belanja / utang: $periodDebitsPiasters';
  }

  @override
  String pdfStatementService11(Object periodCreditsPiasters) {
    return 'Total dibayar: $periodCreditsPiasters';
  }

  @override
  String get pdfStatementService12 => 'Saldo akhir terutang:';

  @override
  String pdfStatementService13(Object trim) {
    return 'Cara bayar: $trim';
  }

  @override
  String get pdfStatementService14 => 'Dibuat dengan Kashkool — coba gratis:';

  @override
  String get statementCalculator1 => 'Semua transaksi';

  @override
  String get statementCalculator2 => 'Januari';

  @override
  String get statementCalculator3 => 'Februari';

  @override
  String get statementCalculator4 => 'Maret';

  @override
  String get statementCalculator5 => 'April';

  @override
  String get statementCalculator6 => 'Mei';

  @override
  String get statementCalculator7 => 'Juni';

  @override
  String get statementCalculator8 => 'Juli';

  @override
  String get statementCalculator9 => 'Agustus';

  @override
  String get statementCalculator10 => 'September';

  @override
  String get statementCalculator11 => 'Oktober';

  @override
  String get statementCalculator12 => 'November';

  @override
  String get statementCalculator13 => 'Desember';

  @override
  String statementCalculator14(Object startDate, Object endDate) {
    return 'Dari $startDate sampai $endDate';
  }

  @override
  String statementCalculator15(Object startDate) {
    return 'Sejak $startDate';
  }

  @override
  String statementCalculator16(Object endDate) {
    return 'Sampai $endDate';
  }

  @override
  String growthFooter1(Object shopCode) {
    return '—\nDibuat dengan Kashkool 📒 Coba gratis: $shopCode';
  }

  @override
  String growthFooter2(Object shopCode) {
    return 'Saya pakai Kashkool 📒 untuk mencatat pelanggan, pemasok, dan laci kas tanpa buku kertas.\nSangat mudah dan bisa tanpa internet. Coba gratis:\n$shopCode';
  }

  @override
  String get notificationService1 => 'Penagihan harian';

  @override
  String get notificationService2 => 'Pengingat pelanggan yang jatuh tempo';

  @override
  String notificationService3(Object dueCount, Object amountStr) {
    return '$dueCount pelanggan berutang $amountStr — ketuk untuk menagih';
  }

  @override
  String get notificationService4 => 'Pengingat tagihan harian 📒';

  @override
  String get backupService1 => 'File database tidak ditemukan';

  @override
  String backupService2(Object dateStr) {
    return 'Cadangan Kashkool - $dateStr';
  }

  @override
  String get backupService3 => 'File yang dipilih tidak ada';

  @override
  String get backupService4 => 'File rusak atau tidak lengkap';

  @override
  String get backupService5 => 'Format file salah (bukan file Kashkool)';

  @override
  String get backupService6 => 'File tidak berisi database Kashkool';

  @override
  String get backupService7 => 'Database di dalam file rusak';

  @override
  String get backupService8 => 'Bukan database SQLite yang valid';

  @override
  String get backupService9 => 'File cadangan tidak valid';

  @override
  String get backupService10 => 'File database tidak ada di arsip';

  @override
  String get googleAuthService1 => 'Cadangan cloud belum diatur di versi ini';

  @override
  String get googleAuthService2 =>
      'Google tidak mengembalikan data masuk, coba lagi';

  @override
  String get googleAuthService3 => 'Masuk dibatalkan';

  @override
  String googleAuthService4(Object codeName) {
    return 'Gagal masuk dengan Google ($codeName)';
  }

  @override
  String get cloudApi1 => 'Alamat server belum diatur di versi ini';

  @override
  String get cloudApi2 => 'Masuk dengan Google dulu';

  @override
  String get cloudApi3 => 'Tidak ada internet, coba lagi';

  @override
  String get cloudApi4 => 'Server terlalu lama merespons, coba lagi';

  @override
  String get cloudApi5 => 'Sesi berakhir, masuk lagi dengan Google';

  @override
  String get cloudApi6 => 'Toko ini terdaftar di akun Google lain';

  @override
  String get cloudApi7 => 'Fitur ini perlu langganan';

  @override
  String get cloudApi8 =>
      'Terlalu banyak percobaan, tunggu sebentar lalu coba lagi';

  @override
  String get cloudApi9 => 'Masuk lagi dengan Google';

  @override
  String get cloudApi10 => 'Masuk Google belum diatur di server';

  @override
  String get cloudApi11 => 'Masalah server, coba lagi nanti';

  @override
  String cloudApi12(Object code) {
    return 'Terjadi masalah ($code)';
  }

  @override
  String get cloudApi13 => 'البريد الإلكتروني مستخدم بالفعل';

  @override
  String get cloudApi14 => 'البريد الإلكتروني أو كلمة المرور غير صحيحة';

  @override
  String get cloudBackupService1 => 'Masuk Google tidak tersedia';

  @override
  String get cloudBackupService2 => 'Lengkapi info toko di Pengaturan dulu';

  @override
  String get cloudBackupService3 => 'Menyiapkan data toko…';

  @override
  String cloudBackupService4(Object length, Object changesLength) {
    return 'Mengunggah $length dari $changesLength…';
  }

  @override
  String get cloudBackupService5 => 'Selesai ✓';

  @override
  String cloudBackupService6(Object changesLength) {
    return 'Mengunduh data… ($changesLength)';
  }

  @override
  String cloudBackupService7(Object changesLength) {
    return 'Menyimpan $changesLength data di HP…';
  }

  @override
  String get cloudBackupService8 => 'Toko';

  @override
  String autoBackupCoordinator1(Object rejected) {
    return '$rejected data tidak terunggah';
  }

  @override
  String get autoBackupCoordinator2 => 'Terjadi masalah, akan dicoba lagi';

  @override
  String get customerRating1 => 'Pelanggan baru (kurang dari 3 transaksi)';

  @override
  String get customerRating2 => 'Lunas dan bayar tepat waktu';

  @override
  String customerRating3(Object oldestUnpaidAgeDays) {
    return 'Terlambat: utang terlama $oldestUnpaidAgeDays hari dan melewati batas';
  }

  @override
  String get customerRating4 => 'Melewati batas utang pelanggan';

  @override
  String get customerRating5 => 'Hanya berutang hari ini, akun lancar';

  @override
  String customerRating6(Object oldestUnpaidAgeDays) {
    return 'Utang terlama baru $oldestUnpaidAgeDays hari (aman)';
  }

  @override
  String customerRating7(Object oldestUnpaidAgeDays) {
    return 'Utang terlama $oldestUnpaidAgeDays hari (lewat 45 hari)';
  }

  @override
  String customerRating8(Object oldestUnpaidAgeDays) {
    return 'Utang terlama $oldestUnpaidAgeDays hari (perlu dipantau)';
  }

  @override
  String get whatsappTemplate1 =>
      'Halo {customer_name} 👋\nIni dari {shop_name}.\nSaldo Anda saat ini: {balance}\nTransaksi terakhir: {last_transaction_date} - {last_transaction_amount}\nUntuk membayar: {payment_info}\nTerima kasih sudah berbelanja 🙏';

  @override
  String get whatsappTemplate2 =>
      'Yth. {customer_name},\nKami mengingatkan bahwa saldo Anda di {shop_name} saat ini {balance}.\nTransaksi terakhir: {last_transaction_date} ({last_transaction_amount})\nPilihan pembayaran: {payment_info}\nHormat kami.';

  @override
  String get whatsappTemplate3 =>
      'Halo {customer_name} 👋\nIni dari {shop_name}.\nMengingatkan cicilan ({item}) jatuh tempo — cicilan ke-{installment_number} dari {installment_count}:\nJumlah tagihan: {amount}\nJatuh tempo: {due_date}\nTotal sisa: {remaining_total}\nPilihan pembayaran: {payment_info}\nTerima kasih atas ketepatan Anda 🙏';

  @override
  String get whatsappTemplate4 => 'Tunai di toko atau transfer';

  @override
  String get money1 => 'EGP';

  @override
  String get batteryOptimizationHelper1 => 'XOS / HiOS';

  @override
  String get batteryOptimizationHelper2 => 'Buka aplikasi Phone Master.';

  @override
  String get batteryOptimizationHelper3 =>
      'Masuk ke \"Auto-start\" dan aktifkan Kashkool.';

  @override
  String get batteryOptimizationHelper4 =>
      'Di pengaturan aplikasi, buka \"Baterai\" dan pilih \"Tidak dibatasi\".';

  @override
  String get batteryOptimizationHelper5 =>
      'Di aplikasi terbaru, tarik aplikasi ke bawah untuk menguncinya 🔒.';

  @override
  String get batteryOptimizationHelper6 => 'MIUI / HyperOS';

  @override
  String get batteryOptimizationHelper7 =>
      'Buka pengaturan aplikasi dan aktifkan \"Autostart\".';

  @override
  String get batteryOptimizationHelper8 =>
      'Di \"Penghemat baterai\", pilih \"Tanpa batasan\".';

  @override
  String get batteryOptimizationHelper9 =>
      'Di aplikasi terbaru, tekan lama Kashkool lalu pilih ikon gembok 🔒.';

  @override
  String get batteryOptimizationHelper10 => 'ColorOS / Realme UI';

  @override
  String get batteryOptimizationHelper11 =>
      'Pengaturan aplikasi -> Penggunaan baterai, aktifkan \"Izinkan aktivitas latar belakang\".';

  @override
  String get batteryOptimizationHelper12 => 'Aktifkan \"Auto-launch\".';

  @override
  String get batteryOptimizationHelper13 =>
      'Di aplikasi terbaru, ketuk titik tiga lalu pilih \"Kunci\".';

  @override
  String get batteryOptimizationHelper14 => 'One UI';

  @override
  String get batteryOptimizationHelper15 =>
      'Buka Pengaturan -> Perawatan perangkat -> Baterai.';

  @override
  String get batteryOptimizationHelper16 =>
      'Buka \"Batas penggunaan latar belakang\".';

  @override
  String get batteryOptimizationHelper17 =>
      'Tambahkan Kashkool ke \"Aplikasi tidak pernah tidur\".';

  @override
  String get batteryOptimizationHelper18 => 'EMUI / MagicOS';

  @override
  String get batteryOptimizationHelper19 =>
      'Buka Pengaturan -> Baterai -> Peluncuran aplikasi.';

  @override
  String get batteryOptimizationHelper20 =>
      'Cari \"Kashkool\", ubah ke manual, lalu aktifkan Auto-launch dan Jalankan di latar belakang.';

  @override
  String get batteryOptimizationHelper21 => 'Pengaturan sistem';

  @override
  String get batteryOptimizationHelper22 => 'Lindungi notifikasi sistem';

  @override
  String get batteryOptimizationHelper23 =>
      'Buka info aplikasi di pengaturan HP.';

  @override
  String get batteryOptimizationHelper24 =>
      'Buka \"Baterai\" lalu pilih \"Tidak dibatasi\".';

  @override
  String get batteryOptimizationHelper25 =>
      'Pastikan mode hemat daya ekstrem mati agar pengingat masuk.';

  @override
  String get homeWidgetService1 => 'Tidak ada';

  @override
  String get homeWidgetService2 => '1 pelanggan';

  @override
  String get homeWidgetService3 => '2 pelanggan';

  @override
  String homeWidgetService4(Object count) {
    return '$count pelanggan';
  }

  @override
  String get pinLockScreen1 => 'PIN salah, coba lagi';

  @override
  String get pinLockScreen2 => 'PIN tidak cocok, coba lagi';

  @override
  String get pinLockScreen3 => 'Sidik jari tidak tersedia atau belum diatur';

  @override
  String get pinLockScreen4 => 'Selamat datang di Kashkool 📒';

  @override
  String get pinLockScreen5 => 'Atur PIN baru';

  @override
  String get pinLockScreen6 => 'Masukkan ulang PIN untuk konfirmasi';

  @override
  String get pinLockScreen7 => 'Masukkan PIN 4 digit';

  @override
  String get pinLockScreen8 => 'Pilih 4 angka yang mudah diingat';

  @override
  String get pinLockScreen9 => 'Ketik angka yang sama lagi';

  @override
  String get pinLockScreen10 => 'Sidik jari';

  @override
  String get pinLockScreen11 => 'Hapus';

  @override
  String get securityService1 => 'Konfirmasi identitas untuk membuka Kashkool';

  @override
  String get settingsLanguageTitle => 'Bahasa';

  @override
  String get settingsLanguageSystem => 'Bahasa HP (otomatis)';
}
