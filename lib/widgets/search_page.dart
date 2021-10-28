import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

/// Widget defining the [SearchPage]
///
/// Uses a [AnimSearchBar] as a [TextEditor] zone and
/// search for [SubReddit] objects.
class SearchPage extends StatefulWidget {

  final List<SubredditRef>? subs;

  SearchPage({Key? key, required this.subs}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

/// [Class] defining the main [SearchPage] state
class _SearchPageState extends State<SearchPage> {

  /// [TextEditingController] for the [AnimSearchBar]
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
  }
}