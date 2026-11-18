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
  String get navInventory => 'Inventaire';

  @override
  String get navCashDrawer => 'Caisse';

  @override
  String get inventoryTitle => 'Inventaire';

  @override
  String get inventoryManageButton => 'Gérer les produits et le stock';

  @override
  String get inventorySearchHint =>
      'Rechercher un produit ou un code-barres...';

  @override
  String get inventoryAddProduct => 'Nouveau produit';

  @override
  String get inventoryEditProduct => 'Modifier le produit';

  @override
  String get inventoryNoProducts => 'Aucun produit ajouté pour l\'instant';

  @override
  String get inventoryNoSearchResults =>
      'Aucun produit ne correspond à la recherche';

  @override
  String get inventoryProductName => 'Nom du produit';

  @override
  String get inventoryNameRequired => 'Saisissez le nom du produit';

  @override
  String get inventoryBarcode => 'Code-barres (facultatif)';

  @override
  String get inventoryCategory => 'Catégorie (facultative)';

  @override
  String get inventoryUnit => 'Unité de vente';

  @override
  String get inventoryUnitExample => 'Ex. : pièce, kg, litre';

  @override
  String get inventoryUnitRequired => 'Saisissez l\'unité de vente';

  @override
  String get inventoryPurchasePrice => 'Prix d\'achat (€)';

  @override
  String get inventorySalePrice => 'Prix de vente (€)';

  @override
  String get inventoryMinimumStock => 'M\'alerter quand le stock atteint';

  @override
  String get inventoryInitialStock => 'Stock actuel';

  @override
  String get inventoryCurrentStock => 'En stock';

  @override
  String get inventoryInStock => 'Disponible';

  @override
  String get inventoryLowStock => 'Stock faible';

  @override
  String get inventoryAdjustStock => 'Ajuster le stock';

  @override
  String get inventoryAddStock => 'Ajouter au stock';

  @override
  String get inventoryRemoveStock => 'Retirer du stock';

  @override
  String get inventoryQuantity => 'Quantité';

  @override
  String get inventoryNote => 'Note (facultative)';

  @override
  String get inventoryMovementHistory => 'Mouvements de stock';

  @override
  String get inventoryMovementOpening => 'Stock initial';

  @override
  String get inventoryMovementAdjustment => 'Ajustement manuel';

  @override
  String get inventoryMovementPurchase => 'Achat';

  @override
  String get inventoryMovementSale => 'Vente';

  @override
  String get inventoryMovementCustomerReturn => 'Retour client';

  @override
  String get inventoryMovementSupplierReturn => 'Retour fournisseur';

  @override
  String get inventoryNoMovements => 'Aucun mouvement de stock pour l\'instant';

  @override
  String get inventorySave => 'Enregistrer';

  @override
  String get inventoryCancel => 'Annuler';

  @override
  String get inventoryDelete => 'Supprimer le produit';

  @override
  String get inventoryDeleteConfirm =>
      'Le produit sera masqué, mais son historique de mouvements sera conservé. Continuer ?';

  @override
  String get inventoryDeleted => 'Produit supprimé';

  @override
  String get inventoryProductSaved => 'Produit enregistré';

  @override
  String get inventoryStockSaved => 'Stock mis à jour';

  @override
  String get inventoryInvalidQuantity =>
      'Saisissez une quantité valide (jusqu\'à 3 décimales)';

  @override
  String get inventoryQuantityRequired =>
      'Saisissez une quantité supérieure à zéro';

  @override
  String get inventoryStockCannotBeNegative =>
      'Le stock est insuffisant pour ce retrait';

  @override
  String get inventoryInvalidPrice => 'Saisissez un prix valide et non négatif';

  @override
  String get inventoryBarcodeExists =>
      'Ce code-barres est déjà utilisé par un autre produit';

  @override
  String get inventoryUnitChangeNotAllowed =>
      'Impossible de modifier l\'unité après des mouvements de stock';

  @override
  String get inventorySaveFailed =>
      'Impossible d\'enregistrer. Vérifiez les informations et réessayez.';

  @override
  String get inventorySupplier => 'Fournisseur (facultatif)';

  @override
  String get inventorySupplierNone => 'Sans fournisseur';

  @override
  String get inventorySupplierFilter => 'Filtrer par fournisseur';

  @override
  String get inventoryFilterAllSuppliers => 'Tous les fournisseurs';

  @override
  String get inventorySupplierProducts => 'Produits du fournisseur';

  @override
  String get inventoryNoSupplierProducts =>
      'Aucun produit lié à ce fournisseur';

  @override
  String get inventorySupplierCardTitle => 'Fournisseur assigné';

  @override
  String get inventoryOrderWhatsApp =>
      'Commander les produits manquants via WhatsApp';

  @override
  String get supplierReturn => 'Retour au fournisseur';

  @override
  String get supplierReturnReason => 'Motif du retour (facultatif)';

  @override
  String get supplierReturnSuccess =>
      'Retour enregistré et montant déduit du compte';

  @override
  String get purchasePaidAmount => 'Montant payé maintenant';

  @override
  String get purchasePaymentFull => 'Paiement intégral';

  @override
  String get purchasePaymentPartial => 'Paiement partiel (reste à crédit)';

  @override
  String get purchasePaymentOnAccount => 'Acompte';

  @override
  String get purchasePaymentCredit => 'Tout à crédit';

  @override
  String get purchaseRemainingDebt => 'Reste dû par la boutique';

  @override
  String get purchaseAdvanceCredit =>
      'Crédit en faveur de la boutique (acompte)';

  @override
  String get profitLossTitle => 'Bénéfices et pertes';

  @override
  String get profitLossRevenue => 'Total des ventes';

  @override
  String get profitLossCogs => 'Coût des marchandises vendues';

  @override
  String get profitLossGross => 'Bénéfice brut';

  @override
  String get profitLossExpenses => 'Dépenses de fonctionnement';

  @override
  String get profitLossNet => 'Bénéfice / perte net';

  @override
  String get profitLossMargin => 'Marge bénéficiaire';

  @override
  String get profitLossPeriodToday => 'Aujourd\'hui';

  @override
  String get profitLossPeriodWeek => '7 derniers jours';

  @override
  String get profitLossPeriodMonth => 'Ce mois-ci';

  @override
  String get profitLossPeriodAll => 'Toutes les périodes';

  @override
  String get profitLossPositive => 'Bénéfice net';

  @override
  String get profitLossNegative => 'Perte nette';

  @override
  String get profitLossCashSectionTitle => 'Bénéfices en espèces encaissés';

  @override
  String get profitLossCashSectionSubtitle =>
      'Bénéfices réellement encaissés en caisse sur les ventes au comptant, après dépenses';

  @override
  String get profitLossCashNet => 'Bénéfice net en caisse';

  @override
  String get profitLossCashRevenue => 'Ventes au comptant';

  @override
  String get profitLossCashCogs => 'Coût des marchandises vendues au comptant';

  @override
  String get profitLossCashGross => 'Bénéfice brut au comptant';

  @override
  String get profitLossCreditSectionTitle =>
      'Bénéfices à crédit (chez les clients)';

  @override
  String get profitLossCreditSectionSubtitle =>
      'Bénéfices des marchandises vendues à crédit et non encore encaissés';

  @override
  String get profitLossCreditGross => 'Bénéfices en attente chez les clients';

  @override
  String get profitLossCreditRevenue => 'Ventes à crédit';

  @override
  String get profitLossCreditCogs => 'Coût des marchandises vendues à crédit';

  @override
  String get profitLossTotalExpectedNet =>
      'Bénéfice net total attendu (comptant + crédit)';

  @override
  String get profitLossCashVsCreditRatio => 'Ratio comptant / crédit';

  @override
  String get shopReportTitle => 'Rapport complet de la boutique';

  @override
  String get shopReportInventoryValue => 'Valeur du stock';

  @override
  String get shopReportAtCost => 'Au prix d\'achat (coût)';

  @override
  String get shopReportAtRetail => 'Au prix de vente (estimé)';

  @override
  String get shopReportExpectedProfit => 'Bénéfice estimé sur le stock';

  @override
  String get shopReportReceivables => 'Dettes des clients';

  @override
  String get shopReportPayables => 'Dettes envers les fournisseurs';

  @override
  String get shopReportCashDrawer => 'Espèces en caisse et en banque';

  @override
  String get shopReportNetWorth => 'Valeur nette de la boutique';

  @override
  String get shopReportLowStockCount => 'Produits en stock faible';

  @override
  String get shopReportShare => 'Partager le rapport via WhatsApp';

  @override
  String get featureManagerTitle => 'Personnaliser les fonctionnalités';

  @override
  String get featureManagerSubtitle =>
      'Affichez ou masquez les sections selon les besoins de votre boutique';

  @override
  String get featureManagerNote =>
      'Masquer une fonctionnalité ne supprime pas ses données ; vous pouvez la réactiver à tout moment en un seul geste.';

  @override
  String get featurePresetTitle => 'Configurations rapides en un geste';

  @override
  String get featurePresetSimple => 'Kashkool - dettes seulement';

  @override
  String get featurePresetSimpleDesc =>
      'Uniquement les comptes clients et le recouvrement';

  @override
  String get featurePresetGrocery => 'Épicerie et supermarché';

  @override
  String get featurePresetGroceryDesc =>
      'Vente rapide + stock et fournisseurs + caisse quotidienne';

  @override
  String get featurePresetElectronics => 'Téléphones et appareils';

  @override
  String get featurePresetElectronicsDesc =>
      'Versements + stock + vente rapide et fournisseurs';

  @override
  String get featurePresetAll => 'Activer toutes les fonctionnalités';

  @override
  String get featurePresetAllDesc =>
      'Débloquer toutes les possibilités de l\'application';

  @override
  String get featureQuickPosTitle => 'Vente rapide et caisse (POS)';

  @override
  String get featureQuickPosDesc =>
      'Un écran pour créer vite des factures au comptant et calculer la monnaie';

  @override
  String get featureSuppliersTitle => 'Fournisseurs et factures d\'achat';

  @override
  String get featureSuppliersDesc =>
      'Suivre les dettes fournisseurs, les commandes de réassort et les retours';

  @override
  String get featureInstallmentsTitle => 'Carnet des versements mensuels';

  @override
  String get featureInstallmentsDesc =>
      'Échéancier, contrats d\'achat et rappels de paiement';

  @override
  String get featureInventoryTitle => 'Stock et gestion des produits';

  @override
  String get featureInventoryDesc =>
      'Enregistrer la marchandise, alertes de stock et historique des mouvements';

  @override
  String get featureCashDrawerTitle => 'Caisse et clôture quotidienne';

  @override
  String get featureCashDrawerDesc =>
      'Suivre l\'argent du jour, écarts et clôture de la journée';

  @override
  String get featureProfitLossTitle => 'Bénéfices, pertes et rapports';

  @override
  String get featureProfitLossDesc =>
      'Calculer le bénéfice net après dépenses et le rapport sur le capital';

  @override
  String get featureOffersTitle => 'Messages promotionnels et fêtes';

  @override
  String get featureOffersDesc =>
      'Envoyer des offres et réductions à des groupes de clients via WhatsApp';

  @override
  String get featureCoreAlwaysActive =>
      'Clients et recouvrement : toujours actifs';

  @override
  String get featureStatusActive => 'Actif';

  @override
  String get featureStatusHidden => 'Masqué';

  @override
  String get quickPosTitle => 'Vente rapide';

  @override
  String get quickPosOpen => 'Ouvrir la vente rapide';

  @override
  String get quickPosSearch => 'Rechercher par nom ou saisir le code-barres...';

  @override
  String get quickPosProducts => 'Produits';

  @override
  String get quickPosAdd => 'Ajouter à la vente';

  @override
  String get quickPosAvailable => 'Disponible';

  @override
  String get quickPosCart => 'Articles de la vente';

  @override
  String get quickPosEmptyCart =>
      'Ajoutez des produits pour commencer la vente';

  @override
  String get quickPosQuantity => 'Quantité';

  @override
  String get quickPosQuantityInvalid =>
      'Saisissez une quantité valide supérieure à zéro';

  @override
  String get quickPosCash => 'Comptant';

  @override
  String get quickPosCredit => 'Au compte d\'un client';

  @override
  String get quickPosSelectCustomer => 'Choisir le client';

  @override
  String get quickPosCustomerRequired =>
      'Choisissez un client pour une vente à crédit';

  @override
  String get quickPosTotal => 'Total';

  @override
  String get quickPosCompleteSale => 'Confirmer la vente';

  @override
  String get quickPosSaving => 'Enregistrement de la vente...';

  @override
  String get quickPosSaleSaved => 'Vente enregistrée';

  @override
  String get quickPosSaveFailed =>
      'Impossible d\'enregistrer la vente. Réessayez.';

  @override
  String get quickPosInsufficientStock =>
      'Le stock est insuffisant pour cette quantité';

  @override
  String get quickPosCashDayClosed =>
      'La caisse du jour est fermée. Rouvrez-la pour enregistrer une vente au comptant.';

  @override
  String get quickPosLoadFailed => 'Impossible de charger les produits';

  @override
  String get quickPosCustomersLoadFailed => 'Impossible de charger les clients';

  @override
  String get quickPosSaleNote => 'Vente rapide';

  @override
  String get supplierPurchasesTitle => 'Achats chez le fournisseur';

  @override
  String get supplierPurchaseNew => 'Enregistrer un achat';

  @override
  String get supplierPurchaseInvoiceNumber => 'Numéro de facture (facultatif)';

  @override
  String get supplierPurchasePaymentType => 'Mode de paiement';

  @override
  String get supplierPurchaseCash => 'Comptant';

  @override
  String get supplierPurchaseCredit => 'À crédit';

  @override
  String get supplierPurchaseAddProduct => 'Choisir un produit';

  @override
  String get supplierPurchaseItems => 'Articles de la facture';

  @override
  String get supplierPurchaseQuantity => 'Quantité';

  @override
  String get supplierPurchaseUnitCost => 'Prix d\'achat unitaire (€)';

  @override
  String get supplierPurchaseAddLine => 'Ajouter l\'article';

  @override
  String get supplierPurchaseNoLines => 'Ajoutez au moins un produit';

  @override
  String get supplierPurchaseSave => 'Enregistrer la facture';

  @override
  String get supplierPurchaseTotal => 'Total de la facture';

  @override
  String get supplierPurchaseSaved => 'Facture d\'achat enregistrée';

  @override
  String get supplierPurchaseSaveFailed =>
      'Impossible d\'enregistrer la facture. Réessayez.';

  @override
  String get supplierPurchaseNoInvoices =>
      'Aucune facture d\'achat pour ce fournisseur';

  @override
  String get supplierPurchaseDetails => 'Détails de la facture';

  @override
  String get supplierPurchaseReturn => 'Retour au fournisseur';

  @override
  String get supplierPurchaseReturned => 'Retourné';

  @override
  String get supplierPurchaseRemaining => 'Disponible pour retour';

  @override
  String get supplierPurchaseReturnQuantity => 'Quantité retournée';

  @override
  String get supplierPurchaseReturnSaved =>
      'Retour enregistré et déduit du compte fournisseur';

  @override
  String get supplierPurchaseReturnLimit =>
      'La quantité demandée dépasse le stock ou le montant retournable';

  @override
  String get supplierCreditNote => 'Avoir sur retour';

  @override
  String get supplierPurchaseInvalidInput =>
      'Vérifiez la quantité et le prix, puis réessayez';

  @override
  String get supplierPurchaseLoadError =>
      'Impossible de charger les factures d\'achat';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get debt => 'Doit';

  @override
  String get payment => 'Paiement';

  @override
  String get settled => 'Soldé';

  @override
  String get currency => '€';

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
  String get netSettled => 'Comptes équilibrés (0 €)';

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
  String get statementFormatReceipt => 'Ticket thermique 80mm';

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
  String get addInstallmentPlanScreen20 => 'Prix total (€) *';

  @override
  String get addInstallmentPlanScreen21 => 'ex. : 12000';

  @override
  String get addInstallmentPlanScreen22 => 'Montant invalide';

  @override
  String get addInstallmentPlanScreen23 => 'Acompte (€)';

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
  String get payInstallmentDialog7 => 'Montant payé (€)';

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
  String get earlySettlementDialog6 => 'Remise de paiement anticipé (€)';

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
    return '+$val €';
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
      'https://wa.me/201005083126?text=Bonjour%2C%20j%27ai%20une%20question%20sur%20Kashkool';

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
  String get settingsScreen79 => 'Limite de crédit par défaut (€)';

  @override
  String get settingsScreen80 => 'Montant en €';

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
  String get money1 => '€';

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

  @override
  String get cloudDeleteAccountTitle => 'Supprimer mon compte cloud';

  @override
  String get cloudDeleteAccountSubtitle =>
      'Supprime définitivement vos sauvegardes cloud et votre compte — les données du téléphone restent';

  @override
  String get cloudDeleteAccountConfirmTitle =>
      'Supprimer définitivement votre compte ?';

  @override
  String get cloudDeleteAccountConfirmBody =>
      'Nous supprimerons votre compte et toutes les sauvegardes cloud de vos boutiques. C\'est irréversible. Les données de ce téléphone restent intactes.';

  @override
  String get cloudDeleteAccountConfirmButton => 'Supprimer définitivement';

  @override
  String get cloudDeleteAccountDone => 'Votre compte cloud a été supprimé';

  @override
  String get authFirstTimeTitle => 'Bienvenue dans Kashkool ! 👋';

  @override
  String get authFirstTimeQuestion =>
      'Vous avez déjà un compte ou vous êtes nouveau ?';

  @override
  String get authHaveAccount => 'J\'ai déjà un compte';

  @override
  String get authHaveAccountSubtitle =>
      'Connectez-vous pour retrouver toutes les données de votre boutique';

  @override
  String get authNewUser => 'Nouvel utilisateur';

  @override
  String get authNewUserSubtitle =>
      'Commencez avec Kashkool et préparez votre boutique étape par étape';

  @override
  String get authContinueGuest => 'Continuer sans compte';

  @override
  String get authContinueGuestSubtitle =>
      'Utilisez l\'application hors ligne, sans internet';

  @override
  String get authLogin => 'Se connecter';

  @override
  String get authRegister => 'Créer un compte';

  @override
  String get authEmail => 'Adresse e-mail';

  @override
  String get authPassword => 'Mot de passe';

  @override
  String get authPasswordConfirm => 'Confirmer le mot de passe';

  @override
  String get authNameOptional => 'Nom (facultatif)';

  @override
  String get authLoginButton => 'Se connecter';

  @override
  String get authRegisterButton => 'Créer le compte';

  @override
  String get authOrGoogle => 'Ou continuer avec Google';

  @override
  String get authSignInWithGoogle => 'Se connecter avec Google';

  @override
  String get authSignInWithGoogleSubtitle =>
      'Sauvegarde en ligne et récupération automatique de vos données';

  @override
  String get authSwitchAccount => 'Changer de compte';

  @override
  String get authSwitchAccountSubtitle =>
      'Choisissez un autre compte ou connectez-vous avec un nouveau';

  @override
  String get authAddAccount => '+ Se connecter avec un autre compte';

  @override
  String get authCurrentAccount => 'Compte actuellement connecté';

  @override
  String get authPasswordsDontMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get authPasswordTooShort =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get authInvalidEmail => 'Saisissez une adresse e-mail valide';

  @override
  String get authLoginSuccess => 'Connexion réussie 🎉';

  @override
  String get authRegisterSuccess => 'Compte créé avec succès 🎉';

  @override
  String authSwitchedTo(Object email) {
    return 'Compte changé : $email';
  }

  @override
  String get cloudApiEmailTaken =>
      'Cette adresse est déjà utilisée, essayez de vous connecter';

  @override
  String get cloudApiInvalidCredentials =>
      'Adresse e-mail ou mot de passe incorrect';

  @override
  String get authBackupBeforeSwitchTitle =>
      'Attention : données non sauvegardées !';

  @override
  String get authBackupBeforeSwitchBody =>
      'Certaines données de ce compte ne sont pas sauvegardées en ligne. Si vous changez de compte maintenant, les données locales seront supprimées et vous ne pourrez pas les récupérer sans faire une sauvegarde d\'abord.';

  @override
  String get authBackupFirst => 'Faire une sauvegarde d\'abord';

  @override
  String get authSwitchWithoutBackup =>
      'Changer et supprimer les données locales';

  @override
  String get authFetchingData => 'Récupération de vos données en ligne…';

  @override
  String get authEmailLoginButton => 'Se connecter par e-mail';

  @override
  String get authEmailRegisterButton =>
      'Créer un compte avec une adresse e-mail';

  @override
  String get authWipingData =>
      'Suppression des données locales et changement de compte…';

  @override
  String get offersBroadcasterTitle => 'Messages d\'offres et de vœux';

  @override
  String get offersBroadcasterSubtitle =>
      'Envoyez vos offres et vos vœux à vos clients via WhatsApp en un geste et gratuitement';

  @override
  String get offersTemplateSection => '1. Choisir le modèle';

  @override
  String get offersAudienceSection => '2. Choisir les destinataires';

  @override
  String get offersMessageSection => '3. Texte et aperçu du message';

  @override
  String get offersTemplateRamadan => 'Ramadan béni 🌙';

  @override
  String get offersTemplateEid => 'Eid bénie 🎉';

  @override
  String get offersTemplateBackToSchool => 'Rentrée scolaire 📚';

  @override
  String get offersTemplateNewOffer => 'Nouvelles offres 🎁';

  @override
  String get offersTemplateCustom => 'Message personnalisé ✍️';

  @override
  String get offersAudienceAllWithPhone =>
      'Tous les clients avec un numéro de téléphone';

  @override
  String get offersAudienceGoodRating =>
      'Clients qui paient régulièrement (vert)';

  @override
  String get offersAudienceActive30Days => 'Actifs ces 30 derniers jours';

  @override
  String get offersAudienceManual => 'Sélection manuelle';

  @override
  String get offersTipSpam =>
      '💡 Conseil : ne dépassez pas 50 clients par envoi pour éviter les restrictions de WhatsApp.';

  @override
  String offersStartCampaign(Object count) {
    return 'Démarrer l\'envoi ($count clients)';
  }

  @override
  String offersResumeCampaign(Object pending) {
    return 'Reprendre la campagne précédente ($pending restants)';
  }

  @override
  String get offersDiscardCampaign =>
      'Commencer une nouvelle campagne à la place';

  @override
  String get offersQueueTitle => 'File d\'envoi';

  @override
  String offersProgressLabel(Object sent, Object total, Object percent) {
    return 'Envoi de $sent sur $total clients ($percent%)';
  }

  @override
  String get offersSendViaWhatsApp => 'Envoyer via WhatsApp';

  @override
  String get offersSkipCustomer => 'Passer le client';

  @override
  String get offersPauseQueue => 'Mettre en pause et revenir';

  @override
  String get offersCampaignCompleteTitle => 'Terminé avec succès ! 🎉';

  @override
  String get offersCampaignCompleteSubtitle =>
      'Tous les messages sélectionnés ont été envoyés à vos clients.';

  @override
  String get offersNoRecipients =>
      'Aucun client ne correspond au filtre choisi avec un numéro de téléphone';

  @override
  String offersSelectManualCustomers(Object count) {
    return 'Sélectionner les clients ($count sélectionnés)';
  }

  @override
  String get offersSampleCustomerName => 'Mohamed Ahmed';

  @override
  String get offersInsertPlaceholderHint =>
      'Appuyez pour insérer une variable dans le message :';

  @override
  String get offersDefaultRamadanText =>
      'Bon Ramadan à vous, {customer_name} ! Nous vous souhaitons à vous et à votre famille un mois béni de la part de {shop_name} 🌙✨';

  @override
  String get offersDefaultEidText =>
      'Eid bénie à vous et à votre famille, {customer_name} ! Bonne année, santé et bonheur de la part de {shop_name} 🎉🐑';

  @override
  String get offersDefaultBackToSchoolText =>
      'Bonne et heureuse rentrée scolaire pour vos enfants, {customer_name} ! Retrouvez tout ce qu\'il vous faut chez {shop_name} 📚✏️';

  @override
  String get offersDefaultNewOfferText =>
      'Bonjour {customer_name} ! De nouvelles offres et réductions vous attendent chez {shop_name} 🎁🔥';

  @override
  String get offersDefaultCustomText =>
      'Bonjour {customer_name} ! Nos salutations de la part de {shop_name} 👋';

  @override
  String offersSentSuccessPrompt(Object name) {
    return 'Le message a-t-il bien été envoyé à $name ?';
  }

  @override
  String get offersYesSent => 'Oui, envoyé';

  @override
  String get offersNotSent => 'Non, pas envoyé';

  @override
  String get offersPreviewCardTitle => 'Aperçu du message pour le client';

  @override
  String get offersIncludeGrowthFooter =>
      'Ajouter la signature Kashkool à la fin du message';

  @override
  String offersCampaignActiveBanner(Object sent, Object total) {
    return 'Vous avez une campagne en cours ($sent sur $total envoyés)';
  }

  @override
  String get notificationServiceInstallmentsChannelName =>
      'Rappel des versements';

  @override
  String get notificationServiceInstallmentsChannelDesc =>
      'Alertes pour les échéances de versements à payer et en retard';

  @override
  String get notificationServiceInstallmentsTitle => 'Versements à payer 🔔';

  @override
  String notificationServiceInstallmentsBody(Object count, Object amountStr) {
    return 'Vous avez $count versements à payer pour un total de $amountStr — appuyez pour continuer';
  }

  @override
  String get notificationServiceBackupChannelName => 'Rappel de sauvegarde';

  @override
  String get notificationServiceBackupChannelDesc =>
      'Rappel régulier pour sauvegarder votre carnet et éviter de perdre vos données';

  @override
  String get notificationServiceBackupTitle =>
      'Attention : pensez à faire une sauvegarde ⚠️';

  @override
  String notificationServiceBackupBody(Object days) {
    return '$days jours se sont écoulés sans sauvegarde. Appuyez pour sauvegarder vos données maintenant.';
  }

  @override
  String get notificationServiceTestTitle =>
      'Notification de test de Kashkool 🚀';

  @override
  String get notificationServiceTestBody =>
      'Les notifications fonctionnent et arrivent à l\'heure 👍';

  @override
  String get notificationServiceSettingsReminderTime =>
      'Heure du rappel quotidien';

  @override
  String get notificationServiceSettingsReminderTimeSubtitle =>
      'L\'heure quotidienne pour vous rappeler les recouvrements et versements à payer';

  @override
  String get notificationServiceSettingsStatus =>
      'Notifications de l\'application';

  @override
  String get notificationServiceSettingsStatusActive =>
      'Activées et fonctionnelles ✓';

  @override
  String get notificationServiceSettingsStatusDisabled =>
      'Désactivées — appuyez pour autoriser';

  @override
  String get notificationServiceSettingsSendTest =>
      'Envoyer une notification de test';

  @override
  String get notificationServiceSettingsSendTestSubtitle =>
      'Vérifiez que les notifications et le son apparaissent sur votre téléphone';

  @override
  String get notificationServiceSettingsSendTestSuccess =>
      'Notification de test envoyée ! Consultez la barre de notifications 👍';

  @override
  String get notificationServiceDailyScheduledTitle =>
      'C\'est l\'heure d\'encaisser 💰';

  @override
  String get notificationServiceDailyScheduledBody =>
      'Ouvrez Kashkool pour voir les clients à relancer aujourd\'hui';

  @override
  String get navHome => 'Accueil';

  @override
  String get moreSectionShop => 'Outils de la boutique';

  @override
  String get moreSectionApp => 'Communication et paramètres';

  @override
  String get moreInventorySubtitle => 'Produits, prix et quantités';

  @override
  String get moreCashDrawerSubtitle => 'Clôture du jour et dépenses';

  @override
  String get moreInstallmentsTitle => 'Échéances';

  @override
  String get moreInstallmentsSubtitle =>
      'Plans d\'échéances et dates de paiement';

  @override
  String get moreOffersSubtitle => 'Offres et vœux à vos clients';

  @override
  String get moreSettingsSubtitle => 'Infos boutique, sécurité et sauvegarde';

  @override
  String get moreProfitLossSubtitle => 'Bénéfices nets et dépenses du magasin';

  @override
  String get moreShopReportSubtitle =>
      'Total des stocks, liquidités et créances';

  @override
  String get notificationServiceGeneralChannelDesc =>
      'Notifications générales et de test de Kashkool';

  @override
  String get notificationServiceGeneralChannelName =>
      'Notifications générales et tests';

  @override
  String notificationServiceLowStockBody(Object remainingStock) {
    return 'Restant en stock : $remainingStock';
  }

  @override
  String get notificationServiceLowStockChannelDesc =>
      'Alerte instantanée quand un article atteint le seuil minimum';

  @override
  String get notificationServiceLowStockChannelName => 'Alertes stock faible';

  @override
  String get notificationServiceLowStockNoSupplierSuffix =>
      ' Touchez pour vérifier le stock et réapprovisionner';

  @override
  String notificationServiceLowStockSupplierSuffix(Object supplierName) {
    return ' Fournisseur : $supplierName — touchez pour commander via WhatsApp';
  }

  @override
  String notificationServiceLowStockTitle(Object productName) {
    return '⚠️ Alerte stock faible : $productName';
  }

  @override
  String get notificationServiceMultipleLowStockBody =>
      'Consultez les articles en rupture pour commander aux fournisseurs.';

  @override
  String notificationServiceMultipleLowStockTitle(Object count) {
    return '⚠️ $count articles en stock faible';
  }

  @override
  String get pdfInvoiceCash => 'Espèces';

  @override
  String get pdfInvoiceCredit => 'Facture de vente à crédit';

  @override
  String pdfInvoiceNumber(Object shortSaleId) {
    return 'Facture n° #$shortSaleId';
  }

  @override
  String get pdfInvoicePayCash => 'Payé en espèces';

  @override
  String get pdfInvoicePayOnCredit => 'Enregistré à crédit (compte)';

  @override
  String get pdfInvoicePaymentMethod => 'Mode de règlement :';

  @override
  String pdfInvoicePhone(Object phone) {
    return 'Tél : $phone';
  }

  @override
  String get pdfInvoicePrice => 'Prix';

  @override
  String get pdfInvoiceThankYou => 'Merci pour votre confiance !';

  @override
  String get pdfInvoiceTotal => 'Total';

  @override
  String get pdfPreviewErrorLabel => 'Impossible de générer le fichier';

  @override
  String get pdfPreviewPreparing => 'Préparation du document PDF...';

  @override
  String get pdfPreviewPrint => 'Impression directe';

  @override
  String get pdfPreviewRetry => 'Réessayer';

  @override
  String get pdfPreviewShare => 'Partager le PDF';

  @override
  String get pdfReportAvailableAmount => 'Montant disponible';

  @override
  String get pdfReportCashInDrawer => 'Espèces en caisse';

  @override
  String get pdfReportCashProfitNote =>
      'Note Kashkool : Le bénéfice net en caisse représente l\'argent réel encaissé. Les bénéfices à crédit se convertissent en caisse lors des recouvrements.';

  @override
  String get pdfReportCashVsCreditTitle =>
      'Comparaison ventes espèces et à crédit';

  @override
  String get pdfReportCount => 'Nombre';

  @override
  String get pdfReportCustomerUnit => 'clients';

  @override
  String get pdfReportDateLabel => 'Date';

  @override
  String get pdfReportDebtSection => '2. Dettes et Créances';

  @override
  String get pdfReportDigitalBalance =>
      'Solde électronique (Banque / Portefeuille)';

  @override
  String get pdfReportGrandTotal => 'Total général';

  @override
  String get pdfReportGrowthFooter =>
      'Généré par Kashkool — Carnet de dettes et ventes gratuit';

  @override
  String get pdfReportInventoryAtCost => 'Valeur du stock au coût d\'achat';

  @override
  String get pdfReportInventoryAtRetail => 'Valeur du stock au prix de vente';

  @override
  String get pdfReportInventorySection => '1. Stock et Inventaire';

  @override
  String get pdfReportInventorySubtitle =>
      'Rapport détaillé d\'évaluation des stocks et disponibilités';

  @override
  String get pdfReportInventoryTitle => 'Rapport général d\'inventaire';

  @override
  String get pdfReportInvoiceUnit => 'factures';

  @override
  String get pdfReportItemUnit => 'articles';

  @override
  String get pdfReportLiquiditySection => '3. Liquidités et Fonds disponibles';

  @override
  String get pdfReportLowStockLabel => 'Ruptures';

  @override
  String get pdfReportLowStockNeedOrder => 'à commander';

  @override
  String get pdfReportLowStockSubtitle =>
      'État complet des articles en rupture, coûts et prix';

  @override
  String get pdfReportLowStockTitle =>
      'État des ruptures et commandes fournisseurs';

  @override
  String get pdfReportMinimum => 'Seuil mini';

  @override
  String get pdfReportMovementUnit => 'mouvements';

  @override
  String get pdfReportNetWorthFormula =>
      '= (Stock au coût + Caisse & Banque + Créances) - Dettes fournisseurs';

  @override
  String get pdfReportOperatingExpenses =>
      'Dépenses d\'exploitation (déduites de la caisse)';

  @override
  String get pdfReportOutOfStock => 'Rupture de stock';

  @override
  String get pdfReportParty => 'Partie / Catégorie';

  @override
  String get pdfReportProductCountLabel => 'Nombre total d\'articles';

  @override
  String get pdfReportProfitLossTitle => 'Rapport des Pertes et Profits';

  @override
  String get pdfReportRowNumber => 'N°';

  @override
  String get pdfReportSalesCount => 'Nombre de ventes';

  @override
  String get pdfReportSalesRevenue => 'Chiffre d\'affaires';

  @override
  String get pdfReportShopOverviewSubtitle =>
      'Bilan exhaustif du stock, des créances et de la trésorerie';

  @override
  String get pdfReportShopOverviewTitle =>
      'Bilan de situation financière du magasin';

  @override
  String get pdfReportSource => 'Source / Poste';

  @override
  String get pdfReportStatus => 'Statut';

  @override
  String get pdfReportSupplier => 'Fournisseur';

  @override
  String get pdfReportSupplierPhone => 'Tél. fournisseur';

  @override
  String get pdfReportSupplierUnit => 'fournisseurs';

  @override
  String get pdfReportTotalCashAvailable => 'Total trésorerie disponible';

  @override
  String get pdfReportTotalCost => 'Coût total';

  @override
  String get pdfReportTotalCostLabel => 'Valeur totale au coût';

  @override
  String get pdfReportTotalNetProfit => 'Bénéfice net global';

  @override
  String get pdfReportTotalProducts => 'Total articles';

  @override
  String get pdfReportValueCountHeader => 'Montant / Nombre';

  @override
  String get quickPosDoneNewSale => 'Terminé · Nouvelle vente';

  @override
  String quickPosFetchLastInvoiceFailed(Object e) {
    return 'Impossible de charger la facture précédente : $e';
  }

  @override
  String get quickPosInvoiceOptions => 'Options de la facture';

  @override
  String quickPosInvoiceTotal(Object total) {
    return 'Total facture : $total';
  }

  @override
  String quickPosItemsCount(Object count) {
    return '$count articles au panier';
  }

  @override
  String get quickPosLastInvoiceNoItems => 'La facture précédente est vide';

  @override
  String get quickPosNoItemsToPreview => 'Aucun article à prévisualiser';

  @override
  String get quickPosNoItemsToPrint => 'Aucun article à imprimer';

  @override
  String get quickPosNoPreviousInvoices =>
      'Aucune facture de vente enregistrée';

  @override
  String quickPosOpenInvoiceFailed(Object e) {
    return 'Impossible d\'ouvrir la facture : $e';
  }

  @override
  String get quickPosOutOfStock => 'Rupture de stock';

  @override
  String get quickPosPaymentMethod => 'Mode de règlement';

  @override
  String get quickPosPreviewBeforeSave => 'Aperçu avant enregistrement';

  @override
  String get quickPosPreviewCurrentInvoice => 'Aperçu de la facture';

  @override
  String quickPosPreviewFailed(Object e) {
    return 'Impossible d\'ouvrir l\'aperçu : $e';
  }

  @override
  String get quickPosPreviewFileName => 'apercu_facture.pdf';

  @override
  String get quickPosPreviewLabel => 'Aperçu';

  @override
  String get quickPosPreviewPrintCurrent => 'Imprimer et aperçu';

  @override
  String get quickPosPreviewSharePdf => 'Aperçu et partage PDF';

  @override
  String quickPosPrintFailed(Object e) {
    return 'Échec de l\'impression : $e';
  }

  @override
  String get quickPosPrintLastInvoice => 'Réimprimer dernière facture';

  @override
  String get quickPosPrintThermalReceipt => 'Imprimer ticket thermique (80mm)';

  @override
  String get quickPosReceiveCash => 'Encaisser espèces';

  @override
  String get quickPosRecordOnAccount => 'Inscrire au compte';

  @override
  String quickPosSaleInvoiceFileName(Object shortId) {
    return 'facture_vente_$shortId.pdf';
  }

  @override
  String quickPosSaleInvoiceTitle(Object shortId) {
    return 'Facture de vente #$shortId';
  }

  @override
  String get quickPosSaleSavedSuccessfully => 'Vente enregistrée avec succès !';

  @override
  String get quickPosSaveAndPrint => 'Enregistrer et imprimer';

  @override
  String get quickPosSaveAndPrintTooltip =>
      'Enregistrer la vente et imprimer le ticket directement';

  @override
  String get quickPosSavingAndPrinting =>
      'Vente enregistrée, impression en cours...';

  @override
  String get quickPosTapToAdd => 'Touchez pour ajouter';

  @override
  String get quickPosTapToAddToCart => 'Touchez pour ajouter au panier';

  @override
  String genericError(Object err) {
    return 'Une erreur est survenue : $err';
  }

  @override
  String get inventoryPdfExportTooltip =>
      'Imprimer et exporter l\'inventaire en PDF';

  @override
  String inventoryPdfFileNameFull(Object dateStr) {
    return 'inventaire_general_$dateStr.pdf';
  }

  @override
  String inventoryPdfFileNameLowStock(Object dateStr) {
    return 'ruptures_stock_$dateStr.pdf';
  }

  @override
  String get inventoryPdfMenuFull => 'Imprimer l\'inventaire complet';

  @override
  String get inventoryPdfMenuLowStock => 'Imprimer uniquement les ruptures';

  @override
  String get inventoryPdfTitleFull => 'Rapport général d\'inventaire';

  @override
  String get inventoryPdfTitleLowStock => 'État des ruptures de stock';

  @override
  String get notificationServiceSettingsSendTestFailure =>
      'Échec de l\'envoi du test — vérifiez les autorisations de notification';

  @override
  String get printExportPdf => 'Imprimer et exporter en PDF';

  @override
  String get profitLossAccountingTipBody =>
      'Le bénéfice net en caisse est l\'argent réel encaissé après règlement des charges. Les bénéfices à crédit deviennent du cash lors des recouvrements.';

  @override
  String get profitLossAccountingTipTitle => 'Conseil comptable de Kashkool';

  @override
  String get profitLossCashBadge => 'Espèces';

  @override
  String get profitLossCreditBadge => 'Crédit';

  @override
  String profitLossNetCalculation(Object netCash, Object netCredit) {
    return '= $netCash Espèces + $netCredit Crédit';
  }

  @override
  String profitLossRecordedSales(Object salesCount) {
    return '$salesCount factures de vente enregistrées';
  }

  @override
  String profitLossReportFileName(Object dateStr) {
    return 'rapport_pertes_profits_$dateStr.pdf';
  }

  @override
  String get profitLossReportTitle => 'Rapport des Pertes et Profits';

  @override
  String restockAvailable(Object stock, Object unit) {
    return 'Disponible : $stock $unit';
  }

  @override
  String get restockCopiedToClipboard =>
      'Message de réapprovisionnement copié !';

  @override
  String restockError(Object err) {
    return 'Impossible de charger les produits : $err';
  }

  @override
  String get restockLinkProductsHint =>
      'Associez les produits à ce fournisseur dans l\'inventaire pour commander en 1 geste.';

  @override
  String get restockMessageFooter =>
      'Merci de confirmer la réception de la commande et la livraison.';

  @override
  String restockMessageGreeting(Object supplierName) {
    return 'Bonjour $supplierName';
  }

  @override
  String get restockMessageHeader =>
      'Nous avons besoin des articles suivants en réassort :';

  @override
  String restockMessageItem(Object name, Object qty, Object unit) {
    return '• $name — requis : $qty $unit';
  }

  @override
  String restockMessageShop(Object shopName) {
    return 'De la part de $shopName';
  }

  @override
  String get restockMessageThanks => 'Merci beaucoup !';

  @override
  String get restockSelectProductsHint =>
      'Sélectionnez les articles à commander via WhatsApp :';

  @override
  String get restockSendWhatsApp => 'Envoyer la commande via WhatsApp';

  @override
  String get shopReportCashInDrawerLabel => 'Espèces en caisse :';

  @override
  String get shopReportCopiedToClipboard =>
      'Bilan financier copié dans le presse-papiers !';

  @override
  String get shopReportCustomersWithDues => 'Clients ayant des dettes :';

  @override
  String get shopReportDigitalBalanceLabel =>
      'Solde électronique (Banque / Portefeuille) :';

  @override
  String shopReportFileName(Object dateStr) {
    return 'situation_financiere_$dateStr.pdf';
  }

  @override
  String shopReportLowStockOf(Object count, Object total) {
    return '$count articles sur $total';
  }

  @override
  String get shopReportNetWorthFormula =>
      '= (Stock au coût + Caisse & Banque + Créances) - Dettes fournisseurs';

  @override
  String shopReportSupplierCount(Object count) {
    return '$count fournisseurs';
  }

  @override
  String get shopReportSuppliersOwed => 'Fournisseurs avec solde dû :';

  @override
  String get shopReportTextCashAvailable => '--- Liquidités disponibles ---';

  @override
  String shopReportTextCashInDrawer(Object amount) {
    return '• Espèces en caisse : $amount';
  }

  @override
  String shopReportTextDate(Object dateStr) {
    return 'Date : $dateStr';
  }

  @override
  String shopReportTextDigitalBalance(Object amount) {
    return '• Solde électronique : $amount';
  }

  @override
  String shopReportTextExpectedProfit(Object profit) {
    return '• Bénéfice attendu sur stock : $profit';
  }

  @override
  String get shopReportTextFooter =>
      'Rapport généré par l\'application Kashkool';

  @override
  String get shopReportTextInventory => '--- Stock et Entrepôt ---';

  @override
  String shopReportTextNetWorth(Object netWorth) {
    return 'Valeur nette du magasin : $netWorth';
  }

  @override
  String shopReportTextPayables(Object amount, Object count) {
    return '• Dû aux fournisseurs : $amount ($count fournisseurs)';
  }

  @override
  String shopReportTextProductCounts(Object total, Object low) {
    return '• Total articles : $total ($low en rupture)';
  }

  @override
  String shopReportTextReceivables(Object amount, Object count) {
    return '• Créances clients : $amount ($count clients)';
  }

  @override
  String shopReportTextShop(Object shopName) {
    return 'Magasin : $shopName';
  }

  @override
  String get shopReportTextTitle => '=== Situation Financière du Magasin ===';

  @override
  String shopReportTextTotalCash(Object amount) {
    return '• Total trésorerie disponible : $amount';
  }

  @override
  String get shopReportTotalCashLabel => 'Total trésorerie disponible :';

  @override
  String get shopReportTotalCustomerDues => 'Total créances clients :';

  @override
  String get shopReportTotalSupplierDues => 'Total dettes fournisseurs :';
}
