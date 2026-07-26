import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qriora/features/privacy/presentation/privacy_screen.dart';

void main() {
  group('PrivacyScreen', () {
    testWidgets('displays app bar with correct title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PrivacyScreen(),
        ),
      );

      expect(find.text('Privacy & data'), findsOneWidget);
    });

    testWidgets('displays on-device analysis section', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PrivacyScreen(),
        ),
      );

      expect(find.text('On-device analysis'), findsOneWidget);
      expect(
        find.textContaining('All scanning, parsing, and risk analysis happens entirely on your device'),
        findsOneWidget,
      );
    });

    testWidgets('displays private mode section', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PrivacyScreen(),
        ),
      );

      expect(find.text('Private mode'), findsOneWidget);
    });

    testWidgets('displays local storage section', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PrivacyScreen(),
        ),
      );

      expect(find.text('Local storage'), findsOneWidget);
    });

    testWidgets('contains multiple privacy cards', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PrivacyScreen(),
        ),
      );

      // Should have multiple privacy-related icons
      expect(find.byIcon(Icons.phone_android), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
      expect(find.byIcon(Icons.storage), findsOneWidget);
    });
  });
}
