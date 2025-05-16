import 'package:botanicare/shared/ui/notification_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('NotificationText renders and displays the provided text',
          (WidgetTester tester) async {
        const testText = 'Test Notification';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NotificationText(text: testText),
            ),
          ),
        );

        // Verify that the text appears
        expect(find.text(testText), findsOneWidget);

        // Verify that the Text widget is inside a Container
        final container = tester.widget<Container>(find.byType(Container));
        final textWidget = tester.widget<Text>(find.text(testText));

        expect(container.padding, EdgeInsets.fromLTRB(20, 12, 20, 12));
        expect(textWidget.textAlign, TextAlign.center);
        expect(textWidget.style?.fontWeight, FontWeight.bold);
      });
}
