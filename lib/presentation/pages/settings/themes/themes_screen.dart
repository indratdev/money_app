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
        listener: (context, state) {
          // if (state is SuccessChangeThemes) {
          //   print("state SuccessChangeThemes : ${state.appTheme}");
          //   // print("SuccessChangeThemes ::: ${state.appTheme}");
          //   if (state.appTheme == AppTheme.darkAppTheme) {
          //     print("bener");
          //   } else {
          //     print("salah");
          //   }
          //   (state.appTheme == AppTheme.darkAppTheme)
          //       // ? _themesOption = ThemesEnum.darkColor
          //       // : _themesOption = ThemesEnum.lightColor;
          //       ? _themesOption = AppTheme.darkAppTheme
          //       : _themesOption = AppTheme.lightAppTheme;
          // }
        },
        builder: (context, state) {
          print("=============build");
          if (state is SuccessReadThemes) {
            print("state SuccessReadThemes : ${state.result}");
            (state.result == true)
                // ? _themesOption = ThemesEnum.darkColor
                // : _themesOption = ThemesEnum.lightColor;
                ? _themesOption = AppTheme.darkAppTheme
                : _themesOption = AppTheme.lightAppTheme;
          }

          if (state is SuccessChangeThemes) {
            // print("state SuccessChangeThemes : ${state.appTheme}");
            // // print("SuccessChangeThemes ::: ${state.appTheme}");
            // if (state.appTheme == AppTheme.darkAppTheme) {
            //   print("bener");
            // } else {
            //   print("salah");
            // }
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
                    // context
                    //     .read<ThemesBloc>()
                    //     .add(UpdateThemesEvent(value: value!.name));
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
                    // context
                    //     .read<ThemesBloc>()
                    //     .add(UpdateThemesEvent(value: value!.name));
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

// class ThemesScreen extends StatefulWidget {
//   ThemesScreen({super.key});

//   @override
//   State<ThemesScreen> createState() => _ThemesScreenState();
// }

// class _ThemesScreenState extends State<ThemesScreen> {
//   ThemesEnum? _themesOption;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('themes-color'.tr()),
//       ),
//       body: Column(
//         children: <Widget>[
//           ListTile(
//             title: Text('light-color'.tr()),
//             leading: Radio<ThemesEnum>(
//               value: ThemesEnum.lightColor,
//               groupValue: _themesOption,
//               onChanged: (ThemesEnum? value) {
//                 setState(() {
//                   _themesOption = value;
//                 });
//               },
//             ),
//           ),
//           ListTile(
//             title: Text('dark-color'.tr()),
//             leading: Radio<ThemesEnum>(
//               value: ThemesEnum.darkColor,
//               groupValue: _themesOption,
//               onChanged: (ThemesEnum? value) {
//                 setState(() {
//                   _themesOption = value;
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
