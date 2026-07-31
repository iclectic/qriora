import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qriora/app/accessibility/accessibility_helpers.dart';

void main() {
  group('QrioraSemantics', () {
    testWidgets('labelled wraps child with semantic label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QrioraSemantics.labelled(
              label: 'Scan button',
              button: true,
              child: const Icon(Icons.qr_code_scanner),
            ),
          ),
        ),
      );

      final finder = find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.label == 'Scan button',
      );
      expect(finder, findsOneWidget);
    });

    testWidgets('header wraps child with header semantic', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QrioraSemantics.header(
              label: 'Risk findings',
              child: const Text('Findings'),
            ),
          ),
        ),
      );

      final finder = find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.header == true,
      );
      expect(finder, findsOneWidget);
    });

    testWidgets('liveRegion wraps child with live region semantic',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QrioraSemantics.liveRegion(
              child: const Text('Analysing...'),
            ),
          ),
        ),
      );

      // Verify the Semantics widget has liveRegion set
      final semanticsFinder = find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.liveRegion == true,
      );
      expect(semanticsFinder, findsOneWidget);
    });

    testWidgets('severityBadge wraps child with combined label',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QrioraSemantics.severityBadge(
              severityLabel: 'High risk',
              findingTitle: 'Suspicious URL',
              child: const Text('High risk'),
            ),
          ),
        ),
      );

      final finder = find.byWidgetPredicate(
        (w) =>
            w is Semantics &&
            w.properties.label == 'High risk risk: Suspicious URL',
      );
      expect(finder, findsOneWidget);
    });
  });

  group('QrioraFocusTraversalPolicy', () {
    testWidgets('wrap adds FocusTraversalGroup', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QrioraFocusTraversalPolicy.wrap(
              const Text('Content'),
            ),
          ),
        ),
      );

      expect(find.byType(FocusTraversalGroup), findsWidgets);
      expect(find.text('Content'), findsOneWidget);
    });
  });
}
