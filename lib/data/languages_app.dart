import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LanguagesApp {
  final List<Locale> _listLanguage = const [
    Locale('id', 'ID'),
    Locale('en', 'US'),
    Locale('ja', 'JP'),
  ];

  final Locale _defaultLanguage = const Locale('id', 'ID');

  // getter
  List<Locale> get getListLanguage {
    return _listLanguage;
  }

  Locale get getDefaultLanguage {
    return _defaultLanguage;
  }
}
