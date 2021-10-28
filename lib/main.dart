import 'package:f_redditech/providers/settings_datas.dart';
import 'package:f_redditech/providers/post_datas.dart';
import 'package:f_redditech/providers/user_datas.dart';
import 'package:f_redditech/widgets/home_page.dart';
import 'package:f_redditech/widgets/base_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostDataModel()),
        ChangeNotifierProvider(create: (_) => SettingsData()),
        ChangeNotifierProvider(create: (_) => UserDataModel())
      ],
      child: const MyApp(),
    )
  );
}

/// Main App [Widget]
class MyApp extends StatelessWidget {

  /// Constructs the actual App [Widget]
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Redditech',
      theme: ThemeData(
        primaryColor: Colors.deepOrange
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const HomePage(),
        '/home': (BuildContext context) => BasePage(),
      },
    );
  }
}