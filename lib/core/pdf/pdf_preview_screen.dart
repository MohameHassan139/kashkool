import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import '../../core/constants/app_colors.dart';
import 'pdf_reports_service.dart';

/// Interactive preview and print screen for any PDF document in Kashkool.
class PdfPreviewScreen extends ConsumerStatefulWidget {
  final String title;
  final String fileName;
  final Future<Uint8List> Function(PdfDocumentFormat format) generator;
  final PdfDocumentFormat initialFormat;
  final bool allowFormatToggle;

  const PdfPreviewScreen({
    super.key,
    required this.title,
    required this.fileName,
    required this.generator,
    this.initialFormat = PdfDocumentFormat.a4,
    this.allowFormatToggle = true,
  });

  @override
  ConsumerState<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends ConsumerState<PdfPreviewScreen> {
  late PdfDocumentFormat _format;
  Uint8List? _pdfBytes;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _format = widget.initialFormat;
    _renderPdf();
  }

  Future<void> _renderPdf() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final bytes = await widget.generator(_format);
      if (mounted) {
        setState(() {
          _pdfBytes = bytes;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handlePrint() async {
    if (_pdfBytes == null) return;
    final pdfService = ref.read(pdfReportsServiceProvider);
    await pdfService.printPdf(
      bytes: _pdfBytes!,
      name: widget.fileName,
    );
  }

  Future<void> _handleShare() async {
    if (_pdfBytes == null) return;
    final pdfService = ref.read(pdfReportsServiceProvider);
    await pdfService.sharePdf(
      bytes: _pdfBytes!,
      fileName: widget.fileName,
      subject: widget.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (widget.allowFormatToggle)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<PdfDocumentFormat>(
                  value: _format,
                  dropdownColor: theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  icon: const Icon(Icons.tune_rounded),
                  items: const [
                    DropdownMenuItem(
                      value: PdfDocumentFormat.a4,
                      child: Text('ورقة A4'),
                    ),
                    DropdownMenuItem(
                      value: PdfDocumentFormat.thermal80mm,
                      child: Text('بون حراري 80مم'),
                    ),
                  ],
                  onChanged: (newFormat) {
                    if (newFormat != null && newFormat != _format) {
                      setState(() => _format = newFormat);
                      _renderPdf();
                    }
                  },
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Main PDF Preview Area
          Expanded(
            child: _isLoading
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 12),
                        Text('جاري تجهيز ملف الـ PDF...'),
                      ],
                    ),
                  )
                : _error != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.error_outline_rounded, size: 48, color: AppColors.debtRed),
                              const SizedBox(height: 12),
                              Text('تعذر إنشاء الملف: $_error', textAlign: TextAlign.center),
                              const SizedBox(height: 16),
                              FilledButton(
                                onPressed: _renderPdf,
                                child: const Text('إعادة المحاولة'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : PdfPreview(
                        build: (_) async => _pdfBytes!,
                        useActions: false,
                        canChangeOrientation: false,
                        canChangePageFormat: false,
                        canDebug: false,
                        scrollViewDecoration: BoxDecoration(
                          color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                        ),
                      ),
          ),

          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  offset: const Offset(0, -2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  // Share Button
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _pdfBytes == null ? null : _handleShare,
                      icon: const Icon(Icons.share_rounded),
                      label: const Text('مشاركة PDF'),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Print Button
                  Expanded(
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _pdfBytes == null ? null : _handlePrint,
                      icon: const Icon(Icons.print_rounded),
                      label: const Text('طباعة فورية'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
