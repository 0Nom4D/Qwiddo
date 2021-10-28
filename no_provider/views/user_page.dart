import 'package:f_redditech/no_provider/views/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

class UserPage extends StatefulWidget {

  final Redditor? userData;

  UserPage({Key? key, required this.userData}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return ProfileHeader(
      bannerPicture: widget.userData!.data!["subreddit"]["banner_img"],
      displayName: widget.userData!.data!["subreddit"]["display_name_prefixed"],
      fullName: widget.userData!.fullname,
      profilePicture: widget.userData!.data!["subreddit"]["icon_img"],
      profileDesc: widget.userData!.data!["subreddit"]["public_description"],
      karmaNb: widget.userData!.awarderKarma! + widget.userData!.awarderKarma! + widget.userData!.commentKarma!,
      createdDate: widget.userData!.createdUtc,
      nbFollowers: widget.userData!.data!["subreddit"]["subscribers"],
    );
  }
}