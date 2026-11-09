import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/shared/widgets/glass_toast.dart';

void main() {
  Widget buildTestApp({
    required VoidCallback onTrigger,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return Center(
              child: ElevatedButton(
                onPressed: onTrigger,
                child: const Text('إظهار الرسالة'),
              ),
            );
          },
        ),
      ),
    );
  }

  testWidgets('AppGlassToast.showSuccess displays glass toast with message and check icon', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        onTrigger: () {},
      ),
    );

    final context = tester.element(find.byType(ElevatedButton));
    AppGlassToast.showSuccess(context, 'تم تسجيل المعاملة بنجاح');
    await tester.pump(); // Start animation
    await tester.pump(const Duration(milliseconds: 300)); // Finish entrance

    expect(find.text('تم تسجيل المعاملة بنجاح'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    expect(find.byType(GlassToastWidget), findsOneWidget);
  });

  testWidgets('AppGlassToast.showError displays error toast with warning icon', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        onTrigger: () {},
      ),
    );

    final context = tester.element(find.byType(ElevatedButton));
    AppGlassToast.showError(context, 'المبلغ غير صحيح');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('المبلغ غير صحيح'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
  });

  testWidgets('AppGlassToast.show displays action button and executes callback on tap', (tester) async {
    var actionTapped = false;

    await tester.pumpWidget(
      buildTestApp(
        onTrigger: () {},
      ),
    );

    final context = tester.element(find.byType(ElevatedButton));
    AppGlassToast.showSuccess(
      context,
      'تم حفظ المعاملة',
      actionLabel: 'تراجع',
      onAction: () {
        actionTapped = true;
      },
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('تراجع'), findsOneWidget);

    await tester.tap(find.text('تراجع'));
    await tester.pump();

    expect(actionTapped, isTrue);
  });

  testWidgets('AppGlassToast auto-dismisses after duration', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        onTrigger: () {},
      ),
    );

    final context = tester.element(find.byType(ElevatedButton));
    AppGlassToast.showSuccess(
      context,
      'رسالة سريعة',
      duration: const Duration(seconds: 2),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('رسالة سريعة'), findsOneWidget);

    // Fast-forward past duration + exit animation
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('رسالة سريعة'), findsNothing);
  });
}
