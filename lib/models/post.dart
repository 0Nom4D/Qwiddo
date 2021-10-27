class Post {
  String title = "";
  String body = "";
  String subReddit = "";
  String username = "";
  String mediaUrl = "";
  String typeMediaUrl = "";
  DateTime createdUtc = DateTime.now();
  int upVotes = 0;
  int downVotes = 0;
  int myUpVotes = 0;
  int myDownVotes = 0;

  Post();

  Post.fromMap(Map<String, dynamic> data) {
    body = data['body'];
    title = data['title'];
    subReddit = data['subReddit'];
    username = data['username'];
    mediaUrl = data['media_url'];
    typeMediaUrl = data['typeMediaUrl'];
    upVotes = data['upVotes'];
    downVotes = data['downVotes'];
    myUpVotes = data['myUpVotes'];
    myDownVotes = data['myDownVotes'];
    createdUtc = data['createdUtc'];
  }

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