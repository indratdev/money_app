import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/pages/settings/themes/themes_bloc/themes_bloc.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';
import '../themes/widgets/tiletheme.dart';
import '../../../../config/themes/app_themes.dart';

class ThemesScreen extends StatelessWidget {
  ThemesScreen({super.key});
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
          if (state is FailureReadThemes || state is FailureChangeThemes) {
            CustomWidgets.showMessageAlertBasic(
                context, 'error-read-themes'.tr(), false);
          }

          if (state is SuccessReadThemes) {
            (state.result == AppTheme.darkAppTheme)
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
              TileLightTheme(themesOption: _themesOption),
              TileDarkTheme(themesOption: _themesOption),
            ],
          );
        },
      ),
    );
  }
}
