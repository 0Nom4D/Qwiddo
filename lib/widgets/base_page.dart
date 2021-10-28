import 'package:f_redditech/widgets/search_page.dart';
import 'package:f_redditech/widgets/main_page.dart';
import 'package:f_redditech/widgets/user_page.dart';
import 'package:flutter/material.dart';

/// Widget defining a [Widget] redirector
///
/// Uses a [BottomNavigationBar] and return the actual Page
class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

/// [BasePage]'s main state manager
class _BasePageState extends State<BasePage> {

  /// Selected [BottomNavigationBar] option
  int _selectedOption = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// List of [BottomNavigationBar] options
  final _pageOptions = [
    MainPage(),
    SearchPage(
      subs: [],
    ),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          child: Text("Redditech",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 40
            ),
          ),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: _pageOptions[_selectedOption],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 30), label: "Rechercher"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 30), label: 'Mon Profil'),
//        BottomNavigationBarItem(icon: Icon(Icons.language, size: 30), label: 'Communautés'),
//        BottomNavigationBarItem(icon: Icon(Icons.settings, size: 30), label: 'Paramètres')
        ],
        elevation: 5.0,
        selectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _selectedOption = index;
          });
        },
        currentIndex: _selectedOption,
        backgroundColor: Colors.deepOrange,
        type: BottomNavigationBarType.fixed
      ),
    );
  }
}