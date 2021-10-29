import 'package:f_redditech/providers/subreddit_post_datas.dart';
import 'package:flappy_search_bar_ns/flappy_search_bar_ns.dart';
import 'package:f_redditech/api_service/api_launcher.dart';
import 'package:f_redditech/widgets/subreddit_page.dart';
import 'package:f_redditech/providers/user_datas.dart';
import 'package:f_redditech/models/sub_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

/// Widget defining the [SearchPage]
///
/// Uses a [AnimSearchBar] as a [TextEditor] zone and
/// search for [SubReddit] objects.
class SearchPage extends StatefulWidget {

  final List<SubredditRef>? subs;

  SearchPage({Key? key, required this.subs}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

/// [Class] defining the main [SearchPage] state
class _SearchPageState extends State<SearchPage> {

  final SearchBarController<SubInfo> _searchBarController = SearchBarController();
  ApiLauncher redditApi = ApiLauncher();
  bool isReplay = false;
  SubInfo? choosenSub;

  @override
  void initState() {
    UserDataModel userDatas = Provider.of<UserDataModel>(context, listen: false);
    ApiLauncher.getUserSubreddits(userDatas);
    super.initState();
  }

  Future<List<SubInfo>> _getAllSubs(String? query) async {
    UserDataModel myUserDatas = Provider.of<UserDataModel>(context, listen: false);
    List<SubInfo> fetchedSubs = [];
    List<Subreddit> newSubs = [];

    newSubs = await redditApi.searchSubs(query!).then((value) => value);
    for (int i = 0; i < newSubs.length; i++) {
      fetchedSubs.add(SubInfo.fromSubreddit(myUserDatas, newSubs[i]));
    }
    return (fetchedSubs);
  }

  @override
  Widget build(BuildContext context) {
    return choosenSub == null ? SafeArea(
      child: SearchBar<SubInfo>(
        searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
        headerPadding: EdgeInsets.symmetric(horizontal: 10),
        listPadding: EdgeInsets.symmetric(horizontal: 10),
        onSearch: _getAllSubs,
        searchBarController: _searchBarController,
        onError: (error) => Text('ERROR: ${error.toString()}'),
        cancellationWidget: Text("Annuler"),
        emptyWidget: Text("Empty widget"),
        header: Row(
          children: <Widget>[
            TextButton(
              child: Text("Trier"),
              onPressed: () {
                _searchBarController.sortList((SubInfo a, SubInfo b) {
                  return b.nbFollowers.compareTo(a.nbFollowers);
                });
              },
            ),
          ],
        ),
        onCancelled: () {},
        onItemFound: (SubInfo? post, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: post!.iconImg == "" ? null : NetworkImage(post.iconImg),
            ),
            title: Text("r/" + post.subName),
            isThreeLine: true,
            subtitle: Text(post.nbFollowers.toString() + " membres"),
            onTap: () {
              setState(() {
                choosenSub = post;
              });
            },
          );
        }
      )
    ) : ChangeNotifierProvider(
      create: (context) => SubRedditModel(),
      child: SubredditPage(
        clickedSub: choosenSub,
      )
    );
  }
}