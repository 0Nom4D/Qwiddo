import 'package:f_redditech/controller/main_page_ctrl.dart';
import 'package:f_redditech/controller/user_page_ctrl.dart';
import 'package:f_redditech/views/user_page.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  TextEditingController _controller = TextEditingController();
  int _selectedOption = 0;

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
    UserPageController()
  ];

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)
          ),
          child: Center(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
                border: InputBorder.none,
                hintText: "Recherche..."
              ),
            ),
          ),
        ),
      ),
      body: _pageOptions[_selectedOption],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 30), label: 'Mon Profil'),
//          BottomNavigationBarItem(icon: Icon(Icons.language, size: 30), label: 'Communautés'),
//          BottomNavigationBarItem(icon: Icon(Icons.settings, size: 30), label: 'Paramètres')
        ],
        elevation: 5.0,
        currentIndex: _selectedOption,
        onTap: (index) {
          setState(() {
            _selectedOption = index;
          });
        },
        backgroundColor: Colors.deepOrange,
        type: BottomNavigationBarType.fixed
      ),
    ));
  }
}