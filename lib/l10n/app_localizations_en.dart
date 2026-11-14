// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Kashkool';

  @override
  String get navCustomers => 'Customers';

  @override
  String get navCollection => 'Collection';

  @override
  String get navSuppliers => 'Suppliers';

  @override
  String get navInventory => 'Inventory';

  @override
  String get navCashDrawer => 'Cash Drawer';

  @override
  String get inventoryTitle => 'Inventory';

  @override
  String get inventoryManageButton => 'Manage products and stock';

  @override
  String get inventorySearchHint => 'Search products or barcode...';

  @override
  String get inventoryAddProduct => 'New product';

  @override
  String get inventoryEditProduct => 'Edit product';

  @override
  String get inventoryNoProducts => 'No products added yet';

  @override
  String get inventoryNoSearchResults => 'No products match your search';

  @override
  String get inventoryProductName => 'Product name';

  @override
  String get inventoryNameRequired => 'Enter a product name';

  @override
  String get inventoryBarcode => 'Barcode (optional)';

  @override
  String get inventoryCategory => 'Category (optional)';

  @override
  String get inventoryUnit => 'Selling unit';

  @override
  String get inventoryUnitExample => 'For example: piece, kg, liter';

  @override
  String get inventoryUnitRequired => 'Enter a selling unit';

  @override
  String get inventoryPurchasePrice => 'Purchase price (EGP)';

  @override
  String get inventorySalePrice => 'Selling price (EGP)';

  @override
  String get inventoryMinimumStock => 'Alert me when stock reaches';

  @override
  String get inventoryInitialStock => 'Current stock';

  @override
  String get inventoryCurrentStock => 'In stock';

  @override
  String get inventoryInStock => 'Available';

  @override
  String get inventoryLowStock => 'Low stock';

  @override
  String get inventoryAdjustStock => 'Adjust stock';

  @override
  String get inventoryAddStock => 'Add to stock';

  @override
  String get inventoryRemoveStock => 'Remove from stock';

  @override
  String get inventoryQuantity => 'Quantity';

  @override
  String get inventoryNote => 'Note (optional)';

  @override
  String get inventoryMovementHistory => 'Stock movements';

  @override
  String get inventoryMovementOpening => 'Opening stock';

  @override
  String get inventoryMovementAdjustment => 'Manual adjustment';

  @override
  String get inventoryMovementPurchase => 'Purchase';

  @override
  String get inventoryMovementSale => 'Sale';

  @override
  String get inventoryMovementCustomerReturn => 'Customer return';

  @override
  String get inventoryMovementSupplierReturn => 'Supplier return';

  @override
  String get inventoryNoMovements => 'No stock movements yet';

  @override
  String get inventorySave => 'Save';

  @override
  String get inventoryCancel => 'Cancel';

  @override
  String get inventoryDelete => 'Delete product';

  @override
  String get inventoryDeleteConfirm =>
      'The product will be hidden, but its movement history will remain. Continue?';

  @override
  String get inventoryDeleted => 'Product deleted';

  @override
  String get inventoryProductSaved => 'Product saved';

  @override
  String get inventoryStockSaved => 'Stock updated';

  @override
  String get inventoryInvalidQuantity =>
      'Enter a valid quantity (up to 3 decimal places)';

  @override
  String get inventoryQuantityRequired => 'Enter a quantity greater than zero';

  @override
  String get inventoryStockCannotBeNegative =>
      'There is not enough stock to remove this quantity';

  @override
  String get inventoryInvalidPrice => 'Enter a valid non-negative price';

  @override
  String get inventoryBarcodeExists =>
      'This barcode is already assigned to another product';

  @override
  String get inventoryUnitChangeNotAllowed =>
      'A unit cannot be changed after stock movements exist';

  @override
  String get inventorySaveFailed =>
      'Could not save. Check the details and try again.';

  @override
  String get quickPosTitle => 'Quick sale';

  @override
  String get quickPosOpen => 'Open quick sale';

  @override
  String get quickPosSearch => 'Search name or type barcode...';

  @override
  String get quickPosProducts => 'Products';

  @override
  String get quickPosAdd => 'Add to sale';

  @override
  String get quickPosAvailable => 'Available';

  @override
  String get quickPosCart => 'Sale items';

  @override
  String get quickPosEmptyCart => 'Add products to start a sale';

  @override
  String get quickPosQuantity => 'Quantity';

  @override
  String get quickPosQuantityInvalid =>
      'Enter a valid quantity greater than zero';

  @override
  String get quickPosCash => 'Cash';

  @override
  String get quickPosCredit => 'On customer account';

  @override
  String get quickPosSelectCustomer => 'Choose a customer';

  @override
  String get quickPosCustomerRequired => 'Choose a customer for a credit sale';

  @override
  String get quickPosTotal => 'Total';

  @override
  String get quickPosCompleteSale => 'Complete sale';

  @override
  String get quickPosSaving => 'Saving sale...';

  @override
  String get quickPosSaleSaved => 'Sale recorded';

  @override
  String get quickPosSaveFailed => 'Could not record the sale. Try again.';

  @override
  String get quickPosInsufficientStock =>
      'There is not enough stock for this quantity';

  @override
  String get quickPosCashDayClosed =>
      'Today\'s cash drawer is closed. Reopen it to record a cash sale.';

  @override
  String get quickPosLoadFailed => 'Could not load products';

  @override
  String get quickPosCustomersLoadFailed => 'Could not load customers';

  @override
  String get quickPosSaleNote => 'Quick sale';

  @override
  String get supplierPurchasesTitle => 'Supplier purchases';

  @override
  String get supplierPurchaseNew => 'Record purchase';

  @override
  String get supplierPurchaseInvoiceNumber => 'Invoice number (optional)';

  @override
  String get supplierPurchasePaymentType => 'Payment type';

  @override
  String get supplierPurchaseCash => 'Cash';

  @override
  String get supplierPurchaseCredit => 'On credit';

  @override
  String get supplierPurchaseAddProduct => 'Choose a product';

  @override
  String get supplierPurchaseItems => 'Invoice items';

  @override
  String get supplierPurchaseQuantity => 'Quantity';

  @override
  String get supplierPurchaseUnitCost => 'Unit cost (EGP)';

  @override
  String get supplierPurchaseAddLine => 'Add item';

  @override
  String get supplierPurchaseNoLines => 'Add at least one product';

  @override
  String get supplierPurchaseSave => 'Save invoice';

  @override
  String get supplierPurchaseTotal => 'Invoice total';

  @override
  String get supplierPurchaseSaved => 'Purchase invoice recorded';

  @override
  String get supplierPurchaseSaveFailed =>
      'Could not save the purchase invoice. Try again.';

  @override
  String get supplierPurchaseNoInvoices =>
      'No purchase invoices for this supplier';

  @override
  String get supplierPurchaseDetails => 'Invoice details';

  @override
  String get supplierPurchaseReturn => 'Return to supplier';

  @override
  String get supplierPurchaseReturned => 'Returned';

  @override
  String get supplierPurchaseRemaining => 'Available to return';

  @override
  String get supplierPurchaseReturnQuantity => 'Return quantity';

  @override
  String get supplierPurchaseReturnSaved =>
      'Return recorded and supplier balance credited';

  @override
  String get supplierPurchaseReturnLimit =>
      'Quantity exceeds the returnable amount or available stock';

  @override
  String get supplierCreditNote => 'Supplier return credit';

  @override
  String get supplierPurchaseInvalidInput =>
      'Check the quantity and price, then try again';

  @override
  String get supplierPurchaseLoadError => 'Could not load purchase invoices';

  @override
  String get navSettings => 'Settings';

  @override
  String get debt => 'Debt';

  @override
  String get payment => 'Payment';

  @override
  String get settled => 'Settled';

  @override
  String get currency => 'EGP';

  @override
  String get piaster => 'Pt';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get search => 'Search...';

  @override
  String placeholderScreen(String screenName) {
    return '$screenName Screen';
  }

  @override
  String get comingSoon => 'Coming soon in the next step';

  @override
  String get totalReceivablesTitle => 'Total Receivables';

  @override
  String get searchCustomersHint => 'Search name or phone...';

  @override
  String get filterAll => 'All';

  @override
  String get filterHasDebt => 'Has Debt';

  @override
  String get filterSettled => 'Settled';

  @override
  String get filterLate => 'Late';

  @override
  String get sortHighestDebt => 'Highest Debt';

  @override
  String get sortName => 'Name';

  @override
  String get sortLastActivity => 'Last Activity';

  @override
  String get addNewCustomer => 'New Customer';

  @override
  String get addCustomer => 'Add Customer';

  @override
  String get editCustomer => 'Edit Customer';

  @override
  String get customerName => 'Customer Name';

  @override
  String get customerNameHint => 'e.g. Mohamed Hassan';

  @override
  String get customerNameRequired => 'Customer name is required';

  @override
  String get customerNameTooShort => 'Name must be at least 2 characters';

  @override
  String get customerPhone => 'Mobile Number';

  @override
  String get customerPhoneHint => '010xxxxxxxx';

  @override
  String get customerPhoneInvalid => 'Invalid phone number';

  @override
  String get customerNotes => 'Notes';

  @override
  String get customerNotesHint => 'e.g. Neighbor 2nd floor';

  @override
  String get creditLimit => 'Credit Limit (Optional)';

  @override
  String get creditLimitHint => 'e.g. 1000';

  @override
  String get noCustomersTitle => 'Your ledger is empty!';

  @override
  String get noCustomersSubtitle =>
      'Tap the button below to add your first customer and start tracking effortlessly';

  @override
  String get noSearchResults => 'No customers found matching your search';

  @override
  String get duplicateCustomerWarning =>
      'Warning: A customer with the same name or phone already exists';

  @override
  String get customerDetails => 'Customer Details';

  @override
  String get callCustomer => 'Call';

  @override
  String get deleteCustomer => 'Delete Customer';

  @override
  String get deleteCustomerConfirm => 'Confirm Customer Deletion';

  @override
  String deleteCustomerWarningDebt(String amount) {
    return 'Warning! This customer has an outstanding balance of $amount. Are you sure you want to delete?';
  }

  @override
  String deleteCustomerSafeConfirm(String name) {
    return 'Are you sure you want to delete customer $name?';
  }

  @override
  String get customerDeleted => 'Customer deleted successfully';

  @override
  String get customerSaved => 'Customer saved successfully';

  @override
  String get lastActivityNever => 'No previous transactions';

  @override
  String lastActivityDate(String date) {
    return 'Last activity: $date';
  }

  @override
  String creditLimitLabel(String amount) {
    return 'Credit Limit: $amount';
  }

  @override
  String get creditLimitExceeded => 'Credit limit exceeded!';

  @override
  String get heOwes => 'Owes';

  @override
  String get hePaid => 'Credit balance';

  @override
  String get currentBalance => 'Current Balance';

  @override
  String get noTransactionsYet => 'No transactions recorded yet';

  @override
  String get addDebtTitle => 'Record debt';

  @override
  String get addPaymentTitle => 'Record payment';

  @override
  String get amountLabel => 'Amount';

  @override
  String get amountRequired => 'Please enter a valid amount greater than 0';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get date => 'Date';

  @override
  String get pickDate => 'Pick Date';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get methodCash => 'Cash';

  @override
  String get methodInstapay => 'InstaPay';

  @override
  String get methodWallet => 'Mobile Wallet';

  @override
  String get methodOther => 'Other';

  @override
  String get noteOptional => 'Note (optional: sugar, oil, card...)';

  @override
  String get voiceDictation => 'Voice Dictation';

  @override
  String get listening => 'Listening... Speak now';

  @override
  String get speechNotAvailable =>
      'Speech-to-text not available on this device';

  @override
  String get attachPhoto => 'Attach Photo';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get removePhoto => 'Remove Photo';

  @override
  String get overpaymentTitle => 'Amount exceeds debt!';

  @override
  String overpaymentMessage(
    String paidAmount,
    String dueAmount,
    String creditAmount,
  ) {
    return 'Paid amount ($paidAmount) is greater than current debt ($dueAmount). Do you want to record the difference ($creditAmount) as customer credit?';
  }

  @override
  String get overpaymentConfirm => 'Yes, record credit';

  @override
  String get transactionSaved => 'Transaction recorded successfully';

  @override
  String get undo => 'Undo';

  @override
  String get transactionUndone => 'Transaction recording undone';

  @override
  String get transactionDetails => 'Transaction Details';

  @override
  String get editTransaction => 'Edit Transaction';

  @override
  String get deleteTransaction => 'Delete Transaction';

  @override
  String get deleteTransactionConfirm =>
      'Are you sure you want to delete this transaction?';

  @override
  String get transactionDeleted => 'Transaction deleted successfully';

  @override
  String get viewPhoto => 'View Photo';

  @override
  String get creditLimitWarningTitle => 'Credit Limit Warning';

  @override
  String creditLimitExceededDialog(
    String customerName,
    String newTotal,
    String limit,
  ) {
    return '$customerName balance will become $newTotal — while their limit is $limit';
  }

  @override
  String get saveAnyway => 'Save Anyway';

  @override
  String get changeLimit => 'Change Limit';

  @override
  String get newCreditLimit => 'New Credit Limit';

  @override
  String get limitUpdated => 'Credit limit updated successfully';

  @override
  String get totalPayablesTitle => 'Total Payables';

  @override
  String get netMarketPosition => 'Net Market Position';

  @override
  String netReceivables(String amount) {
    return 'Net Receivables: $amount';
  }

  @override
  String netPayables(String amount) {
    return 'Net Payables: $amount';
  }

  @override
  String get netSettled => 'Balanced (0 EGP)';

  @override
  String get addNewSupplier => 'New Supplier';

  @override
  String get addSupplier => 'Add Supplier';

  @override
  String get editSupplier => 'Edit Supplier';

  @override
  String get supplierName => 'Supplier / Rep Name';

  @override
  String get supplierNameHint => 'e.g. Emad Juhayna Rep';

  @override
  String get supplierNameRequired => 'Supplier name is required';

  @override
  String get company => 'Company Name';

  @override
  String get companyHint => 'e.g. Juhayna, Chipsy';

  @override
  String get visitDay => 'Weekly Visit Day';

  @override
  String get noSpecificDay => 'No specific day';

  @override
  String get supplierNotes => 'Notes';

  @override
  String get supplierNotesHint => 'e.g. Visits around 10 AM';

  @override
  String get noSuppliersTitle => 'Suppliers ledger is empty!';

  @override
  String get noSuppliersSubtitle =>
      'Tap the button below to add your first supplier or company';

  @override
  String get noSupplierSearchResults => 'No suppliers found';

  @override
  String get searchSuppliersHint => 'Search by rep name, company, or phone...';

  @override
  String get supplierDetails => 'Supplier Details';

  @override
  String get iOweHim => 'I owe';

  @override
  String get iPaidHim => 'I paid';

  @override
  String get deleteSupplier => 'Delete Supplier';

  @override
  String get deleteSupplierConfirm => 'Confirm Supplier Deletion';

  @override
  String deleteSupplierWarningDebt(String amount) {
    return 'Warning! You still owe this supplier $amount. Are you sure you want to delete?';
  }

  @override
  String deleteSupplierSafeConfirm(String name) {
    return 'Are you sure you want to delete supplier $name?';
  }

  @override
  String get supplierDeleted => 'Supplier deleted successfully';

  @override
  String get supplierSaved => 'Supplier saved successfully';

  @override
  String visitDayPrefix(String day) {
    return 'Visit Day: $day';
  }

  @override
  String get sortCompany => 'Company';

  @override
  String get sortVisitDay => 'Visit Day';

  @override
  String get dueCustomersTitle => 'Due Collections';

  @override
  String get totalDueTitle => 'Total Due';

  @override
  String dueCustomersCount(int count) {
    return '$count customers';
  }

  @override
  String dueHeaderSummary(int count, String amount) {
    return 'You have $count customers due for $amount';
  }

  @override
  String oldestDebtDays(int days) {
    return 'Oldest debt from $days days ago';
  }

  @override
  String get oldestDebtToday => 'Debt recorded today';

  @override
  String lastReminderDays(int days) {
    return 'Last reminded: $days days ago';
  }

  @override
  String get lastReminderToday => 'Last reminded: Today';

  @override
  String get neverReminded => 'Never reminded yet';

  @override
  String snoozedUntilDate(String date) {
    return 'Snoozed until $date';
  }

  @override
  String get sendWhatsApp => 'WhatsApp';

  @override
  String get sendSms => 'SMS Message';

  @override
  String get moreActions => 'More';

  @override
  String get snooze3Days => 'Snooze 3 days';

  @override
  String get snooze7Days => 'Snooze 1 week';

  @override
  String get cancelSnooze => 'Cancel snooze';

  @override
  String get recordCollectionPayment => 'Record payment';

  @override
  String get didSendMessage => 'Did you send the message?';

  @override
  String didSendMessageDesc(String name) {
    return 'Did you send the reminder to $name via WhatsApp?';
  }

  @override
  String get yesSent => 'Yes, sent';

  @override
  String get notSent => 'No, not sent';

  @override
  String get reminderMarkedSent => 'Reminder recorded successfully';

  @override
  String get snoozedSuccess => 'Reminder snoozed';

  @override
  String get noDueCustomersTitle => 'No collections due today 🎉';

  @override
  String get noDueCustomersSubtitle =>
      'All customers are settled or were reminded recently.';

  @override
  String get whatsAppNotInstalled =>
      'WhatsApp is not installed. Would you like to send an SMS instead?';

  @override
  String get openSms => 'Send SMS';

  @override
  String get growthFooter => '\nSent via Kashkool App 📒';

  @override
  String get statementTitle => 'Statement';

  @override
  String get generateStatement => 'Generate Statement';

  @override
  String get statementAllTime => 'All Time';

  @override
  String get statementThisMonth => 'This Month';

  @override
  String get statementCustomRange => 'Custom Range';

  @override
  String get statementFormatA4 => 'A4 Paper';

  @override
  String get statementFormatReceipt => 'Thermal Receipt (80mm)';

  @override
  String get dateCol => 'Date';

  @override
  String get descriptionCol => 'Description';

  @override
  String get debtCol => 'Debt';

  @override
  String get paymentCol => 'Payment';

  @override
  String get balanceCol => 'Balance';

  @override
  String get startingBalance => 'Opening Balance';

  @override
  String get finalBalance => 'Final Balance';

  @override
  String periodLabel(String period) {
    return 'Period: $period';
  }

  @override
  String statementGeneratedAt(String date) {
    return 'Generated: $date';
  }

  @override
  String get shareStatement => 'Share Statement';

  @override
  String get printStatement => 'Print';

  @override
  String statementShareSubject(String name) {
    return 'Account Statement - $name';
  }

  @override
  String get totalDebits => 'Total Debts';

  @override
  String get totalCredits => 'Total Payments';

  @override
  String get drawerTitle => 'Cash Drawer Closing';

  @override
  String get todayDrawer => 'Today\'s Drawer';

  @override
  String get expectedInDrawer => 'Expected in Drawer';

  @override
  String get openingCash => 'Opening Cash';

  @override
  String get openingCashHint => 'Cash in drawer at start of day';

  @override
  String get editOpeningCash => 'Edit Opening Cash';

  @override
  String get cashSales => 'Cash Sales';

  @override
  String get addCashSales => 'Record Cash Sales';

  @override
  String get cashIn => 'Cash In';

  @override
  String get digitalIn => 'Digital In';

  @override
  String get cashOut => 'Cash Out';

  @override
  String get customerPaymentsCash => 'Customer Payments (Cash)';

  @override
  String get customerPaymentsDigital => 'Customer Payments (Digital)';

  @override
  String get supplierPaymentsCash => 'Supplier Payments (Cash)';

  @override
  String get expensesCash => 'Shop Expenses (Cash)';

  @override
  String get addExpense => 'Record Expense';

  @override
  String get editExpense => 'Edit Expense';

  @override
  String get deleteExpense => 'Delete Expense';

  @override
  String get deleteExpenseConfirm =>
      'Are you sure you want to delete this expense?';

  @override
  String get expenseCategory => 'Expense Category';

  @override
  String get catRent => 'Rent';

  @override
  String get catElectricity => 'Electricity & Utilities';

  @override
  String get catSalary => 'Salaries & Wages';

  @override
  String get catSupplies => 'Supplies & Inventory';

  @override
  String get catSupplierPayment => 'Supplier Payment';

  @override
  String get catOther => 'Other';

  @override
  String get closeDay => 'Close Day';

  @override
  String get reopenDay => 'Reopen Day';

  @override
  String get reopenDayConfirm =>
      'Are you sure you want to reopen this day for editing?';

  @override
  String get dayClosedSuccess => 'Day closed successfully';

  @override
  String get dayReopenedSuccess => 'Day reopened successfully';

  @override
  String get dayIsClosed => 'Day is Closed';

  @override
  String get dayIsOpen => 'Day is Open';

  @override
  String get actualCountLabel => 'Counted Cash in Drawer';

  @override
  String get actualCountHint => 'Count physical cash and enter amount here';

  @override
  String get drawerBalanced => 'Drawer is perfectly balanced 🎉';

  @override
  String get drawerShortage => 'Drawer Shortage';

  @override
  String get drawerSurplus => 'Drawer Surplus';

  @override
  String differenceAmount(String amount) {
    return 'Difference: $amount';
  }

  @override
  String get closeDaySummary => 'Day Closing Summary';

  @override
  String get confirmCloseDay => 'Confirm Closing';

  @override
  String get historyTab => 'History';

  @override
  String get todayTab => 'Today\'s Drawer';

  @override
  String get monthlyTotals => 'Monthly Totals';

  @override
  String get monthlySales => 'Cash Sales';

  @override
  String get monthlyExpenses => 'Cash Expenses';

  @override
  String get monthlyNet => 'Net Drawer Cash';

  @override
  String get drawerNotes => 'Closing Notes (Optional)';

  @override
  String get noExpensesYet => 'No expenses recorded today';

  @override
  String get noHistoryYet => 'No previous days recorded';

  @override
  String get expenseAddedSuccess => 'Expense saved successfully';

  @override
  String get cashSalesAddedSuccess => 'Cash sales recorded successfully';

  @override
  String get openingCashUpdatedSuccess => 'Opening cash updated successfully';

  @override
  String get dayDetails => 'Day Details';

  @override
  String closedAtTime(String time) {
    return 'Closed at: $time';
  }

  @override
  String get readOnlyDayNotice =>
      'This day is closed. To make changes, tap Reopen Day.';

  @override
  String get privacyModeTitle => 'Privacy Mode';

  @override
  String get privacyModeSubtitle =>
      'Hide financial amounts in home & widgets (••••••)';

  @override
  String get shareAppTitle => 'Share the App';

  @override
  String get shareAppSubtitle => 'Send Kashkool to fellow shop owners';

  @override
  String shopCodeLabel(String code) {
    return 'Shop code: $code';
  }

  @override
  String get growthFooterToggleTitle => 'Hide Kashkool signature from messages';

  @override
  String get growthFooterToggleSubtitle => 'Available in the paid plan 🔒';

  @override
  String get codeCopied => 'Code copied';

  @override
  String get main1 => 'Kashkool';

  @override
  String get notebookImportButton1 => 'Move your notebook into the app 📒';

  @override
  String get notebookImportButton2 =>
      'You don\'t need every old entry: just the customer\'s name and what they owe now.';

  @override
  String get notebookImportButton3 => 'Customers and balances';

  @override
  String get notebookImportButton4 =>
      'One line per customer: name, phone and amount owed';

  @override
  String get notebookImportButton5 => 'Old installment plan';

  @override
  String get notebookImportButton6 =>
      'Price, amount paid, remaining installments and next due date';

  @override
  String get notebookImportButton7 => 'Import from notebook';

  @override
  String get oldInstallmentImportScreen1 => 'Next installment date';

  @override
  String get oldInstallmentImportScreen2 => 'Installment saved ✓';

  @override
  String oldInstallmentImportScreen3(
    Object remaining,
    Object countValue,
    Object nextDue,
  ) {
    return '$remaining left over $countValue installments, the first on $nextDue.';
  }

  @override
  String get oldInstallmentImportScreen4 => 'Done';

  @override
  String get oldInstallmentImportScreen5 => 'Another one';

  @override
  String get oldInstallmentImportScreen6 => 'Saving failed. Nothing was saved';

  @override
  String get oldInstallmentImportScreen7 => ' monthly';

  @override
  String get oldInstallmentImportScreen8 => ' weekly';

  @override
  String oldInstallmentImportScreen9(
    Object remaining,
    Object count,
    Object count2,
    Object monthly,
  ) {
    return '$remaining left — $count installments × about $count2$monthly';
  }

  @override
  String get oldInstallmentImportScreen10 => 'Old installment from notebook';

  @override
  String oldInstallmentImportScreen11(Object savedCount) {
    return 'Old installment ($savedCount)';
  }

  @override
  String get oldInstallmentImportScreen12 =>
      'For plans that started before the app: enter the price, what has been paid so far and how many installments are left. The app creates the remaining schedule only and won\'t count past payments in today\'s cash drawer.';

  @override
  String get oldInstallmentImportScreen13 => 'Customer';

  @override
  String get oldInstallmentImportScreen14 => 'Customer name';

  @override
  String get oldInstallmentImportScreen15 =>
      'Type an existing or new customer\'s name';

  @override
  String get oldInstallmentImportScreen16 => 'Enter the customer\'s name';

  @override
  String get oldInstallmentImportScreen17 =>
      'Customer\'s mobile (if new — optional)';

  @override
  String get oldInstallmentImportScreen18 => 'Invalid mobile number';

  @override
  String get oldInstallmentImportScreen19 => 'Installment';

  @override
  String get oldInstallmentImportScreen20 => 'Item';

  @override
  String get oldInstallmentImportScreen21 => 'e.g. Samsung fridge';

  @override
  String get oldInstallmentImportScreen22 => 'Enter the item';

  @override
  String get oldInstallmentImportScreen23 => 'Total price';

  @override
  String get oldInstallmentImportScreen24 => 'EGP';

  @override
  String get oldInstallmentImportScreen25 => 'Required';

  @override
  String get oldInstallmentImportScreen26 => 'Invalid';

  @override
  String get oldInstallmentImportScreen27 => 'Paid so far';

  @override
  String get oldInstallmentImportScreen28 => 'Must be less than the price';

  @override
  String get oldInstallmentImportScreen29 => 'Installments left';

  @override
  String get oldInstallmentImportScreen30 => 'From 1 to 120';

  @override
  String oldInstallmentImportScreen31(Object nextDue) {
    return 'Next: $nextDue';
  }

  @override
  String get oldInstallmentImportScreen32 => 'Monthly';

  @override
  String get oldInstallmentImportScreen33 => 'Weekly';

  @override
  String get oldInstallmentImportScreen34 => 'Guarantor (optional)';

  @override
  String get oldInstallmentImportScreen35 => 'Guarantor\'s name';

  @override
  String get oldInstallmentImportScreen36 => 'Guarantor\'s mobile';

  @override
  String get oldInstallmentImportScreen37 =>
      'Photos of the notebook or contract (optional — stay on this phone)';

  @override
  String get oldInstallmentImportScreen38 =>
      'You can add several photos: notebook pages, the contract, the guarantor\'s ID…';

  @override
  String oldInstallmentImportScreen39(Object photosLength) {
    return '$photosLength photos — will be saved in the customer\'s photos';
  }

  @override
  String get oldInstallmentImportScreen40 => 'Saving…';

  @override
  String get oldInstallmentImportScreen41 => 'Save installment';

  @override
  String get notebookImportScreen1 => 'Balances as of';

  @override
  String notebookImportScreen2(Object firstError, Object error) {
    return 'Line $firstError: $error';
  }

  @override
  String get notebookImportScreen3 => 'Enter at least one customer name';

  @override
  String get notebookImportScreen4 => 'Saved ✓';

  @override
  String notebookImportScreen5(Object newCustomers) {
    return '$newCustomers new customers';
  }

  @override
  String notebookImportScreen6(Object existingCustomers) {
    return '$existingCustomers existing customers — added to their balance';
  }

  @override
  String notebookImportScreen7(Object totalPiasters) {
    return 'Total: $totalPiasters';
  }

  @override
  String get notebookImportScreen8 => 'Next page';

  @override
  String get notebookImportScreen9 => 'Leave without saving?';

  @override
  String get notebookImportScreen10 =>
      'What you typed on this page won\'t be saved.';

  @override
  String get notebookImportScreen11 => 'Keep going';

  @override
  String get notebookImportScreen12 => 'Leave';

  @override
  String get notebookImportScreen13 => 'Import notebook 📒';

  @override
  String notebookImportScreen14(Object savedPages) {
    return 'Import notebook — page $savedPages';
  }

  @override
  String get notebookImportScreen15 => 'New line';

  @override
  String notebookImportScreen16(Object validLength) {
    return '$validLength customers';
  }

  @override
  String get notebookImportScreen17 => 'Save';

  @override
  String get notebookImportScreen18 =>
      'Write each customer on one line: name, mobile if you have it, and the amount they owe. Tap \"Next\" on the keyboard to move quickly.';

  @override
  String get notebookImportScreen19 => 'Balances as of today';

  @override
  String notebookImportScreen20(Object asOf) {
    return 'As of $asOf';
  }

  @override
  String get notebookImportScreen21 =>
      'Notebook page photos (optional): saved with every customer on the page';

  @override
  String notebookImportScreen22(Object pagePhotosLength) {
    return '$pagePhotosLength page photos — saved with every customer on the page';
  }

  @override
  String get notebookImportScreen23 => 'Page';

  @override
  String get notebookImportScreen24 => 'Photos for this customer';

  @override
  String get notebookImportScreen25 => 'Remove line';

  @override
  String get notebookImportScreen26 => 'Mobile (optional)';

  @override
  String get notebookImportScreen27 => 'Amount';

  @override
  String get notebookImportScreen28 => 'Checking…';

  @override
  String notebookImportScreen29(Object name) {
    return 'You already have \"$name\" — the amount will be added to their balance';
  }

  @override
  String get notebookImportScreen30 => 'Customer owes this amount';

  @override
  String get notebookImportScreen31 => 'You owe the customer this amount';

  @override
  String get notebookImportScreen32 => 'Owes';

  @override
  String get notebookImportScreen33 => 'Credit';

  @override
  String get notebookImportService1 => 'Previous balance from notebook';

  @override
  String get notebookImportService2 => 'Notebook page';

  @override
  String get notebookImportService3 => 'Name is missing';

  @override
  String get notebookImportService4 => 'Name is too long';

  @override
  String get notebookImportService5 => 'Invalid amount';

  @override
  String get notebookImportService6 => 'Paid amount can\'t be negative';

  @override
  String get notebookImportService7 =>
      'Paid amount must be less than the total price';

  @override
  String get notebookImportService8 => 'At least 1 installment must be left';

  @override
  String notebookImportService9(Object paidPiasters) {
    return 'Imported from notebook — paid before: $paidPiasters';
  }

  @override
  String notebookImportService10(Object trim, Object totalPricePiasters) {
    return 'Old installment: $trim (remaining of $totalPricePiasters)';
  }

  @override
  String notebookImportService11(Object trim) {
    return 'Installment: $trim';
  }

  @override
  String get installmentsScreen1 => 'Installments 📋';

  @override
  String get installmentsScreen2 =>
      'Search by customer, item, mobile or guarantor...';

  @override
  String get installmentsScreen3 => 'Total installments';

  @override
  String get installmentsScreen4 => 'Overdue';

  @override
  String get installmentsScreen5 => 'Active plans';

  @override
  String get installmentsScreen6 => 'All';

  @override
  String get installmentsScreen7 => 'Active ⏳';

  @override
  String get installmentsScreen8 => 'Completed ✓';

  @override
  String get installmentsScreen9 => 'Cancelled';

  @override
  String installmentsScreen10(Object e) {
    return 'Couldn\'t load installments: $e';
  }

  @override
  String get installmentsScreen11 => 'No matching installments';

  @override
  String get installmentsScreen12 => 'No installment plans yet';

  @override
  String get installmentsScreen13 =>
      'Tap (+ New installment plan) to create and schedule a customer\'s first plan.';

  @override
  String get installmentsScreen14 => 'New installment plan';

  @override
  String installmentPlanDetailsScreen1(Object instapay) {
    return 'InstaPay: $instapay';
  }

  @override
  String installmentPlanDetailsScreen2(Object wallet) {
    return 'Wallet / Vodafone Cash: $wallet';
  }

  @override
  String installmentPlanDetailsScreen3(Object phoneNum) {
    return 'Phone: $phoneNum';
  }

  @override
  String get installmentPlanDetailsScreen4 => 'Cancel installment plan';

  @override
  String get installmentPlanDetailsScreen5 =>
      'Cancel this plan? Reminders will stop and the payment history is kept.';

  @override
  String get installmentPlanDetailsScreen6 => 'Back';

  @override
  String get installmentPlanDetailsScreen7 => 'Cancel plan';

  @override
  String get installmentPlanDetailsScreen8 => 'Installment plan cancelled';

  @override
  String get installmentPlanDetailsScreen9 => 'Delete installment plan';

  @override
  String get installmentPlanDetailsScreen10 => 'Delete this installment plan?';

  @override
  String get installmentPlanDetailsScreen11 => 'Cancel';

  @override
  String get installmentPlanDetailsScreen12 => 'Delete';

  @override
  String get installmentPlanDetailsScreen13 => 'Installment plan deleted';

  @override
  String get installmentPlanDetailsScreen14 => 'Installment details';

  @override
  String installmentPlanDetailsScreen15(Object e) {
    return 'Error: $e';
  }

  @override
  String get installmentPlanDetailsScreen16 =>
      'Installment plan not found or deleted';

  @override
  String get installmentPlanDetailsScreen17 => 'Delete plan';

  @override
  String get installmentPlanDetailsScreen18 => 'Total price:';

  @override
  String get installmentPlanDetailsScreen19 => 'Down payment:';

  @override
  String get installmentPlanDetailsScreen20 => 'Total paid:';

  @override
  String get installmentPlanDetailsScreen21 => 'Remaining:';

  @override
  String get installmentPlanDetailsScreen22 => 'Pay off early in full';

  @override
  String installmentPlanDetailsScreen23(Object guarantorName) {
    return 'Guarantor: $guarantorName';
  }

  @override
  String get installmentPlanDetailsScreen24 =>
      'Contract / promissory note photo';

  @override
  String get installmentPlanDetailsScreen25 =>
      'Tap to view the document full size';

  @override
  String get installmentPlanDetailsScreen26 => 'Installment document';

  @override
  String installmentPlanDetailsScreen27(Object installmentsLength) {
    return 'Schedule ($installmentsLength)';
  }

  @override
  String get installmentPlanDetailsScreen28 => 'Pay any amount';

  @override
  String installmentPlanDetailsScreen29(
    Object installmentIndex,
    Object dueDate,
  ) {
    return 'Installment $installmentIndex • $dueDate';
  }

  @override
  String installmentPlanDetailsScreen30(Object paidPiasters) {
    return 'Fully paid ✓ ($paidPiasters)';
  }

  @override
  String installmentPlanDetailsScreen31(
    Object paidPiasters,
    Object amountPiasters,
  ) {
    return '$paidPiasters of $amountPiasters paid';
  }

  @override
  String get installmentPlanDetailsScreen32 => 'Overdue ⚠️';

  @override
  String get installmentPlanDetailsScreen33 => 'Due today 🔔';

  @override
  String installmentPlanDetailsScreen34(Object amountPiasters) {
    return 'Upcoming • $amountPiasters';
  }

  @override
  String get installmentPlanDetailsScreen35 => 'WhatsApp reminder';

  @override
  String get installmentPlanDetailsScreen36 => 'Pay';

  @override
  String get addInstallmentPlanScreen1 => 'Mobile phone';

  @override
  String get addInstallmentPlanScreen2 => 'TV';

  @override
  String get addInstallmentPlanScreen3 => 'Washing machine';

  @override
  String get addInstallmentPlanScreen4 => 'Fridge';

  @override
  String get addInstallmentPlanScreen5 => 'Cooker';

  @override
  String get addInstallmentPlanScreen6 => 'Laptop';

  @override
  String get addInstallmentPlanScreen7 => 'Motorcycle';

  @override
  String get addInstallmentPlanScreen8 => 'Furniture';

  @override
  String get addInstallmentPlanScreen9 => 'Choose a customer first';

  @override
  String get addInstallmentPlanScreen10 =>
      'Down payment must be less than the total price';

  @override
  String get addInstallmentPlanScreen11 =>
      'Installment plan created and scheduled ✓';

  @override
  String addInstallmentPlanScreen12(Object e) {
    return 'Something went wrong: $e';
  }

  @override
  String addInstallmentPlanScreen13(Object e) {
    return 'Couldn\'t load customers: $e';
  }

  @override
  String get addInstallmentPlanScreen14 => 'Choose customer';

  @override
  String get addInstallmentPlanScreen15 => 'Please choose a customer';

  @override
  String get addInstallmentPlanScreen16 => 'Item and amounts';

  @override
  String get addInstallmentPlanScreen17 => 'Item or product name *';

  @override
  String get addInstallmentPlanScreen18 => 'e.g. Samsung A15 128GB';

  @override
  String get addInstallmentPlanScreen19 =>
      'Item name must be at least 2 characters';

  @override
  String get addInstallmentPlanScreen20 => 'Total price (EGP) *';

  @override
  String get addInstallmentPlanScreen21 => 'e.g. 12000';

  @override
  String get addInstallmentPlanScreen22 => 'Invalid amount';

  @override
  String get addInstallmentPlanScreen23 => 'Down payment (EGP)';

  @override
  String get addInstallmentPlanScreen24 => 'Amount to pay in installments:';

  @override
  String get addInstallmentPlanScreen25 => 'Duration and frequency';

  @override
  String addInstallmentPlanScreen26(Object count) {
    return '$count installments';
  }

  @override
  String get addInstallmentPlanScreen27 => 'Number of installments *';

  @override
  String get addInstallmentPlanScreen28 => 'Enter a whole number';

  @override
  String get addInstallmentPlanScreen29 => 'Frequency';

  @override
  String get addInstallmentPlanScreen30 => 'First installment due date';

  @override
  String get addInstallmentPlanScreen31 => 'Change date';

  @override
  String get addInstallmentPlanScreen32 => 'Guarantor and documents (optional)';

  @override
  String get addInstallmentPlanScreen33 => 'e.g. Mohamed Ibrahim';

  @override
  String get addInstallmentPlanScreen34 => 'Guarantor\'s mobile';

  @override
  String get addInstallmentPlanScreen35 => 'Invalid phone number';

  @override
  String get addInstallmentPlanScreen36 => 'Document photo taken ✓';

  @override
  String get addInstallmentPlanScreen37 =>
      'Photograph the contract / note / ID';

  @override
  String get addInstallmentPlanScreen38 => 'Tap to change the photo';

  @override
  String get addInstallmentPlanScreen39 =>
      'Keep a photo of the contract for later';

  @override
  String get addInstallmentPlanScreen40 => 'Take photo';

  @override
  String get addInstallmentPlanScreen41 => 'Additional notes';

  @override
  String get addInstallmentPlanScreen42 => 'Link to the customer\'s ledger';

  @override
  String get addInstallmentPlanScreen43 =>
      'Record the total price as debt and the down payment as a payment in the customer\'s main ledger';

  @override
  String addInstallmentPlanScreen44(Object scheduleLength) {
    return 'Schedule preview ($scheduleLength installments)';
  }

  @override
  String addInstallmentPlanScreen45(Object amountPiasters) {
    return 'Installment: ~$amountPiasters';
  }

  @override
  String get addInstallmentPlanScreen46 => 'Save plan and schedule';

  @override
  String installmentProgressBar1(
    Object paidCount,
    Object totalCount,
    Object percentInt,
  ) {
    return '$paidCount of $totalCount paid ($percentInt%)';
  }

  @override
  String installmentProgressBar2(Object remainingPiasters) {
    return 'Left: $remainingPiasters';
  }

  @override
  String get installmentProgressBar3 => 'Fully paid ✓';

  @override
  String get payInstallmentDialog1 => 'Enter a valid amount greater than zero';

  @override
  String payInstallmentDialog2(Object amountPiasters) {
    return 'Payment of $amountPiasters recorded ✓';
  }

  @override
  String payInstallmentDialog3(Object e) {
    return 'Payment failed: $e';
  }

  @override
  String payInstallmentDialog4(Object installmentIndex) {
    return 'Pay installment $installmentIndex';
  }

  @override
  String payInstallmentDialog5(Object itemDescription) {
    return 'Installment payment ($itemDescription)';
  }

  @override
  String get payInstallmentDialog6 => 'Amount due:';

  @override
  String get payInstallmentDialog7 => 'Amount paid (EGP)';

  @override
  String get payInstallmentDialog8 => 'Payment method';

  @override
  String get payInstallmentDialog9 => 'Cash 💵';

  @override
  String get payInstallmentDialog10 => 'InstaPay ⚡';

  @override
  String get payInstallmentDialog11 => 'Wallet 📱';

  @override
  String get payInstallmentDialog12 => 'Payment date';

  @override
  String get payInstallmentDialog13 => 'Change';

  @override
  String get payInstallmentDialog14 => 'Note (optional)';

  @override
  String get payInstallmentDialog15 => 'e.g. sent via a friend';

  @override
  String get payInstallmentDialog16 => 'Record in the customer\'s ledger';

  @override
  String get payInstallmentDialog17 =>
      'Deducted from the customer\'s main balance';

  @override
  String get payInstallmentDialog18 => 'Confirm payment';

  @override
  String earlySettlementDialog1(Object itemDescription) {
    return 'Installment ($itemDescription) paid off ✓';
  }

  @override
  String earlySettlementDialog2(Object e) {
    return 'Payoff failed: $e';
  }

  @override
  String get earlySettlementDialog3 => 'Early payoff';

  @override
  String get earlySettlementDialog4 => 'Remaining installments total:';

  @override
  String get earlySettlementDialog5 => 'Amount to collect:';

  @override
  String get earlySettlementDialog6 => 'Early payment discount (EGP)';

  @override
  String get earlySettlementDialog7 => 'Pay off now';

  @override
  String installmentPlanCard1(Object overdueCount) {
    return 'Overdue ($overdueCount)';
  }

  @override
  String get installmentPlanCard2 => 'Completed ✓';

  @override
  String get installmentPlanCard3 => 'Cancelled';

  @override
  String installmentPlanCard4(Object dueDate, Object paidPiasters) {
    return 'Next: $dueDate ($paidPiasters)';
  }

  @override
  String installmentPlanCard5(Object totalPricePiasters) {
    return 'Total: $totalPricePiasters';
  }

  @override
  String get installmentRepository1 =>
      'Item description must be at least 2 characters';

  @override
  String get installmentRepository2 => 'Total price must be greater than zero';

  @override
  String get installmentRepository3 => 'Down payment can\'t be negative';

  @override
  String get installmentRepository4 =>
      'Down payment must be less than the total price';

  @override
  String get installmentRepository5 =>
      'Number of installments must be greater than zero';

  @override
  String installmentRepository6(Object trim, Object installmentCount) {
    return 'Installment: $trim ($installmentCount installments)';
  }

  @override
  String installmentRepository7(Object trim) {
    return 'Down payment: $trim';
  }

  @override
  String get installmentRepository8 =>
      'Payment amount must be greater than zero';

  @override
  String installmentRepository9(Object itemDescription, Object notes) {
    return 'Installment payment: $itemDescription$notes';
  }

  @override
  String get installmentRepository10 => 'Installment plan not found';

  @override
  String installmentRepository11(Object itemDescription) {
    return 'Early payoff: $itemDescription';
  }

  @override
  String installmentRepository12(Object itemDescription) {
    return 'Early payment discount: $itemDescription';
  }

  @override
  String get collectionScreen1 => 'Due installments';

  @override
  String get dueInstallmentsTab1 => 'This customer has no phone number';

  @override
  String get dueInstallmentsTab2 => 'No installments due or overdue today 🎉';

  @override
  String get dueInstallmentsTab3 =>
      'All installment customers are paying on time.';

  @override
  String dueInstallmentsTab4(Object dueListLength) {
    return '$dueListLength installments to collect:';
  }

  @override
  String dueInstallmentsTab5(
    Object itemDescription,
    Object installmentIndex,
    Object installmentCount,
  ) {
    return '$itemDescription • installment $installmentIndex of $installmentCount';
  }

  @override
  String dueInstallmentsTab6(Object daysOverdue) {
    return '$daysOverdue days late';
  }

  @override
  String get dueInstallmentsTab7 => 'Due today 🔔';

  @override
  String get dueInstallmentsTab8 => 'Call';

  @override
  String get dueInstallmentsTab9 => 'WhatsApp';

  @override
  String cashDrawerScreen1(Object err) {
    return 'Couldn\'t load the cash drawer: $err';
  }

  @override
  String drawerLiveCard1(Object notes) {
    return 'Note: $notes';
  }

  @override
  String expensesListCard1(Object expensesLength) {
    return '$expensesLength expenses';
  }

  @override
  String get expensesListCard2 => 'InstaPay';

  @override
  String get expensesListCard3 => 'Wallet';

  @override
  String get drawerFlowCard1 => '(InstaPay / wallet)';

  @override
  String addCashSalesBottomSheet1(Object currentSalesPiasters) {
    return 'Sales recorded so far: $currentSalesPiasters';
  }

  @override
  String get addCashSalesBottomSheet2 => 'Add to sales (+)';

  @override
  String get addCashSalesBottomSheet3 => 'Set total (=)';

  @override
  String get addCashSalesBottomSheet4 => 'Amount to add';

  @override
  String get addCashSalesBottomSheet5 => 'New sales total';

  @override
  String addCashSalesBottomSheet6(Object val) {
    return '+$val EGP';
  }

  @override
  String drawerHistoryTab1(
    Object cashSalesPiasters,
    Object openingCashPiasters,
  ) {
    return 'Cash sales: $cashSalesPiasters · Opening: $openingCashPiasters';
  }

  @override
  String drawerHistoryTab2(Object date) {
    return 'Details for $date';
  }

  @override
  String get drawerHistoryTab3 => 'Difference';

  @override
  String get customersScreen1 => 'Installments';

  @override
  String get customersScreen2 => 'Privacy mode';

  @override
  String get customersScreen3 => 'Sort';

  @override
  String get customerPhotosScreen1 => 'Photo added';

  @override
  String customerPhotosScreen2(Object pathsLength) {
    return '$pathsLength photos added';
  }

  @override
  String get customerPhotosScreen3 => 'Photo removed';

  @override
  String get customerPhotosScreen4 => 'Restore';

  @override
  String customerPhotosScreen5(Object customerName) {
    return '$customerName\'s photos';
  }

  @override
  String get customerPhotosScreen6 => 'Add photos';

  @override
  String get customerPhotosScreen7 => 'Couldn\'t load photos';

  @override
  String get customerPhotosScreen8 =>
      'No photos for this customer yet.\nPhotograph their notebook pages or any paper about them — photos stay on this phone only.';

  @override
  String get customerPhotosScreen9 => 'Remove photo';

  @override
  String customerDetailsScreen1(
    Object activePlansLength,
    Object remainingPiasters,
  ) {
    return 'Active installments ($activePlansLength) • Left: $remainingPiasters';
  }

  @override
  String get customerDetailsScreen2 => 'Sell to this customer in installments';

  @override
  String get customerDetailsScreen3 => 'View';

  @override
  String get customerDetailsScreen4 => 'New installment plan';

  @override
  String get customerDetailsScreen5 => 'Customer photos';

  @override
  String get photoStrip1 => 'Take a photo';

  @override
  String get photoStrip2 => 'Choose from gallery';

  @override
  String get photoStrip3 => 'You can pick several photos at once';

  @override
  String get photoStrip4 => 'Photo';

  @override
  String get photoStrip5 => 'More';

  @override
  String get photoStrip6 => 'Add photo';

  @override
  String get photoStrip7 => 'Photos';

  @override
  String photoStrip8(Object title, Object index, Object count) {
    return '$title ($index of $count)';
  }

  @override
  String get photoStrip9 => 'Photo';

  @override
  String get photoStrip10 => 'Photo not found on this phone';

  @override
  String creditLimitProgressBar1(Object limitPiasters) {
    return 'Credit limit: $limitPiasters';
  }

  @override
  String ratingExplanationBottomSheet1(Object customerName) {
    return 'Customer rating: $customerName';
  }

  @override
  String get ratingExplanationBottomSheet2 => 'Why this rating:';

  @override
  String get ratingExplanationBottomSheet3 => 'How does the rating work?';

  @override
  String get ratingExplanationBottomSheet4 => 'Excellent';

  @override
  String get ratingExplanationBottomSheet5 =>
      'Settled, or oldest debt is 14 days or less.';

  @override
  String get ratingExplanationBottomSheet6 => 'Follow up';

  @override
  String get ratingExplanationBottomSheet7 =>
      'Oldest debt is 15–45 days old (a reminder is a good idea).';

  @override
  String get ratingExplanationBottomSheet8 => 'Late';

  @override
  String get ratingExplanationBottomSheet9 =>
      'Oldest debt is over 45 days old, or the credit limit was exceeded.';

  @override
  String get ratingExplanationBottomSheet10 => 'New';

  @override
  String get ratingExplanationBottomSheet11 =>
      'Customer with fewer than 3 transactions.';

  @override
  String get ratingExplanationBottomSheet12 => 'Got it';

  @override
  String get customerWithBalance1 => 'New customer';

  @override
  String get settingsScreen1 => 'Shop details 🏪';

  @override
  String get settingsScreen2 => 'Security and privacy 🔒';

  @override
  String get settingsScreen3 => 'Home screen widget 📱';

  @override
  String get settingsScreen4 => 'Reminder messages 💬';

  @override
  String get settingsScreen5 => 'Backup and data 💾';

  @override
  String get settingsScreen6 => 'Share the app 🚀';

  @override
  String get settingsScreen7 => 'General ⚙️';

  @override
  String get settingsScreen8 => 'Kashkool 📒';

  @override
  String get settingsScreen9 =>
      'Shop ledger that works offline (Offline-First)\nVersion 1.0.0';

  @override
  String get settingsScreen10 => 'General store';

  @override
  String get settingsScreen11 => 'Grocery & supermarket 🛒';

  @override
  String get settingsScreen12 => 'Phones & accessories 📱';

  @override
  String get settingsScreen13 => 'Electronics & appliances ⚡';

  @override
  String get settingsScreen14 => 'Pharmacy & cosmetics 💊';

  @override
  String get settingsScreen15 => 'Other businesses 🏪';

  @override
  String settingsScreen16(Object tradeName) {
    return '$tradeName • Edit business and payment details';
  }

  @override
  String get settingsScreen17 => 'Hide amounts on screen and widget (••••••)';

  @override
  String get settingsScreen18 => 'Lock the app with a PIN (4 digits)';

  @override
  String get settingsScreen19 => 'On and protected (tap to turn off)';

  @override
  String get settingsScreen20 => 'Off (tap to set up)';

  @override
  String get settingsScreen21 => 'On 🔒';

  @override
  String get settingsScreen22 => 'Set up';

  @override
  String get settingsScreen23 => 'App lock turned off';

  @override
  String get settingsScreen24 => 'PIN set 🔒';

  @override
  String get settingsScreen25 => 'Unlock with fingerprint / Face ID';

  @override
  String get settingsScreen26 =>
      'Use fingerprint instead of typing the PIN every time';

  @override
  String get settingsScreen27 =>
      'Your device doesn\'t support biometric unlock';

  @override
  String get settingsScreen28 => '1 minute';

  @override
  String get settingsScreen29 => '5 minutes';

  @override
  String get settingsScreen30 => '15 minutes';

  @override
  String get settingsScreen31 => 'Immediately';

  @override
  String get settingsScreen32 => 'Auto-lock after';

  @override
  String get settingsScreen33 => 'As soon as you leave the app';

  @override
  String settingsScreen34(Object timeout) {
    return '$timeout minutes after leaving';
  }

  @override
  String get settingsScreen35 => 'Immediately on exit';

  @override
  String get settingsScreen36 => 'After 1 minute';

  @override
  String get settingsScreen37 => 'After 5 minutes';

  @override
  String get settingsScreen38 => 'After 15 minutes';

  @override
  String get settingsScreen39 => 'Reminder message';

  @override
  String get settingsScreen40 =>
      'Edit the automatic customer message with live preview';

  @override
  String get settingsScreen41 =>
      'Keep reminders from being killed in the background';

  @override
  String get settingsScreen42 =>
      'A practical guide for Xiaomi, Realme and Infinix phones';

  @override
  String get settingsScreen43 => 'No backup exported yet';

  @override
  String get settingsScreen44 => 'Last backup';

  @override
  String get settingsScreen45 => 'Export backup (.kashkool)';

  @override
  String get settingsScreen46 =>
      'Save a copy of the ledger and photos and send it via WhatsApp or Drive';

  @override
  String get settingsScreen47 => 'Backup exported 👍';

  @override
  String settingsScreen48(Object e) {
    return 'Export failed: $e';
  }

  @override
  String get settingsScreen49 => 'Restore backup';

  @override
  String get settingsScreen50 =>
      'Restore accounts and photos from a saved .kashkool file';

  @override
  String get settingsScreen51 => 'Invalid file ❌';

  @override
  String get settingsScreen52 => 'This file isn\'t a valid Kashkool backup.';

  @override
  String get settingsScreen53 => 'OK';

  @override
  String get settingsScreen54 => 'Confirm restore';

  @override
  String get settingsScreen55 =>
      'Warning: restoring replaces all current data in the app with the data in the file.';

  @override
  String settingsScreen56(Object exportedAt) {
    return 'Backup date: $exportedAt';
  }

  @override
  String settingsScreen57(Object photosCount) {
    return 'Photos included: $photosCount';
  }

  @override
  String settingsScreen58(Object fileSizeBytes) {
    return 'File size: $fileSizeBytes KB';
  }

  @override
  String get settingsScreen59 => 'Yes, replace and restore';

  @override
  String get settingsScreen60 => 'Restored 🎉';

  @override
  String get settingsScreen61 =>
      'All accounts, transactions and photos were restored. Please restart the app to refresh every screen.';

  @override
  String get settingsScreen62 => 'Restart now';

  @override
  String settingsScreen63(Object e) {
    return 'Restore failed: $e';
  }

  @override
  String get settingsScreen64 => 'Dark 🌙';

  @override
  String get settingsScreen65 => 'Light ☀️';

  @override
  String get settingsScreen66 => 'Auto';

  @override
  String get settingsScreen67 => 'Appearance';

  @override
  String get settingsScreen68 => 'Automatic (follows the phone)';

  @override
  String get settingsScreen69 => 'Not set';

  @override
  String get settingsScreen70 => 'Default credit limit for new customers';

  @override
  String get settingsScreen71 => 'Contact us on WhatsApp';

  @override
  String get settingsScreen72 => 'Suggestions and direct support';

  @override
  String get settingsScreen73 =>
      'https://wa.me/201000000000?text=Hello%2C%20I%20have%20a%20question%20about%20Kashkool';

  @override
  String get settingsScreen74 => 'Privacy policy and terms of use';

  @override
  String get settingsScreen75 =>
      'Your data is yours and stays on your phone, offline';

  @override
  String get settingsScreen76 => 'Kashkool privacy policy 🔒';

  @override
  String get settingsScreen77 =>
      '1. Kashkool works fully offline (Offline-First).\n\n2. All accounts, names, phone numbers, receipt photos and transactions are stored only on your device. No data is sent to any outside server.\n\n3. You are responsible for exporting a backup regularly (Export backup) so your data is safe if you change or lose your phone.\n\n4. Kashkool is made for shop owners and traders to protect what they\'re owed and track debts safely.';

  @override
  String get settingsScreen78 => 'System (automatic)';

  @override
  String get settingsScreen79 => 'Default credit limit (EGP)';

  @override
  String get settingsScreen80 => 'Amount in EGP';

  @override
  String get settingsScreen81 => 'Leave empty for no limit';

  @override
  String get settingsScreen82 => 'Save';

  @override
  String batteryGuideBottomSheet1(Object brandName) {
    return 'Notification guide ($brandName)';
  }

  @override
  String get batteryGuideBottomSheet2 => 'Keep reminders working';

  @override
  String get batteryGuideBottomSheet3 =>
      'Some phones (like Xiaomi, Realme, Infinix and Huawei) stop apps in the background to save battery. To make sure daily collection and installment reminders arrive on time, follow these steps:';

  @override
  String get batteryGuideBottomSheet4 => 'Open battery settings now';

  @override
  String get backupReminderBanner1 => 'Backup exported 👍';

  @override
  String backupReminderBanner2(Object e) {
    return 'Backup failed: $e';
  }

  @override
  String get backupReminderBanner3 => 'Time for a backup ⚠️';

  @override
  String get backupReminderBanner4 =>
      'It\'s been over 7 days since the last backup. Save your data so nothing is lost if your phone is lost or replaced.';

  @override
  String get backupReminderBanner5 => 'Not now';

  @override
  String get backupReminderBanner6 => 'Saving...';

  @override
  String get backupReminderBanner7 => 'Back up now';

  @override
  String get homeWidgetSettingsCard1 => 'Show your balances on the home screen';

  @override
  String get homeWidgetSettingsCard2 =>
      'The widget shows what customers owe you and today\'s collections without opening the app';

  @override
  String get homeWidgetSettingsCard3 =>
      'The widget is off and shows no numbers';

  @override
  String get homeWidgetSettingsCard4 => 'Add the small widget';

  @override
  String get homeWidgetSettingsCard5 => 'Only what customers owe you';

  @override
  String get homeWidgetSettingsCard6 => 'Add today\'s summary widget';

  @override
  String get homeWidgetSettingsCard7 =>
      'What you\'re owed + today\'s collections + who\'s due + a collect button';

  @override
  String get homeWidgetSettingsCard8 =>
      'Accept the prompt to add the widget to your screen 👍';

  @override
  String get homeWidgetSettingsCard9 => 'Add the widget yourself 📱';

  @override
  String get homeWidgetSettingsCard10 =>
      'Your phone doesn\'t let the app add it automatically. Do this:\n\n1. Long-press an empty spot on the home screen\n2. Choose \"Widgets\"\n3. Find \"Kashkool\" and drag the widget onto the screen';

  @override
  String get messageTemplateEditorBottomSheet1 => 'Al-Amana Grocery';

  @override
  String get messageTemplateEditorBottomSheet2 => 'Vodafone Cash: 01012345678';

  @override
  String get messageTemplateEditorBottomSheet3 => 'Mohamed Ahmed';

  @override
  String get messageTemplateEditorBottomSheet4 => 'Message template saved 👍';

  @override
  String get messageTemplateEditorBottomSheet5 => 'Edit reminder message 💬';

  @override
  String get messageTemplateEditorBottomSheet6 => 'Presets: ';

  @override
  String get messageTemplateEditorBottomSheet7 => 'Friendly 😊';

  @override
  String get messageTemplateEditorBottomSheet8 => 'Formal 👔';

  @override
  String get messageTemplateEditorBottomSheet9 => 'Shop name';

  @override
  String get messageTemplateEditorBottomSheet10 => 'Payment details';

  @override
  String get messageTemplateEditorBottomSheet11 => 'Last transaction date';

  @override
  String get messageTemplateEditorBottomSheet12 =>
      'Write the reminder message here...';

  @override
  String get messageTemplateEditorBottomSheet13 =>
      'Preview as the customer will see it:';

  @override
  String get messageTemplateEditorBottomSheet14 => 'Save template';

  @override
  String shopProfileBottomSheet1(Object trim) {
    return 'Mobile wallet: $trim';
  }

  @override
  String get shopProfileBottomSheet2 => 'Shop details saved 👍';

  @override
  String get shopProfileBottomSheet3 => 'Shop name *';

  @override
  String get shopProfileBottomSheet4 => 'e.g. Al-Amana Grocery';

  @override
  String get shopProfileBottomSheet5 => 'Please enter the shop name';

  @override
  String get shopProfileBottomSheet6 => 'Shop phone';

  @override
  String get shopProfileBottomSheet7 => 'e.g. 010xxxxxxxx';

  @override
  String get shopProfileBottomSheet8 => 'Shop address';

  @override
  String get shopProfileBottomSheet9 =>
      'e.g. Market Street, next to the big mosque';

  @override
  String get shopProfileBottomSheet10 => 'InstaPay account';

  @override
  String get shopProfileBottomSheet11 => 'e.g. name@instapay';

  @override
  String get shopProfileBottomSheet12 => 'Vodafone Cash / mobile wallet number';

  @override
  String get shopProfileBottomSheet13 => 'Business type';

  @override
  String get shopProfileBottomSheet14 => 'Other business 🏪';

  @override
  String get shopProfileBottomSheet15 => 'Turn on installments';

  @override
  String get shopProfileBottomSheet16 =>
      'Show the installments button and payment schedules';

  @override
  String get shopProfileBottomSheet17 => 'Save changes';

  @override
  String get cloudAccountButton1 => 'Your account and cloud backup ☁️';

  @override
  String get cloudAccountButton2 => 'Cloud backup';

  @override
  String get cloudAccountButton3 => 'Sign in with Google';

  @override
  String get cloudBackupCard1 => 'One moment…';

  @override
  String get cloudBackupCard2 => 'Something went wrong, please try again';

  @override
  String get cloudBackupCard3 => 'Opening Google accounts…';

  @override
  String cloudBackupCard4(Object email) {
    return 'Signed in as $email ✓';
  }

  @override
  String get cloudBackupCard5 => 'Backup uploaded with warnings ⚠️';

  @override
  String cloudBackupCard6(Object uploaded, Object rejected, Object n) {
    return '$uploaded records uploaded, $rejected rejected:\n\n$n';
  }

  @override
  String get cloudBackupCard7 => 'All your data is already in the cloud ✓';

  @override
  String cloudBackupCard8(Object uploaded) {
    return '$uploaded records uploaded to the cloud ✓';
  }

  @override
  String get cloudBackupCard9 => 'Loading the shops on your account…';

  @override
  String get cloudBackupCard10 => 'No cloud backup for this account yet';

  @override
  String get cloudBackupCard11 => 'Choose the shop';

  @override
  String get cloudBackupCard12 => ' (employee)';

  @override
  String get cloudBackupCard13 => 'Restore from the cloud?';

  @override
  String cloudBackupCard14(Object name) {
    return 'We\'ll download the \"$name\" backup from the cloud and add it to this phone.\n\n';
  }

  @override
  String get cloudBackupCard15 =>
      'Nothing will be deleted: data that\'s only on this phone stays, and anything changed on the phone after the last backup is kept as is.';

  @override
  String get cloudBackupCard16 => 'Yes, restore';

  @override
  String get cloudBackupCard17 => 'Restored 🎉';

  @override
  String cloudBackupCard18(Object keptLocal) {
    return ', and $keptLocal records were kept because the phone\'s copy is newer';
  }

  @override
  String cloudBackupCard19(Object records, Object keptLocal) {
    return '$records records restored$keptLocal.';
  }

  @override
  String get cloudBackupCard20 =>
      ' Close and reopen the app to refresh every screen.';

  @override
  String get cloudBackupCard21 => 'Close the app';

  @override
  String get cloudBackupCard22 => 'Sign out?';

  @override
  String get cloudBackupCard23 =>
      'Your data stays on the phone and in the cloud, but backups stop until you sign in again.';

  @override
  String get cloudBackupCard24 => 'Sign out';

  @override
  String get cloudBackupCard25 => 'Not available in this version of the app';

  @override
  String get cloudBackupCard26 => 'Cloud backup';

  @override
  String get cloudBackupCard27 =>
      'Sign in with Google to keep your data online. If you lose your phone, restore it on any other phone.';

  @override
  String get cloudBackupCard28 => 'No backup yet';

  @override
  String cloudBackupCard29(Object last) {
    return 'Last backup: $last';
  }

  @override
  String get cloudBackupCard30 => 'Uploading now…';

  @override
  String get cloudBackupCard31 =>
      'Waiting for internet — will upload automatically when it\'s back';

  @override
  String get cloudBackupCard32 => 'Upload paused, we\'ll retry shortly';

  @override
  String get cloudBackupCard33 => 'Everything is uploaded ✓';

  @override
  String get cloudBackupCard34 => 'Uploads automatically when online';

  @override
  String get cloudBackupCard35 => 'Back up now';

  @override
  String get cloudBackupCard36 => 'Restore your data on this phone';

  @override
  String get cloudBackupCard37 =>
      'For a new phone or after reinstalling — deletes nothing';

  @override
  String get cloudBackupCard38 => 'Sign out';

  @override
  String get onboardingScreen1 => 'My shop';

  @override
  String get onboardingScreen2 =>
      'Demo customers were added so you can try the app. You can delete them any time';

  @override
  String get onboardingScreen3 => 'Setting up Kashkool';

  @override
  String get onboardingScreen4 => 'Next: business type';

  @override
  String get onboardingScreen5 => 'Welcome to Kashkool! 👋';

  @override
  String get onboardingScreen6 =>
      'Your digital ledger for customer debts, WhatsApp reminders and installments — made simple.';

  @override
  String get onboardingScreen7 => 'Shop name *';

  @override
  String get onboardingScreen8 => 'e.g. Al-Amana Grocery / Star Mobiles';

  @override
  String get onboardingScreen9 =>
      'Please enter the shop name (at least 2 characters)';

  @override
  String get onboardingScreen10 => 'Shop phone (optional)';

  @override
  String get onboardingScreen11 =>
      'Shown on receipts, statements and WhatsApp messages';

  @override
  String get onboardingScreen12 => 'Grocery & supermarket';

  @override
  String get onboardingScreen13 => 'Daily debts and quick cash drawer closing';

  @override
  String get onboardingScreen14 => 'Phones & accessories';

  @override
  String get onboardingScreen15 =>
      'Device details, installments turned on automatically';

  @override
  String get onboardingScreen16 => 'Electronics & appliances';

  @override
  String get onboardingScreen17 =>
      'Credit sales contracts, installments turned on automatically';

  @override
  String get onboardingScreen18 => 'Pharmacy & cosmetics';

  @override
  String get onboardingScreen19 => 'Credit limits and prescription debts';

  @override
  String get onboardingScreen20 => 'Other businesses';

  @override
  String get onboardingScreen21 => 'A flexible ledger for any kind of business';

  @override
  String get onboardingScreen22 => 'What kind of business do you run?';

  @override
  String get onboardingScreen23 =>
      'We\'ll set up the app\'s screens to fit your work.';

  @override
  String get onboardingScreen24 => 'Supports installments';

  @override
  String get onboardingScreen25 => 'Turn on installment plans';

  @override
  String get onboardingScreen26 =>
      'You can turn it on or off any time in Settings';

  @override
  String get onboardingScreen27 => 'Make sure reminders reach you 🔔';

  @override
  String get onboardingScreen28 =>
      'So Kashkool can remind you every day about collections and installments:';

  @override
  String get onboardingScreen29 => 'Notification permission';

  @override
  String get onboardingScreen30 => 'Notifications are on ✅';

  @override
  String get onboardingScreen31 =>
      'We need notification permission to send your daily collection summary';

  @override
  String get onboardingScreen32 => 'Allow notifications';

  @override
  String onboardingScreen33(Object brandName) {
    return 'Background protection ($brandName)';
  }

  @override
  String get onboardingScreen34 => 'Keep the app running in the background';

  @override
  String get onboardingScreen35 => 'Open battery settings';

  @override
  String get onboardingScreen36 => 'Ready to go! 🚀';

  @override
  String get onboardingScreen37 =>
      'Your shop details are saved. How would you like to start?';

  @override
  String get onboardingScreen38 => '+ Add your first real customer';

  @override
  String get onboardingScreen39 =>
      'Add a customer and start recording debts and payments right away';

  @override
  String get onboardingScreen40 => 'Try with demo data first 💡';

  @override
  String get onboardingScreen41 =>
      'Adds two demo customers with sample balances to explore Kashkool (delete them with one tap)';

  @override
  String get onboardingScreen42 => 'Skip to the home screen';

  @override
  String get shopRepository1 => 'Ahmed Mohamed (demo)';

  @override
  String get shopRepository2 => 'Household shopping';

  @override
  String get shopRepository3 => 'Mahmoud Ibrahim (demo)';

  @override
  String get shopRepository4 => 'Start-of-month stock';

  @override
  String get shopRepository5 => 'Cash payment on account';

  @override
  String get supplierWithBalance1 => 'Saturday';

  @override
  String get supplierWithBalance2 => 'Sunday';

  @override
  String get supplierWithBalance3 => 'Monday';

  @override
  String get supplierWithBalance4 => 'Tuesday';

  @override
  String get supplierWithBalance5 => 'Wednesday';

  @override
  String get supplierWithBalance6 => 'Thursday';

  @override
  String get supplierWithBalance7 => 'Friday';

  @override
  String get trashScreen1 => 'Customers';

  @override
  String get trashScreen2 => 'Transactions';

  @override
  String get trashScreen3 => 'Suppliers';

  @override
  String get trashScreen4 => 'Expenses';

  @override
  String get trashScreen5 => 'Installments';

  @override
  String trashScreen6(Object title) {
    return '\"$title\" restored ✓';
  }

  @override
  String get trashScreen7 => 'Couldn\'t restore it, please try again';

  @override
  String get trashScreen8 => 'Trash 🗑️';

  @override
  String get trashScreen9 =>
      'Anything you delete comes here and isn\'t lost. You can restore it any time, and it comes back in the cloud backup too.';

  @override
  String get trashScreen10 => 'Couldn\'t load deleted items';

  @override
  String get trashScreen11 => 'Trash is empty ✨';

  @override
  String trashScreen12(Object deletedAt) {
    return 'Deleted $deletedAt';
  }

  @override
  String get trashScreen13 => 'Restore';

  @override
  String get trashScreen14 => 'Trash';

  @override
  String get trashScreen15 => 'See deleted items and restore them';

  @override
  String trashScreen16(Object count) {
    return '$count items — you can restore them';
  }

  @override
  String get trashRepository1 => 'Rent';

  @override
  String get trashRepository2 => 'Electricity';

  @override
  String get trashRepository3 => 'Salaries';

  @override
  String get trashRepository4 => 'Supplies';

  @override
  String get trashRepository5 => 'Supplier payment';

  @override
  String get trashRepository6 => 'Expense';

  @override
  String get trashRepository7 => 'I owe';

  @override
  String get trashRepository8 => 'Payment';

  @override
  String get trashRepository9 => 'I paid';

  @override
  String get trashRepository10 => 'Unknown';

  @override
  String trashRepository11(Object itemDescription) {
    return 'Installments: $itemDescription';
  }

  @override
  String pdfStatementService1(Object sanitizedName, Object dateStr) {
    return 'Statement_${sanitizedName}_$dateStr.pdf';
  }

  @override
  String get pdfStatementService2 => 'Customer statement';

  @override
  String pdfStatementService3(Object customerName) {
    return 'Customer: $customerName';
  }

  @override
  String pdfStatementService4(Object phone) {
    return 'Phone: $phone';
  }

  @override
  String pdfStatementService5(Object periodDescription) {
    return 'Period: $periodDescription';
  }

  @override
  String get pdfStatementService6 => 'Balance before this period:';

  @override
  String get pdfStatementService7 => 'Date';

  @override
  String get pdfStatementService8 => 'Description';

  @override
  String get pdfStatementService9 => 'Balance';

  @override
  String pdfStatementService10(Object periodDebitsPiasters) {
    return 'Total purchases / credit: $periodDebitsPiasters';
  }

  @override
  String pdfStatementService11(Object periodCreditsPiasters) {
    return 'Total paid: $periodCreditsPiasters';
  }

  @override
  String get pdfStatementService12 => 'Final balance due:';

  @override
  String pdfStatementService13(Object trim) {
    return 'Ways to pay: $trim';
  }

  @override
  String get pdfStatementService14 => 'Made with Kashkool — try it free:';

  @override
  String get statementCalculator1 => 'All transactions';

  @override
  String get statementCalculator2 => 'January';

  @override
  String get statementCalculator3 => 'February';

  @override
  String get statementCalculator4 => 'March';

  @override
  String get statementCalculator5 => 'April';

  @override
  String get statementCalculator6 => 'May';

  @override
  String get statementCalculator7 => 'June';

  @override
  String get statementCalculator8 => 'July';

  @override
  String get statementCalculator9 => 'August';

  @override
  String get statementCalculator10 => 'September';

  @override
  String get statementCalculator11 => 'October';

  @override
  String get statementCalculator12 => 'November';

  @override
  String get statementCalculator13 => 'December';

  @override
  String statementCalculator14(Object startDate, Object endDate) {
    return 'From $startDate to $endDate';
  }

  @override
  String statementCalculator15(Object startDate) {
    return 'From $startDate';
  }

  @override
  String statementCalculator16(Object endDate) {
    return 'Until $endDate';
  }

  @override
  String growthFooter1(Object shopCode) {
    return '—\nMade with Kashkool 📒 Try it free: $shopCode';
  }

  @override
  String growthFooter2(Object shopCode) {
    return 'I use Kashkool 📒 to track customers, suppliers and my cash drawer without a paper notebook.\nVery easy and works offline. Try it free:\n$shopCode';
  }

  @override
  String get notificationService1 => 'Daily collection';

  @override
  String get notificationService2 =>
      'Reminders about customers who are due to pay';

  @override
  String notificationService3(Object dueCount, Object amountStr) {
    return '$dueCount customers owe $amountStr — tap to collect';
  }

  @override
  String get notificationService4 => 'Daily collection reminder 📒';

  @override
  String get backupService1 => 'Database file not found';

  @override
  String backupService2(Object dateStr) {
    return 'Kashkool backup - $dateStr';
  }

  @override
  String get backupService3 => 'The selected file doesn\'t exist';

  @override
  String get backupService4 => 'The file is damaged or incomplete';

  @override
  String get backupService5 => 'Wrong file format (not a Kashkool file)';

  @override
  String get backupService6 => 'The file has no Kashkool database';

  @override
  String get backupService7 => 'The database inside the file is damaged';

  @override
  String get backupService8 => 'Not a valid SQLite database';

  @override
  String get backupService9 => 'Invalid backup file';

  @override
  String get backupService10 => 'Database file missing from the archive';

  @override
  String get googleAuthService1 =>
      'Cloud backup isn\'t set up in this version of the app';

  @override
  String get googleAuthService2 =>
      'Google didn\'t return sign-in details, please try again';

  @override
  String get googleAuthService3 => 'Sign-in cancelled';

  @override
  String googleAuthService4(Object codeName) {
    return 'Couldn\'t sign in with Google ($codeName)';
  }

  @override
  String get cloudApi1 =>
      'Server address isn\'t set in this version of the app';

  @override
  String get cloudApi2 => 'Sign in with Google first';

  @override
  String get cloudApi3 => 'No internet connection, please try again';

  @override
  String get cloudApi4 => 'The server took too long, please try again';

  @override
  String get cloudApi5 => 'Your session expired, sign in with Google again';

  @override
  String get cloudApi6 => 'This shop belongs to another Google account';

  @override
  String get cloudApi7 => 'This feature needs a subscription';

  @override
  String get cloudApi8 => 'Too many attempts, wait a bit and try again';

  @override
  String get cloudApi9 => 'Sign in with Google again';

  @override
  String get cloudApi10 => 'Google sign-in isn\'t set up on the server';

  @override
  String get cloudApi11 => 'Server problem, try again shortly';

  @override
  String cloudApi12(Object code) {
    return 'Something went wrong ($code)';
  }

  @override
  String get cloudBackupService1 => 'Google sign-in isn\'t available';

  @override
  String get cloudBackupService2 =>
      'Complete your shop details in Settings first';

  @override
  String get cloudBackupService3 => 'Preparing shop data…';

  @override
  String cloudBackupService4(Object length, Object changesLength) {
    return 'Uploading $length of $changesLength…';
  }

  @override
  String get cloudBackupService5 => 'Done ✓';

  @override
  String cloudBackupService6(Object changesLength) {
    return 'Downloading data… ($changesLength)';
  }

  @override
  String cloudBackupService7(Object changesLength) {
    return 'Saving $changesLength records on this phone…';
  }

  @override
  String get cloudBackupService8 => 'Shop';

  @override
  String autoBackupCoordinator1(Object rejected) {
    return '$rejected records weren\'t uploaded';
  }

  @override
  String get autoBackupCoordinator2 =>
      'Something went wrong, we\'ll retry shortly';

  @override
  String get customerRating1 => 'New customer (fewer than 3 transactions)';

  @override
  String get customerRating2 => 'Settled and pays on time';

  @override
  String customerRating3(Object oldestUnpaidAgeDays) {
    return 'Late: oldest debt is $oldestUnpaidAgeDays days old and over the credit limit';
  }

  @override
  String get customerRating4 => 'Over the customer\'s credit limit';

  @override
  String get customerRating5 =>
      'Only took credit today, account is in good standing';

  @override
  String customerRating6(Object oldestUnpaidAgeDays) {
    return 'Oldest amount is only $oldestUnpaidAgeDays days old (safe range)';
  }

  @override
  String customerRating7(Object oldestUnpaidAgeDays) {
    return 'Oldest amount is $oldestUnpaidAgeDays days old (over 45 days late)';
  }

  @override
  String customerRating8(Object oldestUnpaidAgeDays) {
    return 'Oldest amount is $oldestUnpaidAgeDays days old (needs follow-up)';
  }

  @override
  String get whatsappTemplate1 =>
      'Hello {customer_name} 👋\nThis is {shop_name}.\nYour current balance: {balance}\nLast transaction: {last_transaction_date} - {last_transaction_amount}\nTo pay: {payment_info}\nThank you for your business 🙏';

  @override
  String get whatsappTemplate2 =>
      'Dear {customer_name},\nThis is a reminder that your current balance with {shop_name} is {balance}.\nLast recorded transaction: {last_transaction_date} ({last_transaction_amount})\nPayment options: {payment_info}\nKind regards.';

  @override
  String get whatsappTemplate3 =>
      'Hello {customer_name} 👋\nThis is {shop_name}.\nA reminder that an installment for ({item}) is due — installment {installment_number} of {installment_count}:\nAmount due: {amount}\nDue date: {due_date}\nTotal remaining: {remaining_total}\nPayment options: {payment_info}\nThank you for paying on time 🙏';

  @override
  String get whatsappTemplate4 => 'Cash at the shop or any available transfer';

  @override
  String get money1 => 'EGP';

  @override
  String get batteryOptimizationHelper1 => 'XOS / HiOS';

  @override
  String get batteryOptimizationHelper2 =>
      'Open the Phone Master app on your phone.';

  @override
  String get batteryOptimizationHelper3 =>
      'Go to \"Auto-start management\" and turn on Kashkool.';

  @override
  String get batteryOptimizationHelper4 =>
      'In the app\'s settings, open \"Battery\" and choose \"Unrestricted\".';

  @override
  String get batteryOptimizationHelper5 =>
      'In recent apps, pull the app down to lock it 🔒.';

  @override
  String get batteryOptimizationHelper6 => 'MIUI / HyperOS';

  @override
  String get batteryOptimizationHelper7 =>
      'Open the app\'s settings and turn on \"Autostart\".';

  @override
  String get batteryOptimizationHelper8 =>
      'Under \"Battery saver\", choose \"No restrictions\".';

  @override
  String get batteryOptimizationHelper9 =>
      'In recent apps, long-press Kashkool and tap the lock icon 🔒.';

  @override
  String get batteryOptimizationHelper10 => 'ColorOS / Realme UI';

  @override
  String get batteryOptimizationHelper11 =>
      'App settings -> Battery usage, turn on \"Allow background activity\".';

  @override
  String get batteryOptimizationHelper12 => 'Turn on \"Auto-launch\".';

  @override
  String get batteryOptimizationHelper13 =>
      'In recent apps, tap the three dots and choose \"Lock\".';

  @override
  String get batteryOptimizationHelper14 => 'One UI';

  @override
  String get batteryOptimizationHelper15 =>
      'Go to Settings -> Device care -> Battery.';

  @override
  String get batteryOptimizationHelper16 => 'Open \"Background usage limits\".';

  @override
  String get batteryOptimizationHelper17 =>
      'Add Kashkool to \"Never sleeping apps\".';

  @override
  String get batteryOptimizationHelper18 => 'EMUI / MagicOS';

  @override
  String get batteryOptimizationHelper19 =>
      'Go to Settings -> Battery -> App launch.';

  @override
  String get batteryOptimizationHelper20 =>
      'Find \"Kashkool\", switch to manual, and turn on Auto-launch and Run in background.';

  @override
  String get batteryOptimizationHelper21 => 'System settings';

  @override
  String get batteryOptimizationHelper22 => 'Protect system notifications';

  @override
  String get batteryOptimizationHelper23 =>
      'Open the app info in your phone\'s settings.';

  @override
  String get batteryOptimizationHelper24 =>
      'Open \"Battery\" and choose \"Unrestricted\".';

  @override
  String get batteryOptimizationHelper25 =>
      'Make sure ultra power saving mode is off so collection reminders arrive.';

  @override
  String get homeWidgetService1 => 'None';

  @override
  String get homeWidgetService2 => '1 customer';

  @override
  String get homeWidgetService3 => '2 customers';

  @override
  String homeWidgetService4(Object count) {
    return '$count customers';
  }

  @override
  String get pinLockScreen1 => 'Wrong PIN, try again';

  @override
  String get pinLockScreen2 => 'PINs don\'t match, try again';

  @override
  String get pinLockScreen3 =>
      'Fingerprint is unavailable or not set up on this device';

  @override
  String get pinLockScreen4 => 'Welcome to Kashkool 📒';

  @override
  String get pinLockScreen5 => 'Set a new PIN';

  @override
  String get pinLockScreen6 => 'Re-enter the PIN to confirm';

  @override
  String get pinLockScreen7 => 'Enter your 4-digit PIN';

  @override
  String get pinLockScreen8 =>
      'Choose 4 digits you\'ll remember to lock the app';

  @override
  String get pinLockScreen9 => 'Type the same digits again';

  @override
  String get pinLockScreen10 => 'Fingerprint';

  @override
  String get pinLockScreen11 => 'Clear';

  @override
  String get securityService1 => 'Confirm it\'s you to open Kashkool';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsLanguageSystem => 'Phone language (automatic)';

  @override
  String get cloudDeleteAccountTitle => 'Delete my cloud account';

  @override
  String get cloudDeleteAccountSubtitle =>
      'Permanently deletes your cloud backups and account — data on this phone stays';

  @override
  String get cloudDeleteAccountConfirmTitle =>
      'Delete your account permanently?';

  @override
  String get cloudDeleteAccountConfirmBody =>
      'We\'ll delete your account and all cloud backups of the shops you own. This can\'t be undone. Data on this phone stays as it is.';

  @override
  String get cloudDeleteAccountConfirmButton => 'Delete permanently';

  @override
  String get cloudDeleteAccountDone => 'Your cloud account was deleted';

  @override
  String get authFirstTimeTitle => 'Welcome to Kashkool! 👋';

  @override
  String get authFirstTimeQuestion =>
      'Do you already have an account or are you a new user?';

  @override
  String get authHaveAccount => 'I have an account';

  @override
  String get authHaveAccountSubtitle =>
      'Sign in and we will restore all your shop data immediately';

  @override
  String get authNewUser => 'New user';

  @override
  String get authNewUserSubtitle =>
      'Start a new ledger and set up your shop step by step';

  @override
  String get authContinueGuest => 'Continue as guest (offline)';

  @override
  String get authContinueGuestSubtitle =>
      'Use the app completely locally without internet';

  @override
  String get authLogin => 'Sign In';

  @override
  String get authRegister => 'Create Account';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Password';

  @override
  String get authPasswordConfirm => 'Confirm Password';

  @override
  String get authNameOptional => 'Full Name (Optional)';

  @override
  String get authLoginButton => 'Sign In';

  @override
  String get authRegisterButton => 'Create Account';

  @override
  String get authOrGoogle => 'Or continue with Google';

  @override
  String get authSignInWithGoogle => 'تسجيل الدخول بحساب Google';

  @override
  String get authSignInWithGoogleSubtitle =>
      'مزامنة سحابية واسترجاع بيانات محلك تلقائياً';

  @override
  String get authSwitchAccount => 'Switch Account';

  @override
  String get authSwitchAccountSubtitle =>
      'Pick another account or log in with a new one';

  @override
  String get authAddAccount => '+ Log in with another account';

  @override
  String get authCurrentAccount => 'Currently Active';

  @override
  String get authPasswordsDontMatch => 'Passwords do not match';

  @override
  String get authPasswordTooShort => 'Password must be at least 6 characters';

  @override
  String get authInvalidEmail => 'Please enter a valid email address';

  @override
  String get authLoginSuccess => 'Signed in successfully 🎉';

  @override
  String get authRegisterSuccess => 'Account created successfully 🎉';

  @override
  String authSwitchedTo(Object email) {
    return 'Switched to account: $email';
  }

  @override
  String get cloudApiEmailTaken =>
      'This email is already registered, please sign in';

  @override
  String get cloudApiInvalidCredentials => 'Invalid email or password';

  @override
  String get authBackupBeforeSwitchTitle => 'Warning: Unsaved data!';

  @override
  String get authBackupBeforeSwitchBody =>
      'There are unsaved local changes that have not been backed up to the cloud for this account. If you switch accounts now, local data will be wiped and cannot be recovered unless backed up first.';

  @override
  String get authBackupFirst => 'Back up first';

  @override
  String get authSwitchWithoutBackup => 'Switch & wipe local data';

  @override
  String get authFetchingData => 'Fetching your data from the cloud…';

  @override
  String get authEmailLoginButton => 'Sign in with Email';

  @override
  String get authEmailRegisterButton => 'Create account with Email';

  @override
  String get authWipingData => 'Wiping local data and switching account…';

  @override
  String get offersBroadcasterTitle => 'Offers & Greetings';

  @override
  String get offersBroadcasterSubtitle =>
      'Send greetings and offers to your customers via WhatsApp in 1-tap with zero cost';

  @override
  String get offersTemplateSection => '1. Choose Template';

  @override
  String get offersAudienceSection => '2. Choose Target Audience';

  @override
  String get offersMessageSection => '3. Message & Live Preview';

  @override
  String get offersTemplateRamadan => 'Holy Ramadan 🌙';

  @override
  String get offersTemplateEid => 'Blessed Eid 🎉';

  @override
  String get offersTemplateBackToSchool => 'Back to School 📚';

  @override
  String get offersTemplateNewOffer => 'New Special Offers 🎁';

  @override
  String get offersTemplateCustom => 'Custom Message ✍️';

  @override
  String get offersAudienceAllWithPhone => 'All customers with phone';

  @override
  String get offersAudienceGoodRating => 'Punctual payers only (Good rating)';

  @override
  String get offersAudienceActive30Days => 'Active in last 30 days';

  @override
  String get offersAudienceManual => 'Manual customer selection';

  @override
  String get offersTipSpam =>
      '💡 Tip: We recommend sending to ≤ 50 customers per session to avoid WhatsApp spam limits.';

  @override
  String offersStartCampaign(Object count) {
    return 'Start Sending Queue ($count customers)';
  }

  @override
  String offersResumeCampaign(Object pending) {
    return 'Resume Previous Campaign ($pending remaining)';
  }

  @override
  String get offersDiscardCampaign => 'Start a new campaign instead';

  @override
  String get offersQueueTitle => 'Sending Queue';

  @override
  String offersProgressLabel(Object sent, Object total, Object percent) {
    return 'Sent $sent of $total customers ($percent%)';
  }

  @override
  String get offersSendViaWhatsApp => 'Send via WhatsApp';

  @override
  String get offersSkipCustomer => 'Skip Customer';

  @override
  String get offersPauseQueue => 'Pause & Back';

  @override
  String get offersCampaignCompleteTitle => 'Campaign Completed! 🎉';

  @override
  String get offersCampaignCompleteSubtitle =>
      'All campaign messages have been sent to your selected customers.';

  @override
  String get offersNoRecipients =>
      'No customers match the selected filter with a phone number';

  @override
  String offersSelectManualCustomers(Object count) {
    return 'Select Customers ($count selected)';
  }

  @override
  String get offersSampleCustomerName => 'Mohamed Ahmed';

  @override
  String get offersInsertPlaceholderHint =>
      'Tap to insert dynamic placeholder:';

  @override
  String get offersDefaultRamadanText =>
      'Happy Ramadan {customer_name}! Best wishes to you and your family from {shop_name} 🌙✨';

  @override
  String get offersDefaultEidText =>
      'Eid Mubarak to you and your family, {customer_name}! Wishing you joy from {shop_name} 🎉🐑';

  @override
  String get offersDefaultBackToSchoolText =>
      'Wishing your family a successful new school year, {customer_name}! Visit {shop_name} for all your needs 📚✏️';

  @override
  String get offersDefaultNewOfferText =>
      'Hello {customer_name}! We have exciting new offers and discounts waiting for you at {shop_name} 🎁🔥';

  @override
  String get offersDefaultCustomText =>
      'Hello {customer_name}, greetings from {shop_name} 👋';

  @override
  String offersSentSuccessPrompt(Object name) {
    return 'Was the message sent to $name successfully?';
  }

  @override
  String get offersYesSent => 'Yes, Sent';

  @override
  String get offersNotSent => 'Not Sent';

  @override
  String get offersPreviewCardTitle => 'Message Preview for Customer';

  @override
  String get offersIncludeGrowthFooter => 'Append Kashkool referral footer';

  @override
  String offersCampaignActiveBanner(Object sent, Object total) {
    return 'You have an active unfinished campaign ($sent of $total sent)';
  }
}
