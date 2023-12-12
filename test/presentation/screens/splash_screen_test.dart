import 'package:arkademi_app/config/routes.dart';
import 'package:arkademi_app/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SplashScreen navigates to the next screen after delay',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: const SplashScreen(),
      routes: {
        Routes.course: (context) => Container(),
      },
    ));

    // Ensure the SplashScreen widget is on the screen.
    expect(find.byType(SplashScreen), findsOneWidget);

    // Wait for the navigation to happen after the delay.
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Ensure that the navigation has occurred by checking if the destination screen is on the screen.
    expect(find.byType(Container), findsOneWidget);
  });
}
