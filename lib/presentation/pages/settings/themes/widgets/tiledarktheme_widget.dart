import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/themes/app_themes.dart';
import '../themes_bloc/themes_bloc.dart';

class TileDarkTheme extends StatelessWidget {
  const TileDarkTheme({
    Key? key,
    required AppTheme? themesOption,
  })  : _themesOption = themesOption,
        super(key: key);

  final AppTheme? _themesOption;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('dark-color'.tr()),
      leading: Radio<AppTheme>(
        value: AppTheme.darkAppTheme,
        groupValue: _themesOption,
        onChanged: (AppTheme? value) {
          context.read<ThemesBloc>().add(ChangeThemeEvent(appTheme: value!));
        },
      ),
    );
  }
}
