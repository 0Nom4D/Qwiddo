import 'package:f_redditech/src/providers/subreddit_post_datas.dart';
import 'package:f_redditech/src/api_service/api_launcher.dart';
import 'package:f_redditech/src/widgets/main_page.dart';
import 'package:f_redditech/src/models/sub_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loading_page.dart';

/// Widget displaying [Subreddit] Page
///
/// SubredditPage is different every time a subreddit is choosen
class SubredditPage extends StatefulWidget {

  /// Informations about the clicked [Subreddit]
  final SubInfo? clickedSub;

  /// Constructs a new [SubredditPage]
  SubredditPage({Key? key, required this.clickedSub}) : super(key: key);

  @override
  _SubredditPageState createState() => _SubredditPageState();
}

/// [SubredditPage]'s main state
class _SubredditPageState extends State<SubredditPage> {
  @override
  void initState() {
    SubRedditModel thisSubReddit = Provider.of<SubRedditModel>(context, listen: false);
    thisSubReddit.subredditInfo = widget.clickedSub!;
    ApiLauncher.getSubredditPosts(thisSubReddit, false);
    super.initState();
  }

  /// Method designed to make a cooldown between fetching and [ListView] display
  _fetchEntry() async {
    await Future.delayed(Duration(milliseconds: 250));
  }

  @override
  Widget build(BuildContext context) {
    SubRedditModel subredditData = Provider.of<SubRedditModel>(context);
    ScrollController listController = ScrollController();

    return FutureBuilder(
      future: _fetchEntry(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return LoadingScreen();
        return Stack(
          children: <Widget>[
            SubredditHeader(
              subRedditInfo: Provider.of<SubRedditModel>(context).subredditInfo,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, (MediaQuery.of(context).size.height) - 275, 0, 0),
              child: Consumer<SubRedditModel>(
                builder: (context, provider, _) =>
                NotificationListener<ScrollEndNotification>(
                  child: ListView.builder(
                    controller: listController,
                    itemCount: provider.subredditPostTilesList.length,
                    itemBuilder: (context, index) {
                      return PostCard(
                        post: provider.subredditPostTilesList[index],
                      );
                    }
                  ),
                  onNotification: (ScrollEndNotification scrollInfo) {
                    if (listController.position.atEdge) {
                      if (listController.position.pixels != 0)
                        ApiLauncher.getSubredditPosts(provider, false);
                      else
                        ApiLauncher.getSubredditPosts(provider, true);
                    }
                    return true;
                  }
                )
              )
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, (MediaQuery.of(context).size.height) - 325, 0, 0),
              alignment: Alignment.topCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: Wrap(
                          children: [
                            ListTile(
                              title: Text("Nouveautés"),
                              onTap: () {
                                subredditData.changeCategory("new", "Nouveautés");
                                Navigator.pop(context);
                              }
                            ),
                            ListTile(
                              title: Text("Au top"),
                              onTap: () {
                                subredditData.changeCategory("top", "Au top");
                                Navigator.pop(context);
                              }
                            ),
                            ListTile(
                              title: Text("Populaires"),
                              onTap: () {
                                subredditData.changeCategory("hot", "Populaires");
                                Navigator.pop(context);
                              }
                            ),
                            ListTile(
                              title: Text("En hausse"),
                              onTap: () {
                                subredditData.changeCategory("rising", "En hausse");
                                Navigator.pop(context);
                              }
                            )
                          ],
                        )
                      );
                    }
                  );
                },
                child: Text(subredditData.categoryType,
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
              ),
            )
          ]
        );
      }
    );
  }
}

/// [StatelessWidget] display the actual Subreddit header such as [ProfileHeader]
class SubredditHeader extends StatelessWidget {

  /// Informations about the clicked Subreddit
  final SubInfo? subRedditInfo;

  /// Constructs the actual [SubredditHeader] [Object]
  SubredditHeader({Key? key, required this.subRedditInfo}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 225.0,
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
          top: 100.0,
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
          top: 255.0,
          left: 25.0,
          child: RichText(
            text: TextSpan(
              text: "r/" + subRedditInfo!.subName,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Positioned(
          top: 255,
          left: (MediaQuery.of(context).size.width) - 125,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              SubRedditModel thisSubReddit = Provider.of<SubRedditModel>(context, listen: false);
              thisSubReddit.subscribe();
            },
            child: subRedditInfo!.subJoined ? Text("Abonné") : Text("S'abonner"),
          ),
        ),
        Positioned(
          top: 290,
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
          top: 325,
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