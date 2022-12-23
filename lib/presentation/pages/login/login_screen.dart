import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/pages/login/bloc/login_bloc.dart';

import '../../../config/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // check passcode
    checkPinCode(bool status) {
      if (status == false) {
        Future.delayed(
          Duration.zero,
          () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.first, (route) => false);
          },
        );
      } else {}
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is SuccessCheckUsePincode) {
            checkPinCode(state.status);
          }
          return Column();
        },
      ),
    );
  }
}
