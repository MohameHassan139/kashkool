import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../onboarding/data/shop_repository.dart';
import '../../data/settings_repository.dart';

/// Modal bottom sheet allowing the shopkeeper to edit their shop name, address, phone, logo, and payment info.
class ShopProfileBottomSheet extends ConsumerStatefulWidget {
  const ShopProfileBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
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
      parts.add('محفظة كاش: ${_walletController.text.trim()}');
    }
    if (_instaPayController.text.trim().isNotEmpty) {
      parts.add('إنستاباي: ${_instaPayController.text.trim()}');
    }
    await repo.setPaymentInfo(parts.join(' | '));

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حفظ بيانات المحل بنجاح 👍'),
          backgroundColor: AppColors.paymentGreen,
        ),
      );
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
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              const Text(
                'بيانات المحل 🏪',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Logo Picker
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.primaryBlueLight,
                      backgroundImage: _logoPath != null ? FileImage(File(_logoPath!)) : null,
                      child: _logoPath == null
                          ? const Icon(Icons.storefront_rounded, size: 40, color: AppColors.primaryBlue)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: _pickLogo,
                        child: const CircleAvatar(
                          radius: 14,
                          backgroundColor: AppColors.primaryBlue,
                          child: Icon(Icons.camera_alt_rounded, size: 14, color: Colors.white),
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
                decoration: const InputDecoration(
                  labelText: 'اسم المحل *',
                  hintText: 'مثلاً: بقالة الأمانة',
                  prefixIcon: Icon(Icons.storefront_outlined),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'يرجى إدخال اسم المحل';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Shop Phone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'رقم هاتف المحل',
                  hintText: 'مثلاً: 010xxxxxxxx',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
              ),
              const SizedBox(height: 12),

              // Shop Address
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'عنوان المحل',
                  hintText: 'مثلاً: شارع السوق، بجوار المسجد الكبير',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
              ),
              const SizedBox(height: 12),

              // InstaPay Handle
              TextFormField(
                controller: _instaPayController,
                decoration: const InputDecoration(
                  labelText: 'حساب إنستاباي (InstaPay)',
                  hintText: 'مثلاً: name@instapay',
                  prefixIcon: Icon(Icons.payment_outlined),
                ),
              ),
              const SizedBox(height: 12),

              // Wallet Number
              TextFormField(
                controller: _walletController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'رقم فودافون كاش / المحفظة الذكية',
                  hintText: 'مثلاً: 010xxxxxxxx',
                  prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                ),
              ),
              // Trade Type
              DropdownButtonFormField<String>(
                initialValue: _tradeType,
                decoration: const InputDecoration(
                  labelText: 'نوع النشاط التجاري',
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                items: const [
                  DropdownMenuItem(value: 'grocery', child: Text('بقالة وسوبرماركت 🛒')),
                  DropdownMenuItem(value: 'mobile', child: Text('موبايلات وإكسسوارات 📱')),
                  DropdownMenuItem(value: 'electronics', child: Text('أجهزة كهربائية ومنزلية ⚡')),
                  DropdownMenuItem(value: 'pharmacy', child: Text('صيدلية ومستحضرات 💊')),
                  DropdownMenuItem(value: 'other', child: Text('نشاط وتجارة أخرى 🏪')),
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
                title: const Text('تفعيل نظام الأقساط', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                subtitle: const Text('إظهار زر الأقساط وجداول السداد في التطبيق', style: TextStyle(fontSize: 12)),
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
                child: const Text('حفظ التعديلات', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
