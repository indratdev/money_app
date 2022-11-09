import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum ThemesEnum { lightColor, darkColor }

class ThemesScreen extends StatefulWidget {
  ThemesScreen({super.key});

  @override
  State<ThemesScreen> createState() => _ThemesScreenState();
}

class _ThemesScreenState extends State<ThemesScreen> {
  ThemesEnum? _themesOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('themes-color'.tr()),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('light-color'.tr()),
            leading: Radio<ThemesEnum>(
              value: ThemesEnum.lightColor,
              groupValue: _themesOption,
              onChanged: (ThemesEnum? value) {
                setState(() {
                  _themesOption = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('dark-color'.tr()),
            leading: Radio<ThemesEnum>(
              value: ThemesEnum.darkColor,
              groupValue: _themesOption,
              onChanged: (ThemesEnum? value) {
                setState(() {
                  _themesOption = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
