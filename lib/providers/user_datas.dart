import 'package:f_redditech/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// [UserDataModel] class defining a [ChangeNotifier] object
class UserDataModel extends ChangeNotifier {
  /// [UserData] of the user's profile
  UserData userData = UserData();

  /// Upload the user's profile data
  addUserDatas(UserData newDatas) {
    userData = newDatas;
    notifyListeners();
  }

  /// Set the user's profile data
  setPostList(UserData newData) {
    userData = UserData();
    userData = newData;
    notifyListeners();
  }

  /// Clear the user's profile data
  clearPostTileList() {
    userData = UserData();
    notifyListeners();
  }
}