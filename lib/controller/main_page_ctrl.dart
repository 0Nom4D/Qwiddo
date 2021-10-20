import 'package:draw/draw.dart';
import 'package:f_redditech/models/api_launcher.dart';
import 'package:f_redditech/views/loading_page.dart';
import 'package:f_redditech/views/main_page.dart';
import 'package:flutter/cupertino.dart';

class MainPageController extends StatefulWidget {
  MainPageController({Key? key}) : super(key: key);

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

  void retrievePosts() async {
    List<Submission>? tmp;

    if (redditApi.isFlowCreated() == false)
      await redditApi.createRedditFlow();
    if (posts == null) {
      tmp = await redditApi.getFrontPagePosts().then((value) {
        return (value);
      });
      setState(() {
        posts = tmp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    retrievePosts();
    if (posts == null)
      return (LoadingScreen());
    return (MainPage(
      posts: posts,
    ));
  }
}