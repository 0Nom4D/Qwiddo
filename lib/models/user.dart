class UserData {
  String username = "";
  String displayName = "";
  String pubDescription = "";
  String iconImg = "";
  String bannerImg = "";
  DateTime createdUtc = DateTime.now();
  int nbFollowers = 0;
  int karmaAmount = 0;

  UserData();

  UserData.fromMap(Map<String, dynamic> data) {
    displayName = data['displayName'];
    username = data['username'];
    pubDescription = data['pubDescription'];
    bannerImg = data['bannerImg'];
    iconImg = data['iconImg'];
    createdUtc = data['createdUtc'];
    nbFollowers = data['nbFollowers'];
    karmaAmount = data['karmaAmount'];
  }

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