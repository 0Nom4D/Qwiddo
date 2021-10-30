import  'package:f_redditech/flutter_mvc_poc/views/loading_page.dart';
import 'package:f_redditech/flutter_mvc_poc/models/api_launcher.dart';
import 'package:f_redditech/flutter_mvc_poc/views/user_page.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

class UserPageController extends StatefulWidget {
  UserPageController({Key? key}) : super(key: key);

  @override
  _UserPageController createState() => _UserPageController();
}

class _UserPageController extends State<UserPageController> {

  ApiLauncher redditApi = ApiLauncher();
  Redditor? myProfile;

  @override
  void initState() {
    super.initState();
    myProfile = null;
  }

  void connectToApi() async {
    Redditor? tmp;

    if (redditApi.isFlowCreated() == false)
      await redditApi.createRedditFlow();
    tmp = await redditApi.getMe().then((value) {
      if (value != null)
        return (value);
      return (null);
    });
    if (!mounted)
      return;
    setState(() {
      myProfile = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    connectToApi();
    if (myProfile == null)
      return (LoadingScreen());
    return UserPage(
      userData: myProfile,
    );
  }
}