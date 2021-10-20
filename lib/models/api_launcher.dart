import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:draw/draw.dart';

class ApiLauncher {

  static final ApiLauncher _apiLauncher = ApiLauncher._internal();

  factory ApiLauncher() => _apiLauncher;

  late Reddit redditApi;

  bool isConnected = false;

  ApiLauncher._internal();

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

  Future<Redditor?> getMe() async {
    Redditor? retrievedUser;

    if (isFlowCreated() == false)
      this.createRedditFlow();
    retrievedUser = await redditApi.user.me();
    if (retrievedUser == null)
      return (null);
    return (retrievedUser);
  }

  Future<List<Submission>> getFrontPagePosts() async {
    List<Submission> posts = [];

    if (isFlowCreated() == false)
      this.createRedditFlow();
    await for (var frontPost in redditApi.front.hot(limit: 5)) {
      posts.add(frontPost as Submission);
    }
    return (posts);
  }

  bool isFlowCreated() {
    return this.isConnected;
  }
}