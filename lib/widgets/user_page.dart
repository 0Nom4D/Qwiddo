import 'package:f_redditech/api_service/api_launcher.dart';
import 'package:f_redditech/widgets/profile_header.dart';
import 'package:f_redditech/providers/user_datas.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {

  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  @override
  void initState() {
    UserDataModel userDatas = Provider.of<UserDataModel>(context, listen: false);
    ApiLauncher.getMe(userDatas);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDataModel userData = Provider.of<UserDataModel>(context);

    return ProfileHeader(
      bannerPicture: userData.userData.bannerImg,
      displayName: userData.userData.displayName,
      fullName: userData.userData.username,
      profilePicture: userData.userData.iconImg,
      profileDesc: userData.userData.pubDescription,
      karmaNb: userData.userData.karmaAmount,
      createdDate: userData.userData.createdUtc,
      nbFollowers: userData.userData.nbFollowers,
    );
  }
}