import 'package:draw/draw.dart';

/// Class defining a User Profile
class UserData {

  /// Account fullname
  String username = "";

  /// Account display name
  String displayName = "";

  /// Profile Description
  String pubDescription = "";

  /// Profile Picture url
  String iconImg = "";

  /// Banner Picture url
  String bannerImg = "";

  /// Date exposing when the account has been created
  DateTime createdUtc = DateTime.now();

  /// Number of followers
  int nbFollowers = 0;

  /// Karma amount value
  int karmaAmount = 0;

  /// Constructs an empty [UserData] object
  UserData();

  /// Fill a [UserData] object from a [Redditor]'s map
  UserData.fromMap(Redditor fetchedPost) {
    displayName = fetchedPost.data!["subreddit"]['display_name_prefixed'];
    username = fetchedPost.fullname!;
    pubDescription = fetchedPost.data!["subreddit"]["public_description"];
    bannerImg = fetchedPost.data!["subreddit"]["banner_img"];
    iconImg = fetchedPost.data!["subreddit"]['icon_img'];
    createdUtc = fetchedPost.createdUtc!;
    nbFollowers = fetchedPost.data!["subreddit"]['subscribers'];
    karmaAmount = fetchedPost.awarderKarma! + fetchedPost.awarderKarma! + fetchedPost.commentKarma!;
  }

  /// Creates a [Map<String, dynamic>] from a [UserData] object
  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'username': username,
      'pubDescription': pubDescription,
      'bannerImg': bannerImg,
      'iconImg': iconImg,
      'createdUtc': createdUtc,
      'nbFollowers': nbFollowers,
      'karmaAmount': karmaAmount
    };
  }
}