import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';

// reddit.subreddits.searchByName

/// Widget defining a Loading Animation
class LoadingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: TabBarView(
        children: <Widget>[
          LoadingBouncingGrid.square(
            borderSize: 3.0,
            backgroundColor: Colors.deepOrange,
          ),
        ],
      ),
    );
  }
}