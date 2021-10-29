import 'package:f_redditech/providers/user_datas.dart';
import 'package:draw/draw.dart';

class SubInfo {
  String bannerImg = "";
  String iconImg = "";
  String subName = "";
  String description = "";
  int nbFollowers = 0;
  bool subJoined = false;
  Subreddit? rawData;

  SubInfo();

  SubInfo.fromSubreddit(UserDataModel myUserDatas, Subreddit subredditInfos) {
    if (subredditInfos.data!["mobile_banner_image"].toString() == "")
      bannerImg = subredditInfos.data!["mobile_banner_image"].toString().replaceAll("amp;", "");
    else
      bannerImg = subredditInfos.data!["banner_background_image"].toString().replaceAll("amp;", "");
    iconImg = subredditInfos.iconImage.toString().replaceAll("amp;", "");
    nbFollowers = subredditInfos.data!["subscribers"];
    description = subredditInfos.data!["public_description"];
    subJoined = isUserSubscribed(myUserDatas, subredditInfos);
    subName = subredditInfos.displayName;
    rawData = subredditInfos;
  }

  bool isUserSubscribed(UserDataModel myUserDatas, Subreddit subredditInfos) {
    for (int i = 0; i < myUserDatas.userData.subbedThreads.length; i++) {
      if (myUserDatas.userData.subbedThreads[i].fullname == subredditInfos.fullname)
        return true;
    }
    return false;
  }

  Map<String, dynamic> toMap() {
    return {
      'iconImg': iconImg,
      'displayName': subName,
      'nbSubs': nbFollowers,
      'headerImg': bannerImg,
      'subJoined': subJoined,
      'rawData': rawData,
      'description': description
    };
  }
}