import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:f_redditech/main_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key, userInfos}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage2> {

  Redditor? userInfos;

  void connectToReddit() async {

    Redditor? myUser;

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
    myUser = await reddit.user.me();
    if (myUser != null) {
      if (myUser.data != null) {
        print(myUser.data?["subreddit"]["banner_img"]);
      }
    }
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