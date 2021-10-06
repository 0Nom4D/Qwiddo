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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
      ),
    );
  }
}