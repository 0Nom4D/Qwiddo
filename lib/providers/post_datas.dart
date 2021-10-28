import 'package:f_redditech/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// [PostDataModel] class defining a [ChangeNotifier] object
class PostDataModel extends ChangeNotifier {

  /// [List] of every post fetched from Reddit Api
  List<Post> postTilesList = [];

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

 // upVoteItem(Post postToUpVote) {
 //   for (Post tmp in postTilesList) {
 //     if (postToUpVote.itemId == tmp.itemId) {
 //       if (tmp.myUpVotes == 1) {
 //         tmp.myUpVotes = 0;
 //         ApiLauncher.cancelVote(tmp.rawData!);
 //       } else {
 //         if (tmp.myDownVotes == 1) {
 //           tmp.myDownVotes = 0;
 //           ApiLauncher.cancelVote(tmp.rawData!);
 //         }
 //         tmp.myUpVotes++;
 //         ApiLauncher.upvotePost(tmp.rawData!);
 //       }
 //     }
 //   }
 // }
 //
 // downVoteItem(Post postToDownVote) {
 //   for (Post tmp in postTilesList) {
 //     if (postToDownVote.itemId == tmp.itemId) {
 //       if (tmp.myDownVotes == 1) {
 //         tmp.myDownVotes = 0;
 //         ApiLauncher.cancelVote(tmp.rawData!);
 //       } else {
 //         if (tmp.myUpVotes == 1) {
 //           tmp.myUpVotes = 0;
 //           ApiLauncher.cancelVote(tmp.rawData!);
 //         }
 //         tmp.myDownVotes++;
 //         ApiLauncher.downvotePost(tmp.rawData!);
 //       }
 //     }
 //   }
 // }

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