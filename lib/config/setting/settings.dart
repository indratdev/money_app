import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_app/config/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/pages/settings/category/bloc/category_bloc.dart';

enum BlocName {
  categoryRead,
  languangeRead,
  clearDataRead,
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
      labelSetting: 'category'.tr(),
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
      labelSetting: 'titleLanguage'.tr(),
      iconSetting: Icon(Icons.language),
      routeSetting: AppRoutes.settLanguage,
      blocName: BlocName.languangeRead,
    ),
    Setting(
      labelSetting: 'clear-data-all'.tr(),
      iconSetting: Icon(Icons.clear_all),
      routeSetting: AppRoutes.settClearData,
      blocName: BlocName.clearDataRead,
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
