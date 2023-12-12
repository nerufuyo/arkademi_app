import 'package:arkademi_app/presentation/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test bottomSheetWidget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => bottomSheetWidget(
                      onPrevious: () {},
                      onNext: () {},
                    ),
                  );
                },
                child: const Text('Show Bottom Sheet'),
              );
            },
          ),
        ),
      ),
    );

    // Tap the button to show the bottom sheet.
    await tester.tap(find.text('Show Bottom Sheet'));
    await tester.pumpAndSettle();

    // You can add your test cases here.
    // Example: Test if the 'Sebelumnya' text is present in the bottom sheet.
    expect(find.text('Sebelumnya'), findsOneWidget);

    // Example: Test if the 'Selanjutnya' text is present in the bottom sheet.
    expect(find.text('Selanjutnya'), findsOneWidget);

    // Example: Test if the previous button is disabled initially.
    expect(
      find.byIcon(Icons.keyboard_double_arrow_left_rounded),
      findsOneWidget,
    );
    expect(
      tester
          .widget<Icon>(find.byIcon(Icons.keyboard_double_arrow_left_rounded))
          .color,
      equals(Colors.grey),
    );

    // Example: Test if the next button is enabled initially.
    expect(
      find.byIcon(Icons.keyboard_double_arrow_right_rounded),
      findsOneWidget,
    );
    expect(
      tester
          .widget<Icon>(find.byIcon(Icons.keyboard_double_arrow_right_rounded))
          .color,
      equals(Colors.black),
    );
  });
}
