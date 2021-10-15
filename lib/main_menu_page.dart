import "package:flutter/material.dart";
import 'package:draw/draw.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key, required this.userInfos}) : super(key: key);

  final Redditor? userInfos;

  @override
  _MyMainMenuPageState createState() => _MyMainMenuPageState();
}

class _MyMainMenuPageState extends State<MainMenuPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              child: Text('Redditech'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/main');
              },
            ),
            ListTile(
              title: const Text('Communities'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
            onPressed: () {
              print("I'm accessing to profile.");
            },
            child: Text(widget.userInfos != null ? widget.userInfos!.displayName: "",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}