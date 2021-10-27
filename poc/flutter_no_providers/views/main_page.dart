import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:f_redditech/no_provider/controller/main_page_ctrl.dart';
import 'package:f_redditech/no_provider/models/api_launcher.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

class MainPage extends StatefulWidget {

  late final List<Submission>? posts;

  MainPage({Key? key, required this.posts}) : super(key: key);

  late final int postsLength = 0;

  late final List<Widget> bodyWidgets = [];

  @override
  _MainPageState createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {

  String _selected = "";
  final redditApi = ApiLauncher();

  @override
  void initState() {
    super.initState();
    _selected = "";
  }

  List<Widget> _listCreation() {
    widget.bodyWidgets.add(
      ElevatedButton(
        onPressed: () {
          MainPageController(category: _selected);
        },
        child: Row(
          children: [
            Text(_selected),
            PopupMenuButton<String>(
              onSelected: (String result) { setState(() { _selected = result; }); },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                    value: "new",
                    child: Text('New')
                ),
                const PopupMenuItem<String>(
                  value: "hot",
                  child: Text('Populaire'),
                ),
                const PopupMenuItem<String>(
                  value: "top",
                  child: Text('Au top'),
                ),
                const PopupMenuItem<String>(
                  value: "best",
                  child: Text('Meilleur'),
                ),
              ],
            ),
          ]
        )
      )
    );
    for (int i = 0; i < widget.posts!.length; i++) {
      widget.bodyWidgets.add(PostCard(post: widget.posts![i]));
    }
    return (widget.bodyWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: _listCreation(),
        ),
      ]
    );
  }
}

class PostCard extends StatelessWidget {

  final Submission post;

  PostCard({Key? key, required this.post}) : super(key: key);

  String timeBetween(DateTime from, DateTime to) {
    final nbSecondsFrom = from.second;
    final nbSecondsTo = to.second;
    int diffSeconds = nbSecondsTo - nbSecondsFrom;

    if (diffSeconds < 60)
      return ("Now");
    else if (diffSeconds >= 60 && diffSeconds < 3600)
      return ((diffSeconds / 60).toString() + " min");
    else if (diffSeconds >= 3600 && diffSeconds < 86400)
      return ((diffSeconds / 3600).toString() + " h");
    else if (diffSeconds >= 86400 && diffSeconds < 604800)
      return ((diffSeconds / 86400).toString() + " d");
    else if (diffSeconds >= 604800 && diffSeconds < 7257600)
      return ((diffSeconds / 604800).toString() + " mois");
    return ((diffSeconds / 7257600).toString() + " ans");
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ExpansionTileCardState> postCard = new GlobalKey();

    final now = DateTime.now();
    final totalTime = timeBetween(post.createdUtc, now);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ExpansionTileCard(
        baseColor: Colors.white,
        expandedColor: Colors.white,
        key: postCard,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            "https://media.tenor.com/images/e627ecf80ad5b216c47a6fb939a51890/tenor.gif")
        ),
        title: Text(post.data!["subreddit_name_prefixed"]),
        subtitle: Text("u/" + post.author + " • " + totalTime),
        children: <Widget>[
          Divider(
            thickness: 0.5,
            height: 1.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 2.0),
              child: Text(post.title,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 2.0),
              child: post.selftext == null ? Text("") : Text(
                post.selftext!,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 16),
              ),
            ),
          ),
          MediaWidget(
              post: post
          ),
          OptionsBar(
            post: post,
          )
        ],
      ),
    );
  }
}

class MediaWidget extends StatelessWidget {

  final Submission post;

  MediaWidget ({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (post.data!["secure_media"] != null) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Column(
              children: <Widget>[
                Text("Here lies a video...")
              ],
            )
        ),
      );
    } else if (post.data!["preview"] != null) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Column(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: post
                      .data!["preview"]["images"][0]["source"]["url"]
                      .replaceAll("amp;", ""),
                  fit: BoxFit.fitHeight,
                ),
              ],
            )
        ),
      );
    }
    return Container();
  }
}

class OptionsBar extends StatelessWidget {

  final Submission post;

  OptionsBar({Key? key, required this.post}) : super(key: key);

  final ApiLauncher redditApi = ApiLauncher();

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceAround,
      buttonHeight: 50,
      buttonMinWidth: 50,
      children: <Widget>[
        IconButton(
          onPressed: () {
            redditApi.upvotePost(this.post);
          },
          icon: Icon(Icons.arrow_upward),
        ),
        Text(this.post.upvotes.toString()),
        IconButton(
            onPressed: () {
              redditApi.downvotePost(this.post);
            },
            icon: Icon(Icons.arrow_downward)
        ),
        Text(this.post.downvotes.toString()),
        IconButton(
            onPressed: () {
              print("Page de commentaire");
              // Commenter le post;
            },
            icon: Icon(Icons.comment)
        )
      ],
    );
  }
}