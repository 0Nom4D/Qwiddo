import 'package:cached_network_image/cached_network_image.dart';
import 'package:f_redditech/src/api_service/api_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Widget defining the [HomePage]
///
/// Uses [CachedNetworkImage] for background decoration and texts
class HomePage extends StatefulWidget {

  /// Constructs a new [HomePage] widget
  const HomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/// HomePage's main state
class _MyHomePageState extends State<HomePage> {

  ApiLauncher redditApi = ApiLauncher();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: CachedNetworkImage(
            imageUrl: "https://cdn.dribbble.com/users/244018/screenshots/1506924/media/b0f10339a5471a0733561a83636babf8.gif",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(Colors.blue.withOpacity(0.8), BlendMode.dstATop),
                  )
                ),
              ),
            ),
          ),
          Container(
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
                  Navigator.pushNamed(context, '/home');
                },
                child: new Tooltip(message: 'Connexion', child: new Text("Se connecter")),
              ),
            ),
          ),
        Container(
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              Text("Redditech\nRedditech est une application que vous pouvez utiliser de la même façon que le client reddit avec des fonctionalités limitées.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 4.0
                  ..color = Colors.white,
                ),
              ),
              Text("Redditech\nRedditech est une application que vous pouvez utiliser de la même façon que le client reddit avec des fonctionalités limitées.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepOrange
                ),
              )
            ]
          )
        )
      ],
    );
  }
}