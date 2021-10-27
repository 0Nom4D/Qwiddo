import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:f_redditech/api_service/api_launcher.dart';
import 'package:f_redditech/providers/settings_datas.dart';
import 'package:f_redditech/providers/post_datas.dart';
import 'package:f_redditech/models/post.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

class MainPage extends StatefulWidget {

  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {

  List<Submission> postCardsList = [];

  @override
  void initState() {
    SettingsData settingsData = Provider.of<SettingsData>(context, listen: false);
    PostDataModel postData = Provider.of<PostDataModel>(context, listen: false);
    ApiLauncher.getFrontPagePosts(postData, settingsData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PostDataModel postData = Provider.of<PostDataModel>(context);

    return ListView.builder(
      itemCount: postData.postTilesList.length,
      itemBuilder: (context, index) {
        return PostCard(
          post: postData.postTilesList[index]
        );
      }
    );
  }
}

class PostCard extends StatelessWidget {

  final Post post;

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

class MediaWidget extends StatelessWidget {

  final Post post;

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

class OptionsBar extends StatelessWidget {

  final Post post;

  OptionsBar({Key? key, required this.post}) : super(key: key);

//  final ApiLauncher redditApi = ApiLauncher();

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceAround,
      buttonHeight: 50,
      buttonMinWidth: 50,
      children: <Widget>[
        IconButton(
          onPressed: () {
//            redditApi.upvotePost(this.post);
          },
          icon: Icon(Icons.arrow_upward),
        ),
        Text(this.post.upVotes.toString()),
        IconButton(
            onPressed: () {
//              redditApi.downvotePost(this.post);
            },
            icon: Icon(Icons.arrow_downward)
        ),
        Text(this.post.downVotes.toString()),
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