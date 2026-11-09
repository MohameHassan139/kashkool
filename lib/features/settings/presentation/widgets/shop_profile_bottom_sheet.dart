import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../shared/widgets/glass_toast.dart';
import '../../../onboarding/data/shop_repository.dart';
import '../../data/settings_repository.dart';
import '../../../../l10n/l10n.dart';

/// Modal bottom sheet allowing the shopkeeper to edit their shop name, address, phone, logo, and payment info.
class ShopProfileBottomSheet extends ConsumerStatefulWidget {
  const ShopProfileBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const ShopProfileBottomSheet(),
    );
  }

  @override
  ConsumerState<ShopProfileBottomSheet> createState() => _ShopProfileBottomSheetState();
}

class _ShopProfileBottomSheetState extends ConsumerState<ShopProfileBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _instaPayController = TextEditingController();
  final _walletController = TextEditingController();
  String _tradeType = 'grocery';
  bool _enableInstallments = false;
  String? _logoPath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final repo = ref.read(settingsRepositoryProvider);
    final shopRepo = ref.read(shopRepositoryProvider);
    final activeShop = await shopRepo.getActiveShop();

    final name = await repo.getShopName();
    final phone = await repo.getShopPhone();
    final address = await repo.getShopAddress();
    final instaPay = await repo.getShopInstaPay();
    final wallet = await repo.getShopWallet();
    final logo = await repo.getShopLogoPath();

    if (mounted) {
      setState(() {
        _nameController.text = name.isNotEmpty ? name : (activeShop?.name ?? '');
        _phoneController.text = phone.isNotEmpty ? phone : (activeShop?.phone ?? '');
        _addressController.text = address.isNotEmpty ? address : (activeShop?.address ?? '');
        _tradeType = activeShop?.shopType ?? 'grocery';
        _enableInstallments = activeShop?.enableInstallments ?? false;
        _instaPayController.text = instaPay;
        _walletController.text = wallet;
        _logoPath = logo;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _instaPayController.dispose();
    _walletController.dispose();
    super.dispose();
  }

  Future<void> _pickLogo() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (image != null && mounted) {
      setState(() {
        _logoPath = image.path;
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(settingsRepositoryProvider);
    final shopRepo = ref.read(shopRepositoryProvider);

    await shopRepo.createOrUpdateShop(
      name: _nameController.text.trim(),
      shopType: _tradeType,
      phone: _phoneController.text.trim().isNotEmpty ? _phoneController.text.trim() : null,
      address: _addressController.text.trim().isNotEmpty ? _addressController.text.trim() : null,
      enableInstallments: _enableInstallments,
    );

    await repo.setShopName(_nameController.text.trim());
    await repo.setShopPhone(_phoneController.text.trim());
    await repo.setShopAddress(_addressController.text.trim());
    await repo.setShopInstaPay(_instaPayController.text.trim());
    await repo.setShopWallet(_walletController.text.trim());
    await repo.setShopLogoPath(_logoPath);

    // Also compose payment info string
    final parts = <String>[];
    if (_walletController.text.trim().isNotEmpty) {
      parts.add(L10n.t.shopProfileBottomSheet1(_walletController.text.trim()));
    }
    if (_instaPayController.text.trim().isNotEmpty) {
      parts.add(L10n.t.installmentPlanDetailsScreen1(_instaPayController.text.trim()));
    }
    await repo.setPaymentInfo(parts.join(' | '));

    if (mounted) {
      Navigator.of(context).pop();
      AppGlassToast.showSuccess(context, L10n.t.shopProfileBottomSheet2);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 250,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 48,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              Text(
                L10n.t.settingsScreen1,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Logo Picker
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                      backgroundImage: _logoPath != null ? FileImage(File(_logoPath!)) : null,
                      child: _logoPath == null
                          ? Icon(Icons.storefront_rounded, size: 40, color: Theme.of(context).colorScheme.primary)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: _pickLogo,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: Icon(
                            Icons.camera_alt_rounded,
                            size: 14,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Shop Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: L10n.t.shopProfileBottomSheet3,
                  hintText: L10n.t.shopProfileBottomSheet4,
                  prefixIcon: Icon(Icons.storefront_outlined),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return L10n.t.shopProfileBottomSheet5;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Shop Phone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: L10n.t.shopProfileBottomSheet6,
                  hintText: L10n.t.shopProfileBottomSheet7,
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
              ),
              const SizedBox(height: 12),

              // Shop Address
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: L10n.t.shopProfileBottomSheet8,
                  hintText: L10n.t.shopProfileBottomSheet9,
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
              ),
              const SizedBox(height: 12),

              // InstaPay Handle
              TextFormField(
                controller: _instaPayController,
                decoration: InputDecoration(
                  labelText: L10n.t.shopProfileBottomSheet10,
                  hintText: L10n.t.shopProfileBottomSheet11,
                  prefixIcon: Icon(Icons.payment_outlined),
                ),
              ),
              const SizedBox(height: 12),

              // Wallet Number
              TextFormField(
                controller: _walletController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: L10n.t.shopProfileBottomSheet12,
                  hintText: L10n.t.shopProfileBottomSheet7,
                  prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                ),
              ),
              // Trade Type
              DropdownButtonFormField<String>(
                initialValue: _tradeType,
                decoration: InputDecoration(
                  labelText: L10n.t.shopProfileBottomSheet13,
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                items: [
                  DropdownMenuItem(value: 'grocery', child: Text(L10n.t.settingsScreen11)),
                  DropdownMenuItem(value: 'mobile', child: Text(L10n.t.settingsScreen12)),
                  DropdownMenuItem(value: 'electronics', child: Text(L10n.t.settingsScreen13)),
                  DropdownMenuItem(value: 'pharmacy', child: Text(L10n.t.settingsScreen14)),
                  DropdownMenuItem(value: 'other', child: Text(L10n.t.shopProfileBottomSheet14)),
                ],
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _tradeType = val;
                      if (val == 'mobile' || val == 'electronics') {
                        _enableInstallments = true;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 12),

              // Installments Toggle
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(L10n.t.shopProfileBottomSheet15, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                subtitle: Text(L10n.t.shopProfileBottomSheet16, style: TextStyle(fontSize: 12)),
                value: _enableInstallments,
                onChanged: (val) => setState(() => _enableInstallments = val),
              ),
              const SizedBox(height: 24),

              // Save Button
              ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(L10n.t.shopProfileBottomSheet17, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
