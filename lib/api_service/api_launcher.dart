import 'package:f_redditech/models/post.dart';
import 'package:f_redditech/models/user.dart';
import 'package:f_redditech/providers/post_datas.dart';
import 'package:f_redditech/providers/settings_datas.dart';
import 'package:f_redditech/providers/user_datas.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:draw/draw.dart';
import 'dart:io';

class ApiLauncher {

  static final ApiLauncher _apiLauncher = ApiLauncher._internal();

  factory ApiLauncher() => _apiLauncher;

  late Reddit redditApi;

  bool isConnected = false;

  ApiLauncher._internal();

  Future<void> createRedditFlow() async {
    Map<String, String> envVars = Platform.environment;

    redditApi = Reddit.createInstalledFlowInstance(
      clientId: envVars["REDDITECHCLIENTID"],
      userAgent: "Qwiddo",
      redirectUri: Uri.parse("reddit://success"),
    );
    final authUrl = redditApi.auth.url(["*"], "Qwiddo", compactLogin: true);
    final result = await FlutterWebAuth.authenticate(
        url: authUrl.toString(),
        callbackUrlScheme: "reddit"
    );
    String? code = Uri.parse(result).queryParameters['code'];
    await redditApi.auth.authorize(code.toString());
    isConnected = true;
  }

  static getMe(UserDataModel userDataNotifier) async {
    ApiLauncher redditApi = ApiLauncher();
    UserData userDatas = UserData();
    Redditor? retrievedUser;

    if (redditApi.isFlowCreated() == false)
      await redditApi.createRedditFlow();
    retrievedUser = await redditApi.redditApi.user.me();
    if (retrievedUser == null)
      return (null);
    userDatas.displayName = retrievedUser.data!["subreddit"]["display_name_prefixed"];
    userDatas.username = retrievedUser.fullname!;
    userDatas.pubDescription = retrievedUser.data!["subreddit"]["public_description"];
    userDatas.iconImg = retrievedUser.data!["subreddit"]["icon_img"];
    userDatas.bannerImg = retrievedUser.data!["subreddit"]["banner_img"];
    userDatas.karmaAmount = retrievedUser.awarderKarma! + retrievedUser.awarderKarma! + retrievedUser.commentKarma!;
    userDatas.createdUtc = retrievedUser.createdUtc!;
    userDatas.nbFollowers = retrievedUser.data!["subreddit"]["subscribers"];
    userDataNotifier.addUserDatas(userDatas);
  }

  static getFrontPagePosts(PostDataModel postsDataNotifier, SettingsData settingsDataNotifier) async {
    ApiLauncher redditApi = ApiLauncher();
    Submission fetchedSubmission;
    List<Post> posts = [];
    var chosenMethod;
    Post newPost;

    if (redditApi.isFlowCreated() == false)
      await redditApi.createRedditFlow();
    switch (settingsDataNotifier.fetchedCategory) {
      case "new":
        chosenMethod = redditApi.redditApi.front.newest(
          limit: settingsDataNotifier.fetchedLimit
        );
        break;
      case "hot":
        chosenMethod = redditApi.redditApi.front.hot(
          limit: settingsDataNotifier.fetchedLimit
        );
        break;
      case "top":
        chosenMethod = redditApi.redditApi.front.top(
          limit: settingsDataNotifier.fetchedLimit
        );
        break;
      case "rising":
        chosenMethod = redditApi.redditApi.front.rising(
          limit: settingsDataNotifier.fetchedLimit
        );
        break;
      case "best":
        chosenMethod = redditApi.redditApi.front.best(
          limit: settingsDataNotifier.fetchedLimit
        );
        break;
      case "controversial":
        chosenMethod = redditApi.redditApi.front.controversial(
          limit: settingsDataNotifier.fetchedLimit
        );
        break;
    }
    await for (var frontPost in chosenMethod) {
      newPost = Post();
      fetchedSubmission = frontPost as Submission;
      newPost.title = fetchedSubmission.title;
      newPost.body = fetchedSubmission.selftext == null? "" : fetchedSubmission.selftext!;
      newPost.username = "u/" + fetchedSubmission.author;
      newPost.subReddit = fetchedSubmission.data!["subreddit_name_prefixed"];
      newPost.createdUtc = fetchedSubmission.createdUtc;
      newPost.upVotes = fetchedSubmission.upvotes;
      newPost.downVotes = fetchedSubmission.downvotes;
      newPost.myUpVotes = 0;
      newPost.myDownVotes = 0;
      if (fetchedSubmission.data!["secure_media"] != null) {
        newPost.mediaUrl = "";
        newPost.typeMediaUrl = "video";
      } else if (fetchedSubmission.data!["preview"] != null) {
        newPost.mediaUrl = fetchedSubmission.data!["preview"]["images"][0]["source"]["url"].replaceAll("amp;", "");
        newPost.typeMediaUrl = "image";
      }
      posts.add(newPost);
    }
    postsDataNotifier.setPostList(posts);
  }

  static Future<List<SubredditRef>> searchSubs(String query) async {
    ApiLauncher redditApi = ApiLauncher();

    if (redditApi.isFlowCreated() == false)
      redditApi.createRedditFlow();
    return (redditApi.redditApi.subreddits.searchByName(
      query,
      includeNsfw: true,
      exact: false
    ));
  }

  static Future<void> upvotePost(Submission upvotedPost) {
    return (upvotedPost.upvote());
  }

  static Future<void> downvotePost(Submission downvotedPost) {
    return (downvotedPost.downvote());
  }

  bool isFlowCreated() {
    return this.isConnected;
  }
}