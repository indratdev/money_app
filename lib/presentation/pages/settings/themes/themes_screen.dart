// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/pages/settings/themes/themes_bloc/themes_bloc.dart';

import '../../../../config/themes/app_themes.dart';

// enum ThemesEnum { lightColor, darkColor }

class ThemesScreen extends StatelessWidget {
  ThemesScreen({super.key});

  // ThemesEnum? _themesOption;
  AppTheme? _themesOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('themes-color'.tr()),
      ),
      body: BlocConsumer<ThemesBloc, ThemesState>(
        listener: (context, state) {},
        builder: (context, state) {
          print("=============build");
          if (state is SuccessReadThemes) {
            print("state SuccessReadThemes : ${state.result}");
            (state.result == true)
                ? _themesOption = AppTheme.darkAppTheme
                : _themesOption = AppTheme.lightAppTheme;
          }

          if (state is SuccessChangeThemes) {
            (state.appTheme == AppTheme.darkAppTheme)
                ? _themesOption = AppTheme.darkAppTheme
                : _themesOption = AppTheme.lightAppTheme;
          }

          return Column(
            children: <Widget>[
              ListTile(
                title: Text('light-color'.tr()),
                leading: Radio<AppTheme>(
                  value: AppTheme.lightAppTheme,
                  groupValue: _themesOption,
                  onChanged: (AppTheme? value) {
                    context
                        .read<ThemesBloc>()
                        .add(ChangeThemeEvent(appTheme: value!));
                  },
                ),
              ),
              ListTile(
                title: Text('dark-color'.tr()),
                leading: Radio<AppTheme>(
                  value: AppTheme.darkAppTheme,
                  groupValue: _themesOption,
                  onChanged: (AppTheme? value) {
                    context
                        .read<ThemesBloc>()
                        .add(ChangeThemeEvent(appTheme: value!));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
