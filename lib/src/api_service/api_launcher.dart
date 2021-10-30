import 'package:f_redditech/src/providers/subreddit_post_datas.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:f_redditech/src/providers/post_datas.dart';
import 'package:f_redditech/src/providers/user_datas.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:f_redditech/src/models/post.dart';
import 'package:f_redditech/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:draw/draw.dart';
import 'dart:convert';

/// Api Service Singleton Class
class ApiLauncher {

  /// Static ApiLauncher for Singleton
  static final ApiLauncher _apiLauncher = ApiLauncher._internal();

  /// Factory building the Singleton
  factory ApiLauncher() => _apiLauncher;

  /// [Reddit] object
  late Reddit redditApi;

  /// Boolean telling if the Installed flow instance is created
  bool isConnected = false;

  /// Function creating the Singleton
  ApiLauncher._internal();

  /// Methode creating the [Reddit] object
  ///
  /// Connects the user to [Reddit] using Auth02
  Future<void> createRedditFlow() async {
    String? apiKey = dotenv.env['QWIDDO_API_KEY'];

    if (apiKey == null)
      return;
    redditApi = Reddit.createInstalledFlowInstance(
      clientId: apiKey,
      userAgent: "Qwiddo",
      redirectUri: Uri.parse("reddit://success"),
    );
    final authUrl = redditApi.auth.url(["*"], "Qwiddo", compactLogin: true);
    final result = await FlutterWebAuth.authenticate(
        url: authUrl.toString(),
        callbackUrlScheme: "reddit"
    );
    String? code = Uri
        .parse(result)
        .queryParameters['code'];
    await redditApi.auth.authorize(code.toString());
    isConnected = true;
  }

  /// Static Method getting the connected User
  ///
  /// Checks if the Installed Flow is created. If not it creates it and fetch
  /// the user's data, either it's already created it just fetch the user's data.
  static getMe(UserDataModel userDataNotifier) async {
    ApiLauncher redditApi = ApiLauncher();
    UserData userDatas = UserData();
    Redditor? retrievedUser;

    if (redditApi.isFlowCreated() == false)
      await redditApi.createRedditFlow();
    retrievedUser = await redditApi.redditApi.user.me();
    if (retrievedUser == null)
      return (null);
    userDatas = UserData.fromMap(retrievedUser);
    userDataNotifier.addUserDatas(userDatas);
  }

  /// Static Method Fetching the [Reddit] front page posts
  ///
  /// Cheks if the installed flow is created. It creates it if the installed flow
  /// isn't created and fetch the posts according to the filter. Store the
  /// posts datas using the [PostDataModel] [Provider].
  /// If [getWholeNew] boolean is true, it wipes the post data list and re-fill it.
  /// If [getWholeNew] boolean is false, it adds at the end of the list.
  static getFrontPagePosts(PostDataModel postsDataNotifier, bool getWholeNew) async {
    List<SubredditRef> fetchedForIcon = [];
    ApiLauncher redditApi = ApiLauncher();
    Submission fetchedSubmission;
    List<Post> posts = [];
    var chosenMethod;
    String? after;
    Post newPost;

    if (redditApi.isFlowCreated() == false)
      await redditApi.createRedditFlow();
    if (getWholeNew == false)
      after = postsDataNotifier.getLastFetchedItem();
    switch (postsDataNotifier.fetchedCategory) {
      case "new":
        chosenMethod = redditApi.redditApi.front.newest(
          limit: 25,
          after: after
        );
        break;
      case "hot":
        chosenMethod = redditApi.redditApi.front.hot(
          limit: 25,
          after: after
        );
        break;
      case "top":
        chosenMethod = redditApi.redditApi.front.top(
          limit: 25,
          after: after
        );
        break;
      case "rising":
        chosenMethod = redditApi.redditApi.front.rising(
          limit: 25,
          after: after
        );
        break;
      case "best":
        chosenMethod = redditApi.redditApi.front.best(
          limit: 25,
          after: after
        );
        break;
      case "controversial":
        chosenMethod = redditApi.redditApi.front.controversial(
          limit: 25,
          after: after
        );
        break;
    }
    await for (var frontPost in chosenMethod) {
      fetchedSubmission = frontPost as Submission;
      newPost = Post.fromMap(fetchedSubmission);
      fetchedForIcon = await redditApi.redditApi.subreddits.searchByName(newPost.subReddit, exact: true);
      if (fetchedForIcon.length > 0) {
        Subreddit tmp = (await fetchedForIcon[0].populate());
        newPost.subIcon = tmp.iconImage.toString().replaceAll("amp;", "");
      }
      posts.add(newPost);
    }
    if (getWholeNew == false)
      postsDataNotifier.addPostListToList(posts);
    else
      postsDataNotifier.setPostList(posts);
  }

