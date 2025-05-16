import 'package:botanicare/shared/ui/add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AddButton renders and triggers onPressed', (WidgetTester tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AddButton(
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    // Verify button is present
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Tap the button
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Verify callback was triggered
    expect(pressed, isTrue);
  });
}
