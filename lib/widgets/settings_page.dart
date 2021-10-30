import 'package:f_redditech/api_service/api_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loading_page.dart';

class SettingsPage extends StatefulWidget {

  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {

  List<String> optionsName = [
    "hide_from_robots",
    "private_feeds",
    "hide_ads",
    "over_18",
    "no_profanity",
    "creddit_autorenew"
  ];
  List<String> descriptionsName = [
    "Cacher son profil des bots",
    "Afficher les feeds privés",
    "Cacher les publicités",
    "Afficher les posts +18",
    "Cacher les posts profanes",
    "Auto-renouveler les crédits Reddit"
  ];
  Map<String, bool> fetchedSettings = {
    'hide_from_robots': false,
    'private_feeds': false,
    'hide_ads': false,
    'over_18': false,
    'no_profanity': false,
    'creddit_autorenew': false
  };
  Map<String, dynamic> settingsMap = {};

  @override
  void initState() {
    super.initState();
  }

  _getPrefs() async {
    settingsMap = await ApiLauncher.getPrefs();
    fetchedSettings['hide_from_robots'] = settingsMap['hide_from_robots'];
    fetchedSettings['private_feeds'] = settingsMap['private_feeds'];
    fetchedSettings['hide_ads'] = settingsMap['hide_ads'];
    fetchedSettings['over_18'] = settingsMap['over_18'];
    fetchedSettings['no_profanity'] = settingsMap['no_profanity'];
    fetchedSettings['creddit_autorenew'] = settingsMap['creddit_autorenew'];
    return (fetchedSettings);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getPrefs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: fetchedSettings.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(optionsName[index]),
                        subtitle: Text(descriptionsName[index]),
                        trailing: SettingSwitch(
                          settings: fetchedSettings,
                          index: optionsName[index]
                        ),
                      )
                    );
                  }
                )
              )
            ],
          );
        }
        return LoadingScreen();
      }
    );
  }
}

class SettingSwitch extends StatefulWidget {

  final Map<String, bool> settings;
  final String index;

  SettingSwitch({Key? key, required this.settings, required this.index}) : super(key: key);

  @override
  _SettingSwitch createState() => _SettingSwitch();
}

class _SettingSwitch extends State<SettingSwitch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Switch(
        onChanged: (value) {
          setState(() {
            widget.settings[widget.index] = value;
            ApiLauncher.savePrefs(widget.settings);
          });
        },
        activeTrackColor: Colors.black26,
        activeColor: Colors.deepOrange,
        value: widget.settings[widget.index]!,
      ),
    );
  }
}