  /// Static Method Fetch Subs using the [searchByName] Method
  ///
  /// Fetch a list of [Subreddits] depending the query string [query]
  Future<List<Subreddit>> searchSubs(String query) async {
    ApiLauncher redditApi = ApiLauncher();
    List<Subreddit> fetchedSubs = [];
    List<SubredditRef> fetched = [];

    if (redditApi.isFlowCreated() == false)
      await redditApi.createRedditFlow();
    fetched = await redditApi.redditApi.subreddits.searchByName(query);
    for (SubredditRef sub in fetched) {
      fetchedSubs.add(await sub.populate());
    }
    return (fetchedSubs);
  }

  /// Static Method Fetched the [Subreddit]s the user is subscribed to
  ///
  /// Fetch a list of subreddits the user is subscribed to
  static getUserSubreddits(UserDataModel userDataNotifier) async {
    ApiLauncher redditApi = ApiLauncher();

    if (redditApi.isFlowCreated() == false)
      await redditApi.createRedditFlow();
    userDataNotifier.userData.subbedThreads = await redditApi.redditApi.user.subreddits().toList();
  }

  /// Static Method Fetch posts from a [Subreddit]
  ///
  /// Works the same way as [getFrontPagePosts] static method
  /// Cheks if the installed flow is created. It creates it if the installed flow
  /// isn't created and fetch the posts according to the filter. Store the
  /// posts datas using the [PostDataModel] [Provider].
  /// If [getWholeNew] boolean is true, it wipes the post data list and re-fill it.
  /// If [getWholeNew] boolean is false, it adds at the end of the list.
  static getSubredditPosts(SubRedditModel subRedditDatas, bool getWholeNew) async {
    List<SubredditRef> fetchedForIcon = [];
    ApiLauncher redditApi = ApiLauncher();
    Submission fetchedSubmission;
    List<Post> posts = [];
    var chosenMethod;
    Subreddit tmp;
    String? after;
    Post newPost;

    if (redditApi.isFlowCreated() == false)
      await redditApi.createRedditFlow();
    if (getWholeNew == false)
      after = subRedditDatas.getLastFetchedItem();
    switch (subRedditDatas.fetchedCategory) {
      case "new":
        chosenMethod = subRedditDatas.subredditInfo.rawData!.newest(
            limit: 25,
            after: after
        );
        break;
      case "hot":
        chosenMethod = subRedditDatas.subredditInfo.rawData!.hot(
            limit: 25,
            after: after
        );
        break;
      case "top":
        chosenMethod = subRedditDatas.subredditInfo.rawData!.top(
            limit: 25,
            after: after
        );
        break;
      case "rising":
        chosenMethod = subRedditDatas.subredditInfo.rawData!.rising(
            limit: 25,
            after: after
        );
        break;
      case "controversial":
        chosenMethod = subRedditDatas.subredditInfo.rawData!.controversial(
            limit: 25,
            after: after
        );
        break;
    }
    await for (var frontPost in chosenMethod) {
      fetchedSubmission = frontPost as Submission;
      newPost = Post.fromMap(fetchedSubmission);
      fetchedForIcon = await redditApi.redditApi.subreddits.searchByName(newPost.subReddit, exact: true);
      if (fetchedForIcon.length > 0) {
        tmp = (await fetchedForIcon[0].populate());
        newPost.subIcon = tmp.iconImage.toString().replaceAll("amp;", "");
      }
      posts.add(newPost);
    }
    if (getWholeNew == false)
      subRedditDatas.addPostListToList(posts);
    else
      subRedditDatas.setPostList(posts);
  }

  /// Static Method Request the Reddit Api to subscribe to the Subreddit
  static subscribeToSub(Subreddit targetedSub) async {
    await targetedSub.subscribe();
  }

  /// Static Method Request the Reddit Api to unsubscribe to the Subreddit
  static unsubscribeToSub(Subreddit targetedSub) async {
    await targetedSub.unsubscribe();
  }

  /// Static Method Fetchs every settings of the current user
  static Future<Map<String, dynamic>> getPrefs() async {
    ApiLauncher redditApi = ApiLauncher();
    Map<String, dynamic> settingsMap = {};

    settingsMap = await redditApi.redditApi.get(
        "/api/v1/me/prefs",
        objectify: false
    );
    return (settingsMap);
  }

  /// Static Method Send a PATCH request to the Reddit Api to update preferences
  static savePrefs(Map<String, dynamic> settingsMap) async {
    ApiLauncher redditApi = ApiLauncher();
    await http.patch(Uri.https("oauth.reddit.com", "api/v1/me/prefs"),
        headers: {
          "Authorization": "Bearer ${redditApi.redditApi.auth.credentials.accessToken}",
          "Content-Type": "application/json"
        },
        body: json.encode(settingsMap)
    );
  }

  /// Static Method Upvoting a Submission Post
  static upvotePost(Submission upvotedPost) async {
    return (await upvotedPost.upvote());
  }

  /// Static Method Downvoting a Submission Post
  static downvotePost(Submission downvotedPost) async {
    return (await downvotedPost.downvote());
  }

  /// Static Method Canceling a Submission Vote
  static cancelVote(Submission post) async {
    return (await post.clearVote());
  }

  /// Returning a boolean defining the state of the Reddit flow
  /// True if the user is connected and the flowInstance is created
  /// False either
  bool isFlowCreated() {
    return this.isConnected;
  }
}