import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qriora/features/settings/presentation/about_screen.dart';

void main() {
  group('AboutScreen', () {
    testWidgets('displays app bar with correct title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AboutScreen(),
        ),
      );

      expect(find.text('About Qriora'), findsOneWidget);
    });

    testWidgets('displays core principles section', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AboutScreen(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.textContaining('Qriora'), findsWidgets);
    });

    testWidgets('displays privacy first principle', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AboutScreen(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.textContaining('Privacy'), findsWidgets);
    });
  });
}
