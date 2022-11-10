// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/pages/settings/themes/themes_bloc/themes_bloc.dart';

enum ThemesEnum { lightColor, darkColor }

class ThemesScreen extends StatelessWidget {
  ThemesScreen({super.key});

  ThemesEnum? _themesOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('themes-color'.tr()),
      ),
      body: BlocConsumer<ThemesBloc, ThemesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SuccessReadThemes) {
            (state.result == true)
                ? _themesOption = ThemesEnum.darkColor
                : _themesOption = ThemesEnum.lightColor;
          }
          return Column(
            children: <Widget>[
              ListTile(
                title: Text('light-color'.tr()),
                leading: Radio<ThemesEnum>(
                  value: ThemesEnum.lightColor,
                  groupValue: _themesOption,
                  onChanged: (ThemesEnum? value) {
                    context
                        .read<ThemesBloc>()
                        .add(UpdateThemesEvent(value: value!.name));
                  },
                ),
              ),
              ListTile(
                title: Text('dark-color'.tr()),
                leading: Radio<ThemesEnum>(
                  value: ThemesEnum.darkColor,
                  groupValue: _themesOption,
                  onChanged: (ThemesEnum? value) {
                    context
                        .read<ThemesBloc>()
                        .add(UpdateThemesEvent(value: value!.name));
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
