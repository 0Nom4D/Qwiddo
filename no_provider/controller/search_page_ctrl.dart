import 'package:f_redditech/no_provider/models/api_launcher.dart';
import 'package:f_redditech/no_provider/views/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

class SearchPageController extends StatefulWidget {

  SearchPageController({Key? key}) : super(key: key);

  @override
  _SearchPageControllerState createState() => _SearchPageControllerState();
}

class _SearchPageControllerState extends State<SearchPageController> {

  List<SubredditRef> fetchedSubs = [];
  String query = "r/aww";

  @override
  void initState() {
    super.initState();
    query = "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setQuery(String newQuery) {
    this.query = newQuery;
  }

  void searchSubs(String query) async {
    ApiLauncher redditApi = ApiLauncher();
    List<SubredditRef> gotSubs;

    if (redditApi.isFlowCreated() == false)
      await redditApi.createRedditFlow();
    gotSubs = await redditApi.searchSubs(query).then((value) {
      return value;
    });
    if (mounted) {
      setState(() {
          fetchedSubs = gotSubs;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    searchSubs(this.query);
    return SearchPage(
        subs: fetchedSubs
    );
  }
}