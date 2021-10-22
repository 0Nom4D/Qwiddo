import 'package:f_redditech/src/ui/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';
import 'loading_page.dart';

class UserPage extends StatefulWidget {

  final Redditor? userData;

  UserPage({Key? key, required this.userData}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            color: Colors.black,
          ), onPressed: () {
            print("We're back baby!");
//            Navigator.popAndPushNamed(context, '/main');
          },
        )
      ),
      body: ProfileHeader(
        bannerPicture: widget.userData!.data!["subreddit"]["banner_img"],
        displayName: widget.userData!.data!["subreddit"]["display_name_prefixed"],
        fullName: widget.userData!.fullname,
        profilePicture: widget.userData!.data!["subreddit"]["icon_img"],
        profileDesc: widget.userData!.data!["subreddit"]["description"],
        karmaNb: widget.userData!.awarderKarma! + widget.userData!.awarderKarma! + widget.userData!.commentKarma!,
        createdDate: widget.userData!.createdUtc,
        nbFollowers: widget.userData!.data!["subreddit"]["subscribers"],
      )
    );
  }

  @override
  bool get wantKeepAlive => throw UnimplementedError();
}