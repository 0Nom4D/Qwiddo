import 'package:f_redditech/src/providers/user_datas.dart';
import 'package:draw/draw.dart';

class SubInfo {
  /// Banner image url
  String bannerImg = "";

  /// Profile image url
  String iconImg = "";

  /// Subreddit name
  String subName = "";

  /// Subreddit description
  String description = "";

  /// Number of followers
  int nbFollowers = 0;

  /// Boolean telling if user is subscribed to Subreddit
  bool subJoined = false;

  /// [Subreddit] raw Data
  Subreddit? rawData;

  /// Constructs a SubInfo object
  SubInfo();

  /// Constructs a SubInfo object from a Subreddit Object
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

  /// Checks if the user is subscribed to the fetched [Subreddit]
  bool isUserSubscribed(UserDataModel myUserDatas, Subreddit subredditInfos) {
    for (int i = 0; i < myUserDatas.userData.subbedThreads.length; i++) {
      if (myUserDatas.userData.subbedThreads[i].fullname == subredditInfos.fullname)
        return true;
    }
    return false;
  }

  /// Creates a map from a [SubInfo] Object
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