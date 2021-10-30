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

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}