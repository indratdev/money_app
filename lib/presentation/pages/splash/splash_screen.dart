import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:money_app/data/constants.dart' as constants;
import 'package:money_app/presentation/pages/login/bloc/login_bloc.dart';
import 'package:money_app/presentation/pages/settings/pin/bloc/pin_bloc.dart';

import '../../../config/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.login, (route) => false);
    });
    BlocProvider.of<LoginBloc>(context)
        .add(CheckUsePincode()); // check use pincode ?
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text(constants.appName)),
    );
  }
}
