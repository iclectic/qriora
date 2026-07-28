import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:qriora/app/bootstrap.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('QrioraApp end-to-end', () {
    testWidgets('app boots and displays onboarding', (tester) async {
      bootstrap();
      await tester.pumpAndSettle();

      // Onboarding should be visible on first launch
      expect(find.text('Qriora'), findsOneWidget);
      expect(find.text('Know before you open.'), findsOneWidget);
    });
  });
}
