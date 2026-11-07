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
  String get navCashDrawer => 'Cash Drawer';

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
  String placeholderScreen(Object screenName) {
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
  String get customerPhoneInvalid =>
      'Invalid mobile number (010, 011, 012, 015)';

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
  String get addDebtTitle => 'Record Debt (عليه)';

  @override
  String get addPaymentTitle => 'Record Payment (دفع)';

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
  String get iOweHim => 'I Owe (عليّا)';

  @override
  String get iPaidHim => 'I Paid (دفعتله)';

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
}
