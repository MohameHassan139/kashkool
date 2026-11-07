import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import '../../../core/db/app_database.dart';
import '../../../l10n/app_localizations.dart';
import '../../settings/data/settings_repository.dart';
import '../data/pdf_statement_service.dart';
import '../data/statement_calculator.dart';
import '../domain/statement_filter.dart';

/// Screen allowing shop owner to customize, preview, share, and print customer statements.
class StatementPreviewScreen extends ConsumerStatefulWidget {
  final Customer customer;
  final List<Transaction> transactions;

  const StatementPreviewScreen({
    super.key,
    required this.customer,
    required this.transactions,
  });

  @override
  ConsumerState<StatementPreviewScreen> createState() => _StatementPreviewScreenState();
}

class _StatementPreviewScreenState extends ConsumerState<StatementPreviewScreen> {
  final _pdfService = PdfStatementService();

  StatementPeriod _selectedPeriod = StatementPeriod.allTime;
  StatementPageFormat _selectedFormat = StatementPageFormat.a4;
  DateTimeRange? _customDateRange;

  Uint8List? _pdfBytes;
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    _generate();
  }

  Future<void> _generate() async {
    setState(() => _isGenerating = true);

    final settings = ref.read(settingsRepositoryProvider);
    final shopName = await settings.getShopName();
    final paymentInfo = await settings.getPaymentInfo();

    final statement = StatementCalculator.compute(
      allTransactions: widget.transactions,
      period: _selectedPeriod,
      customStart: _customDateRange?.start,
      customEnd: _customDateRange?.end,
    );

    final bytes = await _pdfService.generatePdf(
      customer: widget.customer,
      statement: statement,
      shopName: shopName,
      paymentInfo: paymentInfo,
      pageFormat: _selectedFormat,
    );

    if (mounted) {
      setState(() {
        _pdfBytes = bytes;
        _isGenerating = false;
      });
    }
  }

  Future<void> _pickCustomDateRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 1),
      initialDateRange: _customDateRange ??
          DateTimeRange(
            start: DateTime(now.year, now.month, 1),
            end: now,
          ),
    );

    if (picked != null) {
      setState(() {
        _customDateRange = picked;
        _selectedPeriod = StatementPeriod.custom;
      });
      await _generate();
    }
  }

  Future<void> _share() async {
    if (_pdfBytes == null) return;
    final l10n = AppLocalizations.of(context)!;
    final fileName = PdfStatementService.buildFileName(widget.customer.name);

    await _pdfService.sharePdf(
      bytes: _pdfBytes!,
      fileName: fileName,
      subject: l10n.statementShareSubject(widget.customer.name),
    );
  }

  Future<void> _print() async {
    if (_pdfBytes == null) return;
    final fileName = PdfStatementService.buildFileName(widget.customer.name);
    await _pdfService.printPdf(bytes: _pdfBytes!, name: fileName);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.statementTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            tooltip: l10n.shareStatement,
            onPressed: _pdfBytes != null ? _share : null,
          ),
          IconButton(
            icon: const Icon(Icons.print_rounded),
            tooltip: l10n.printStatement,
            onPressed: _pdfBytes != null ? _print : null,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter & Options Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
              border: Border(
                bottom: BorderSide(
                  color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                ),
              ),
            ),
            child: Column(
              children: [
                // Period Filters
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ChoiceChip(
                        label: Text(l10n.statementAllTime),
                        selected: _selectedPeriod == StatementPeriod.allTime,
                        onSelected: (val) {
                          if (val) {
                            setState(() => _selectedPeriod = StatementPeriod.allTime);
                            _generate();
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      ChoiceChip(
                        label: Text(l10n.statementThisMonth),
                        selected: _selectedPeriod == StatementPeriod.thisMonth,
                        onSelected: (val) {
                          if (val) {
                            setState(() => _selectedPeriod = StatementPeriod.thisMonth);
                            _generate();
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      ChoiceChip(
                        label: Text(
                          _customDateRange != null && _selectedPeriod == StatementPeriod.custom
                              ? '${DateFormat('MM/dd').format(_customDateRange!.start)} - ${DateFormat('MM/dd').format(_customDateRange!.end)}'
                              : l10n.statementCustomRange,
                        ),
                        selected: _selectedPeriod == StatementPeriod.custom,
                        onSelected: (_) => _pickCustomDateRange(),
                      ),
                      const SizedBox(width: 16),

                      // Format Toggle (A4 vs Thermal 80mm)
                      DropdownButton<StatementPageFormat>(
                        value: _selectedFormat,
                        underline: const SizedBox.shrink(),
                        items: [
                          DropdownMenuItem(
                            value: StatementPageFormat.a4,
                            child: Text(l10n.statementFormatA4),
                          ),
                          DropdownMenuItem(
                            value: StatementPageFormat.thermalRoll80,
                            child: Text(l10n.statementFormatReceipt),
                          ),
                        ],
                        onChanged: (format) {
                          if (format != null) {
                            setState(() => _selectedFormat = format);
                            _generate();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // PDF Preview Area
          Expanded(
            child: _isGenerating
                ? const Center(child: CircularProgressIndicator())
                : _pdfBytes == null
                    ? Center(child: Text(l10n.noTransactionsYet))
                    : PdfPreview(
                        build: (format) async => _pdfBytes!,
                        useActions: false,
                        canChangeOrientation: false,
                        canChangePageFormat: false,
                        canDebug: false,
                        scrollViewDecoration: BoxDecoration(
                          color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                        ),
                      ),
          ),

          // Bottom Action Bar (Share & Print)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366), // WhatsApp Green
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.share_rounded),
                    label: Text(
                      l10n.shareStatement,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    onPressed: _pdfBytes != null ? _share : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.print_outlined),
                    label: Text(
                      l10n.printStatement,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    onPressed: _pdfBytes != null ? _print : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
