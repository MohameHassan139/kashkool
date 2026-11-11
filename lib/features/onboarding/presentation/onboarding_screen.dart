import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/cloud/cloud_api.dart';
import '../../../core/cloud/cloud_providers.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/utils/battery_optimization_helper.dart';
import '../../../shared/widgets/glass_toast.dart';
import '../../customers/presentation/add_edit_customer_screen.dart';
import '../data/shop_repository.dart';
import '../../../core/utils/phone.dart';
import '../../../l10n/l10n.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  int _currentPage = 0;
  final int _totalPages = 5;

  // Form State
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedTradeType = 'grocery';
  bool _enableInstallments = false;
  bool _isGoogleSigningIn = false;

  // Step 3 State
  bool _notificationGranted = false;
  BrandBatteryGuide? _batteryGuide;
  bool _isLoadingGuide = true;

  @override
  void initState() {
    super.initState();
    _loadDeviceGuide();
  }

  Future<void> _loadDeviceGuide() async {
    final guide = await BatteryOptimizationHelper.getDeviceGuide();
    if (mounted) {
      setState(() {
        _batteryGuide = guide;
        _isLoadingGuide = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onTradeSelected(String type) {
    setState(() {
      _selectedTradeType = type;
      if (type == 'mobile' || type == 'electronics') {
        _enableInstallments = true;
      } else {
        _enableInstallments = false;
      }
    });
  }

  Future<void> _saveShopDetails() async {
    final repo = ref.read(shopRepositoryProvider);
    final name = _nameController.text.trim().isEmpty
        ? L10n.t.onboardingScreen1
        : _nameController.text.trim();
    final rawPhone = _phoneController.text.trim();
    final phone = rawPhone.isEmpty ? null : (PhoneUtils.normalize(rawPhone) ?? rawPhone);

    await repo.createOrUpdateShop(
      name: name,
      shopType: _selectedTradeType,
      phone: phone,
      enableInstallments: _enableInstallments,
    );
  }

  Future<void> _finishOnboarding({bool seedData = false, bool openAddCustomer = false}) async {
    FocusScope.of(context).unfocus();
    final repo = ref.read(shopRepositoryProvider);
    await _saveShopDetails();

    if (seedData) {
      await repo.seedSampleData();
    }

    await repo.setOnboardingCompleted(true);

    if (!mounted) return;

    if (seedData) {
      AppGlassToast.showSuccess(
        context,
        L10n.t.onboardingScreen2,
      );
    }

    if (openAddCustomer) {
      context.go('/');
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => const AddEditCustomerScreen(),
      );
    } else {
      context.go('/');
    }
  }

  Future<void> _onGoogleSignInPressed() async {
    if (_isGoogleSigningIn) return;
    setState(() => _isGoogleSigningIn = true);

    try {
      final cloudService = ref.read(cloudBackupServiceProvider);
      final session = await cloudService.signIn();
      if (!mounted) return;

      AppGlassToast.showSuccess(context, L10n.t.cloudBackupCard4(session.email));

      // Check if user has cloud shops
      final shops = await cloudService.listCloudShops();
      if (shops.isNotEmpty && mounted) {
        // User has existing shop on the cloud! Restore and finish
        final shop = shops.first;
        await cloudService.restore(shop);
        final repo = ref.read(shopRepositoryProvider);
        await repo.setOnboardingCompleted(true);
        if (mounted) {
          AppGlassToast.showSuccess(context, L10n.t.cloudBackupCard17);
          context.go('/');
        }
        return;
      }

      // If no existing shop on cloud, advance to setup shop name
      if (mounted) {
        unawaited(_pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ));
      }
    } on CloudApiException catch (e) {
      if (mounted && e.code != 'canceled') {
        AppGlassToast.showError(context, e.message);
      }
    } catch (e, st) {
      debugPrint('Google Sign In Error: $e\n$st');
      if (mounted) {
        AppGlassToast.showError(context, L10n.t.cloudBackupCard2);
      }
    } finally {
      if (mounted) setState(() => _isGoogleSigningIn = false);
    }
  }

  void _onGuestPressed() {
    unawaited(_pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    ));
  }

  void _nextPage() {
    FocusScope.of(context).unfocus();
    if (_currentPage == 1) {
      if (!_formKey.currentState!.validate()) return;
    }

    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n.t.onboardingScreen3,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: _currentPage > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: _prevPage,
              )
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: List.generate(_totalPages, (index) {
                  final active = index <= _currentPage;
                  return Expanded(
                    child: Container(
                      height: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: active
                            ? theme.colorScheme.primary
                            : (isDark ? const Color(0xFF374151) : Colors.grey[300]),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Page Content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  _buildStep0AccountChoice(),
                  _buildStep1ShopIdentity(),
                  _buildStep2TradeType(),
                  _buildStep3NotificationsAndBattery(),
                  _buildStep4FirstAction(),
                ],
              ),
            ),

            // Bottom Buttons (Steps 1 to 3)
            if (_currentPage > 0 && _currentPage < _totalPages - 1)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      _currentPage == 1 ? L10n.t.onboardingScreen4 : L10n.t.ratingExplanationBottomSheet6,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // STEP 0: Account Choice (First Time Question)
  // -------------------------------------------------------------
  Widget _buildStep0AccountChoice() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.menu_book_rounded,
                size: 56,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            L10n.t.authFirstTimeTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            L10n.t.authFirstTimeQuestion,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 28),

          // Option 1: Sign in with Google
          _buildChoiceCard(
            title: L10n.t.authSignInWithGoogle,
            subtitle: L10n.t.authSignInWithGoogleSubtitle,
            icon: Icons.account_circle_rounded,
            iconColor: AppColors.primaryBlue,
            iconBgColor: AppColors.primaryBlue.withValues(alpha: 0.12),
            isLoading: _isGoogleSigningIn,
            onTap: _onGoogleSignInPressed,
          ),
          const SizedBox(height: 16),

          // Option 2: Continue as guest (offline)
          _buildChoiceCard(
            title: L10n.t.authContinueGuest,
            subtitle: L10n.t.authContinueGuestSubtitle,
            icon: Icons.phone_android_rounded,
            iconColor: isDark ? Colors.grey[300]! : AppColors.primaryNavy,
            iconBgColor: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
            onTap: _onGuestPressed,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildChoiceCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? const Color(0xFF334155) : Colors.grey[200]!,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.chevron_left_rounded, color: AppColors.neutralGrey),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // STEP 1: Shop Identity
  // -------------------------------------------------------------
  Widget _buildStep1ShopIdentity() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryNavy.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.storefront_rounded,
                  size: 64,
                  color: AppColors.primaryNavy,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              L10n.t.onboardingScreen5,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              L10n.t.onboardingScreen6,
              style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.4),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Shop Name Field
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: L10n.t.onboardingScreen7,
                hintText: L10n.t.onboardingScreen8,
                prefixIcon: const Icon(Icons.store_rounded),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (val) {
                if (val == null || val.trim().length < 2) {
                  return L10n.t.onboardingScreen9;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Shop Phone Field
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: L10n.t.onboardingScreen10,
                hintText: '01XXXXXXXXX',
                prefixIcon: const Icon(Icons.phone_rounded),
                helperText: L10n.t.onboardingScreen11,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (val) {
                final text = val?.trim() ?? '';
                if (text.isEmpty) return null;
                if (!PhoneUtils.isValid(text)) {
                  return L10n.t.customerPhoneInvalid;
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // STEP 2: Trade Type
  // -------------------------------------------------------------
  Widget _buildStep2TradeType() {
    final tradeTypes = [
      {
        'id': 'grocery',
        'title': L10n.t.onboardingScreen12,
        'icon': Icons.shopping_basket_rounded,
        'desc': L10n.t.onboardingScreen13,
      },
      {
        'id': 'mobile',
        'title': L10n.t.onboardingScreen14,
        'icon': Icons.phone_android_rounded,
        'desc': L10n.t.onboardingScreen15,
      },
      {
        'id': 'electronics',
        'title': L10n.t.onboardingScreen16,
        'icon': Icons.tv_rounded,
        'desc': L10n.t.onboardingScreen17,
      },
      {
        'id': 'pharmacy',
        'title': L10n.t.onboardingScreen18,
        'icon': Icons.local_pharmacy_rounded,
        'desc': L10n.t.onboardingScreen19,
      },
      {
        'id': 'other',
        'title': L10n.t.onboardingScreen20,
        'icon': Icons.business_center_rounded,
        'desc': L10n.t.onboardingScreen21,
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            L10n.t.onboardingScreen22,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            L10n.t.onboardingScreen23,
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
          const SizedBox(height: 18),

          // Trade Cards
          ...tradeTypes.map((trade) {
            final isSelected = _selectedTradeType == trade['id'];
            final isInstallmentTrade =
                trade['id'] == 'mobile' || trade['id'] == 'electronics';

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: InkWell(
                onTap: () => _onTradeSelected(trade['id'] as String),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryNavy.withValues(alpha: 0.05)
                        : Colors.white,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryNavy
                          : Colors.grey.withValues(alpha: 0.3),
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryNavy
                              : Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          trade['icon'] as IconData,
                          color: isSelected ? Colors.white : Colors.grey[700],
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  trade['title'] as String,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? AppColors.primaryNavy
                                        : Colors.black87,
                                  ),
                                ),
                                if (isInstallmentTrade) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.paymentGreen
                                          .withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      L10n.t.onboardingScreen24,
                                      style: TextStyle(
                                        color: AppColors.paymentGreen,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              trade['desc'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color: isSelected ? AppColors.primaryNavy : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 8),
          // Explicit Installments Toggle
          SwitchListTile.adaptive(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            value: _enableInstallments,
            title: Text(
              L10n.t.onboardingScreen25,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            subtitle: Text(
              L10n.t.onboardingScreen26,
              style: TextStyle(fontSize: 12),
            ),
            onChanged: (val) => setState(() => _enableInstallments = val),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // STEP 3: Notifications & Background Battery Survival
  // -------------------------------------------------------------
  Widget _buildStep3NotificationsAndBattery() {
    final guide = _batteryGuide;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            L10n.t.onboardingScreen27,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            L10n.t.onboardingScreen28,
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
          const SizedBox(height: 20),

          // 1. Notification Permission Card
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _notificationGranted
                              ? AppColors.paymentGreen.withValues(alpha: 0.12)
                              : Colors.amber.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _notificationGranted
                              ? Icons.check_circle_rounded
                              : Icons.notifications_active_rounded,
                          color: _notificationGranted
                              ? AppColors.paymentGreen
                              : Colors.amber[800],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              L10n.t.onboardingScreen29,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _notificationGranted
                                  ? L10n.t.onboardingScreen30
                                  : L10n.t.onboardingScreen31,
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (!_notificationGranted)
                    OutlinedButton.icon(
                      onPressed: () async {
                        final granted =
                            await NotificationService().requestPermissions();
                        setState(() => _notificationGranted = granted);
                      },
                      icon: const Icon(Icons.security_rounded),
                      label: Text(L10n.t.onboardingScreen32),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryNavy,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 2. Battery Optimization Guide Card
          Card(
            elevation: 1,
            color: Colors.blueGrey[50],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.battery_alert_rounded, color: Colors.indigo),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          guide != null
                              ? L10n.t.onboardingScreen33(guide.brandName)
                              : L10n.t.onboardingScreen34,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  if (guide != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      guide.osName,
                      style: TextStyle(fontSize: 11, color: Colors.indigo[800], fontWeight: FontWeight.w600),
                    ),
                  ],
                  const Divider(height: 24),
                  if (_isLoadingGuide)
                    const Center(child: CircularProgressIndicator())
                  else if (guide != null)
                    ...guide.steps.asMap().entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.indigo.withValues(alpha: 0.15),
                              child: Text(
                                '${entry.key + 1}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                entry.value,
                                style: const TextStyle(fontSize: 12, height: 1.35),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => BatteryOptimizationHelper.openBatterySettings(),
                    icon: const Icon(Icons.tune_rounded, size: 18),
                    label: Text(L10n.t.onboardingScreen35),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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

  // -------------------------------------------------------------
  // STEP 4: First Action
  // -------------------------------------------------------------
  Widget _buildStep4FirstAction() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.paymentGreen.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline_rounded,
                size: 64,
                color: AppColors.paymentGreen,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            L10n.t.onboardingScreen36,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            L10n.t.onboardingScreen37,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),

          // Action 1: Add first real customer
          Card(
            elevation: 1.5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => _finishOnboarding(openAddCustomer: true),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryNavy.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.person_add_alt_1_rounded,
                        color: AppColors.primaryNavy,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            L10n.t.onboardingScreen38,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            L10n.t.onboardingScreen39,
                            style: const TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Action 2: Skip to home
          TextButton(
            onPressed: () => _finishOnboarding(),
            child: Text(
              L10n.t.onboardingScreen42,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
