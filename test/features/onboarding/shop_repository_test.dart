import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/onboarding/data/shop_repository.dart';

void main() {
  late AppDatabase db;
  late ShopRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = ShopRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('ShopRepository Basic & Profile Operations', () {
    test('isOnboardingCompleted returns false initially', () async {
      final completed = await repository.isOnboardingCompleted();
      expect(completed, isFalse);
    });

    test(
      'setOnboardingCompleted updates status and emits via stream',
      () async {
        final initial = await repository.isOnboardingCompleted();
        expect(initial, isFalse);

        await repository.setOnboardingCompleted(true);
        final completed = await repository.isOnboardingCompleted();
        expect(completed, isTrue);

        final streamVal = await repository.watchOnboardingCompleted().first;
        expect(streamVal, isTrue);
      },
    );

    test(
      'createOrUpdateShop creates new shop and defaults installments based on trade',
      () async {
        final shop = await repository.createOrUpdateShop(
          name: 'محل النجم للموبايل',
          shopType: 'mobile',
          phone: '01012345678',
        );

        expect(shop.name, equals('محل النجم للموبايل'));
        expect(shop.shopType, equals('mobile'));
        expect(shop.phone, equals('01012345678'));
        expect(shop.enableInstallments, isTrue); // Auto-enabled for mobile

        final active = await repository.getActiveShop();
        expect(active?.id, equals(shop.id));
      },
    );

    test(
      'createOrUpdateShop for grocery defaults installments to false',
      () async {
        final shop = await repository.createOrUpdateShop(
          name: 'بقالة الأمانة',
          shopType: 'grocery',
          phone: '01122334455',
        );

        expect(shop.enableInstallments, isFalse); // Auto-disabled for grocery
      },
    );

    test(
      'createOrUpdateShop allows explicitly overriding enableInstallments',
      () async {
        final shop = await repository.createOrUpdateShop(
          name: 'بقالة ومستلزمات منزلية',
          shopType: 'grocery',
          enableInstallments: true,
        );

        expect(shop.enableInstallments, isTrue);
      },
    );
  });
}
