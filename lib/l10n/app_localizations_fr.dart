// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Kashkool';

  @override
  String get navCustomers => 'Clients';

  @override
  String get navCollection => 'Recouvrement';

  @override
  String get navSuppliers => 'Fournisseurs';

  @override
  String get navCashDrawer => 'Caisse';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get debt => 'Doit';

  @override
  String get payment => 'Paiement';

  @override
  String get settled => 'Soldé';

  @override
  String get currency => 'EGP';

  @override
  String get piaster => 'Pt';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get search => 'Rechercher...';

  @override
  String placeholderScreen(String screenName) {
    return 'Écran $screenName';
  }

  @override
  String get comingSoon => 'Bientôt disponible';

  @override
  String get totalReceivablesTitle => 'Ce que les clients vous doivent';

  @override
  String get searchCustomersHint => 'Rechercher par nom ou téléphone...';

  @override
  String get filterAll => 'Tous';

  @override
  String get filterHasDebt => 'Avec dette';

  @override
  String get filterSettled => 'Soldés';

  @override
  String get filterLate => 'En retard';

  @override
  String get sortHighestDebt => 'Dette la plus élevée';

  @override
  String get sortName => 'Nom';

  @override
  String get sortLastActivity => 'Dernière activité';

  @override
  String get addNewCustomer => 'Nouveau client';

  @override
  String get addCustomer => 'Ajouter un client';

  @override
  String get editCustomer => 'Modifier le client';

  @override
  String get customerName => 'Nom du client';

  @override
  String get customerNameHint => 'ex. : Mohamed l\'épicier';

  @override
  String get customerNameRequired => 'Le nom du client est obligatoire';

  @override
  String get customerNameTooShort =>
      'Le nom doit comporter au moins 2 caractères';

  @override
  String get customerPhone => 'Numéro de mobile';

  @override
  String get customerPhoneHint => '010xxxxxxxx';

  @override
  String get customerPhoneInvalid => 'Numéro invalide (010, 011, 012, 015)';

  @override
  String get customerNotes => 'Notes';

  @override
  String get customerNotesHint => 'ex. : voisin du 2e étage';

  @override
  String get creditLimit => 'Plafond de crédit (facultatif)';

  @override
  String get creditLimitHint => 'ex. : 1000';

  @override
  String get noCustomersTitle => 'Votre carnet est vide !';

  @override
  String get noCustomersSubtitle =>
      'Appuyez sur le bouton ci-dessous pour ajouter votre premier client et suivre ses comptes facilement';

  @override
  String get noSearchResults => 'Aucun client trouvé';

  @override
  String get duplicateCustomerWarning =>
      'Attention : un client avec le même nom ou numéro existe déjà';

  @override
  String get customerDetails => 'Détails du client';

  @override
  String get callCustomer => 'Appeler';

  @override
  String get deleteCustomer => 'Supprimer le client';

  @override
  String get deleteCustomerConfirm => 'Confirmer la suppression';

  @override
  String deleteCustomerWarningDebt(String amount) {
    return 'Attention ! Ce client doit encore $amount. Voulez-vous vraiment le supprimer ?';
  }

  @override
  String deleteCustomerSafeConfirm(String name) {
    return 'Voulez-vous vraiment supprimer le client $name ?';
  }

  @override
  String get customerDeleted => 'Client supprimé';

  @override
  String get customerSaved => 'Client enregistré';

  @override
  String get lastActivityNever => 'Aucune opération';

  @override
  String lastActivityDate(String date) {
    return 'Dernière opération : $date';
  }

  @override
  String creditLimitLabel(String amount) {
    return 'Plafond : $amount';
  }

  @override
  String get creditLimitExceeded => 'Plafond dépassé !';

  @override
  String get heOwes => 'Doit';

  @override
  String get hePaid => 'Crédit (a trop payé)';

  @override
  String get currentBalance => 'Solde actuel';

  @override
  String get noTransactionsYet => 'Aucune opération enregistrée';

  @override
  String get addDebtTitle => 'Enregistrer une dette';

  @override
  String get addPaymentTitle => 'Enregistrer un paiement';

  @override
  String get amountLabel => 'Montant';

  @override
  String get amountRequired => 'Saisissez un montant valide supérieur à 0';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get yesterday => 'Hier';

  @override
  String get date => 'Date';

  @override
  String get pickDate => 'Choisir la date';

  @override
  String get paymentMethod => 'Mode de paiement';

  @override
  String get methodCash => 'Espèces';

  @override
  String get methodInstapay => 'InstaPay';

  @override
  String get methodWallet => 'Portefeuille mobile';

  @override
  String get methodOther => 'Autre';

  @override
  String get noteOptional => 'Note (facultatif : sucre, huile, recharge...)';

  @override
  String get voiceDictation => 'Dictée vocale';

  @override
  String get listening => 'À l\'écoute... Parlez maintenant';

  @override
  String get speechNotAvailable =>
      'Dictée vocale indisponible sur cet appareil';

  @override
  String get attachPhoto => 'Joindre une photo';

  @override
  String get camera => 'Appareil photo';

  @override
  String get gallery => 'Galerie';

  @override
  String get removePhoto => 'Retirer la photo';

  @override
  String get overpaymentTitle => 'Le montant dépasse la dette !';

  @override
  String overpaymentMessage(
    String paidAmount,
    String dueAmount,
    String creditAmount,
  ) {
    return 'Le montant payé ($paidAmount) dépasse la dette ($dueAmount). Enregistrer la différence ($creditAmount) comme crédit du client ?';
  }

  @override
  String get overpaymentConfirm => 'Oui, enregistrer le crédit';

  @override
  String get transactionSaved => 'Opération enregistrée';

  @override
  String get undo => 'Annuler';

  @override
  String get transactionUndone => 'Opération annulée';

  @override
  String get transactionDetails => 'Détails de l\'opération';

  @override
  String get editTransaction => 'Modifier l\'opération';

  @override
  String get deleteTransaction => 'Supprimer l\'opération';

  @override
  String get deleteTransactionConfirm => 'Supprimer cette opération ?';

  @override
  String get transactionDeleted => 'Opération supprimée';

  @override
  String get viewPhoto => 'Voir la photo';

  @override
  String get creditLimitWarningTitle => 'Alerte plafond de crédit';

  @override
  String creditLimitExceededDialog(
    String customerName,
    String newTotal,
    String limit,
  ) {
    return '$customerName devra $newTotal, alors que son plafond est de $limit';
  }

  @override
  String get saveAnyway => 'Enregistrer quand même';

  @override
  String get changeLimit => 'Modifier le plafond';

  @override
  String get newCreditLimit => 'Nouveau plafond';

  @override
  String get limitUpdated => 'Plafond mis à jour';

  @override
  String get totalPayablesTitle => 'Ce que vous devez aux fournisseurs';

  @override
  String get netMarketPosition => 'Position nette';

  @override
  String netReceivables(String amount) {
    return 'Net à recevoir : $amount';
  }

  @override
  String netPayables(String amount) {
    return 'Net à payer : $amount';
  }

  @override
  String get netSettled => 'Comptes équilibrés (0 EGP)';

  @override
  String get addNewSupplier => 'Nouveau fournisseur';

  @override
  String get addSupplier => 'Ajouter un fournisseur';

  @override
  String get editSupplier => 'Modifier le fournisseur';

  @override
  String get supplierName => 'Nom du fournisseur / commercial';

  @override
  String get supplierNameHint => 'ex. : Karim, commercial Danone';

  @override
  String get supplierNameRequired => 'Le nom du fournisseur est obligatoire';

  @override
  String get company => 'Société / marque';

  @override
  String get companyHint => 'ex. : Danone, Lay\'s';

  @override
  String get visitDay => 'Jour de visite hebdomadaire';

  @override
  String get noSpecificDay => 'Pas de jour fixe';

  @override
  String get supplierNotes => 'Notes';

  @override
  String get supplierNotesHint => 'ex. : passe vers 10 h';

  @override
  String get noSuppliersTitle => 'Aucun fournisseur !';

  @override
  String get noSuppliersSubtitle =>
      'Appuyez sur le bouton ci-dessous pour ajouter votre premier fournisseur';

  @override
  String get noSupplierSearchResults => 'Aucun fournisseur trouvé';

  @override
  String get searchSuppliersHint =>
      'Rechercher par nom, société ou téléphone...';

  @override
  String get supplierDetails => 'Détails du fournisseur';

  @override
  String get iOweHim => 'Je dois';

  @override
  String get iPaidHim => 'J\'ai payé';

  @override
  String get deleteSupplier => 'Supprimer le fournisseur';

  @override
  String get deleteSupplierConfirm => 'Confirmer la suppression';

  @override
  String deleteSupplierWarningDebt(String amount) {
    return 'Attention ! Vous devez encore $amount à ce fournisseur. Le supprimer quand même ?';
  }

  @override
  String deleteSupplierSafeConfirm(String name) {
    return 'Supprimer le fournisseur $name ?';
  }

  @override
  String get supplierDeleted => 'Fournisseur supprimé';

  @override
  String get supplierSaved => 'Fournisseur enregistré';

  @override
  String visitDayPrefix(String day) {
    return 'Jour de visite : $day';
  }

  @override
  String get sortCompany => 'Société';

  @override
  String get sortVisitDay => 'Jour de visite';

  @override
  String get dueCustomersTitle => 'Clients à relancer';

  @override
  String get totalDueTitle => 'Total dû';

  @override
  String dueCustomersCount(int count) {
    return '$count clients';
  }

  @override
  String dueHeaderSummary(int count, String amount) {
    return '$count clients vous doivent $amount';
  }

  @override
  String oldestDebtDays(int days) {
    return 'Dette la plus ancienne : il y a $days jours';
  }

  @override
  String get oldestDebtToday => 'Dette enregistrée aujourd\'hui';

  @override
  String lastReminderDays(int days) {
    return 'Dernier rappel : il y a $days jours';
  }

  @override
  String get lastReminderToday => 'Dernier rappel : aujourd\'hui';

  @override
  String get neverReminded => 'Jamais relancé';

  @override
  String snoozedUntilDate(String date) {
    return 'Reporté jusqu\'au $date';
  }

  @override
  String get sendWhatsApp => 'WhatsApp';

  @override
  String get sendSms => 'SMS';

  @override
  String get moreActions => 'Plus';

  @override
  String get snooze3Days => 'Reporter de 3 jours';

  @override
  String get snooze7Days => 'Reporter d\'une semaine';

  @override
  String get cancelSnooze => 'Annuler le report';

  @override
  String get recordCollectionPayment => 'Enregistrer un paiement';

  @override
  String get didSendMessage => 'Message envoyé ?';

  @override
  String didSendMessageDesc(String name) {
    return 'Avez-vous envoyé le rappel à $name par WhatsApp ?';
  }

  @override
  String get yesSent => 'Oui, envoyé';

  @override
  String get notSent => 'Non, pas envoyé';

  @override
  String get reminderMarkedSent => 'Rappel enregistré';

  @override
  String get snoozedSuccess => 'Rappel reporté';

  @override
  String get noDueCustomersTitle => 'Aucun recouvrement aujourd\'hui 🎉';

  @override
  String get noDueCustomersSubtitle =>
      'Tous les clients sont à jour ou ont été relancés récemment.';

  @override
  String get whatsAppNotInstalled =>
      'WhatsApp n\'est pas installé. Envoyer un SMS à la place ?';

  @override
  String get openSms => 'Envoyer un SMS';

  @override
  String get growthFooter => '\nEnvoyé via l\'app Kashkool 📒';

  @override
  String get statementTitle => 'Relevé de compte';

  @override
  String get generateStatement => 'Générer un relevé';

  @override
  String get statementAllTime => 'Toutes les opérations';

  @override
  String get statementThisMonth => 'Ce mois-ci';

  @override
  String get statementCustomRange => 'Période personnalisée';

  @override
  String get statementFormatA4 => 'Format A4';

  @override
  String get statementFormatReceipt => 'Ticket thermique (80 mm)';

  @override
  String get dateCol => 'Date';

  @override
  String get descriptionCol => 'Libellé';

  @override
  String get debtCol => 'Débit';

  @override
  String get paymentCol => 'Paiement';

  @override
  String get balanceCol => 'Solde';

  @override
  String get startingBalance => 'Solde d\'ouverture';

  @override
  String get finalBalance => 'Solde final';

  @override
  String periodLabel(String period) {
    return 'Période : $period';
  }

  @override
  String statementGeneratedAt(String date) {
    return 'Généré le : $date';
  }

  @override
  String get shareStatement => 'Partager le relevé';

  @override
  String get printStatement => 'Imprimer';

  @override
  String statementShareSubject(String name) {
    return 'Relevé de compte - $name';
  }

  @override
  String get totalDebits => 'Total des achats / avances';

  @override
  String get totalCredits => 'Total payé';

  @override
  String get drawerTitle => 'Clôture de caisse';

  @override
  String get todayDrawer => 'Caisse du jour';

  @override
  String get expectedInDrawer => 'Attendu en caisse';

  @override
  String get openingCash => 'Fond de caisse';

  @override
  String get openingCashHint => 'Montant en caisse en début de journée';

  @override
  String get editOpeningCash => 'Modifier le fond de caisse';

  @override
  String get cashSales => 'Ventes en espèces';

  @override
  String get addCashSales => 'Enregistrer des ventes en espèces';

  @override
  String get cashIn => 'Entrées (espèces)';

  @override
  String get digitalIn => 'Entrées (numérique)';

  @override
  String get cashOut => 'Sorties (espèces)';

  @override
  String get customerPaymentsCash => 'Paiements clients (espèces)';

  @override
  String get customerPaymentsDigital => 'Paiements clients (numérique)';

  @override
  String get supplierPaymentsCash => 'Paiements fournisseurs (espèces)';

  @override
  String get expensesCash => 'Dépenses (espèces)';

  @override
  String get addExpense => 'Ajouter une dépense';

  @override
  String get editExpense => 'Modifier la dépense';

  @override
  String get deleteExpense => 'Supprimer la dépense';

  @override
  String get deleteExpenseConfirm => 'Supprimer cette dépense ?';

  @override
  String get expenseCategory => 'Catégorie';

  @override
  String get catRent => 'Loyer';

  @override
  String get catElectricity => 'Électricité et charges';

  @override
  String get catSalary => 'Salaires';

  @override
  String get catSupplies => 'Marchandises et fournitures';

  @override
  String get catSupplierPayment => 'Paiement fournisseur';

  @override
  String get catOther => 'Autre';

  @override
  String get closeDay => 'Clôturer la journée';

  @override
  String get reopenDay => 'Rouvrir la journée';

  @override
  String get reopenDayConfirm => 'Rouvrir cette journée pour la modifier ?';

  @override
  String get dayClosedSuccess => 'Journée clôturée';

  @override
  String get dayReopenedSuccess => 'Journée rouverte';

  @override
  String get dayIsClosed => 'Journée clôturée';

  @override
  String get dayIsOpen => 'Journée ouverte';

  @override
  String get actualCountLabel => 'Espèces comptées en caisse';

  @override
  String get actualCountHint => 'Saisissez le montant compté';

  @override
  String get drawerBalanced => 'Caisse parfaitement équilibrée 🎉';

  @override
  String get drawerShortage => 'Manque en caisse';

  @override
  String get drawerSurplus => 'Excédent en caisse';

  @override
  String differenceAmount(String amount) {
    return 'Écart : $amount';
  }

  @override
  String get closeDaySummary => 'Résumé de clôture';

  @override
  String get confirmCloseDay => 'Confirmer la clôture';

  @override
  String get historyTab => 'Historique';

  @override
  String get todayTab => 'Caisse du jour';

  @override
  String get monthlyTotals => 'Totaux du mois';

  @override
  String get monthlySales => 'Ventes en espèces';

  @override
  String get monthlyExpenses => 'Dépenses en espèces';

  @override
  String get monthlyNet => 'Solde net de caisse';

  @override
  String get drawerNotes => 'Notes de clôture (facultatif)';

  @override
  String get noExpensesYet => 'Aucune dépense aujourd\'hui';

  @override
  String get noHistoryYet => 'Aucune journée précédente';

  @override
  String get expenseAddedSuccess => 'Dépense enregistrée';

  @override
  String get cashSalesAddedSuccess => 'Ventes en espèces enregistrées';

  @override
  String get openingCashUpdatedSuccess => 'Fond de caisse mis à jour';

  @override
  String get dayDetails => 'Détails de la journée';

  @override
  String closedAtTime(String time) {
    return 'Clôturée à : $time';
  }

  @override
  String get readOnlyDayNotice =>
      'Cette journée est clôturée. Pour modifier, appuyez sur Rouvrir la journée.';

  @override
  String get privacyModeTitle => 'Mode confidentialité';

  @override
  String get privacyModeSubtitle =>
      'Masquer les montants à l\'écran et dans le widget (••••••)';

  @override
  String get shareAppTitle => 'Partager l\'application';

  @override
  String get shareAppSubtitle => 'Envoyez Kashkool à d\'autres commerçants';

  @override
  String shopCodeLabel(String code) {
    return 'Code boutique : $code';
  }

  @override
  String get growthFooterToggleTitle =>
      'Masquer la signature Kashkool des messages';

  @override
  String get growthFooterToggleSubtitle =>
      'Disponible dans l\'offre payante 🔒';

  @override
  String get codeCopied => 'Code copié';

  @override
  String get main1 => 'Kashkool';

  @override
  String get notebookImportButton1 => 'Transférez votre carnet dans l\'app 📒';

  @override
  String get notebookImportButton2 =>
      'Inutile de tout recopier : le nom du client et ce qu\'il doit aujourd\'hui suffisent.';

  @override
  String get notebookImportButton3 => 'Clients et soldes';

  @override
  String get notebookImportButton4 =>
      'Une ligne par client : nom, téléphone et montant dû';

  @override
  String get notebookImportButton5 => 'Ancien paiement échelonné';

  @override
  String get notebookImportButton6 =>
      'Prix, montant payé, échéances restantes et prochaine date';

  @override
  String get notebookImportButton7 => 'Importer du carnet';

  @override
  String get oldInstallmentImportScreen1 => 'Date de la prochaine échéance';

  @override
  String get oldInstallmentImportScreen2 => 'Échéancier enregistré ✓';

  @override
  String oldInstallmentImportScreen3(
    Object remaining,
    Object countValue,
    Object nextDue,
  ) {
    return 'Reste $remaining en $countValue échéances, la première le $nextDue.';
  }

  @override
  String get oldInstallmentImportScreen4 => 'Terminé';

  @override
  String get oldInstallmentImportScreen5 => 'Un autre';

  @override
  String get oldInstallmentImportScreen6 =>
      'Échec de l\'enregistrement, rien n\'a été enregistré';

  @override
  String get oldInstallmentImportScreen7 => ' par mois';

  @override
  String get oldInstallmentImportScreen8 => ' par semaine';

  @override
  String oldInstallmentImportScreen9(
    Object remaining,
    Object count,
    Object count2,
    Object monthly,
  ) {
    return 'Reste $remaining — $count échéances × environ $count2$monthly';
  }

  @override
  String get oldInstallmentImportScreen10 => 'Ancien échéancier du carnet';

  @override
  String oldInstallmentImportScreen11(Object savedCount) {
    return 'Ancien échéancier ($savedCount)';
  }

  @override
  String get oldInstallmentImportScreen12 =>
      'Pour les échéanciers commencés avant l\'app : saisissez le prix, ce qui a déjà été payé et le nombre d\'échéances restantes. L\'app crée seulement le calendrier restant et ne compte pas les anciens paiements dans la caisse du jour.';

  @override
  String get oldInstallmentImportScreen13 => 'Client';

  @override
  String get oldInstallmentImportScreen14 => 'Nom du client';

  @override
  String get oldInstallmentImportScreen15 =>
      'Nom d\'un client existant ou nouveau';

  @override
  String get oldInstallmentImportScreen16 => 'Saisissez le nom du client';

  @override
  String get oldInstallmentImportScreen17 =>
      'Mobile du client (si nouveau — facultatif)';

  @override
  String get oldInstallmentImportScreen18 => 'Numéro invalide';

  @override
  String get oldInstallmentImportScreen19 => 'Échéancier';

  @override
  String get oldInstallmentImportScreen20 => 'Article';

  @override
  String get oldInstallmentImportScreen21 => 'ex. : réfrigérateur Samsung';

  @override
  String get oldInstallmentImportScreen22 => 'Saisissez l\'article';

  @override
  String get oldInstallmentImportScreen23 => 'Prix total';

  @override
  String get oldInstallmentImportScreen24 => 'EGP';

  @override
  String get oldInstallmentImportScreen25 => 'Obligatoire';

  @override
  String get oldInstallmentImportScreen26 => 'Invalide';

  @override
  String get oldInstallmentImportScreen27 => 'Déjà payé';

  @override
  String get oldInstallmentImportScreen28 => 'Doit être inférieur au prix';

  @override
  String get oldInstallmentImportScreen29 => 'Échéances restantes';

  @override
  String get oldInstallmentImportScreen30 => 'De 1 à 120';

  @override
  String oldInstallmentImportScreen31(Object nextDue) {
    return 'Prochaine : $nextDue';
  }

  @override
  String get oldInstallmentImportScreen32 => 'Mensuel';

  @override
  String get oldInstallmentImportScreen33 => 'Hebdomadaire';

  @override
  String get oldInstallmentImportScreen34 => 'Garant (facultatif)';

  @override
  String get oldInstallmentImportScreen35 => 'Nom du garant';

  @override
  String get oldInstallmentImportScreen36 => 'Mobile du garant';

  @override
  String get oldInstallmentImportScreen37 =>
      'Photos du carnet ou du contrat (facultatif — restent sur le téléphone)';

  @override
  String get oldInstallmentImportScreen38 =>
      'Vous pouvez ajouter plusieurs photos : pages du carnet, contrat, pièce d\'identité du garant…';

  @override
  String oldInstallmentImportScreen39(Object photosLength) {
    return '$photosLength photos — seront ajoutées aux photos du client';
  }

  @override
  String get oldInstallmentImportScreen40 => 'Enregistrement…';

  @override
  String get oldInstallmentImportScreen41 => 'Enregistrer l\'échéancier';

  @override
  String get notebookImportScreen1 => 'Soldes au';

  @override
  String notebookImportScreen2(Object firstError, Object error) {
    return 'Ligne $firstError : $error';
  }

  @override
  String get notebookImportScreen3 => 'Saisissez au moins un nom de client';

  @override
  String get notebookImportScreen4 => 'Enregistré ✓';

  @override
  String notebookImportScreen5(Object newCustomers) {
    return '$newCustomers nouveaux clients';
  }

  @override
  String notebookImportScreen6(Object existingCustomers) {
    return '$existingCustomers clients existants — ajouté à leur solde';
  }

  @override
  String notebookImportScreen7(Object totalPiasters) {
    return 'Total : $totalPiasters';
  }

  @override
  String get notebookImportScreen8 => 'Page suivante';

  @override
  String get notebookImportScreen9 => 'Quitter sans enregistrer ?';

  @override
  String get notebookImportScreen10 =>
      'Ce que vous avez saisi sur cette page ne sera pas enregistré.';

  @override
  String get notebookImportScreen11 => 'Continuer';

  @override
  String get notebookImportScreen12 => 'Quitter';

  @override
  String get notebookImportScreen13 => 'Importer le carnet 📒';

  @override
  String notebookImportScreen14(Object savedPages) {
    return 'Importer le carnet — page $savedPages';
  }

  @override
  String get notebookImportScreen15 => 'Nouvelle ligne';

  @override
  String notebookImportScreen16(Object validLength) {
    return '$validLength clients';
  }

  @override
  String get notebookImportScreen17 => 'Enregistrer';

  @override
  String get notebookImportScreen18 =>
      'Un client par ligne : nom, mobile si vous l\'avez, et montant dû. Appuyez sur « Suivant » sur le clavier pour aller vite.';

  @override
  String get notebookImportScreen19 => 'Soldes à ce jour';

  @override
  String notebookImportScreen20(Object asOf) {
    return 'Au $asOf';
  }

  @override
  String get notebookImportScreen21 =>
      'Photos de la page (facultatif) : enregistrées avec chaque client de la page';

  @override
  String notebookImportScreen22(Object pagePhotosLength) {
    return '$pagePhotosLength photos de la page — enregistrées avec chaque client';
  }

  @override
  String get notebookImportScreen23 => 'Page';

  @override
  String get notebookImportScreen24 => 'Photos de ce client';

  @override
  String get notebookImportScreen25 => 'Supprimer la ligne';

  @override
  String get notebookImportScreen26 => 'Mobile (facultatif)';

  @override
  String get notebookImportScreen27 => 'Montant';

  @override
  String get notebookImportScreen28 => 'Recherche…';

  @override
  String notebookImportScreen29(Object name) {
    return '« $name » existe déjà — le montant sera ajouté à son solde';
  }

  @override
  String get notebookImportScreen30 => 'Le client doit ce montant';

  @override
  String get notebookImportScreen31 => 'Vous devez ce montant au client';

  @override
  String get notebookImportScreen32 => 'Doit';

  @override
  String get notebookImportScreen33 => 'Crédit';

  @override
  String get notebookImportService1 => 'Ancien solde du carnet';

  @override
  String get notebookImportService2 => 'Page du carnet';

  @override
  String get notebookImportService3 => 'Nom manquant';

  @override
  String get notebookImportService4 => 'Nom trop long';

  @override
  String get notebookImportService5 => 'Montant invalide';

  @override
  String get notebookImportService6 =>
      'Le montant payé ne peut pas être négatif';

  @override
  String get notebookImportService7 =>
      'Le montant payé doit être inférieur au prix total';

  @override
  String get notebookImportService8 => 'Il doit rester au moins 1 échéance';

  @override
  String notebookImportService9(Object paidPiasters) {
    return 'Importé du carnet — déjà payé : $paidPiasters';
  }

  @override
  String notebookImportService10(Object trim, Object totalPricePiasters) {
    return 'Ancien échéancier : $trim (reste sur $totalPricePiasters)';
  }

  @override
  String notebookImportService11(Object trim) {
    return 'Échéancier : $trim';
  }

  @override
  String get installmentsScreen1 => 'Paiements échelonnés 📋';

  @override
  String get installmentsScreen2 =>
      'Rechercher par client, article, mobile ou garant...';

  @override
  String get installmentsScreen3 => 'Total des échéances';

  @override
  String get installmentsScreen4 => 'En retard';

  @override
  String get installmentsScreen5 => 'Plans actifs';

  @override
  String get installmentsScreen6 => 'Tous';

  @override
  String get installmentsScreen7 => 'Actifs ⏳';

  @override
  String get installmentsScreen8 => 'Terminés ✓';

  @override
  String get installmentsScreen9 => 'Annulés';

  @override
  String installmentsScreen10(Object e) {
    return 'Erreur de chargement : $e';
  }

  @override
  String get installmentsScreen11 => 'Aucun résultat';

  @override
  String get installmentsScreen12 => 'Aucun échéancier pour l\'instant';

  @override
  String get installmentsScreen13 =>
      'Appuyez sur (+ Nouvel échéancier) pour créer le premier plan d\'un client.';

  @override
  String get installmentsScreen14 => 'Nouvel échéancier';

  @override
  String installmentPlanDetailsScreen1(Object instapay) {
    return 'InstaPay : $instapay';
  }

  @override
  String installmentPlanDetailsScreen2(Object wallet) {
    return 'Portefeuille / Vodafone Cash : $wallet';
  }

  @override
  String installmentPlanDetailsScreen3(Object phoneNum) {
    return 'Téléphone : $phoneNum';
  }

  @override
  String get installmentPlanDetailsScreen4 => 'Annuler l\'échéancier';

  @override
  String get installmentPlanDetailsScreen5 =>
      'Annuler ce plan ? Les rappels s\'arrêtent, l\'historique des paiements est conservé.';

  @override
  String get installmentPlanDetailsScreen6 => 'Retour';

  @override
  String get installmentPlanDetailsScreen7 => 'Annuler le plan';

  @override
  String get installmentPlanDetailsScreen8 => 'Échéancier annulé';

  @override
  String get installmentPlanDetailsScreen9 => 'Supprimer l\'échéancier';

  @override
  String get installmentPlanDetailsScreen10 => 'Supprimer cet échéancier ?';

  @override
  String get installmentPlanDetailsScreen11 => 'Annuler';

  @override
  String get installmentPlanDetailsScreen12 => 'Supprimer';

  @override
  String get installmentPlanDetailsScreen13 => 'Échéancier supprimé';

  @override
  String get installmentPlanDetailsScreen14 => 'Détails de l\'échéancier';

  @override
  String installmentPlanDetailsScreen15(Object e) {
    return 'Erreur : $e';
  }

  @override
  String get installmentPlanDetailsScreen16 =>
      'Échéancier introuvable ou supprimé';

  @override
  String get installmentPlanDetailsScreen17 => 'Supprimer le plan';

  @override
  String get installmentPlanDetailsScreen18 => 'Prix total :';

  @override
  String get installmentPlanDetailsScreen19 => 'Acompte :';

  @override
  String get installmentPlanDetailsScreen20 => 'Total payé :';

  @override
  String get installmentPlanDetailsScreen21 => 'Reste :';

  @override
  String get installmentPlanDetailsScreen22 => 'Solder par anticipation';

  @override
  String installmentPlanDetailsScreen23(Object guarantorName) {
    return 'Garant : $guarantorName';
  }

  @override
  String get installmentPlanDetailsScreen24 =>
      'Photo du contrat / reconnaissance de dette';

  @override
  String get installmentPlanDetailsScreen25 =>
      'Appuyez pour voir le document en grand';

  @override
  String get installmentPlanDetailsScreen26 => 'Document de l\'échéancier';

  @override
  String installmentPlanDetailsScreen27(Object installmentsLength) {
    return 'Calendrier ($installmentsLength)';
  }

  @override
  String get installmentPlanDetailsScreen28 => 'Paiement libre';

  @override
  String installmentPlanDetailsScreen29(
    Object installmentIndex,
    Object dueDate,
  ) {
    return 'Échéance $installmentIndex • $dueDate';
  }

  @override
  String installmentPlanDetailsScreen30(Object paidPiasters) {
    return 'Entièrement payé ✓ ($paidPiasters)';
  }

  @override
  String installmentPlanDetailsScreen31(
    Object paidPiasters,
    Object amountPiasters,
  ) {
    return '$paidPiasters payé sur $amountPiasters';
  }

  @override
  String get installmentPlanDetailsScreen32 => 'En retard ⚠️';

  @override
  String get installmentPlanDetailsScreen33 => 'À payer aujourd\'hui 🔔';

  @override
  String installmentPlanDetailsScreen34(Object amountPiasters) {
    return 'À venir • $amountPiasters';
  }

  @override
  String get installmentPlanDetailsScreen35 => 'Rappel WhatsApp';

  @override
  String get installmentPlanDetailsScreen36 => 'Payer';

  @override
  String get addInstallmentPlanScreen1 => 'Téléphone';

  @override
  String get addInstallmentPlanScreen2 => 'Téléviseur';

  @override
  String get addInstallmentPlanScreen3 => 'Lave-linge';

  @override
  String get addInstallmentPlanScreen4 => 'Réfrigérateur';

  @override
  String get addInstallmentPlanScreen5 => 'Cuisinière';

  @override
  String get addInstallmentPlanScreen6 => 'Ordinateur portable';

  @override
  String get addInstallmentPlanScreen7 => 'Moto';

  @override
  String get addInstallmentPlanScreen8 => 'Meubles';

  @override
  String get addInstallmentPlanScreen9 => 'Choisissez d\'abord un client';

  @override
  String get addInstallmentPlanScreen10 =>
      'L\'acompte doit être inférieur au prix total';

  @override
  String get addInstallmentPlanScreen11 => 'Échéancier créé et planifié ✓';

  @override
  String addInstallmentPlanScreen12(Object e) {
    return 'Une erreur s\'est produite : $e';
  }

  @override
  String addInstallmentPlanScreen13(Object e) {
    return 'Erreur de chargement des clients : $e';
  }

  @override
  String get addInstallmentPlanScreen14 => 'Choisir le client';

  @override
  String get addInstallmentPlanScreen15 => 'Veuillez choisir un client';

  @override
  String get addInstallmentPlanScreen16 => 'Article et montants';

  @override
  String get addInstallmentPlanScreen17 => 'Nom de l\'article *';

  @override
  String get addInstallmentPlanScreen18 => 'ex. : Samsung A15 128 Go';

  @override
  String get addInstallmentPlanScreen19 =>
      'Le nom doit comporter au moins 2 caractères';

  @override
  String get addInstallmentPlanScreen20 => 'Prix total (EGP) *';

  @override
  String get addInstallmentPlanScreen21 => 'ex. : 12000';

  @override
  String get addInstallmentPlanScreen22 => 'Montant invalide';

  @override
  String get addInstallmentPlanScreen23 => 'Acompte (EGP)';

  @override
  String get addInstallmentPlanScreen24 => 'Montant à échelonner :';

  @override
  String get addInstallmentPlanScreen25 => 'Durée et fréquence';

  @override
  String addInstallmentPlanScreen26(Object count) {
    return '$count échéances';
  }

  @override
  String get addInstallmentPlanScreen27 => 'Nombre d\'échéances *';

  @override
  String get addInstallmentPlanScreen28 => 'Saisissez un nombre entier';

  @override
  String get addInstallmentPlanScreen29 => 'Fréquence';

  @override
  String get addInstallmentPlanScreen30 => 'Date de la première échéance';

  @override
  String get addInstallmentPlanScreen31 => 'Changer la date';

  @override
  String get addInstallmentPlanScreen32 => 'Garant et documents (facultatif)';

  @override
  String get addInstallmentPlanScreen33 => 'ex. : Mohamed Ibrahim';

  @override
  String get addInstallmentPlanScreen34 => 'Mobile du garant';

  @override
  String get addInstallmentPlanScreen35 =>
      'Numéro invalide (010, 011, 012, 015)';

  @override
  String get addInstallmentPlanScreen36 => 'Photo du document prise ✓';

  @override
  String get addInstallmentPlanScreen37 =>
      'Photographier le contrat / la reconnaissance / la pièce d\'identité';

  @override
  String get addInstallmentPlanScreen38 => 'Appuyez pour changer la photo';

  @override
  String get addInstallmentPlanScreen39 => 'Gardez une photo du contrat';

  @override
  String get addInstallmentPlanScreen40 => 'Photographier';

  @override
  String get addInstallmentPlanScreen41 => 'Notes supplémentaires';

  @override
  String get addInstallmentPlanScreen42 => 'Lier au compte du client';

  @override
  String get addInstallmentPlanScreen43 =>
      'Enregistrer le prix total en dette et l\'acompte en paiement dans le compte du client';

  @override
  String addInstallmentPlanScreen44(Object scheduleLength) {
    return 'Aperçu du calendrier ($scheduleLength échéances)';
  }

  @override
  String addInstallmentPlanScreen45(Object amountPiasters) {
    return 'Échéance : ~$amountPiasters';
  }

  @override
  String get addInstallmentPlanScreen46 => 'Enregistrer l\'échéancier';

  @override
  String installmentProgressBar1(
    Object paidCount,
    Object totalCount,
    Object percentInt,
  ) {
    return '$paidCount sur $totalCount payées ($percentInt %)';
  }

  @override
  String installmentProgressBar2(Object remainingPiasters) {
    return 'Reste : $remainingPiasters';
  }

  @override
  String get installmentProgressBar3 => 'Entièrement payé ✓';

  @override
  String get payInstallmentDialog1 =>
      'Saisissez un montant valide supérieur à zéro';

  @override
  String payInstallmentDialog2(Object amountPiasters) {
    return 'Paiement de $amountPiasters enregistré ✓';
  }

  @override
  String payInstallmentDialog3(Object e) {
    return 'Échec du paiement : $e';
  }

  @override
  String payInstallmentDialog4(Object installmentIndex) {
    return 'Payer l\'échéance $installmentIndex';
  }

  @override
  String payInstallmentDialog5(Object itemDescription) {
    return 'Paiement d\'échéance ($itemDescription)';
  }

  @override
  String get payInstallmentDialog6 => 'Montant dû :';

  @override
  String get payInstallmentDialog7 => 'Montant payé (EGP)';

  @override
  String get payInstallmentDialog8 => 'Mode de paiement';

  @override
  String get payInstallmentDialog9 => 'Espèces 💵';

  @override
  String get payInstallmentDialog10 => 'InstaPay ⚡';

  @override
  String get payInstallmentDialog11 => 'Portefeuille 📱';

  @override
  String get payInstallmentDialog12 => 'Date de paiement';

  @override
  String get payInstallmentDialog13 => 'Modifier';

  @override
  String get payInstallmentDialog14 => 'Note (facultatif)';

  @override
  String get payInstallmentDialog15 => 'ex. : virement par un proche';

  @override
  String get payInstallmentDialog16 => 'Enregistrer dans le compte du client';

  @override
  String get payInstallmentDialog17 => 'Déduit du solde principal du client';

  @override
  String get payInstallmentDialog18 => 'Confirmer le paiement';

  @override
  String earlySettlementDialog1(Object itemDescription) {
    return 'Échéancier ($itemDescription) soldé ✓';
  }

  @override
  String earlySettlementDialog2(Object e) {
    return 'Échec du solde : $e';
  }

  @override
  String get earlySettlementDialog3 => 'Solde anticipé';

  @override
  String get earlySettlementDialog4 => 'Total restant :';

  @override
  String get earlySettlementDialog5 => 'Montant à encaisser :';

  @override
  String get earlySettlementDialog6 => 'Remise pour paiement anticipé (EGP)';

  @override
  String get earlySettlementDialog7 => 'Solder maintenant';

  @override
  String installmentPlanCard1(Object overdueCount) {
    return 'En retard ($overdueCount)';
  }

  @override
  String get installmentPlanCard2 => 'Terminé ✓';

  @override
  String get installmentPlanCard3 => 'Annulé';

  @override
  String installmentPlanCard4(Object dueDate, Object paidPiasters) {
    return 'Prochaine : $dueDate ($paidPiasters)';
  }

  @override
  String installmentPlanCard5(Object totalPricePiasters) {
    return 'Total : $totalPricePiasters';
  }

  @override
  String get installmentRepository1 =>
      'La description doit comporter au moins 2 caractères';

  @override
  String get installmentRepository2 =>
      'Le prix total doit être supérieur à zéro';

  @override
  String get installmentRepository3 => 'L\'acompte ne peut pas être négatif';

  @override
  String get installmentRepository4 =>
      'L\'acompte doit être inférieur au prix total';

  @override
  String get installmentRepository5 =>
      'Le nombre d\'échéances doit être supérieur à zéro';

  @override
  String installmentRepository6(Object trim, Object installmentCount) {
    return 'Échéancier : $trim ($installmentCount échéances)';
  }

  @override
  String installmentRepository7(Object trim) {
    return 'Acompte : $trim';
  }

  @override
  String get installmentRepository8 => 'Le montant doit être supérieur à zéro';

  @override
  String installmentRepository9(Object itemDescription, Object notes) {
    return 'Paiement d\'échéance : $itemDescription$notes';
  }

  @override
  String get installmentRepository10 => 'Échéancier introuvable';

  @override
  String installmentRepository11(Object itemDescription) {
    return 'Solde anticipé : $itemDescription';
  }

  @override
  String installmentRepository12(Object itemDescription) {
    return 'Remise anticipée : $itemDescription';
  }

  @override
  String get collectionScreen1 => 'Échéances dues';

  @override
  String get dueInstallmentsTab1 => 'Ce client n\'a pas de numéro';

  @override
  String get dueInstallmentsTab2 =>
      'Aucune échéance due ou en retard aujourd\'hui 🎉';

  @override
  String get dueInstallmentsTab3 => 'Tous les clients paient à temps.';

  @override
  String dueInstallmentsTab4(Object dueListLength) {
    return '$dueListLength échéances à encaisser :';
  }

  @override
  String dueInstallmentsTab5(
    Object itemDescription,
    Object installmentIndex,
    Object installmentCount,
  ) {
    return '$itemDescription • échéance $installmentIndex sur $installmentCount';
  }

  @override
  String dueInstallmentsTab6(Object daysOverdue) {
    return '$daysOverdue jours de retard';
  }

  @override
  String get dueInstallmentsTab7 => 'À payer aujourd\'hui 🔔';

  @override
  String get dueInstallmentsTab8 => 'Appeler';

  @override
  String get dueInstallmentsTab9 => 'WhatsApp';

  @override
  String cashDrawerScreen1(Object err) {
    return 'Erreur de chargement de la caisse : $err';
  }

  @override
  String drawerLiveCard1(Object notes) {
    return 'Note : $notes';
  }

  @override
  String expensesListCard1(Object expensesLength) {
    return '$expensesLength dépenses';
  }

  @override
  String get expensesListCard2 => 'InstaPay';

  @override
  String get expensesListCard3 => 'Portefeuille';

  @override
  String get drawerFlowCard1 => '(InstaPay / portefeuille)';

  @override
  String addCashSalesBottomSheet1(Object currentSalesPiasters) {
    return 'Ventes enregistrées : $currentSalesPiasters';
  }

  @override
  String get addCashSalesBottomSheet2 => 'Ajouter aux ventes (+)';

  @override
  String get addCashSalesBottomSheet3 => 'Modifier le total (=)';

  @override
  String get addCashSalesBottomSheet4 => 'Montant à ajouter';

  @override
  String get addCashSalesBottomSheet5 => 'Nouveau total des ventes';

  @override
  String addCashSalesBottomSheet6(Object val) {
    return '+$val EGP';
  }

  @override
  String drawerHistoryTab1(
    Object cashSalesPiasters,
    Object openingCashPiasters,
  ) {
    return 'Ventes : $cashSalesPiasters · Fond : $openingCashPiasters';
  }

  @override
  String drawerHistoryTab2(Object date) {
    return 'Détails du $date';
  }

  @override
  String get drawerHistoryTab3 => 'Écart';

  @override
  String get customersScreen1 => 'Paiements échelonnés';

  @override
  String get customersScreen2 => 'Mode confidentialité';

  @override
  String get customersScreen3 => 'Trier';

  @override
  String get customerPhotosScreen1 => 'Photo ajoutée';

  @override
  String customerPhotosScreen2(Object pathsLength) {
    return '$pathsLength photos ajoutées';
  }

  @override
  String get customerPhotosScreen3 => 'Photo retirée';

  @override
  String get customerPhotosScreen4 => 'Restaurer';

  @override
  String customerPhotosScreen5(Object customerName) {
    return 'Photos de $customerName';
  }

  @override
  String get customerPhotosScreen6 => 'Ajouter des photos';

  @override
  String get customerPhotosScreen7 => 'Impossible de charger les photos';

  @override
  String get customerPhotosScreen8 =>
      'Aucune photo pour ce client.\nPhotographiez ses pages du carnet ou tout document — les photos restent sur ce téléphone.';

  @override
  String get customerPhotosScreen9 => 'Retirer la photo';

  @override
  String customerDetailsScreen1(
    Object activePlansLength,
    Object remainingPiasters,
  ) {
    return 'Échéanciers actifs ($activePlansLength) • Reste : $remainingPiasters';
  }

  @override
  String get customerDetailsScreen2 => 'Vendre à ce client en plusieurs fois';

  @override
  String get customerDetailsScreen3 => 'Voir';

  @override
  String get customerDetailsScreen4 => 'Nouvel échéancier';

  @override
  String get customerDetailsScreen5 => 'Photos du client';

  @override
  String get photoStrip1 => 'Prendre une photo';

  @override
  String get photoStrip2 => 'Choisir dans la galerie';

  @override
  String get photoStrip3 => 'Vous pouvez en choisir plusieurs à la fois';

  @override
  String get photoStrip4 => 'Photo';

  @override
  String get photoStrip5 => 'Plus';

  @override
  String get photoStrip6 => 'Ajouter une photo';

  @override
  String get photoStrip7 => 'Photos';

  @override
  String photoStrip8(Object title, Object index, Object count) {
    return '$title ($index sur $count)';
  }

  @override
  String get photoStrip9 => 'Photo';

  @override
  String get photoStrip10 => 'Photo introuvable sur ce téléphone';

  @override
  String creditLimitProgressBar1(Object limitPiasters) {
    return 'Plafond : $limitPiasters';
  }

  @override
  String ratingExplanationBottomSheet1(Object customerName) {
    return 'Note du client : $customerName';
  }

  @override
  String get ratingExplanationBottomSheet2 => 'Raison de la note :';

  @override
  String get ratingExplanationBottomSheet3 => 'Comment fonctionne la note ?';

  @override
  String get ratingExplanationBottomSheet4 => 'Excellent';

  @override
  String get ratingExplanationBottomSheet5 =>
      'Soldé, ou dette la plus ancienne de 14 jours max.';

  @override
  String get ratingExplanationBottomSheet6 => 'À suivre';

  @override
  String get ratingExplanationBottomSheet7 =>
      'Dette la plus ancienne entre 15 et 45 jours (un rappel est conseillé).';

  @override
  String get ratingExplanationBottomSheet8 => 'En retard';

  @override
  String get ratingExplanationBottomSheet9 =>
      'Dette la plus ancienne de plus de 45 jours, ou plafond dépassé.';

  @override
  String get ratingExplanationBottomSheet10 => 'Nouveau';

  @override
  String get ratingExplanationBottomSheet11 =>
      'Client avec moins de 3 opérations.';

  @override
  String get ratingExplanationBottomSheet12 => 'Compris';

  @override
  String get customerWithBalance1 => 'Nouveau client';

  @override
  String get settingsScreen1 => 'Infos de la boutique 🏪';

  @override
  String get settingsScreen2 => 'Sécurité et confidentialité 🔒';

  @override
  String get settingsScreen3 => 'Widget d\'accueil 📱';

  @override
  String get settingsScreen4 => 'Messages de rappel 💬';

  @override
  String get settingsScreen5 => 'Sauvegarde et données 💾';

  @override
  String get settingsScreen6 => 'Partager l\'app 🚀';

  @override
  String get settingsScreen7 => 'Général ⚙️';

  @override
  String get settingsScreen8 => 'Kashkool 📒';

  @override
  String get settingsScreen9 =>
      'Carnet de comptes hors ligne (Offline-First)\nVersion 1.0.0';

  @override
  String get settingsScreen10 => 'Commerce général';

  @override
  String get settingsScreen11 => 'Épicerie et supermarché 🛒';

  @override
  String get settingsScreen12 => 'Téléphones et accessoires 📱';

  @override
  String get settingsScreen13 => 'Électroménager ⚡';

  @override
  String get settingsScreen14 => 'Pharmacie et cosmétiques 💊';

  @override
  String get settingsScreen15 => 'Autres activités 🏪';

  @override
  String settingsScreen16(Object tradeName) {
    return '$tradeName • Modifier l\'activité et le paiement';
  }

  @override
  String get settingsScreen17 =>
      'Masquer les montants à l\'écran et dans le widget (••••••)';

  @override
  String get settingsScreen18 => 'Verrouiller avec un code PIN (4 chiffres)';

  @override
  String get settingsScreen19 => 'Activé (appuyez pour désactiver)';

  @override
  String get settingsScreen20 => 'Désactivé (appuyez pour configurer)';

  @override
  String get settingsScreen21 => 'Activé 🔒';

  @override
  String get settingsScreen22 => 'Configurer';

  @override
  String get settingsScreen23 => 'Verrouillage désactivé';

  @override
  String get settingsScreen24 => 'Code PIN défini 🔒';

  @override
  String get settingsScreen25 => 'Déverrouiller par empreinte / Face ID';

  @override
  String get settingsScreen26 => 'Utiliser l\'empreinte au lieu du code';

  @override
  String get settingsScreen27 =>
      'Votre appareil ne prend pas en charge la biométrie';

  @override
  String get settingsScreen28 => '1 minute';

  @override
  String get settingsScreen29 => '5 minutes';

  @override
  String get settingsScreen30 => '15 minutes';

  @override
  String get settingsScreen31 => 'Immédiatement';

  @override
  String get settingsScreen32 => 'Verrouillage automatique';

  @override
  String get settingsScreen33 => 'Dès la sortie de l\'app';

  @override
  String settingsScreen34(Object timeout) {
    return '$timeout minutes après la sortie';
  }

  @override
  String get settingsScreen35 => 'Immédiatement à la sortie';

  @override
  String get settingsScreen36 => 'Après 1 minute';

  @override
  String get settingsScreen37 => 'Après 5 minutes';

  @override
  String get settingsScreen38 => 'Après 15 minutes';

  @override
  String get settingsScreen39 => 'Message de rappel';

  @override
  String get settingsScreen40 => 'Modifier le message automatique avec aperçu';

  @override
  String get settingsScreen41 =>
      'Empêcher l\'arrêt des rappels en arrière-plan';

  @override
  String get settingsScreen42 =>
      'Guide pratique pour Xiaomi, Realme et Infinix';

  @override
  String get settingsScreen43 => 'Aucune sauvegarde exportée';

  @override
  String get settingsScreen44 => 'Dernière sauvegarde';

  @override
  String get settingsScreen45 => 'Exporter une sauvegarde (.kashkool)';

  @override
  String get settingsScreen46 =>
      'Sauvegardez le carnet et les photos, puis envoyez-les par WhatsApp ou Drive';

  @override
  String get settingsScreen47 => 'Sauvegarde exportée 👍';

  @override
  String settingsScreen48(Object e) {
    return 'Échec de l\'export : $e';
  }

  @override
  String get settingsScreen49 => 'Restaurer une sauvegarde';

  @override
  String get settingsScreen50 =>
      'Restaurer comptes et photos depuis un fichier .kashkool';

  @override
  String get settingsScreen51 => 'Fichier invalide ❌';

  @override
  String get settingsScreen52 =>
      'Ce fichier n\'est pas une sauvegarde Kashkool valide.';

  @override
  String get settingsScreen53 => 'OK';

  @override
  String get settingsScreen54 => 'Confirmer la restauration';

  @override
  String get settingsScreen55 =>
      'Attention : la restauration remplace toutes les données actuelles par celles du fichier.';

  @override
  String settingsScreen56(Object exportedAt) {
    return 'Date : $exportedAt';
  }

  @override
  String settingsScreen57(Object photosCount) {
    return 'Photos incluses : $photosCount';
  }

  @override
  String settingsScreen58(Object fileSizeBytes) {
    return 'Taille : $fileSizeBytes Ko';
  }

  @override
  String get settingsScreen59 => 'Oui, remplacer et restaurer';

  @override
  String get settingsScreen60 => 'Restauration réussie 🎉';

  @override
  String get settingsScreen61 =>
      'Comptes, opérations et photos restaurés. Redémarrez l\'app pour actualiser tous les écrans.';

  @override
  String get settingsScreen62 => 'Redémarrer maintenant';

  @override
  String settingsScreen63(Object e) {
    return 'Échec de la restauration : $e';
  }

  @override
  String get settingsScreen64 => 'Sombre 🌙';

  @override
  String get settingsScreen65 => 'Clair ☀️';

  @override
  String get settingsScreen66 => 'Auto';

  @override
  String get settingsScreen67 => 'Apparence';

  @override
  String get settingsScreen68 => 'Automatique (selon le téléphone)';

  @override
  String get settingsScreen69 => 'Non défini';

  @override
  String get settingsScreen70 => 'Plafond par défaut des nouveaux clients';

  @override
  String get settingsScreen71 => 'Contactez-nous sur WhatsApp';

  @override
  String get settingsScreen72 => 'Suggestions et assistance directe';

  @override
  String get settingsScreen73 =>
      'https://wa.me/201000000000?text=Bonjour%2C%20j%27ai%20une%20question%20sur%20Kashkool';

  @override
  String get settingsScreen74 => 'Confidentialité et conditions d\'utilisation';

  @override
  String get settingsScreen75 =>
      'Vos données vous appartiennent et restent sur votre téléphone, hors ligne';

  @override
  String get settingsScreen76 => 'Politique de confidentialité de Kashkool 🔒';

  @override
  String get settingsScreen77 =>
      '1. Kashkool fonctionne entièrement hors ligne (Offline-First).\n\n2. Comptes, noms, numéros, photos de factures et opérations sont stockés uniquement sur votre appareil. Aucune donnée n\'est envoyée à un serveur externe.\n\n3. Vous êtes responsable d\'exporter régulièrement une sauvegarde (Exporter une sauvegarde) en cas de changement ou de perte du téléphone.\n\n4. Kashkool est conçu pour aider les commerçants à protéger leurs créances et suivre leurs dettes en toute sécurité.';

  @override
  String get settingsScreen78 => 'Système (automatique)';

  @override
  String get settingsScreen79 => 'Plafond par défaut (EGP)';

  @override
  String get settingsScreen80 => 'Montant en EGP';

  @override
  String get settingsScreen81 => 'Laissez vide pour aucun plafond';

  @override
  String get settingsScreen82 => 'Enregistrer';

  @override
  String batteryGuideBottomSheet1(Object brandName) {
    return 'Guide des notifications ($brandName)';
  }

  @override
  String get batteryGuideBottomSheet2 => 'Garder les rappels actifs';

  @override
  String get batteryGuideBottomSheet3 =>
      'Certains téléphones (Xiaomi, Realme, Infinix, Huawei…) arrêtent les apps en arrière-plan pour économiser la batterie. Pour recevoir les rappels à temps, suivez ces étapes :';

  @override
  String get batteryGuideBottomSheet4 => 'Ouvrir les réglages de batterie';

  @override
  String get backupReminderBanner1 => 'Sauvegarde exportée 👍';

  @override
  String backupReminderBanner2(Object e) {
    return 'Échec de la sauvegarde : $e';
  }

  @override
  String get backupReminderBanner3 => 'Pensez à sauvegarder ⚠️';

  @override
  String get backupReminderBanner4 =>
      'Plus de 7 jours depuis la dernière sauvegarde. Sauvegardez pour ne rien perdre si vous changez ou perdez votre téléphone.';

  @override
  String get backupReminderBanner5 => 'Plus tard';

  @override
  String get backupReminderBanner6 => 'Enregistrement...';

  @override
  String get backupReminderBanner7 => 'Sauvegarder maintenant';

  @override
  String get homeWidgetSettingsCard1 =>
      'Afficher vos soldes sur l\'écran d\'accueil';

  @override
  String get homeWidgetSettingsCard2 =>
      'Le widget affiche ce qu\'on vous doit et les encaissements du jour sans ouvrir l\'app';

  @override
  String get homeWidgetSettingsCard3 =>
      'Le widget est désactivé et n\'affiche aucun chiffre';

  @override
  String get homeWidgetSettingsCard4 => 'Ajouter le petit widget';

  @override
  String get homeWidgetSettingsCard5 => 'Seulement ce qu\'on vous doit';

  @override
  String get homeWidgetSettingsCard6 => 'Ajouter le widget résumé du jour';

  @override
  String get homeWidgetSettingsCard7 =>
      'Créances + encaissé aujourd\'hui + clients à relancer + bouton';

  @override
  String get homeWidgetSettingsCard8 =>
      'Acceptez la demande pour ajouter le widget 👍';

  @override
  String get homeWidgetSettingsCard9 => 'Ajoutez le widget vous-même 📱';

  @override
  String get homeWidgetSettingsCard10 =>
      'Votre téléphone ne permet pas l\'ajout automatique. Faites ceci :\n\n1. Appui long sur un espace vide de l\'écran d\'accueil\n2. Choisissez « Widgets »\n3. Cherchez « Kashkool » et faites glisser le widget';

  @override
  String get messageTemplateEditorBottomSheet1 => 'Épicerie du Coin';

  @override
  String get messageTemplateEditorBottomSheet2 => 'Vodafone Cash : 01012345678';

  @override
  String get messageTemplateEditorBottomSheet3 => 'Mohamed Ahmed';

  @override
  String get messageTemplateEditorBottomSheet4 =>
      'Modèle de message enregistré 👍';

  @override
  String get messageTemplateEditorBottomSheet5 =>
      'Modifier le message de rappel 💬';

  @override
  String get messageTemplateEditorBottomSheet6 => 'Modèles : ';

  @override
  String get messageTemplateEditorBottomSheet7 => 'Amical 😊';

  @override
  String get messageTemplateEditorBottomSheet8 => 'Formel 👔';

  @override
  String get messageTemplateEditorBottomSheet9 => 'Nom de la boutique';

  @override
  String get messageTemplateEditorBottomSheet10 => 'Infos de paiement';

  @override
  String get messageTemplateEditorBottomSheet11 =>
      'Date de la dernière opération';

  @override
  String get messageTemplateEditorBottomSheet12 =>
      'Écrivez le message de rappel ici...';

  @override
  String get messageTemplateEditorBottomSheet13 =>
      'Aperçu tel que le client le verra :';

  @override
  String get messageTemplateEditorBottomSheet14 => 'Enregistrer le modèle';

  @override
  String shopProfileBottomSheet1(Object trim) {
    return 'Portefeuille mobile : $trim';
  }

  @override
  String get shopProfileBottomSheet2 => 'Infos de la boutique enregistrées 👍';

  @override
  String get shopProfileBottomSheet3 => 'Nom de la boutique *';

  @override
  String get shopProfileBottomSheet4 => 'ex. : Épicerie du Coin';

  @override
  String get shopProfileBottomSheet5 => 'Veuillez saisir le nom de la boutique';

  @override
  String get shopProfileBottomSheet6 => 'Téléphone de la boutique';

  @override
  String get shopProfileBottomSheet7 => 'ex. : 010xxxxxxxx';

  @override
  String get shopProfileBottomSheet8 => 'Adresse de la boutique';

  @override
  String get shopProfileBottomSheet9 =>
      'ex. : rue du Marché, à côté de la grande mosquée';

  @override
  String get shopProfileBottomSheet10 => 'Compte InstaPay';

  @override
  String get shopProfileBottomSheet11 => 'ex. : name@instapay';

  @override
  String get shopProfileBottomSheet12 =>
      'Numéro Vodafone Cash / portefeuille mobile';

  @override
  String get shopProfileBottomSheet13 => 'Type d\'activité';

  @override
  String get shopProfileBottomSheet14 => 'Autre activité 🏪';

  @override
  String get shopProfileBottomSheet15 => 'Activer les paiements échelonnés';

  @override
  String get shopProfileBottomSheet16 =>
      'Afficher le bouton et les calendriers d\'échéances';

  @override
  String get shopProfileBottomSheet17 => 'Enregistrer';

  @override
  String get cloudAccountButton1 => 'Votre compte et la sauvegarde cloud ☁️';

  @override
  String get cloudAccountButton2 => 'Sauvegarde cloud';

  @override
  String get cloudAccountButton3 => 'Se connecter avec Google';

  @override
  String get cloudBackupCard1 => 'Un instant…';

  @override
  String get cloudBackupCard2 => 'Un problème est survenu, réessayez';

  @override
  String get cloudBackupCard3 => 'Ouverture des comptes Google…';

  @override
  String cloudBackupCard4(Object email) {
    return 'Connecté avec $email ✓';
  }

  @override
  String get cloudBackupCard5 => 'Sauvegarde envoyée avec des remarques ⚠️';

  @override
  String cloudBackupCard6(Object uploaded, Object rejected, Object n) {
    return '$uploaded enregistrements envoyés, $rejected refusés :\n\n$n';
  }

  @override
  String get cloudBackupCard7 => 'Toutes vos données sont déjà dans le cloud ✓';

  @override
  String cloudBackupCard8(Object uploaded) {
    return '$uploaded enregistrements envoyés dans le cloud ✓';
  }

  @override
  String get cloudBackupCard9 => 'Chargement des boutiques de votre compte…';

  @override
  String get cloudBackupCard10 => 'Aucune sauvegarde cloud pour ce compte';

  @override
  String get cloudBackupCard11 => 'Choisir la boutique';

  @override
  String get cloudBackupCard12 => ' (employé)';

  @override
  String get cloudBackupCard13 => 'Restaurer depuis le cloud ?';

  @override
  String cloudBackupCard14(Object name) {
    return 'Nous allons télécharger la sauvegarde « $name » et l\'ajouter à ce téléphone.\n\n';
  }

  @override
  String get cloudBackupCard15 =>
      'Rien ne sera supprimé : les données présentes uniquement sur ce téléphone restent, et ce qui a été modifié après la dernière sauvegarde est conservé.';

  @override
  String get cloudBackupCard16 => 'Oui, restaurer';

  @override
  String get cloudBackupCard17 => 'Restauré 🎉';

  @override
  String cloudBackupCard18(Object keptLocal) {
    return ', et $keptLocal enregistrements conservés car la version du téléphone est plus récente';
  }

  @override
  String cloudBackupCard19(Object records, Object keptLocal) {
    return '$records enregistrements restaurés$keptLocal.';
  }

  @override
  String get cloudBackupCard20 =>
      ' Fermez et rouvrez l\'app pour actualiser tous les écrans.';

  @override
  String get cloudBackupCard21 => 'Fermer l\'app';

  @override
  String get cloudBackupCard22 => 'Se déconnecter ?';

  @override
  String get cloudBackupCard23 =>
      'Vos données restent sur le téléphone et dans le cloud, mais les sauvegardes s\'arrêtent jusqu\'à la reconnexion.';

  @override
  String get cloudBackupCard24 => 'Se déconnecter';

  @override
  String get cloudBackupCard25 => 'Indisponible dans cette version';

  @override
  String get cloudBackupCard26 => 'Sauvegarde cloud';

  @override
  String get cloudBackupCard27 =>
      'Connectez-vous avec Google pour sauvegarder vos données en ligne. Si vous perdez votre téléphone, restaurez-les sur un autre.';

  @override
  String get cloudBackupCard28 => 'Aucune sauvegarde';

  @override
  String cloudBackupCard29(Object last) {
    return 'Dernière sauvegarde : $last';
  }

  @override
  String get cloudBackupCard30 => 'Envoi en cours…';

  @override
  String get cloudBackupCard31 =>
      'En attente d\'internet — envoi automatique au retour';

  @override
  String get cloudBackupCard32 => 'Envoi interrompu, nouvel essai bientôt';

  @override
  String get cloudBackupCard33 => 'Tout est envoyé ✓';

  @override
  String get cloudBackupCard34 => 'Envoi automatique en ligne';

  @override
  String get cloudBackupCard35 => 'Sauvegarder maintenant';

  @override
  String get cloudBackupCard36 => 'Restaurer vos données sur ce téléphone';

  @override
  String get cloudBackupCard37 =>
      'Pour un nouveau téléphone ou après réinstallation — ne supprime rien';

  @override
  String get cloudBackupCard38 => 'Se déconnecter';

  @override
  String get onboardingScreen1 => 'Ma boutique';

  @override
  String get onboardingScreen2 =>
      'Des clients de démonstration ont été ajoutés ; vous pouvez les supprimer à tout moment';

  @override
  String get onboardingScreen3 => 'Configuration de Kashkool';

  @override
  String get onboardingScreen4 => 'Suivant : type d\'activité';

  @override
  String get onboardingScreen5 => 'Bienvenue sur Kashkool ! 👋';

  @override
  String get onboardingScreen6 =>
      'Votre carnet numérique pour les dettes, les rappels WhatsApp et les paiements échelonnés — tout simplement.';

  @override
  String get onboardingScreen7 => 'Nom de la boutique *';

  @override
  String get onboardingScreen8 => 'ex. : Épicerie du Coin / Star Mobiles';

  @override
  String get onboardingScreen9 =>
      'Saisissez le nom de la boutique (2 caractères min.)';

  @override
  String get onboardingScreen10 => 'Téléphone de la boutique (facultatif)';

  @override
  String get onboardingScreen11 =>
      'Affiché sur les reçus, relevés et messages WhatsApp';

  @override
  String get onboardingScreen12 => 'Épicerie et supermarché';

  @override
  String get onboardingScreen13 =>
      'Dettes du quotidien et clôture de caisse rapide';

  @override
  String get onboardingScreen14 => 'Téléphones et accessoires';

  @override
  String get onboardingScreen15 =>
      'Infos appareils, paiements échelonnés activés';

  @override
  String get onboardingScreen16 => 'Électroménager';

  @override
  String get onboardingScreen17 =>
      'Ventes à crédit, paiements échelonnés activés';

  @override
  String get onboardingScreen18 => 'Pharmacie et cosmétiques';

  @override
  String get onboardingScreen19 =>
      'Plafonds de crédit et dettes d\'ordonnances';

  @override
  String get onboardingScreen20 => 'Autres activités';

  @override
  String get onboardingScreen21 =>
      'Un carnet souple pour tout type de commerce';

  @override
  String get onboardingScreen22 => 'Quel est votre type d\'activité ?';

  @override
  String get onboardingScreen23 => 'Nous adapterons l\'app à votre activité.';

  @override
  String get onboardingScreen24 => 'Paiements échelonnés';

  @override
  String get onboardingScreen25 => 'Activer les échéanciers';

  @override
  String get onboardingScreen26 =>
      'Modifiable à tout moment dans les paramètres';

  @override
  String get onboardingScreen27 => 'Recevoir les rappels à temps 🔔';

  @override
  String get onboardingScreen28 =>
      'Pour que Kashkool vous rappelle chaque jour les encaissements et échéances :';

  @override
  String get onboardingScreen29 => 'Autorisation des notifications';

  @override
  String get onboardingScreen30 => 'Notifications activées ✅';

  @override
  String get onboardingScreen31 =>
      'Nous avons besoin des notifications pour vous envoyer le résumé quotidien';

  @override
  String get onboardingScreen32 => 'Autoriser les notifications';

  @override
  String onboardingScreen33(Object brandName) {
    return 'Protection en arrière-plan ($brandName)';
  }

  @override
  String get onboardingScreen34 => 'Empêcher l\'arrêt en arrière-plan';

  @override
  String get onboardingScreen35 => 'Ouvrir les réglages de batterie';

  @override
  String get onboardingScreen36 => 'C\'est parti ! 🚀';

  @override
  String get onboardingScreen37 =>
      'Les infos de votre boutique sont enregistrées. Comment voulez-vous commencer ?';

  @override
  String get onboardingScreen38 => '+ Ajouter votre premier client';

  @override
  String get onboardingScreen39 =>
      'Ajoutez un client et notez dettes et paiements tout de suite';

  @override
  String get onboardingScreen40 =>
      'Essayer d\'abord avec des données de démo 💡';

  @override
  String get onboardingScreen41 =>
      'Ajoute deux clients de démo pour découvrir Kashkool (suppression en un clic)';

  @override
  String get onboardingScreen42 => 'Passer à l\'écran d\'accueil';

  @override
  String get shopRepository1 => 'Ahmed Mohamed (démo)';

  @override
  String get shopRepository2 => 'Courses pour la maison';

  @override
  String get shopRepository3 => 'Mahmoud Ibrahim (démo)';

  @override
  String get shopRepository4 => 'Marchandise de début de mois';

  @override
  String get shopRepository5 => 'Acompte en espèces';

  @override
  String get supplierWithBalance1 => 'Samedi';

  @override
  String get supplierWithBalance2 => 'Dimanche';

  @override
  String get supplierWithBalance3 => 'Lundi';

  @override
  String get supplierWithBalance4 => 'Mardi';

  @override
  String get supplierWithBalance5 => 'Mercredi';

  @override
  String get supplierWithBalance6 => 'Jeudi';

  @override
  String get supplierWithBalance7 => 'Vendredi';

  @override
  String get trashScreen1 => 'Clients';

  @override
  String get trashScreen2 => 'Opérations';

  @override
  String get trashScreen3 => 'Fournisseurs';

  @override
  String get trashScreen4 => 'Dépenses';

  @override
  String get trashScreen5 => 'Échéanciers';

  @override
  String trashScreen6(Object title) {
    return '« $title » restauré ✓';
  }

  @override
  String get trashScreen7 => 'Restauration impossible, réessayez';

  @override
  String get trashScreen8 => 'Corbeille 🗑️';

  @override
  String get trashScreen9 =>
      'Tout ce que vous supprimez arrive ici et n\'est pas perdu. Restaurez-le à tout moment, y compris dans la sauvegarde cloud.';

  @override
  String get trashScreen10 => 'Impossible de charger la corbeille';

  @override
  String get trashScreen11 => 'La corbeille est vide ✨';

  @override
  String trashScreen12(Object deletedAt) {
    return 'Supprimé le $deletedAt';
  }

  @override
  String get trashScreen13 => 'Restaurer';

  @override
  String get trashScreen14 => 'Corbeille';

  @override
  String get trashScreen15 => 'Voir et restaurer les éléments supprimés';

  @override
  String trashScreen16(Object count) {
    return '$count éléments — restaurables';
  }

  @override
  String get trashRepository1 => 'Loyer';

  @override
  String get trashRepository2 => 'Électricité';

  @override
  String get trashRepository3 => 'Salaires';

  @override
  String get trashRepository4 => 'Fournitures';

  @override
  String get trashRepository5 => 'Paiement fournisseur';

  @override
  String get trashRepository6 => 'Dépense';

  @override
  String get trashRepository7 => 'Je dois';

  @override
  String get trashRepository8 => 'Paiement';

  @override
  String get trashRepository9 => 'J\'ai payé';

  @override
  String get trashRepository10 => 'Inconnu';

  @override
  String trashRepository11(Object itemDescription) {
    return 'Échéancier : $itemDescription';
  }

  @override
  String pdfStatementService1(Object sanitizedName, Object dateStr) {
    return 'Releve_${sanitizedName}_$dateStr.pdf';
  }

  @override
  String get pdfStatementService2 => 'Relevé de compte client';

  @override
  String pdfStatementService3(Object customerName) {
    return 'Client : $customerName';
  }

  @override
  String pdfStatementService4(Object phone) {
    return 'Téléphone : $phone';
  }

  @override
  String pdfStatementService5(Object periodDescription) {
    return 'Période : $periodDescription';
  }

  @override
  String get pdfStatementService6 => 'Solde avant cette période :';

  @override
  String get pdfStatementService7 => 'Date';

  @override
  String get pdfStatementService8 => 'Libellé';

  @override
  String get pdfStatementService9 => 'Solde';

  @override
  String pdfStatementService10(Object periodDebitsPiasters) {
    return 'Total achats / avances : $periodDebitsPiasters';
  }

  @override
  String pdfStatementService11(Object periodCreditsPiasters) {
    return 'Total payé : $periodCreditsPiasters';
  }

  @override
  String get pdfStatementService12 => 'Solde final dû :';

  @override
  String pdfStatementService13(Object trim) {
    return 'Moyens de paiement : $trim';
  }

  @override
  String get pdfStatementService14 =>
      'Réalisé avec Kashkool — essayez gratuitement :';

  @override
  String get statementCalculator1 => 'Toutes les opérations';

  @override
  String get statementCalculator2 => 'Janvier';

  @override
  String get statementCalculator3 => 'Février';

  @override
  String get statementCalculator4 => 'Mars';

  @override
  String get statementCalculator5 => 'Avril';

  @override
  String get statementCalculator6 => 'Mai';

  @override
  String get statementCalculator7 => 'Juin';

  @override
  String get statementCalculator8 => 'Juillet';

  @override
  String get statementCalculator9 => 'Août';

  @override
  String get statementCalculator10 => 'Septembre';

  @override
  String get statementCalculator11 => 'Octobre';

  @override
  String get statementCalculator12 => 'Novembre';

  @override
  String get statementCalculator13 => 'Décembre';

  @override
  String statementCalculator14(Object startDate, Object endDate) {
    return 'Du $startDate au $endDate';
  }

  @override
  String statementCalculator15(Object startDate) {
    return 'À partir du $startDate';
  }

  @override
  String statementCalculator16(Object endDate) {
    return 'Jusqu\'au $endDate';
  }

  @override
  String growthFooter1(Object shopCode) {
    return '—\nRéalisé avec Kashkool 📒 Essayez gratuitement : $shopCode';
  }

  @override
  String growthFooter2(Object shopCode) {
    return 'J\'utilise Kashkool 📒 pour suivre clients, fournisseurs et caisse sans carnet papier.\nTrès simple et fonctionne hors ligne. Essayez gratuitement :\n$shopCode';
  }

  @override
  String get notificationService1 => 'Recouvrement quotidien';

  @override
  String get notificationService2 => 'Rappels des clients à relancer';

  @override
  String notificationService3(Object dueCount, Object amountStr) {
    return '$dueCount clients vous doivent $amountStr — touchez pour relancer';
  }

  @override
  String get notificationService4 => 'Rappel de recouvrement 📒';

  @override
  String get backupService1 => 'Fichier de base de données introuvable';

  @override
  String backupService2(Object dateStr) {
    return 'Sauvegarde Kashkool - $dateStr';
  }

  @override
  String get backupService3 => 'Le fichier sélectionné n\'existe pas';

  @override
  String get backupService4 => 'Fichier endommagé ou incomplet';

  @override
  String get backupService5 => 'Format invalide (pas un fichier Kashkool)';

  @override
  String get backupService6 => 'Le fichier ne contient pas de base Kashkool';

  @override
  String get backupService7 => 'La base de données du fichier est endommagée';

  @override
  String get backupService8 => 'Base SQLite invalide';

  @override
  String get backupService9 => 'Fichier de sauvegarde invalide';

  @override
  String get backupService10 => 'Base de données absente de l\'archive';

  @override
  String get googleAuthService1 =>
      'La sauvegarde cloud n\'est pas configurée dans cette version';

  @override
  String get googleAuthService2 =>
      'Google n\'a pas renvoyé les identifiants, réessayez';

  @override
  String get googleAuthService3 => 'Connexion annulée';

  @override
  String googleAuthService4(Object codeName) {
    return 'Connexion Google impossible ($codeName)';
  }

  @override
  String get cloudApi1 =>
      'Adresse du serveur non configurée dans cette version';

  @override
  String get cloudApi2 => 'Connectez-vous d\'abord avec Google';

  @override
  String get cloudApi3 => 'Pas de connexion internet, réessayez';

  @override
  String get cloudApi4 => 'Le serveur met trop de temps, réessayez';

  @override
  String get cloudApi5 => 'Session expirée, reconnectez-vous avec Google';

  @override
  String get cloudApi6 => 'Cette boutique appartient à un autre compte Google';

  @override
  String get cloudApi7 => 'Cette fonction nécessite un abonnement';

  @override
  String get cloudApi8 => 'Trop de tentatives, patientez puis réessayez';

  @override
  String get cloudApi9 => 'Reconnectez-vous avec Google';

  @override
  String get cloudApi10 => 'Connexion Google non configurée sur le serveur';

  @override
  String get cloudApi11 => 'Problème serveur, réessayez bientôt';

  @override
  String cloudApi12(Object code) {
    return 'Une erreur s\'est produite ($code)';
  }

  @override
  String get cloudBackupService1 => 'Connexion Google indisponible';

  @override
  String get cloudBackupService2 =>
      'Complétez d\'abord les infos de la boutique dans les paramètres';

  @override
  String get cloudBackupService3 => 'Préparation des données…';

  @override
  String cloudBackupService4(Object length, Object changesLength) {
    return 'Envoi de $length sur $changesLength…';
  }

  @override
  String get cloudBackupService5 => 'Terminé ✓';

  @override
  String cloudBackupService6(Object changesLength) {
    return 'Téléchargement… ($changesLength)';
  }

  @override
  String cloudBackupService7(Object changesLength) {
    return 'Enregistrement de $changesLength éléments sur le téléphone…';
  }

  @override
  String get cloudBackupService8 => 'Boutique';

  @override
  String autoBackupCoordinator1(Object rejected) {
    return '$rejected éléments non envoyés';
  }

  @override
  String get autoBackupCoordinator2 =>
      'Un problème est survenu, nouvel essai bientôt';

  @override
  String get customerRating1 => 'Nouveau client (moins de 3 opérations)';

  @override
  String get customerRating2 => 'Compte soldé, paie à temps';

  @override
  String customerRating3(Object oldestUnpaidAgeDays) {
    return 'En retard : dette la plus ancienne de $oldestUnpaidAgeDays jours et plafond dépassé';
  }

  @override
  String get customerRating4 => 'Plafond du client dépassé';

  @override
  String get customerRating5 => 'Dette du jour uniquement, compte en règle';

  @override
  String customerRating6(Object oldestUnpaidAgeDays) {
    return 'Montant le plus ancien : $oldestUnpaidAgeDays jours seulement (zone sûre)';
  }

  @override
  String customerRating7(Object oldestUnpaidAgeDays) {
    return 'Montant le plus ancien : $oldestUnpaidAgeDays jours (plus de 45 jours)';
  }

  @override
  String customerRating8(Object oldestUnpaidAgeDays) {
    return 'Montant le plus ancien : $oldestUnpaidAgeDays jours (à suivre)';
  }

  @override
  String get whatsappTemplate1 =>
      'Bonjour {customer_name} 👋\nIci {shop_name}.\nVotre solde actuel : {balance}\nDernière opération : {last_transaction_date} - {last_transaction_amount}\nPour payer : {payment_info}\nMerci de votre confiance 🙏';

  @override
  String get whatsappTemplate2 =>
      'Cher/Chère {customer_name},\nNous vous rappelons que votre solde chez {shop_name} s\'élève à {balance}.\nDernière opération : {last_transaction_date} ({last_transaction_amount})\nMoyens de paiement : {payment_info}\nCordialement.';

  @override
  String get whatsappTemplate3 =>
      'Bonjour {customer_name} 👋\nIci {shop_name}.\nRappel : l\'échéance de ({item}) arrive — échéance {installment_number} sur {installment_count} :\nMontant dû : {amount}\nDate d\'échéance : {due_date}\nTotal restant : {remaining_total}\nMoyens de paiement : {payment_info}\nMerci de votre ponctualité 🙏';

  @override
  String get whatsappTemplate4 => 'Espèces en boutique ou virement';

  @override
  String get money1 => 'EGP';

  @override
  String get batteryOptimizationHelper1 => 'XOS / HiOS';

  @override
  String get batteryOptimizationHelper2 => 'Ouvrez l\'app Phone Master.';

  @override
  String get batteryOptimizationHelper3 =>
      'Allez dans « Gestion du démarrage auto » et activez Kashkool.';

  @override
  String get batteryOptimizationHelper4 =>
      'Dans les réglages de l\'app, ouvrez « Batterie » et choisissez « Sans restriction ».';

  @override
  String get batteryOptimizationHelper5 =>
      'Dans les apps récentes, faites glisser l\'app vers le bas pour la verrouiller 🔒.';

  @override
  String get batteryOptimizationHelper6 => 'MIUI / HyperOS';

  @override
  String get batteryOptimizationHelper7 =>
      'Ouvrez les réglages de l\'app et activez « Démarrage auto ».';

  @override
  String get batteryOptimizationHelper8 =>
      'Dans « Économiseur de batterie », choisissez « Aucune restriction ».';

  @override
  String get batteryOptimizationHelper9 =>
      'Dans les apps récentes, appui long sur Kashkool puis l\'icône cadenas 🔒.';

  @override
  String get batteryOptimizationHelper10 => 'ColorOS / Realme UI';

  @override
  String get batteryOptimizationHelper11 =>
      'Réglages de l\'app -> Utilisation de la batterie, activez « Autoriser l\'activité en arrière-plan ».';

  @override
  String get batteryOptimizationHelper12 => 'Activez « Lancement auto ».';

  @override
  String get batteryOptimizationHelper13 =>
      'Dans les apps récentes, touchez les trois points puis « Verrouiller ».';

  @override
  String get batteryOptimizationHelper14 => 'One UI';

  @override
  String get batteryOptimizationHelper15 =>
      'Allez dans Paramètres -> Maintenance de l\'appareil -> Batterie.';

  @override
  String get batteryOptimizationHelper16 =>
      'Ouvrez « Limites d\'utilisation en arrière-plan ».';

  @override
  String get batteryOptimizationHelper17 =>
      'Ajoutez Kashkool aux « Applis jamais en veille ».';

  @override
  String get batteryOptimizationHelper18 => 'EMUI / MagicOS';

  @override
  String get batteryOptimizationHelper19 =>
      'Allez dans Paramètres -> Batterie -> Lancement d\'applis.';

  @override
  String get batteryOptimizationHelper20 =>
      'Cherchez « Kashkool », passez en manuel et activez Lancement auto + Exécution en arrière-plan.';

  @override
  String get batteryOptimizationHelper21 => 'Réglages système';

  @override
  String get batteryOptimizationHelper22 => 'Protéger les notifications';

  @override
  String get batteryOptimizationHelper23 =>
      'Ouvrez les infos de l\'app dans les réglages.';

  @override
  String get batteryOptimizationHelper24 =>
      'Ouvrez « Batterie » et choisissez « Sans restriction ».';

  @override
  String get batteryOptimizationHelper25 =>
      'Vérifiez que le mode d\'économie d\'énergie extrême est désactivé pour recevoir les rappels.';

  @override
  String get homeWidgetService1 => 'Aucun';

  @override
  String get homeWidgetService2 => '1 client';

  @override
  String get homeWidgetService3 => '2 clients';

  @override
  String homeWidgetService4(Object count) {
    return '$count clients';
  }

  @override
  String get pinLockScreen1 => 'Code PIN incorrect, réessayez';

  @override
  String get pinLockScreen2 => 'Les codes ne correspondent pas, recommencez';

  @override
  String get pinLockScreen3 => 'Empreinte indisponible ou non configurée';

  @override
  String get pinLockScreen4 => 'Bienvenue sur Kashkool 📒';

  @override
  String get pinLockScreen5 => 'Définir un nouveau code';

  @override
  String get pinLockScreen6 => 'Ressaisissez le code pour confirmer';

  @override
  String get pinLockScreen7 => 'Saisissez votre code à 4 chiffres';

  @override
  String get pinLockScreen8 => 'Choisissez 4 chiffres faciles à retenir';

  @override
  String get pinLockScreen9 => 'Retapez les mêmes chiffres';

  @override
  String get pinLockScreen10 => 'Empreinte';

  @override
  String get pinLockScreen11 => 'Effacer';

  @override
  String get securityService1 =>
      'Confirmez votre identité pour ouvrir Kashkool';

  @override
  String get settingsLanguageTitle => 'Langue';

  @override
  String get settingsLanguageSystem => 'Langue du téléphone (auto)';
}
