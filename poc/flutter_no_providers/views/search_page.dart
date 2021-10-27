import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

class SearchPage extends StatefulWidget {

  final List<SubredditRef>? subs;

  SearchPage({Key? key, required this.subs}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

//  _subsListCreation() {
//    final List<Widget> subList = [];
//
//    for (int i = 0; i < widget.subs.length; i++) {
//      subList.add(SubTile(widget.subs[i]));
//    }
//    return (subList);
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimSearchBar(
        textController: this.textController,
        onSuffixTap: () {
          setState(() {
            textController.clear();
          });
        },
        width: MediaQuery.of(context).size.width,
      )
    );
//    return ListView(
//      children: _subsListCreation(),
//    );
  }
}