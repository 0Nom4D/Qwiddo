import 'package:f_redditech/api_service/api_launcher.dart';
import 'package:f_redditech/no_provider/views/loading_page.dart';
import 'package:f_redditech/widgets/profile_header.dart';
import 'package:f_redditech/providers/user_datas.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

/// [Widget] defining the User page
class UserPage extends StatefulWidget {

  /// Constructs a [UserPage]
  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

/// Main [Widget]'s of the [UserPage] widget
class _UserPageState extends State<UserPage> {

  @override
  void initState() {
    UserDataModel userDatas = Provider.of<UserDataModel>(context, listen: false);
    ApiLauncher.getMe(userDatas);
    super.initState();
  }

  /// Method designed to make a cooldown between fetching and [ListView] display
  _fetchEntry() async {
    await Future.delayed(Duration(milliseconds: 250));
  }

  @override
  Widget build(BuildContext context) {
    UserDataModel userData = Provider.of<UserDataModel>(context);

    return FutureBuilder(
      future: _fetchEntry(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return LoadingScreen();
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
    );
  }
}