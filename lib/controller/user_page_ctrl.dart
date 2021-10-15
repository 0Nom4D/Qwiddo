import 'package:f_redditech/views/loading_page.dart';
import 'package:f_redditech/models/api_launcher.dart';
import 'package:f_redditech/views/user_page.dart';
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
    await redditApi.createRedditFlow();
    myProfile = await redditApi.getMe().then((value) {
      if (value != null)
        return (value);
      return (null);
    });
    print(myProfile!.awardeeKarma);
    print(myProfile!.awarderKarma);
    print(myProfile!.commentKarma);
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