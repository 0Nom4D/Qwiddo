import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

//  Redditor? userInfos;

//  void connectToReddit() async {
//    final reddit = Reddit.createInstalledFlowInstance(
//      clientId: "KE5DpJuRH0sNw1tWYQeerA",
//      userAgent: "Epicturech",
//      redirectUri: Uri.parse("reddit://success"),
//    );

//    final authUrl = reddit.auth.url(["*"], "Epicturech", compactLogin: true);
//    final result = await FlutterWebAuth.authenticate(
//        url: authUrl.toString(),
//        callbackUrlScheme: "reddit"
//    );
//    String? code = Uri.parse(result).queryParameters['code'];
//    await reddit.auth.authorize(code.toString());
//    userInfos = (await reddit.user.me())!;
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(Colors.blue.withOpacity(0.8), BlendMode.dstATop),
                image: NetworkImage("https://cdn.dribbble.com/users/244018/screenshots/1506924/media/b0f10339a5471a0733561a83636babf8.gif"),
                fit: BoxFit.cover,
              )
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 20
                  ),
                  primary: Colors.deepOrange,
                ),
                onPressed: () {
                  //Revoir les routes + Re-faire l'appel d'API à Reddit API puis récupérer la vue changée
                },
                child: const Text('Connect to Redditech'),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Text("Redditech\nRedditech is an application you can use such as the Reddit app with limited features.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4.0
                    ..color = Colors.white,
                  ),
                ),
                Text("Redditech\nRedditech is an application you can use such as the Reddit app with limited features.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ]
            )
          )
        ],
      ),
    );
  }
}