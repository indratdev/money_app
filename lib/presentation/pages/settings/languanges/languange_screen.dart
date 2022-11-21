import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum LanguageOptionEnum { id_ID, en_US, ja_JP }

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
    } else if (language == LanguageOptionEnum.ja_JP.name) {
      _languageOption = LanguageOptionEnum.ja_JP;
    }

    return _languageOption;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLanguage(context.locale.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('titleLanguage'.tr()),
            ),
            body: Column(
              children: <Widget>[
                TileLanguage(
                  context,
                  'Indonesia',
                  LanguageOptionEnum.id_ID,
                  const Locale('id', 'ID'),
                ),
                TileLanguage(
                  context,
                  'English',
                  LanguageOptionEnum.en_US,
                  const Locale('en', 'US'),
                ),
                TileLanguage(
                  context,
                  'Japanese',
                  LanguageOptionEnum.ja_JP,
                  const Locale('ja', 'JP'),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
      },
    );
  }

  ListTile TileLanguage(BuildContext context, String title,
      LanguageOptionEnum values, Locale lll) {
    return ListTile(
      title: Text(title),
      leading: Radio<LanguageOptionEnum>(
        value: values,
        groupValue: _languageOption,
        onChanged: (LanguageOptionEnum? value) {
          setState(() {
            _languageOption = value;
            context.setLocale(lll);
          });
        },
      ),
    );
  }
}
