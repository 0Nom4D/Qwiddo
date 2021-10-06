import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:f_redditech/main_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

  Redditor? userInfos;

  void connectToReddit() async {
    final reddit = Reddit.createInstalledFlowInstance(
      clientId: "KE5DpJuRH0sNw1tWYQeerA",
      userAgent: "Epicturech",
      redirectUri: Uri.parse("reddit://success"),
    );

    final authUrl = reddit.auth.url(["*"], "Epicturech", compactLogin: true);
    final result = await FlutterWebAuth.authenticate(
        url: authUrl.toString(),
        callbackUrlScheme: "reddit"
    );
    String? code = Uri.parse(result).queryParameters['code'];
    await reddit.auth.authorize(code.toString());
    userInfos = (await reddit.user.me())!;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
                fontSize: 20
            ),
            primary: Colors.deepOrange,
          ),
          onPressed: () {
            connectToReddit();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainMenuPage(
                      userInfos: userInfos
                  )
              ),
            );
          },
          child: const Text('Connect to Redditech'),
        )
    );
  }
}