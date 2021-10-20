import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

class MainPage extends StatefulWidget {

  final List<Submission>? posts;

  MainPage({Key? key, required this.posts}) : super(key: key);

  late final int postsLength;

  @override
  _MainPageState createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    super.initState();
    widget.postsLength = 0;
  }

  _createdPostCard(Submission newPosts) {
    return (Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(newPosts.data!["subreddit_name_prefixed"],
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
            subtitle: Text("u/" + newPosts.author,
                style: TextStyle(
                  fontSize: 15.0
                ),
              ),
          )
        ],
      )
    ));
  }

  List<Widget> _listCreation() {
    List<Widget> _allCards = [];

    for (int i = 0; i < widget.posts!.length; i++) {
      _allCards.add(_createdPostCard(widget.posts![i]));
    }
    return (_allCards);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _listCreation(),
    );
  }
}