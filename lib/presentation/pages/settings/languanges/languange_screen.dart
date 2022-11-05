import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

enum LanguageOptionEnum { indonesia, english }

class LanguangeScreen extends StatefulWidget {
  const LanguangeScreen({super.key});

  @override
  State<LanguangeScreen> createState() => _LanguangeScreenState();
}

class _LanguangeScreenState extends State<LanguangeScreen> {
  LanguageOptionEnum? _languageOption = LanguageOptionEnum.indonesia;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bahasa"),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text("Indonesia"),
            leading: Radio<LanguageOptionEnum>(
              value: LanguageOptionEnum.indonesia,
              groupValue: _languageOption,
              onChanged: (LanguageOptionEnum? value) {
                setState(() {
                  print("value 1>>> $value");
                  _languageOption = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text("English"),
            leading: Radio<LanguageOptionEnum>(
              value: LanguageOptionEnum.english,
              groupValue: _languageOption,
              onChanged: (LanguageOptionEnum? value) {
                setState(() {
                  print("value 2>>> $value");
                  _languageOption = value;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
