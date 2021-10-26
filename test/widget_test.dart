import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:f_redditech/views/home_page.dart';
import 'package:f_redditech/views/base_page.dart';
import 'package:f_redditech/views/loading_page.dart';
import 'package:f_redditech/views/user_page.dart';

void main() {
  final homeApp = MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        home: HomePage(),
      ));
  testWidgets('Test set home page', (WidgetTester tester) async {
    await tester.pumpWidget(homeApp);
  });
  final baseApp = MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        home: BasePage(),
      ));
  testWidgets('Test set base page', (WidgetTester tester) async {
    await tester.pumpWidget(baseApp);
  });
  final loadingApp = MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        home: LoadingScreen(),
      ));
  testWidgets('Test set loading page', (WidgetTester tester) async {
    await tester.pumpWidget(loadingApp);
  });
  testWidgets('test du tap', (WidgetTester t) async{
    await t.pumpWidget(baseApp);
    final home_btn = find.byIcon(Icons.home);
    final profil_btn = find.byIcon(Icons.account_circle);
    await t.tap(home_btn);
    final Redditor? userData;
    await t.pump();
    await t.tap(profil_btn);
  });
}