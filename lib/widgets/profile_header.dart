import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileHeader extends StatelessWidget {

  final String bannerPicture;
  final String profileDesc;
  final String profilePicture;
  final String fullName;
  final String displayName;
  final DateTime createdDate;
  final int nbFollowers;
  final int karmaNb;

  ProfileHeader({
    required this.bannerPicture,
    required this.profilePicture,
    required this.fullName,
    required this.displayName,
    required this.profileDesc,
    required this.karmaNb,
    required this.createdDate,
    required this.nbFollowers,
  });

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {

    initializeDateFormatting('az');

    final now = DateTime.now();
    final totalDays = daysBetween(createdDate, now);

    final dayFormat = DateFormat.yMMMMd('fr_FR').format(this.createdDate);

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 325.0,
              decoration: BoxDecoration(
                color: Colors.white54,
                image: this.bannerPicture.replaceAll("amp;", "") == "" ? null : DecorationImage(
                  image: NetworkImage(
                    (this.bannerPicture.replaceAll("amp;", ""))
                  ), // Image de couverture
                  fit: BoxFit.cover,
                )
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
              ),
            )
          ],
        ),
        Positioned(
          top: 200.0,
          left: 25.0,
          child: Container(
            height: 150.0,
            width: 150.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                (this.profilePicture.replaceAll("amp;", ""))
              ), // Image de profile
            ),
          ),
        ),
        Positioned(
          top: 355.0,
          left: 25.0,
          child: RichText(
            text: TextSpan(
              text: this.displayName,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: " · " + this.fullName,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  )
                )
              ]
            ),
          ),
        ),
        Positioned(
          top: 390,
          left: 25.0,
          child: Text(
            this.karmaNb.toString() + " karma · " + totalDays.toString() +
    "d · " + dayFormat + " · " + this.nbFollowers.toString() + " follower(s)",
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.grey
            ),
          )
        ),
        Positioned(
          top: 425,
          left: 25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: (MediaQuery.of(context).size.width) - 25,
                child: Text(this.profileDesc != "" ? this.profileDesc : "No description...",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black
                  ),
                ),
              )
            ]
          )
        )
      ],
    );
  }
}