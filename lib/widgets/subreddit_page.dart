import 'package:f_redditech/api_service/api_launcher.dart';
import 'package:f_redditech/models/sub_info.dart';
import 'package:f_redditech/providers/subreddit_post_datas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubredditPage extends StatefulWidget {

  final SubInfo? clickedSub;

  SubredditPage({Key? key, required this.clickedSub}) : super(key: key);

  @override
  _SubredditPageState createState() => _SubredditPageState();
}

class _SubredditPageState extends State<SubredditPage> {
  @override
  void initState() {
    SubRedditModel thisSubReddit = Provider.of<SubRedditModel>(context, listen: false);
    thisSubReddit.subredditInfo = widget.clickedSub!;
    ApiLauncher.getSubredditPosts(thisSubReddit, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubRedditModel>(
      builder: (context, provider, child) {
        return SubredditHeader(
          subRedditInfo: provider.subredditInfo,
        );
      }
    );
  }
}

class SubredditHeader extends StatelessWidget {

  final SubInfo? subRedditInfo;

  SubredditHeader({Key? key, required this.subRedditInfo}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 325.0,
              decoration: BoxDecoration(
                color: Colors.white54,
                image: subRedditInfo!.bannerImg == "" ? null : DecorationImage(
                  image: NetworkImage(subRedditInfo!.bannerImg), // Image de couverture
                  fit: BoxFit.cover,
                )
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
              ),
            )
          ],
        ),
        Positioned(
          top: 200.0,
          left: 25.0,
          child: Container(
            height: 150.0,
            width: 150.0,
            child: CircleAvatar(
              backgroundImage: subRedditInfo!.iconImg == "" ? null :
              NetworkImage(subRedditInfo!.iconImg), // Image de profile
            ),
          ),
        ),
        Positioned(
          top: 355.0,
          left: 25.0,
          child: RichText(
            text: TextSpan(
              text: subRedditInfo!.subName,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Positioned(
          left: (MediaQuery.of(context).size.width) - 125,
          child: ElevatedButton(
            onPressed: () {
              SubRedditModel thisSubReddit = Provider.of<SubRedditModel>(context, listen: false);
              thisSubReddit.subscribe();
            },
            child: subRedditInfo!.subJoined ? Text("Abonné") : Text("S'abonner"),
          ),
        ),
        Positioned(
          top: 390,
          left: 25.0,
          child: Text(
            subRedditInfo!.nbFollowers.toString() + " membres",
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.grey
            ),
          )
        ),
        Positioned(
          top: 425,
          left: 25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: (MediaQuery.of(context).size.width) - 50,
                child: Text(subRedditInfo!.description != "" ?
                subRedditInfo!.description : "Pas de description...",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black
                  ),
                ),
              )
            ]
          )
        )
      ],
    );
  }
}