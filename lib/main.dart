// import 'package:f_redditech/views/main_page.dart';
import 'package:f_redditech/views/home_page.dart';
import 'controller/user_page_ctrl.dart';
import 'package:flutter/material.dart';

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
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const HomePage(),
//        '/home': (BuildContext context) => MainPage(postData: []),
        '/profile': (BuildContext context) => UserPageController(),
      },
    );
  }
}

/*

 */
