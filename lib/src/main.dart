import 'package:f_redditech/src/providers/post_datas.dart';
import 'package:f_redditech/src/providers/user_datas.dart';
import 'package:f_redditech/src/widgets/home_page.dart';
import 'package:f_redditech/src/widgets/base_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostDataModel()),
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