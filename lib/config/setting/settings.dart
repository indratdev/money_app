import 'package:flutter/material.dart';
import 'package:money_app/config/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/settings/category/bloc/category_bloc.dart';

enum BlocName {
  categoryRead,
}

class Setting {
  Icon iconSetting;
  String labelSetting;
  String routeSetting;
  // Type bloc;
  // Type event;
  // void aaa;
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
        context.read<CategoryBloc>().add(ReadCategory());
        print("jalan");
        break;
      default:
        context.read<CategoryBloc>().add(ReadCategory());
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
