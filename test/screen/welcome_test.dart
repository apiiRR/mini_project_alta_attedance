import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_project_alta_attedance/Screens/Welcome/components/body.dart';

void main() {
  testWidgets('user mendapatkan tampilan login dari tampilan welcome',
      (WidgetTester tester) async {
    await tester.pumpWidget(MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: Body(),
          ),
        )));

    final login = find.text("Login");
    await tester.tap(login);

    final textLogin = find.text("Login");
    expect(textLogin, findsOneWidget);
  });
}
