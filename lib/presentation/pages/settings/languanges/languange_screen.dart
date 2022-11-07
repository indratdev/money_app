import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum LanguageOptionEnum { id_ID, en_US }

class LanguangeScreen extends StatefulWidget {
  const LanguangeScreen({super.key});

  @override
  State<LanguangeScreen> createState() => _LanguangeScreenState();
}

class _LanguangeScreenState extends State<LanguangeScreen> {
  @override
  void initState() {
    super.initState();
  }

  LanguageOptionEnum? _languageOption = LanguageOptionEnum.id_ID;

  @override
  Widget build(BuildContext context) {
    var chooseLanguage = context.locale.toString();
    print("aaaaa : $chooseLanguage");
    return Scaffold(
      appBar: AppBar(
        title: Text('titleLanguage'.tr()),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text("Indonesia"),
            leading: Radio<LanguageOptionEnum>(
              value: LanguageOptionEnum.id_ID,
              groupValue: _languageOption,
              onChanged: (LanguageOptionEnum? value) {
                setState(() {
                  print("value 1>>> $value");
                  _languageOption = value;
                  context.setLocale(Locale('id', 'ID'));
                });
              },
            ),
          ),
          ListTile(
            title: Text("English"),
            leading: Radio<LanguageOptionEnum>(
              value: LanguageOptionEnum.en_US,
              groupValue: _languageOption,
              onChanged: (LanguageOptionEnum? value) {
                setState(() {
                  print("value 2>>> $value");
                  _languageOption = value;
                  context.setLocale(Locale('en', 'US'));
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
