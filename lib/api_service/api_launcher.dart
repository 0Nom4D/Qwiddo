import 'package:f_redditech/models/post.dart';
import 'package:f_redditech/models/user.dart';
import 'package:f_redditech/providers/post_datas.dart';
import 'package:f_redditech/providers/settings_datas.dart';
import 'package:f_redditech/providers/user_datas.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:draw/draw.dart';

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
//    Map<String, String> envVars = Platform.environment;

    redditApi = Reddit.createInstalledFlowInstance(
      clientId: "KE5DpJuRH0sNw1tWYQeerA",
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
  static getFrontPagePosts(PostDataModel postsDataNotifier, SettingsData settingsDataNotifier, bool getWholeNew) async {
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
    switch (settingsDataNotifier.fetchedCategory) {
      case "new":
        chosenMethod = redditApi.redditApi.front.newest(
          limit: settingsDataNotifier.fetchedLimit,
          after: after
        );
        break;
      case "hot":
        chosenMethod = redditApi.redditApi.front.hot(
          limit: settingsDataNotifier.fetchedLimit,
          after: after
        );
        break;
      case "top":
        chosenMethod = redditApi.redditApi.front.top(
          limit: settingsDataNotifier.fetchedLimit,
          after: after
        );
        break;
      case "rising":
        chosenMethod = redditApi.redditApi.front.rising(
          limit: settingsDataNotifier.fetchedLimit,
          after: after
        );
        break;
      case "best":
        chosenMethod = redditApi.redditApi.front.best(
          limit: settingsDataNotifier.fetchedLimit,
          after: after
        );
        break;
      case "controversial":
        chosenMethod = redditApi.redditApi.front.controversial(
          limit: settingsDataNotifier.fetchedLimit,
          after: after
        );
        break;
    }
    await for (var frontPost in chosenMethod) {
      fetchedSubmission = frontPost as Submission;
      newPost = Post.fromMap(fetchedSubmission);
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
  static Future<List<SubredditRef>> searchSubs(String query) async {
    ApiLauncher redditApi = ApiLauncher();

    if (redditApi.isFlowCreated() == false)
      await redditApi.createRedditFlow();
    return (await redditApi.redditApi.subreddits.searchByName(
      query,
      includeNsfw: true,
      exact: false
    ));
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

  /// Method
  ///
  /// Returning a boolean defining the state of the Reddit flow
  /// True if the user is connected and the flowInstance is created
  /// False either
  bool isFlowCreated() {
    return this.isConnected;
  }
}