import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:f_redditech/api_service/api_launcher.dart';
import 'package:f_redditech/no_provider/views/loading_page.dart';
import 'package:f_redditech/providers/settings_datas.dart';
import 'package:f_redditech/providers/post_datas.dart';
import 'package:f_redditech/models/post.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

/// A [Widget] Class that defines the actual MainPage Widget
///
/// MainPage uses Providers to get the post datas wrapped with [ListView.builder]
/// and with [FutureBuilder].
class MainPage extends StatefulWidget {

  /// Constructs a MainPage Widget
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();

}

/// Main widget's state defines the first state of the widget
///
/// _MainPageState uses SettingsData [Provider] and the Api Service to
/// fetch [Subreddit] posts data.
class _MainPageState extends State<MainPage> {

  /// List of [Submissions] fetched from the [FrontPage]
  List<Submission> postCardsList = [];

  @override
  void initState() {
    SettingsData settingsData = Provider.of<SettingsData>(context, listen: false);
    PostDataModel postData = Provider.of<PostDataModel>(context, listen: false);
    ApiLauncher.getFrontPagePosts(postData, settingsData, true);
    super.initState();
  }

  /// Method designed to make a cooldown between fetching and [ListView] display
  _fetchEntry() async {
    await Future.delayed(Duration(milliseconds: 250));
  }

  @override
  Widget build(BuildContext context) {
    PostDataModel postData = Provider.of<PostDataModel>(context, listen: false);
    SettingsData settingsData = Provider.of<SettingsData>(context, listen: false);

    return FutureBuilder(
      future: _fetchEntry(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return LoadingScreen();
        return Consumer<PostDataModel>(
          builder: (context, provider, _) => NotificationListener<ScrollNotification>(
            child: ListView.builder(
              itemCount: provider.postTilesList.length,
              itemBuilder: (context, index) {
                return PostCard(
                    post: provider.postTilesList[index]
                );
              }
            ),
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.atEdge) {
                if (scrollInfo.metrics.pixels != 0)
                  ApiLauncher.getFrontPagePosts(postData, settingsData, false);
                else
                  ApiLauncher.getFrontPagePosts(postData, settingsData, true);
              }
              return true;
            }
          ),
        );
      }
    );
  }
}

/// Widget defining the posts' [ExpansionTileCard]
///
/// Uses a [ExpansionTileCard], [MediaWidget] and an [OptionsBar] Widget
class PostCard extends StatelessWidget {

  /// [Post] class defining the post at a specific index
  final Post post;

  /// Constructs a [PostCard] Widget
  PostCard({Key? key, required this.post}) : super(key: key);

  /// Method computing time between two [DateTime] objects
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
        title: Text(post.subReddit),
        subtitle: Text(post.username + " • " + totalTime),
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
              child: post.body == "" ? Text("") : Text(
                post.body,
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

/// Widget exposing a Media such as Image / Video
class MediaWidget extends StatelessWidget {

  /// [Post] class defining the post at a specific index
  final Post post;

  /// Constructs a [MediaWidget] widget
  MediaWidget ({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (post.typeMediaUrl == "video") {
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
    } else if (post.typeMediaUrl == "image") {
      return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Column(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: post.mediaUrl,
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

/// Widget exposing a bar of [IconButtons]
///
/// Uses an upvote [IconButton] and a downvote [IconButton]
class OptionsBar extends StatelessWidget {

  /// [Post] class defining the post at a specific index
  final Post post;

  /// Constructs a [OptionsBar] Widget
  OptionsBar({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceAround,
      buttonHeight: 50,
      buttonMinWidth: 50,
      children: <Widget>[
        IconButton(
          onPressed: () {
//            PostDataModel postData = Provider.of<PostDataModel>(context, listen: false);
            print("Upvoted");
//            postData.upVoteItem(this.post);
          },
          icon: Icon(Icons.arrow_upward),
        ),
        Text(this.post.upVotes.toString()),
        IconButton(
            onPressed: () {
//              PostDataModel postData = Provider.of<PostDataModel>(context, listen: false);
              print("Downvoted");
//              postData.downVoteItem(this.post);
            },
            icon: Icon(Icons.arrow_downward)
        ),
        Text(this.post.downVotes.toString()),
      ],
    );
  }
}