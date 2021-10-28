import 'package:draw/draw.dart';

/// Class defining a Subreddit post
class Post {

  /// Post title
  String title = "";

  /// Post body
  String body = "";

  /// Post subreddit's name
  String subReddit = "";

  /// Post author username
  String username = "";

  /// Media url
  String mediaUrl = "";

  /// Media type
  ///
  /// Either Video or Image
  String typeMediaUrl = "";

  /// [DateTime] when the post has been created
  DateTime createdUtc = DateTime.now();

  /// Upvotes number on the post
  int upVotes = 0;

  /// Downvotes number on the post
  int downVotes = 0;

  /// Number of upvote of the user on the post
  int myUpVotes = 0;

  /// Number of downvote of the user on the post
  int myDownVotes = 0;

  /// Post unique ID
  String itemId = "";

  /// [Submission?] object having the whole Sumbisson data
  Submission? rawData;

  /// Base constructor constructing an empty [Post] Object
  Post();

  /// Fill a [Post] object from a [Submission]'s map
  Post.fromMap(Submission fetchedSubmission) {
    title = fetchedSubmission.title;
    body = fetchedSubmission.selftext == null? "" : fetchedSubmission.selftext!;
    username = "u/" + fetchedSubmission.author;
    subReddit = fetchedSubmission.data!["subreddit_name_prefixed"];
    createdUtc = fetchedSubmission.createdUtc;
    upVotes = fetchedSubmission.upvotes;
    downVotes = fetchedSubmission.downvotes;
    itemId = fetchedSubmission.fullname!;
    myUpVotes = 0;
    myDownVotes = 0;
    if (fetchedSubmission.data!["secure_media"] != null) {
      mediaUrl = "";
      typeMediaUrl = "video";
    } else if (fetchedSubmission.data!["preview"] != null) {
      mediaUrl = fetchedSubmission.data!["preview"]["images"][0]["source"]["url"].replaceAll("amp;", "");
      typeMediaUrl = "image";
    }
    rawData = fetchedSubmission;
  }

  /// Creates a [Map<String, dynamic>] from a [Post] object
  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'title': title,
      'subReddit': body,
      'username': username,
      'media_url': mediaUrl,
      'typeMediaUrl': typeMediaUrl,
      'upVotes': upVotes,
      'downVotes': downVotes,
      'myUpVotes': myUpVotes,
      'myDownVotes': myDownVotes,
      'createdUtc': createdUtc
    };
  }
}