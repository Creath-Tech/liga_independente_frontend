//import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:liga_independente_frontend/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Home Page E2E Test', () {
    testWidgets('Nome do teste', (WidgetTester tester) async {
      app.main();
    });
  });

  testWidgets('Nome de outro teste', (WidgetTester tester) async {
    app.main();
  });
}
