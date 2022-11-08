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

  LanguageOptionEnum? _languageOption; // = LanguageOptionEnum.id_ID;

  Future<LanguageOptionEnum?> checkLanguage(String language) async {
    if (language == LanguageOptionEnum.en_US.name) {
      _languageOption = LanguageOptionEnum.en_US;
    } else if (language == LanguageOptionEnum.id_ID.name) {
      _languageOption = LanguageOptionEnum.id_ID;
    }

    return _languageOption;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLanguage(context.locale.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var aa = snapshot.data;
          print("aa :: $aa");
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
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
      },
    );
  }
}
