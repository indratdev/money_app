import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/setting/settings.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  final mSetting = MenuSetting();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('titleSetting'.tr()),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 7,
            child: SizedBox(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: mSetting.getListSettings.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                          mSetting.getListSettings[index].routeSetting);

                      // call bloc
                      mSetting.callBloc(
                          context, mSetting.getListSettings[index].blocName);
                    },
                    child: ListTile(
                      iconColor: Colors.blue,
                      leading: mSetting.getListSettings[index].iconSetting,
                      title: Text(mSetting.getListSettings[index].labelSetting
                          .toString()),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
