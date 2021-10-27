import 'package:f_redditech/no_provider/models/api_launcher.dart';
import 'package:f_redditech/no_provider/views/loading_page.dart';
import 'package:f_redditech/no_provider/views/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:draw/draw.dart';

class MainPageController extends StatefulWidget {

  final String category;
  final int limit;

  MainPageController({this.category = "new", this.limit = 15});

  @override
  _MainPageController createState() => _MainPageController();
}

class _MainPageController extends State<MainPageController> {

  ApiLauncher redditApi = ApiLauncher();
  List<Submission>? posts;

  @override
  void initState() {
    super.initState();
    posts = null;
  }

  void retrievePosts(String category, int limit) async {
    List<Submission>? tmp;

    if (redditApi.isFlowCreated() == false)
      await redditApi.createRedditFlow();
    if (posts == null) {
      tmp = await redditApi.getFrontPagePosts(category, limit).then((value) {
        return (value);
      });
      setState(() {
        posts = tmp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    retrievePosts(widget.category, widget.limit);
    if (posts == null)
      return (LoadingScreen());
    return MainPage(
      posts: posts
    );
  }
}