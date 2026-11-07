import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/utils/battery_optimization_helper.dart';
import '../../customers/presentation/add_edit_customer_screen.dart';
import '../data/shop_repository.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  int _currentPage = 0;
  final int _totalPages = 4;

  // Form State
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedTradeType = 'grocery';
  bool _enableInstallments = false;

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
        ? 'محلي'
        : _nameController.text.trim();
    final phone = _phoneController.text.trim().isEmpty
        ? null
        : _phoneController.text.trim();

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تمت إضافة عملاء تجريبيين لتجربة التطبيق، يمكنك حذفهم في أي وقت'),
          backgroundColor: AppColors.paymentGreen,
          duration: Duration(seconds: 4),
        ),
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

  void _nextPage() {
    FocusScope.of(context).unfocus();
    if (_currentPage == 0) {
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
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'تهيئة كشكول لأول مرة',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                        color: active ? AppColors.primaryNavy : Colors.grey[300],
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
                  _buildStep1ShopIdentity(),
                  _buildStep2TradeType(),
                  _buildStep3NotificationsAndBattery(),
                  _buildStep4FirstAction(),
                ],
              ),
            ),

            // Bottom Buttons (Steps 1 to 3)
            if (_currentPage < _totalPages - 1)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryNavy,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      _currentPage == 0 ? 'متابعة نوع النشاط' : 'متابعة',
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
            const Text(
              'أهلاً بك في كشكول! 👋',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'دفترك الإلكتروني لحسابات الديون، التحصيل بالواتساب، والأقساط بدون تعقيد.',
              style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.4),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Shop Name Field
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'اسم المحل أو الكشكول *',
                hintText: 'مثال: بقالة الأمانة / موبايلات النجم',
                prefixIcon: const Icon(Icons.store_rounded),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (val) {
                if (val == null || val.trim().length < 2) {
                  return 'يرجى كتابة اسم المحل (حرفين على الأقل)';
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
                labelText: 'رقم هاتف المحل (اختياري)',
                hintText: '01XXXXXXXXX',
                prefixIcon: const Icon(Icons.phone_rounded),
                helperText: 'يظهر في فواتير وكشوفات الحساب وتذييل رسائل الواتساب',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
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
        'title': 'بقالة وسوبرماركت',
        'icon': Icons.shopping_basket_rounded,
        'desc': 'حسابات الديون اليومية وسرعة إغلاق الدرج',
      },
      {
        'id': 'mobile',
        'title': 'موبايلات وإكسسوارات',
        'icon': Icons.phone_android_rounded,
        'desc': 'بيانات الأجهزة ويفعّل نظام الأقساط تلقائياً',
      },
      {
        'id': 'electronics',
        'title': 'أجهزة كهربائية ومنزلية',
        'icon': Icons.tv_rounded,
        'desc': 'عقود بيع بالآجل ويفعّل نظام الأقساط تلقائياً',
      },
      {
        'id': 'pharmacy',
        'title': 'صيدلية ومستحضرات',
        'icon': Icons.local_pharmacy_rounded,
        'desc': 'حدود الائتمان ومتابعة ديون الروشتات',
      },
      {
        'id': 'other',
        'title': 'أنشطة وتجارة أخرى',
        'icon': Icons.business_center_rounded,
        'desc': 'دفتر مرن ومناسب لجميع أنواع التجارة الحرة',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'ما هو نوع نشاطك التجاري؟',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            'سنقوم بتهيئة واجهة التطبيق والأقسام بناءً على طبيعة شغلك.',
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
                                    child: const Text(
                                      'يدعم الأقساط',
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
            title: const Text(
              'تفعيل نظام وجداول الأقساط',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            subtitle: const Text(
              'يمكنك تشغيله أو إيقافه في أي وقت من الإعدادات',
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
          const Text(
            'ضمان وصول الإشعارات والتذكيرات 🔔',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            'حتى يعمل كشكول في موعده اليومي لتنبيهك بالتحصيلات ومواعيد الأقساط:',
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
                            const Text(
                              'إذن إرسال الإشعارات',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _notificationGranted
                                  ? 'تم تفعيل الإشعارات بنجاح ✅'
                                  : 'محتاجين إذن الإشعارات عشان نبعتلك ملخص التحصيل اليومي',
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
                      label: const Text('السماح بالإشعارات الآن'),
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
                              ? 'حماية التطبيق في الخلفية (${guide.brandName})'
                              : 'حماية التطبيق من الإغلاق في الخلفية',
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
                    label: const Text('فتح إعدادات بطارية الهاتف'),
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
          const Text(
            'جاهز للانطلاق! 🚀',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'تم حفظ بيانات محلك. كيف تود أن تبدأ الآن؟',
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
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '+ إضافة أول عميل حقيقي',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'سجل أول عميل وابدأ تدوين الديون والدفعات مباشرة',
                            style: TextStyle(fontSize: 12, color: Colors.black54),
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
          const SizedBox(height: 12),

          // Action 2: Try with sample demo data
          Card(
            elevation: 1.5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => _finishOnboarding(seedData: true),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.warningAmber.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.science_rounded,
                        color: AppColors.warningAmber,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'جرب ببيانات تجريبية أولاً 💡',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'إضافة عميلين وحسابات تجريبية لاكتشاف مميزات كشكول (يمكن حذفهم بضغطة زر)',
                            style: TextStyle(fontSize: 12, color: Colors.black54),
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
          const SizedBox(height: 12),

          // Action 3: Skip to home
          TextButton(
            onPressed: () => _finishOnboarding(),
            child: const Text(
              'تخطي والذهاب إلى الشاشة الرئيسية',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
