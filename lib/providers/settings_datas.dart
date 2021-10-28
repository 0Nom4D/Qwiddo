import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// [SettingsData] class defining a [ChangeNotifier] object
class SettingsData extends ChangeNotifier {
  String fetchedCategory = "new";
  int fetchedLimit = 25;
}