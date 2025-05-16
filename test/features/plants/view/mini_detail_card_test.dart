import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:botanicare/features/plants/view/mini_detail_card.dart';

void main() {
  testWidgets('MiniDetailCard renders title, description, and icon',
          (WidgetTester tester) async {
        const String testTitle = 'Test Title';
        const String testDescription = 'Test Description';
        const IconData testIcon = Icons.info;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MiniDetailCard(
                icon: testIcon,
                title: testTitle,
                description: testDescription,
              ),
            ),
          ),
        );

        // Check that title and description are present
        expect(find.text(testTitle), findsOneWidget);
        expect(find.text(testDescription), findsOneWidget);

        // Check that the icon is rendered
        final iconFinder = find.byIcon(testIcon);
        expect(iconFinder, findsOneWidget);

        // Check that the card is present
        expect(find.byType(Card), findsOneWidget);

        // Check the style and layout constraints
        final titleText = tester.widget<Text>(find.text(testTitle));
        expect(titleText.maxLines, 1);
        expect(titleText.overflow, TextOverflow.ellipsis);
        expect(titleText.style?.fontWeight, FontWeight.bold);

        final descriptionText = tester.widget<Text>(find.text(testDescription));
        expect(descriptionText.maxLines, 1);
        expect(descriptionText.overflow, TextOverflow.ellipsis);
        expect(descriptionText.style?.fontSize, 16);
      });
}
