import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/setting/settings.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  final mSetting = MenuSetting();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          // Flexible(
          //   flex: 7,
          //   child: Container(
          //     // color: Colors.grey,
          //     child: ListView.separated(
          //       separatorBuilder: (context, index) => const Divider(),
          //       itemCount: mSetting.getListSettings.length,
          //       itemBuilder: (context, index) {
          //         return GestureDetector(
          //           onTap: () {
          //             Navigator.of(context, rootNavigator: true).pushNamed(
          //                 mSetting.getListSettings[index].routeSetting);
          //           },
          //           child: ListTile(
          //             iconColor: Colors.blue,
          //             leading: mSetting.getListSettings[index].iconSetting,
          //             title: Text(mSetting.getListSettings[index].labelSetting
          //                 .toString()),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
          // followMeWidget(),
        ],
      ),
    );
  }
}

class followMeWidget extends StatelessWidget {
  const followMeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        // color: Colors.yellow,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                'Ikuti Kami',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.facebookSquare,
                        color: Colors.blue,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.instagramSquare,
                        color: Colors.blue,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.twitterSquare,
                        color: Colors.blue,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
