import 'package:f_redditech/models/post.dart';
import 'package:f_redditech/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDataModel extends ChangeNotifier {
  UserData userData = UserData();

  addUserDatas(UserData newDatas) {
    userData = newDatas;
    notifyListeners();
  }

  setPostList(UserData newData) {
    userData = UserData();
    userData = newData;
    notifyListeners();
  }

  clearPostTileList() {
    userData = UserData();
    notifyListeners();
  }
}