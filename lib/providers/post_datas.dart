import 'package:f_redditech/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostDataModel extends ChangeNotifier {
  List<Post> postTilesList = [];

  addPostTileInList(Post newPost) {
    postTilesList.add(newPost);
    notifyListeners();
  }

  addPostListToList(List<Post> newPosts) {
    postTilesList.addAll(newPosts);
    notifyListeners();
  }

  setPostList(List<Post> postList) {
    postTilesList = [];
    postTilesList = postList;
    notifyListeners();
  }

  clearPostTileList() {
    postTilesList.clear();
    notifyListeners();
  }
}