import 'package:arkademi_app/presentation/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test dialogWidget', (WidgetTester tester) async {
    bool tapped = false;

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ElevatedButton(
          onPressed: () {
            dialogWidget(
              tester.element(find.byType(ElevatedButton)),
              message: 'Test Message',
              action: 'Test Action',
              onTapped: () {
                tapped = true;
              },
            );
          },
          child: const Text('Show Dialog'),
        ),
      ),
    ));

    // Tap the button to show the dialog.
    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    // Verify that the dialog content is present.
    expect(find.text('Test Message'), findsOneWidget);
    expect(find.text('Test Action'), findsOneWidget);

    // Tap the action button in the dialog.
    await tester.tap(find.text('Test Action'));
    await tester.pumpAndSettle();

    // Verify that the onTapped function is called.
    expect(tapped, true);

    // Close the dialog.
    await tester.tap(find.text('Batal'));
    await tester.pumpAndSettle();

    // Verify that the dialog is closed.
    expect(find.byType(Dialog), findsNothing);
  });
}
