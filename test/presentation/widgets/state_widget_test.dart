import 'package:arkademi_app/presentation/widgets/state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test loadingWidget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: loadingWidget(),
      ),
    ));

    // Verify that the CircularProgressIndicator is present.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Test emptyWidget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: emptyWidget(),
      ),
    ));

    // Verify that the 'Data Not Found' text is present.
    expect(find.text('Data Not Found'), findsOneWidget);
  });
}
