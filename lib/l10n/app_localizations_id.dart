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
  String get navInventory => 'Inventaris';

  @override
  String get navCashDrawer => 'Laci Kas';

  @override
  String get inventoryTitle => 'Inventaris';

  @override
  String get inventoryManageButton => 'Kelola produk dan stok';

  @override
  String get inventorySearchHint => 'Cari produk atau barcode...';

  @override
  String get inventoryAddProduct => 'Produk baru';

  @override
  String get inventoryEditProduct => 'Edit produk';

  @override
  String get inventoryNoProducts => 'Belum ada produk';

  @override
  String get inventoryNoSearchResults => 'Tidak ada produk yang cocok';

  @override
  String get inventoryProductName => 'Nama produk';

  @override
  String get inventoryNameRequired => 'Masukkan nama produk';

  @override
  String get inventoryBarcode => 'Barcode (opsional)';

  @override
  String get inventoryCategory => 'Kategori (opsional)';

  @override
  String get inventoryUnit => 'Satuan penjualan';

  @override
  String get inventoryUnitExample => 'Contoh: pcs, kg, liter';

  @override
  String get inventoryUnitRequired => 'Masukkan satuan penjualan';

  @override
  String get inventoryPurchasePrice => 'Harga beli (EGP)';

  @override
  String get inventorySalePrice => 'Harga jual (EGP)';

  @override
  String get inventoryMinimumStock => 'Ingatkan saat stok mencapai';

  @override
  String get inventoryInitialStock => 'Stok saat ini';

  @override
  String get inventoryCurrentStock => 'Stok tersedia';

  @override
  String get inventoryInStock => 'Tersedia';

  @override
  String get inventoryLowStock => 'Stok menipis';

  @override
  String get inventoryAdjustStock => 'Ubah stok';

  @override
  String get inventoryAddStock => 'Tambah stok';

  @override
  String get inventoryRemoveStock => 'Kurangi stok';

  @override
  String get inventoryQuantity => 'Jumlah';

  @override
  String get inventoryNote => 'Catatan (opsional)';

  @override
  String get inventoryMovementHistory => 'Riwayat stok';

  @override
  String get inventoryMovementOpening => 'Stok awal';

  @override
  String get inventoryMovementAdjustment => 'Penyesuaian manual';

  @override
  String get inventoryMovementPurchase => 'Pembelian';

  @override
  String get inventoryMovementSale => 'Penjualan';

  @override
  String get inventoryMovementCustomerReturn => 'Retur pelanggan';

  @override
  String get inventoryMovementSupplierReturn => 'Retur supplier';

  @override
  String get inventoryNoMovements => 'Belum ada pergerakan stok';

  @override
  String get inventorySave => 'Simpan';

  @override
  String get inventoryCancel => 'Batal';

  @override
  String get inventoryDelete => 'Hapus produk';

  @override
  String get inventoryDeleteConfirm =>
      'Produk akan disembunyikan, tapi riwayatnya tetap tersimpan. Yakin?';

  @override
  String get inventoryDeleted => 'Produk dihapus';

  @override
  String get inventoryProductSaved => 'Produk tersimpan';

  @override
  String get inventoryStockSaved => 'Stok diperbarui';

  @override
  String get inventoryInvalidQuantity =>
      'Masukkan jumlah yang benar (maksimal 3 angka desimal)';

  @override
  String get inventoryQuantityRequired => 'Masukkan jumlah lebih dari nol';

  @override
  String get inventoryStockCannotBeNegative =>
      'Stok tidak cukup untuk dikurangi';

  @override
  String get inventoryInvalidPrice =>
      'Masukkan harga yang benar (tidak negatif)';

  @override
  String get inventoryBarcodeExists => 'Barcode sudah dipakai produk lain';

  @override
  String get inventoryUnitChangeNotAllowed =>
      'Satuan tidak bisa diubah setelah ada pergerakan stok';

  @override
  String get inventorySaveFailed =>
      'Gagal menyimpan. Periksa data lalu coba lagi.';

  @override
  String get inventorySupplier => 'Supplier (opsional)';

  @override
  String get inventorySupplierNone => 'Tanpa supplier';

  @override
  String get inventorySupplierFilter => 'Filter berdasarkan supplier';

  @override
  String get inventoryFilterAllSuppliers => 'Semua supplier';

  @override
  String get inventorySupplierProducts => 'Produk supplier';

  @override
  String get inventoryNoSupplierProducts =>
      'Tidak ada produk untuk supplier ini';

  @override
  String get inventorySupplierCardTitle => 'Supplier yang ditugaskan';

  @override
  String get inventoryOrderWhatsApp => 'Pesan lewat WhatsApp';

  @override
  String get supplierReturn => 'Retur ke supplier';

  @override
  String get supplierReturnReason => 'Alasan retur (opsional)';

  @override
  String get supplierReturnSuccess =>
      'Retur berhasil dicatat dan saldo diperbarui';

  @override
  String get purchasePaidAmount => 'Jumlah dibayar sekarang';

  @override
  String get purchasePaymentFull => 'Bayar penuh';

  @override
  String get purchasePaymentPartial => 'Bayar sebagian (sisa kredit)';

  @override
  String get purchasePaymentOnAccount => 'Setoran ke rekening';

  @override
  String get purchasePaymentCredit => 'Kredit penuh';

  @override
  String get purchaseRemainingDebt => 'Sisa utang toko';

  @override
  String get purchaseAdvanceCredit => 'Saldo lebih toko (setoran)';

  @override
  String get profitLossTitle => 'Laba & Rugi';

  @override
  String get profitLossRevenue => 'Total penjualan';

  @override
  String get profitLossCogs => 'Biaya barang terjual';

  @override
  String get profitLossGross => 'Laba kotor';

  @override
  String get profitLossExpenses => 'Biaya operasional';

  @override
  String get profitLossNet => 'Laba / Rugi bersih';

  @override
  String get profitLossMargin => 'Margin laba';

  @override
  String get profitLossPeriodToday => 'Hari ini';

  @override
  String get profitLossPeriodWeek => '7 hari terakhir';

  @override
  String get profitLossPeriodMonth => 'Bulan ini';

  @override
  String get profitLossPeriodAll => 'Semua waktu';

  @override
  String get profitLossPositive => 'Laba bersih';

  @override
  String get profitLossNegative => 'Rugi bersih';

  @override
  String get profitLossCashSectionTitle => 'Laba tunai yang sudah diterima';

  @override
  String get profitLossCashSectionSubtitle =>
      'Laba dari penjualan tunai yang sudah masuk laci setelah dikurangi biaya';

  @override
  String get profitLossCashNet => 'Laba tunai bersih di laci';

  @override
  String get profitLossCashRevenue => 'Penjualan tunai';

  @override
  String get profitLossCashCogs => 'Biaya barang tunai terjual';

  @override
  String get profitLossCashGross => 'Laba kotor tunai';

  @override
  String get profitLossCreditSectionTitle => 'Laba kredit (belum ditagih)';

  @override
  String get profitLossCreditSectionSubtitle =>
      'Laba barang yang dijual kredit dan belum ditagih';

  @override
  String get profitLossCreditGross => 'Laba tertunda di pelanggan';

  @override
  String get profitLossCreditRevenue => 'Penjualan kredit';

  @override
  String get profitLossCreditCogs => 'Biaya barang kredit';

  @override
  String get profitLossTotalExpectedNet =>
      'Total perkiraan laba (tunai + kredit)';

  @override
  String get profitLossCashVsCreditRatio => 'Perbandingan tunai dan kredit';

  @override
  String get shopReportTitle => 'Laporan lengkap toko';

  @override
  String get shopReportInventoryValue => 'Nilai barang toko';

  @override
  String get shopReportAtCost => 'Harga beli (modal)';

  @override
  String get shopReportAtRetail => 'Harga jual (perkiraan)';

  @override
  String get shopReportExpectedProfit => 'Perkiraan laba barang';

  @override
  String get shopReportReceivables => 'Piutang pelanggan';

  @override
  String get shopReportPayables => 'Utang ke supplier';

  @override
  String get shopReportCashDrawer => 'Uang di laci dan brankas';

  @override
  String get shopReportNetWorth => 'Nilai bersih toko';

  @override
  String get shopReportLowStockCount => 'Barang yang stoknya menipis';

  @override
  String get shopReportShare => 'Bagikan laporan via WhatsApp';

  @override
  String get featureManagerTitle => 'Atur fitur toko';

  @override
  String get featureManagerSubtitle =>
      'Tampilkan atau sembunyikan bagian sesuai kebutuhan toko';

  @override
  String get featureManagerNote =>
      'Menyembunyikan fitur tidak menghapus datanya, dan bisa aktif lagi kapan saja.';

  @override
  String get featurePresetTitle => 'Pilihan cepat sekali ketuk';

  @override
  String get featurePresetSimple => 'Buku utang saja';

  @override
  String get featurePresetSimpleDesc =>
      'Fokus penuh pada piutang dan penagihan pelanggan';

  @override
  String get featurePresetGrocery => 'Toko kelontong & swalayan';

  @override
  String get featurePresetGroceryDesc =>
      'Jual cepat + stok & supplier + laci harian';

  @override
  String get featurePresetElectronics => 'Toko hp & elektronik';

  @override
  String get featurePresetElectronicsDesc =>
      'Kredit + stok + jual cepat & supplier';

  @override
  String get featurePresetAll => 'Aktifkan semua fitur';

  @override
  String get featurePresetAllDesc => 'Buka semua kemampuan aplikasi';

  @override
  String get featureQuickPosTitle => 'Jual cepat & kasir (POS)';

  @override
  String get featureQuickPosDesc =>
      'Layar untuk buat faktur tunai cepat dan hitung kembalian';

  @override
  String get featureSuppliersTitle => 'Supplier & faktur pembelian';

  @override
  String get featureSuppliersDesc =>
      'Pantau utang supplier, pesanan stok, dan retur';

  @override
  String get featureInstallmentsTitle => 'Buku kredit bulanan';

  @override
  String get featureInstallmentsDesc =>
      'Jadwal kredit, kontrak, dan pengingat tanggal bayar';

  @override
  String get featureInventoryTitle => 'Stok & pengelolaan barang';

  @override
  String get featureInventoryDesc =>
      'Catat barang, peringatan stok tipis, dan riwayat pergerakan';

  @override
  String get featureCashDrawerTitle => 'Kas & laci harian';

  @override
  String get featureCashDrawerDesc =>
      'Hitung uang harian, selisih, dan tutup hari';

  @override
  String get featureProfitLossTitle => 'Laba rugi & laporan';

  @override
  String get featureProfitLossDesc =>
      'Hitung laba bersih setelah biaya dan laporan modal';

  @override
  String get featureOffersTitle => 'Pesan promo & ucapan';

  @override
  String get featureOffersDesc =>
      'Kirim promo dan ucapan ke pelanggan lewat WhatsApp';

  @override
  String get featureCoreAlwaysActive => 'Pelanggan & penagihan selalu aktif';

  @override
  String get featureStatusActive => 'Aktif';

  @override
  String get featureStatusHidden => 'Disembunyikan';

  @override
  String get quickPosTitle => 'Jual cepat';

  @override
  String get quickPosOpen => 'Buka jual cepat';

  @override
  String get quickPosSearch => 'Cari nama atau ketik barcode...';

  @override
  String get quickPosProducts => 'Produk';

  @override
  String get quickPosAdd => 'Tambah ke penjualan';

  @override
  String get quickPosAvailable => 'Tersedia';

  @override
  String get quickPosCart => 'Barang dijual';

  @override
  String get quickPosEmptyCart => 'Tambah produk untuk mulai jualan';

  @override
  String get quickPosQuantity => 'Jumlah';

  @override
  String get quickPosQuantityInvalid =>
      'Masukkan jumlah yang benar lebih dari nol';

  @override
  String get quickPosCash => 'Tunai';

  @override
  String get quickPosCredit => 'Kredit pelanggan';

  @override
  String get quickPosSelectCustomer => 'Pilih pelanggan';

  @override
  String get quickPosCustomerRequired => 'Pilih pelanggan untuk jualan kredit';

  @override
  String get quickPosTotal => 'Total';

  @override
  String get quickPosCompleteSale => 'Selesaikan penjualan';

  @override
  String get quickPosSaving => 'Menyimpan penjualan...';

  @override
  String get quickPosSaleSaved => 'Penjualan dicatat';

  @override
  String get quickPosSaveFailed => 'Gagal mencatat penjualan. Coba lagi.';

  @override
  String get quickPosInsufficientStock => 'Stok tidak cukup untuk jumlah ini';

  @override
  String get quickPosCashDayClosed =>
      'Laci hari ini sudah ditutup. Buka lagi untuk catat jualan tunai.';

  @override
  String get quickPosLoadFailed => 'Gagal memuat produk';

  @override
  String get quickPosCustomersLoadFailed => 'Gagal memuat pelanggan';

  @override
  String get quickPosSaleNote => 'Jual cepat';

  @override
  String get supplierPurchasesTitle => 'Pembelian supplier';

  @override
  String get supplierPurchaseNew => 'Catat pembelian';

  @override
  String get supplierPurchaseInvoiceNumber => 'Nomor faktur (opsional)';

  @override
  String get supplierPurchasePaymentType => 'Cara pembayaran';

  @override
  String get supplierPurchaseCash => 'Tunai';

  @override
  String get supplierPurchaseCredit => 'Kredit';

  @override
  String get supplierPurchaseAddProduct => 'Pilih produk';

  @override
  String get supplierPurchaseItems => 'Barang faktur';

  @override
  String get supplierPurchaseQuantity => 'Jumlah';

  @override
  String get supplierPurchaseUnitCost => 'Harga beli per satuan (EGP)';

  @override
  String get supplierPurchaseAddLine => 'Tambah barang';

  @override
  String get supplierPurchaseNoLines => 'Tambah minimal satu produk';

  @override
  String get supplierPurchaseSave => 'Simpan faktur';

  @override
  String get supplierPurchaseTotal => 'Total faktur';

  @override
  String get supplierPurchaseSaved => 'Faktur pembelian dicatat';

  @override
  String get supplierPurchaseSaveFailed => 'Gagal menyimpan faktur. Coba lagi.';

  @override
  String get supplierPurchaseNoInvoices =>
      'Belum ada faktur pembelian dari supplier ini';

  @override
  String get supplierPurchaseDetails => 'Detail faktur';

  @override
  String get supplierPurchaseReturn => 'Retur ke supplier';

  @override
  String get supplierPurchaseReturned => 'Diretur';

  @override
  String get supplierPurchaseRemaining => 'Bisa diretur';

  @override
  String get supplierPurchaseReturnQuantity => 'Jumlah retur';

  @override
  String get supplierPurchaseReturnSaved =>
      'Retur dicatat dan saldo supplier dikurangi';

  @override
  String get supplierPurchaseReturnLimit =>
      'Jumlah melebihi batas retur atau stok yang ada';

  @override
  String get supplierCreditNote => 'Saldo kredit dari retur';

  @override
  String get supplierPurchaseInvalidInput =>
      'Periksa jumlah dan harga lalu coba lagi';

  @override
  String get supplierPurchaseLoadError => 'Gagal memuat faktur pembelian';

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
  String get customerPhoneHint => '010xxxxxxxx';

  @override
  String get customerPhoneInvalid => 'Nomor tidak valid (010, 011, 012, 015)';

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
  String get statementFormatReceipt => 'Struk Termal (80mm)';

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
      'https://wa.me/201005083126?text=Halo%2C%20saya%20punya%20pertanyaan%20tentang%20Kashkool';

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
  String get shopProfileBottomSheet7 => 'mis. 010xxxxxxxx';

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
  String get onboardingScreen2 =>
      'Pelanggan contoh ditambahkan untuk mencoba aplikasi, bisa dihapus kapan saja';

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
  String get onboardingScreen40 => 'Coba dulu dengan data contoh 💡';

  @override
  String get onboardingScreen41 =>
      'Menambah dua pelanggan contoh untuk mencoba Kashkool (hapus dengan sekali ketuk)';

  @override
  String get onboardingScreen42 => 'Lewati ke layar utama';

  @override
  String get shopRepository1 => 'Ahmad (contoh)';

  @override
  String get shopRepository2 => 'Belanja rumah tangga';

  @override
  String get shopRepository3 => 'Mahmud (contoh)';

  @override
  String get shopRepository4 => 'Stok awal bulan';

  @override
  String get shopRepository5 => 'Bayar tunai ke rekening';

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

  @override
  String get cloudDeleteAccountTitle => 'Hapus akun cloud saya';

  @override
  String get cloudDeleteAccountSubtitle =>
      'Menghapus permanen cadangan cloud dan akun — data di HP tetap ada';

  @override
  String get cloudDeleteAccountConfirmTitle => 'Hapus akun secara permanen?';

  @override
  String get cloudDeleteAccountConfirmBody =>
      'Kami akan menghapus akun Anda dan semua cadangan cloud toko milik Anda. Ini tidak bisa dibatalkan. Data di HP ini tetap ada.';

  @override
  String get cloudDeleteAccountConfirmButton => 'Hapus permanen';

  @override
  String get cloudDeleteAccountDone => 'Akun cloud Anda telah dihapus';

  @override
  String get authFirstTimeTitle => 'Selamat datang di Kashkool! 👋';

  @override
  String get authFirstTimeQuestion => 'Sudah punya akun atau pengguna baru?';

  @override
  String get authHaveAccount => 'Sudah punya akun';

  @override
  String get authHaveAccountSubtitle =>
      'Masuk dan semua data toko langsung kembali';

  @override
  String get authNewUser => 'Pengguna baru';

  @override
  String get authNewUserSubtitle =>
      'Mulai Kashkool baru dan siapkan toko langkah demi langkah';

  @override
  String get authContinueGuest => 'Lanjut sebagai tamu (tanpa akun)';

  @override
  String get authContinueGuestSubtitle =>
      'Pakai aplikasi lokal tanpa internet sama sekali';

  @override
  String get authLogin => 'Masuk';

  @override
  String get authRegister => 'Buat akun baru';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Kata sandi';

  @override
  String get authPasswordConfirm => 'Konfirmasi kata sandi';

  @override
  String get authNameOptional => 'Nama (opsional)';

  @override
  String get authLoginButton => 'Masuk';

  @override
  String get authRegisterButton => 'Daftar';

  @override
  String get authOrGoogle => 'Atau lanjut dengan akun Google';

  @override
  String get authSignInWithGoogle => 'Masuk dengan akun Google';

  @override
  String get authSignInWithGoogleSubtitle =>
      'Sinkronisasi cloud dan pemulihan data toko otomatis';

  @override
  String get authSwitchAccount => 'Ganti akun';

  @override
  String get authSwitchAccountSubtitle =>
      'Pilih akun lain atau masuk dengan akun baru';

  @override
  String get authAddAccount => '+ Masuk dengan akun lain';

  @override
  String get authCurrentAccount => 'Akun yang sedang aktif';

  @override
  String get authPasswordsDontMatch => 'Kata sandi tidak sama';

  @override
  String get authPasswordTooShort => 'Kata sandi minimal 6 karakter';

  @override
  String get authInvalidEmail => 'Masukkan email yang benar';

  @override
  String get authLoginSuccess => 'Berhasil masuk 🎉';

  @override
  String get authRegisterSuccess => 'Akun berhasil dibuat 🎉';

  @override
  String authSwitchedTo(Object email) {
    return 'Beralih ke akun: $email';
  }

  @override
  String get cloudApiEmailTaken => 'Email ini sudah terdaftar, coba masuk';

  @override
  String get cloudApiInvalidCredentials => 'Email atau kata sandi salah';

  @override
  String get authBackupBeforeSwitchTitle => 'Perhatian: data belum tersimpan!';

  @override
  String get authBackupBeforeSwitchBody =>
      'Ada data yang belum dicadangkan ke cloud untuk akun ini. Jika ganti akun sekarang, data lokal akan terhapus dan tidak bisa kembali kecuali Anda buat cadangan dulu.';

  @override
  String get authBackupFirst => 'Cadangkan dulu';

  @override
  String get authSwitchWithoutBackup => 'Ganti dan hapus data lokal';

  @override
  String get authFetchingData => 'Mengambil data Anda dari cloud…';

  @override
  String get authEmailLoginButton => 'Masuk dengan email';

  @override
  String get authEmailRegisterButton => 'Daftar dengan email';

  @override
  String get authWipingData => 'Menghapus data lokal dan mengganti akun…';

  @override
  String get offersBroadcasterTitle => 'Pesan promo & ucapan';

  @override
  String get offersBroadcasterSubtitle =>
      'Kirim promo dan ucapan ke pelanggan lewat WhatsApp sekali ketuk dan gratis';

  @override
  String get offersTemplateSection => '1. Pilih template';

  @override
  String get offersAudienceSection => '2. Pilih penerima';

  @override
  String get offersMessageSection => '3. Isi pesan & pratinjau';

  @override
  String get offersTemplateRamadan => 'Ramadan berkah 🌙';

  @override
  String get offersTemplateEid => 'Selamat Hari Raya 🎉';

  @override
  String get offersTemplateBackToSchool => 'Masuk sekolah 📚';

  @override
  String get offersTemplateNewOffer => 'Promo baru 🎁';

  @override
  String get offersTemplateCustom => 'Pesan sendiri ✍️';

  @override
  String get offersAudienceAllWithPhone => 'Semua pelanggan yang punya nomor';

  @override
  String get offersAudienceGoodRating => 'Pelanggan yang rajin bayar (hijau)';

  @override
  String get offersAudienceActive30Days => 'Aktif 30 hari terakhir';

  @override
  String get offersAudienceManual => 'Pilih sendiri';

  @override
  String get offersTipSpam =>
      '💡 Tips: jangan kirim lebih dari 50 pelanggan sekali agar WhatsApp tidak membatasi.';

  @override
  String offersStartCampaign(Object count) {
    return 'Mulai antrean kirim ($count pelanggan)';
  }

  @override
  String offersResumeCampaign(Object pending) {
    return 'Lanjutkan kampanye ($pending tersisa)';
  }

  @override
  String get offersDiscardCampaign => 'Mulai kampanye baru saja';

  @override
  String get offersQueueTitle => 'Antrean pengiriman';

  @override
  String offersProgressLabel(Object sent, Object total, Object percent) {
    return 'Mengirim $sent dari $total pelanggan ($percent%)';
  }

  @override
  String get offersSendViaWhatsApp => 'Kirim via WhatsApp';

  @override
  String get offersSkipCustomer => 'Lewati pelanggan';

  @override
  String get offersPauseQueue => 'Jeda dan kembali';

  @override
  String get offersCampaignCompleteTitle => 'Selesai! 🎉';

  @override
  String get offersCampaignCompleteSubtitle =>
      'Semua pesan berhasil dikirim ke pelanggan Anda.';

  @override
  String get offersNoRecipients =>
      'Tidak ada pelanggan yang cocok dan punya nomor telepon';

  @override
  String offersSelectManualCustomers(Object count) {
    return 'Pilih pelanggan ($count dipilih)';
  }

  @override
  String get offersSampleCustomerName => 'Muhammad Ahmad';

  @override
  String get offersInsertPlaceholderHint =>
      'Ketuk untuk sisipkan variabel ke pesan:';

  @override
  String get offersDefaultRamadanText =>
      'Semoga selalu sehat ya {customer_name}, dalam bulan Ramadan yang berkah. Semoga Anda dan keluarga diberi berkah dari {shop_name} 🌙✨';

  @override
  String get offersDefaultEidText =>
      'Selamat Hari Raya untuk Anda dan keluarga {customer_name}, semoga selalu sehat dan bahagia dari {shop_name} 🎉🐑';

  @override
  String get offersDefaultBackToSchoolText =>
      'Tahun ajaran baru yang menyenangkan dan sukses untuk anak-anak kita {customer_name}. Semua kebutuhan tersedia di {shop_name} 📚✏️';

  @override
  String get offersDefaultNewOfferText =>
      'Halo {customer_name}! Ada promo dan diskon baru spesial untuk Anda di {shop_name}, mari mampir kapan saja 🎁🔥';

  @override
  String get offersDefaultCustomText =>
      'Halo {customer_name}, salam dari {shop_name} 👋';

  @override
  String offersSentSuccessPrompt(Object name) {
    return 'Apakah pesan ke $name berhasil dikirim?';
  }

  @override
  String get offersYesSent => 'Ya, sudah dikirim';

  @override
  String get offersNotSent => 'Belum dikirim';

  @override
  String get offersPreviewCardTitle => 'Pratinjau pesan pelanggan';

  @override
  String get offersIncludeGrowthFooter =>
      'Tambahkan tanda tangan Kashkool di akhir pesan';

  @override
  String offersCampaignActiveBanner(Object sent, Object total) {
    return 'Ada kampanye lama yang belum selesai ($sent dari $total terkirim)';
  }

  @override
  String get notificationServiceInstallmentsChannelName => 'Pengingat kredit';

  @override
  String get notificationServiceInstallmentsChannelDesc =>
      'Pengingat tanggal kredit yang jatuh tempo dan terlambat';

  @override
  String get notificationServiceInstallmentsTitle =>
      'Pengingat kredit jatuh tempo 🔔';

  @override
  String notificationServiceInstallmentsBody(Object count, Object amountStr) {
    return 'Ada $count kredit jatuh tempo total $amountStr — ketuk untuk lanjut';
  }

  @override
  String get notificationServiceBackupChannelName => 'Pengingat cadangan';

  @override
  String get notificationServiceBackupChannelDesc =>
      'Pengingat berkala untuk menyimpan data buku Anda agar tidak hilang';

  @override
  String get notificationServiceBackupTitle =>
      'Perhatian: perlu buat cadangan ⚠️';

  @override
  String notificationServiceBackupBody(Object days) {
    return 'Sudah $days hari tanpa cadangan. Ketuk untuk menyimpan data Anda sekarang.';
  }

  @override
  String get notificationServiceTestTitle => 'Notifikasi uji dari Kashkool 🚀';

  @override
  String get notificationServiceTestBody =>
      'Notifikasi berfungsi dan sampai tepat waktu 👍';

  @override
  String get notificationServiceSettingsReminderTime =>
      'Waktu pengingat harian';

  @override
  String get notificationServiceSettingsReminderTimeSubtitle =>
      'Jam harian untuk mengingatkan penagihan dan kredit jatuh tempo';

  @override
  String get notificationServiceSettingsStatus => 'Notifikasi aplikasi';

  @override
  String get notificationServiceSettingsStatusActive => 'Aktif dan berjalan ✓';

  @override
  String get notificationServiceSettingsStatusDisabled =>
      'Nonaktif — ketuk untuk izinkan';

  @override
  String get notificationServiceSettingsSendTest =>
      'Kirim notifikasi uji sekarang';

  @override
  String get notificationServiceSettingsSendTestSubtitle =>
      'Cek notifikasi dan suara langsung di ponsel Anda';

  @override
  String get notificationServiceSettingsSendTestSuccess =>
      'Notifikasi uji terkirim! Cek panel notifikasi 👍';

  @override
  String get notificationServiceDailyScheduledTitle => 'Waktunya menagih 💰';

  @override
  String get notificationServiceDailyScheduledBody =>
      'Buka Kashkool untuk melihat pelanggan yang jatuh tempo hari ini';

  @override
  String get navHome => 'Beranda';

  @override
  String get moreSectionShop => 'Alat toko';

  @override
  String get moreSectionApp => 'Komunikasi & pengaturan';

  @override
  String get moreInventorySubtitle => 'Produk, harga, dan jumlah';

  @override
  String get moreCashDrawerSubtitle => 'Penutupan harian dan pengeluaran';

  @override
  String get moreInstallmentsTitle => 'Cicilan';

  @override
  String get moreInstallmentsSubtitle =>
      'Rencana cicilan dan tanggal jatuh tempo';

  @override
  String get moreOffersSubtitle => 'Penawaran dan ucapan untuk pelanggan';

  @override
  String get moreSettingsSubtitle => 'Info toko, keamanan, dan cadangan';

  @override
  String get moreProfitLossSubtitle => 'Laba bersih dan beban operasional toko';

  @override
  String get moreShopReportSubtitle => 'Total stok, kas, dan piutang';

  @override
  String get notificationServiceGeneralChannelDesc =>
      'Saluran pemberitahuan umum dan pengujian Kashkool';

  @override
  String get notificationServiceGeneralChannelName =>
      'Pemberitahuan Umum dan Uji Coba';

  @override
  String notificationServiceLowStockBody(Object remainingStock) {
    return 'Tersisa di stok: $remainingStock';
  }

  @override
  String get notificationServiceLowStockChannelDesc =>
      'Peringatan instan saat barang mencapai batas minimum';

  @override
  String get notificationServiceLowStockChannelName =>
      'Peringatan Stok Menipis';

  @override
  String get notificationServiceLowStockNoSupplierSuffix =>
      ' Ketuk untuk memeriksa stok dan memperbarui';

  @override
  String notificationServiceLowStockSupplierSuffix(Object supplierName) {
    return ' Pemasok: $supplierName — ketuk untuk memesan via WhatsApp';
  }

  @override
  String notificationServiceLowStockTitle(Object productName) {
    return '⚠️ Peringatan stok menipis: $productName';
  }

  @override
  String get notificationServiceMultipleLowStockBody =>
      'Periksa daftar barang yang menipis untuk segera dipesan ke pemasok.';

  @override
  String notificationServiceMultipleLowStockTitle(Object count) {
    return '⚠️ $count barang stoknya menipis';
  }

  @override
  String get pdfInvoiceCash => 'Tunai';

  @override
  String get pdfInvoiceCredit => 'Faktur Penjualan Kredit (Bon)';

  @override
  String pdfInvoiceNumber(Object shortSaleId) {
    return 'Nomor Faktur: #$shortSaleId';
  }

  @override
  String get pdfInvoicePayCash => 'Dibayar Tunai';

  @override
  String get pdfInvoicePayOnCredit => 'Dicatat Kredit (Utang Akun)';

  @override
  String get pdfInvoicePaymentMethod => 'Metode Pembayaran:';

  @override
  String pdfInvoicePhone(Object phone) {
    return 'Telepon: $phone';
  }

  @override
  String get pdfInvoicePrice => 'Harga';

  @override
  String get pdfInvoiceThankYou => 'Terima kasih atas kunjungan Anda!';

  @override
  String get pdfInvoiceTotal => 'Total';

  @override
  String get pdfPreviewErrorLabel => 'Gagal membuat berkas';

  @override
  String get pdfPreviewPreparing => 'Menyiapkan dokumen PDF...';

  @override
  String get pdfPreviewPrint => 'Cetak Langsung';

  @override
  String get pdfPreviewRetry => 'Coba Lagi';

  @override
  String get pdfPreviewShare => 'Bagikan PDF';

  @override
  String get pdfReportAvailableAmount => 'Jumlah Tersedia';

  @override
  String get pdfReportCashInDrawer => 'Kas di Laci';

  @override
  String get pdfReportCashProfitNote =>
      'Catatan Kashkool: Laba bersih kas adalah uang nyata yang masuk ke laci setelah biaya dan beban. Laba kredit berubah menjadi kas setelah pelunasan.';

  @override
  String get pdfReportCashVsCreditTitle =>
      'Perbandingan Penjualan Tunai vs Kredit';

  @override
  String get pdfReportCount => 'Jumlah';

  @override
  String get pdfReportCustomerUnit => 'pelanggan';

  @override
  String get pdfReportDateLabel => 'Tanggal';

  @override
  String get pdfReportDebtSection => '2. Utang dan Piutang';

  @override
  String get pdfReportDigitalBalance => 'Saldo Bank / Dompet Digital';

  @override
  String get pdfReportGrandTotal => 'Total Keseluruhan';

  @override
  String get pdfReportGrowthFooter =>
      'Dibuat dengan aplikasi Kashkool — Buku Kas & Utang Gratis';

  @override
  String get pdfReportInventoryAtCost => 'Nilai Stok pada Harga Beli (Modal)';

  @override
  String get pdfReportInventoryAtRetail => 'Nilai Stok pada Harga Jual';

  @override
  String get pdfReportInventorySection => '1. Stok dan Gudang';

  @override
  String get pdfReportInventorySubtitle =>
      'Laporan penilaian persediaan dan status ketersediaan barang';

  @override
  String get pdfReportInventoryTitle => 'Laporan Penilaian Persediaan Umum';

  @override
  String get pdfReportInvoiceUnit => 'faktur';

  @override
  String get pdfReportItemUnit => 'barang';

  @override
  String get pdfReportLiquiditySection => '3. Kas dan Likuiditas yang Tersedia';

  @override
  String get pdfReportLowStockLabel => 'Menipis';

  @override
  String get pdfReportLowStockNeedOrder => 'perlu dipesan';

  @override
  String get pdfReportLowStockSubtitle =>
      'Daftar lengkap barang yang menipis, modal, dan harga jual';

  @override
  String get pdfReportLowStockTitle => 'Laporan Stok Menipis & Pesanan Pemasok';

  @override
  String get pdfReportMinimum => 'Batas Min';

  @override
  String get pdfReportMovementUnit => 'transaksi';

  @override
  String get pdfReportNetWorthFormula =>
      '= (Stok Modal + Kas Laci & Bank + Piutang) - Utang Pemasok';

  @override
  String get pdfReportOperatingExpenses =>
      'Biaya Operasional (dipotong dari kas laci)';

  @override
  String get pdfReportOutOfStock => 'Stok Habis';

  @override
  String get pdfReportParty => 'Pihak / Kategori';

  @override
  String get pdfReportProductCountLabel => 'Total Jumlah Produk';

  @override
  String get pdfReportProfitLossTitle => 'Laporan Laba dan Rugi';

  @override
  String get pdfReportRowNumber => 'No';

  @override
  String get pdfReportSalesCount => 'Jumlah Penjualan';

  @override
  String get pdfReportSalesRevenue => 'Pendapatan Penjualan';

  @override
  String get pdfReportShopOverviewSubtitle =>
      'Pemeriksaan menyeluruh atas stok, piutang, dan kas';

  @override
  String get pdfReportShopOverviewTitle => 'Laporan Posisi Keuangan Toko';

  @override
  String get pdfReportSource => 'Sumber / Pos';

  @override
  String get pdfReportStatus => 'Status';

  @override
  String get pdfReportSupplier => 'Pemasok';

  @override
  String get pdfReportSupplierPhone => 'Telepon Pemasok';

  @override
  String get pdfReportSupplierUnit => 'pemasok';

  @override
  String get pdfReportTotalCashAvailable => 'Total Kas Tersedia';

  @override
  String get pdfReportTotalCost => 'Total Modal';

  @override
  String get pdfReportTotalCostLabel => 'Total Nilai Modal';

  @override
  String get pdfReportTotalNetProfit => 'Total Laba Bersih Toko';

  @override
  String get pdfReportTotalProducts => 'Total Produk';

  @override
  String get pdfReportValueCountHeader => 'Jumlah / Nilai';

  @override
  String get quickPosDoneNewSale => 'Selesai · Penjualan Baru';

  @override
  String quickPosFetchLastInvoiceFailed(Object e) {
    return 'Gagal memuat faktur sebelumnya: $e';
  }

  @override
  String get quickPosInvoiceOptions => 'Opsi Faktur';

  @override
  String quickPosInvoiceTotal(Object total) {
    return 'Total Faktur: $total';
  }

  @override
  String quickPosItemsCount(Object count) {
    return '$count barang di keranjang';
  }

  @override
  String get quickPosLastInvoiceNoItems =>
      'Faktur sebelumnya kosong tanpa barang';

  @override
  String get quickPosNoItemsToPreview => 'Tidak ada barang untuk pratinjau';

  @override
  String get quickPosNoItemsToPrint => 'Tidak ada barang untuk dicetak';

  @override
  String get quickPosNoPreviousInvoices =>
      'Belum ada faktur penjualan sebelumnya';

  @override
  String quickPosOpenInvoiceFailed(Object e) {
    return 'Gagal membuka faktur: $e';
  }

  @override
  String get quickPosOutOfStock => 'Stok habis';

  @override
  String get quickPosPaymentMethod => 'Metode Pembayaran';

  @override
  String get quickPosPreviewBeforeSave => 'Pratinjau faktur sebelum menyimpan';

  @override
  String get quickPosPreviewCurrentInvoice => 'Pratinjau faktur saat ini';

  @override
  String quickPosPreviewFailed(Object e) {
    return 'Gagal membuka pratinjau: $e';
  }

  @override
  String get quickPosPreviewFileName => 'pratinjau_faktur.pdf';

  @override
  String get quickPosPreviewLabel => 'Pratinjau';

  @override
  String get quickPosPreviewPrintCurrent => 'Cetak dan Pratinjau Faktur';

  @override
  String get quickPosPreviewSharePdf => 'Pratinjau dan Bagikan PDF';

  @override
  String quickPosPrintFailed(Object e) {
    return 'Gagal mencetak faktur: $e';
  }

  @override
  String get quickPosPrintLastInvoice => 'Cetak ulang faktur terakhir';

  @override
  String get quickPosPrintThermalReceipt => 'Cetak Struk Termal (80mm)';

  @override
  String get quickPosReceiveCash => 'Terima Tunai';

  @override
  String get quickPosRecordOnAccount => 'Catat ke Akun';

  @override
  String quickPosSaleInvoiceFileName(Object shortId) {
    return 'faktur_penjualan_$shortId.pdf';
  }

  @override
  String quickPosSaleInvoiceTitle(Object shortId) {
    return 'Faktur Penjualan #$shortId';
  }

  @override
  String get quickPosSaleSavedSuccessfully => 'Penjualan berhasil disimpan!';

  @override
  String get quickPosSaveAndPrint => 'Simpan & Cetak';

  @override
  String get quickPosSaveAndPrintTooltip =>
      'Simpan penjualan dan langsung cetak struk';

  @override
  String get quickPosSavingAndPrinting =>
      'Penjualan disimpan, sedang mencetak...';

  @override
  String get quickPosTapToAdd => 'Ketuk untuk tambah';

  @override
  String get quickPosTapToAddToCart => 'Ketuk barang untuk tambah ke keranjang';

  @override
  String genericError(Object err) {
    return 'Terjadi kesalahan: $err';
  }

  @override
  String get inventoryPdfExportTooltip =>
      'Cetak dan ekspor laporan inventaris ke PDF';

  @override
  String inventoryPdfFileNameFull(Object dateStr) {
    return 'inventaris_lengkap_$dateStr.pdf';
  }

  @override
  String inventoryPdfFileNameLowStock(Object dateStr) {
    return 'stok_menipis_$dateStr.pdf';
  }

  @override
  String get inventoryPdfMenuFull => 'Cetak Laporan Inventaris Lengkap';

  @override
  String get inventoryPdfMenuLowStock => 'Cetak Hanya Barang Menipis';

  @override
  String get inventoryPdfTitleFull => 'Laporan Penilaian Persediaan Umum';

  @override
  String get inventoryPdfTitleLowStock => 'Laporan Barang Stok Menipis';

  @override
  String get notificationServiceSettingsSendTestFailure =>
      'Gagal mengirim pemberitahuan uji coba — periksa izin pemberitahuan ponsel';

  @override
  String get printExportPdf => 'Cetak dan Ekspor PDF';

  @override
  String get profitLossAccountingTipBody =>
      'Laba bersih kas adalah uang nyata di laci setelah membayar biaya dan beban. Laba kredit menjadi kas saat pelunasan.';

  @override
  String get profitLossAccountingTipTitle => 'Tips Akuntansi dari Kashkool';

  @override
  String get profitLossCashBadge => 'Tunai';

  @override
  String get profitLossCreditBadge => 'Kredit';

  @override
  String profitLossNetCalculation(Object netCash, Object netCredit) {
    return '= $netCash Tunai + $netCredit Kredit';
  }

  @override
  String profitLossRecordedSales(Object salesCount) {
    return '$salesCount faktur penjualan tercatat';
  }

  @override
  String profitLossReportFileName(Object dateStr) {
    return 'laporan_laba_rugi_$dateStr.pdf';
  }

  @override
  String get profitLossReportTitle => 'Laporan Laba dan Rugi';

  @override
  String restockAvailable(Object stock, Object unit) {
    return 'Tersedia: $stock $unit';
  }

  @override
  String get restockCopiedToClipboard =>
      'Pesan pesanan barang disalin ke papan klip!';

  @override
  String restockError(Object err) {
    return 'Gagal memuat produk: $err';
  }

  @override
  String get restockLinkProductsHint =>
      'Hubungkan produk ke pemasok ini di layar inventaris untuk memesan dengan 1 sentuhan.';

  @override
  String get restockMessageFooter =>
      'Mohon konfirmasi penerimaan pesanan dan jadwal pengiriman.';

  @override
  String restockMessageGreeting(Object supplierName) {
    return 'Halo $supplierName';
  }

  @override
  String get restockMessageHeader =>
      'Kami membutuhkan pasokan barang berikut untuk toko:';

  @override
  String restockMessageItem(Object name, Object qty, Object unit) {
    return '• $name — dibutuhkan: $qty $unit';
  }

  @override
  String restockMessageShop(Object shopName) {
    return 'Dari toko $shopName';
  }

  @override
  String get restockMessageThanks => 'Terima kasih banyak!';

  @override
  String get restockSelectProductsHint =>
      'Pilih barang dan jumlah yang dibutuhkan untuk dipesan via WhatsApp:';

  @override
  String get restockSendWhatsApp => 'Kirim Pesanan via WhatsApp';

  @override
  String get shopReportCashInDrawerLabel => 'Kas di Laci:';

  @override
  String get shopReportCopiedToClipboard =>
      'Laporan posisi keuangan disalin ke papan klip!';

  @override
  String get shopReportCustomersWithDues =>
      'Pelanggan dengan piutang tertunggak:';

  @override
  String get shopReportDigitalBalanceLabel => 'Saldo Bank / Dompet Digital:';

  @override
  String shopReportFileName(Object dateStr) {
    return 'posisi_keuangan_toko_$dateStr.pdf';
  }

  @override
  String shopReportLowStockOf(Object count, Object total) {
    return '$count barang dari total $total';
  }

  @override
  String get shopReportNetWorthFormula =>
      '= (Stok Modal + Kas Laci & Bank + Piutang) - Utang Pemasok';

  @override
  String shopReportSupplierCount(Object count) {
    return '$count pemasok';
  }

  @override
  String get shopReportSuppliersOwed => 'Pemasok dengan utang belum lunas:';

  @override
  String get shopReportTextCashAvailable =>
      '--- Kas dan Likuiditas yang Tersedia ---';

  @override
  String shopReportTextCashInDrawer(Object amount) {
    return '• Kas di Laci: $amount';
  }

  @override
  String shopReportTextDate(Object dateStr) {
    return 'Tanggal: $dateStr';
  }

  @override
  String shopReportTextDigitalBalance(Object amount) {
    return '• Saldo Bank / Dompet: $amount';
  }

  @override
  String shopReportTextExpectedProfit(Object profit) {
    return '• Estimasi Laba dari Stok: $profit';
  }

  @override
  String get shopReportTextFooter => 'Laporan dibuat dengan aplikasi Kashkool';

  @override
  String get shopReportTextInventory => '--- Stok dan Gudang ---';

  @override
  String shopReportTextNetWorth(Object netWorth) {
    return 'Nilai Bersih Toko: $netWorth';
  }

  @override
  String shopReportTextPayables(Object amount, Object count) {
    return '• Utang ke Pemasok: $amount ($count pemasok)';
  }

  @override
  String shopReportTextProductCounts(Object total, Object low) {
    return '• Total Produk: $total ($low barang menipis)';
  }

  @override
  String shopReportTextReceivables(Object amount, Object count) {
    return '• Piutang Pelanggan: $amount ($count pelanggan)';
  }

  @override
  String shopReportTextShop(Object shopName) {
    return 'Toko: $shopName';
  }

  @override
  String get shopReportTextTitle => '=== Laporan Posisi Keuangan Toko ===';

  @override
  String shopReportTextTotalCash(Object amount) {
    return '• Total Kas Tersedia: $amount';
  }

  @override
  String get shopReportTotalCashLabel => 'Total Kas Tersedia:';

  @override
  String get shopReportTotalCustomerDues => 'Total Piutang Pelanggan:';

  @override
  String get shopReportTotalSupplierDues => 'Total Utang ke Pemasok:';
}
