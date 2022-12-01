import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_app/config/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/pages/settings/pin/bloc/pin_bloc.dart';
import 'package:money_app/presentation/pages/settings/themes/themes_bloc/themes_bloc.dart';

import '../../presentation/pages/settings/category/bloc/category_bloc.dart';

enum BlocName {
  defaultRead,
  categoryRead,
  languangeRead,
  clearDataRead,
  themesRead,
  pinRead,
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
    this.blocName = BlocName.defaultRead,
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
        break;
      case BlocName.themesRead:
        context.read<ThemesBloc>().add(ReadThemesEvent());
        break;
      case BlocName.pinRead:
        context.read<PinBloc>().add(CheckPinUsed());
        break;
      default:
        context.read<CategoryBloc>().add(ReadCategory(isDefault: 1));
    }
  }

  List<Setting> getListSettings = [
    Setting(
      labelSetting: 'category'.tr(),
      routeSetting: AppRoutes.settCategory,
      iconSetting: const Icon(Icons.category),
      blocName: BlocName.categoryRead,
    ),
    Setting(
      labelSetting: 'titleLanguage'.tr(),
      iconSetting: const Icon(Icons.language),
      routeSetting: AppRoutes.settLanguage,
      blocName: BlocName.languangeRead,
    ),
    Setting(
      labelSetting: 'clear-data-all'.tr(),
      iconSetting: const Icon(Icons.clear_all),
      routeSetting: AppRoutes.settClearData,
      blocName: BlocName.clearDataRead,
    ),
    Setting(
      labelSetting: 'themes-color'.tr(),
      iconSetting: const Icon(Icons.colorize),
      routeSetting: AppRoutes.settThemes,
      blocName: BlocName.themesRead,
    ),
    Setting(
      labelSetting: 'title-pin'.tr(),
      iconSetting: const Icon(Icons.password),
      routeSetting: AppRoutes.settPin,
      blocName: BlocName.pinRead,
    ),
    Setting(
      labelSetting: 'donation'.tr(),
      iconSetting: const Icon(Icons.money_rounded),
      routeSetting: AppRoutes.settDonation,
    ),
  ];
}
