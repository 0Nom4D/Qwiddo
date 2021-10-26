import 'package:f_redditech/views/base_page.dart';
import 'package:f_redditech/views/home_page.dart';
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
      home: Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text("Redditech"),
          centerTitle: true,
          actions: [Icon(Icons.account_circle)],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.deepOrange,
          items: [
            BottomNavigationBarItem(
              title: Text("Connect"),
              icon: Icon(Icons.account_circle),
            ),
          ],
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const HomePage(),
        '/home': (BuildContext context) => BasePage(),
      },
    );
  }
}

/*

 */
