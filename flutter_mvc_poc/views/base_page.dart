import 'package:f_redditech/flutter_mvc_poc/controller/search_page_ctrl.dart';
import 'package:f_redditech/flutter_mvc_poc/controller/main_page_ctrl.dart';
import 'package:f_redditech/flutter_mvc_poc/controller/user_page_ctrl.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  TextEditingController _controller = TextEditingController();
  int _selectedOption = 0;
  String? query;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final _pageOptions = [
    MainPageController(),
    SearchPageController(),
    UserPageController()
  ];

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
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
        )
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
    )
    );
  }
}