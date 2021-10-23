import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
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

  @override
  void initState() {
    super.initState();
  }

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

  List<Widget> _listCreation() {
    for (int i = 0; i < widget.posts!.length; i++) {
      widget.bodyWidgets.add(_createdPostCard(widget.posts![i]));
    }
    return (widget.bodyWidgets);
  }

  _createMediaWidget(Submission newPosts) {
    if (newPosts.data!["secure_media"] != null) {
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
    } else if (newPosts.data!["preview"] != null) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Column(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: newPosts
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

  _createdPostCard(Submission newPosts) {
    final GlobalKey<ExpansionTileCardState> postCard = new GlobalKey();

    final now = DateTime.now();
    final totalTime = timeBetween(newPosts.createdUtc, now);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ExpansionTileCard(
        baseColor: Colors.white,
        expandedColor: Colors.white,
        key: postCard,
        leading: CircleAvatar(
          backgroundImage: NetworkImage("https://media.tenor.com/images/e627ecf80ad5b216c47a6fb939a51890/tenor.gif")
        ),
        title: Text(newPosts.data!["subreddit_name_prefixed"]),
        subtitle: Text("u/" + newPosts.author + " • " + totalTime),
        children: <Widget>[
          Divider(
            thickness: 0.5,
            height: 1.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Text(newPosts.title,
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: newPosts.selftext == null? Text("") : Text(
                newPosts.selftext!,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
              ),
            ),
          ),
          _createMediaWidget(newPosts),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            buttonHeight: 50,
            buttonMinWidth: 50,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  print("Upvote!");
                  // Upvoter le post;
                },
                icon: Icon(Icons.arrow_upward),
              ),
              Text(newPosts.upvotes.toString()),
              IconButton(
                onPressed: () {
                  print("Downvote!");
                  // Downvoter le post;
                },
                icon: Icon(Icons.arrow_downward)
              ),
              Text(newPosts.downvotes.toString()),
              IconButton(
                  onPressed: () {
                    print("Page de commentaire");
                    // Commenter le post;
                  },
                  icon: Icon(Icons.comment)
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _listCreation(),
    );
  }
}