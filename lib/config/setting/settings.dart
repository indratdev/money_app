import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_app/config/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/pages/settings/languanges/languange_bloc/language_bloc.dart';

import '../../presentation/pages/settings/category/bloc/category_bloc.dart';

enum BlocName {
  categoryRead,
  languangeRead,
}

class Setting {
  Icon iconSetting;
  String labelSetting;
  String routeSetting;
  BlocName blocName;

  Setting({
    this.iconSetting = const Icon(Icons.error),
    this.labelSetting = 'no name',
    required this.routeSetting,
    // required this.bloc,
    // required this.event,
    // this.aaa,
    required this.blocName,
  });
}

class MenuSetting {
  callBloc(BuildContext context, BlocName blocName) {
    switch (blocName) {
      case BlocName.categoryRead:
        context.read<CategoryBloc>().add(InitCategory());
        context.read<CategoryBloc>().add(ReadCategory(isDefault: 1));
        break;
      case BlocName.languangeRead:
        // context.read<LanguageBloc>().add(ReadLanguangeEvent());
        break;
      default:
        context.read<CategoryBloc>().add(ReadCategory(isDefault: 1));
    }
  }

  List<Setting> getListSettings = [
    Setting(
      labelSetting: 'Kategori',
      routeSetting: AppRoutes.settCategory,
      iconSetting: Icon(Icons.category),
      blocName: BlocName.categoryRead,
      // bloc: CategoryBloc,
      // event: ReadCategory,
      // aaa: call
      // context.read<CategoryBloc>().add(ReadCategory()),

      // BlocProvider.of<CategoryBloc>(context).add(ReadCategory()),
    ),
    Setting(
      labelSetting: 'Bahasa',
      iconSetting: Icon(Icons.language),
      routeSetting: AppRoutes.settLanguage,
      blocName: BlocName.languangeRead,
    ),
    // Setting(
    //     labelSetting: 'Backup Data',
    //     routeSetting: '/setting/backupData',
    //     iconSetting: Icon(Icons.backup)),
    // Setting(
    //   labelSetting: 'Tema',
    //   routeSetting: '/setting/warnaTema',
    //   iconSetting: Icon(Icons.color_lens),
    // ),
  ];
}
