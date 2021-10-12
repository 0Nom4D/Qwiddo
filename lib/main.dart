import 'package:f_redditech/views/home_page.dart';
import 'package:flutter/material.dart';
import 'main_menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Redditech',
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (BuildContext context) => const HomePage(),
        '/main': (BuildContext context) => const MainMenuPage(userInfos: null),
      },
    );
  }
}
