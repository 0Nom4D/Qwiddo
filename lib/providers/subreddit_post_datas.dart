import 'package:f_redditech/api_service/api_launcher.dart';
import 'package:f_redditech/models/sub_info.dart';
import 'package:f_redditech/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// [PostDataModel] class defining a [ChangeNotifier] object
class SubRedditModel extends ChangeNotifier {

  /// [List] of every post fetched from Reddit Api
  List<Post> subredditPostTilesList = [];
  String categoryType = "Nouveautés";
  SubInfo subredditInfo = SubInfo();
  String fetchedCategory = "new";

  /// Add a post to the fetched [List]
  addPostTileInList(Post newPost) {
    subredditPostTilesList.add(newPost);
    notifyListeners();
  }

  /// Checks if a [Post] is already in the [List]
  _isAlreadyInList(Post newPost) {
    for (Post tmp in subredditPostTilesList) {
      if (tmp.subReddit == newPost.subReddit && tmp.username == newPost.username &&
          tmp.createdUtc == newPost.createdUtc && tmp.title == newPost.title &&
          tmp.body == newPost.body)
        return true;
    }
    return false;
  }

  /// Add the content of a [List] to the [List<Post>]
  addPostListToList(List<Post> newPosts) {
    for (int i = 0; i < newPosts.length; i++) {
      if (_isAlreadyInList(newPosts[i]) == false)
        subredditPostTilesList.add(newPosts[i]);
    }
    notifyListeners();
  }

  subscribe() {
    if (subredditInfo.subJoined == false) {
      subredditInfo.subJoined = true;
      ApiLauncher.subscribeToSub(subredditInfo.rawData!);
    } else {
      subredditInfo.subJoined = false;
      ApiLauncher.unsubscribeToSub(subredditInfo.rawData!);
    }
    notifyListeners();
  }

  /// Set the fetched [List]
  setPostList(List<Post> postList) {
    subredditPostTilesList = [];
    subredditPostTilesList = postList;
    notifyListeners();
  }

  changeCategory(String newCategory, String newCategoryType) {
    categoryType = newCategoryType;
    fetchedCategory = newCategory;
    notifyListeners();
  }

  /// Get the last [Post] itemId object
  getLastFetchedItem() {
    if (subredditPostTilesList.isEmpty)
      return (null);
    return (subredditPostTilesList.last.itemId);
  }

  /// Clear the [List<Post>]
  clearPostTileList() {
    subredditPostTilesList.clear();
    notifyListeners();
  }
}