// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:virtual_portrait/main.dart';

void main() {
  testWidgets('Pineapple Digital Picture Frame initialization test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PineappleFrameApp());

    // Wait for initialization
    await tester.pump();

    // Verify that the app loads with pineapple branding
    expect(find.text('🍍'), findsWidgets);
    expect(find.textContaining('Pineapple'), findsWidgets);

    // Wait for potential async operations
    await tester.pumpAndSettle(const Duration(seconds: 5));
  });
}
