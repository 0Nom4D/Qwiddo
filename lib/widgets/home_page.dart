import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
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
                child: new Tooltip(message: 'Connection', child: new Text("Connect to Redditech")),
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