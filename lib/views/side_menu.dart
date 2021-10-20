import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {

  SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            child: Text("Redditech",
              textAlign: TextAlign.center,
            )
          ),
          ListTile(
            title: const Text('Accueil'),
            onTap: () {
              Navigator.popAndPushNamed(context, "/home");
            },
          ),
          ListTile(
            title: const Text("Communautés"),
            onTap: () {
              print("Go to communities");
//              Navigator.popAndPushNamed(context, "/communities");
            }
          ),
          ListTile(
            title: const Text('Paramètres'),
            onTap: () {
              print("Go to settings!");
//            Navigator.popAndPushNamed(context, "/settings");
            },
          )
        ],
      )
    ));
  }

}