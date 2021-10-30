import 'package:f_redditech/api_service/api_launcher.dart';
import 'package:f_redditech/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// [PostDataModel] class defining a [ChangeNotifier] object
class PostDataModel extends ChangeNotifier {

  /// [List] of every post fetched from Reddit Api
  List<Post> postTilesList = [];
  String categoryType = "Nouveautés";
  String fetchedCategory = "new";

  /// Add a post to the fetched [List]
  addPostTileInList(Post newPost) {
    postTilesList.add(newPost);
    notifyListeners();
  }

  /// Checks if a [Post] is already in the [List]
  _isAlreadyInList(Post newPost) {
    for (Post tmp in postTilesList) {
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
        postTilesList.add(newPosts[i]);
    }
    notifyListeners();
  }

  /// Set the fetched [List]
  setPostList(List<Post> postList) {
    postTilesList = [];
    postTilesList = postList;
    notifyListeners();
  }

  changeCategory(String newCategory, String newCategoryType) {
    categoryType = newCategoryType;
    fetchedCategory = newCategory;
    ApiLauncher.getFrontPagePosts(this, true);
    notifyListeners();
  }

  /// Get the last [Post] itemId object
  getLastFetchedItem() {
    if (postTilesList.isEmpty)
      return (null);
    return (postTilesList.last.itemId);
  }

  /// Clear the [List<Post>]
  clearPostTileList() {
    postTilesList.clear();
    notifyListeners();
  }
}