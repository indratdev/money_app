import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:money_app/domain/usecases/parameter_cases.dart';

import '../../../../../config/themes/app_themes.dart';

part 'themes_event.dart';
part 'themes_state.dart';

class ThemesBloc extends Bloc<ThemesEvent, ThemesState> {
  final ParameterCases _getParameterCases;
  ThemesBloc(this._getParameterCases) : super(ThemesInitial()) {
    on<ReadThemesEvent>((event, emit) async {
      try {
        final result = await _getParameterCases.executeReadThemes();
        // print("ReadThemesEvent ... $result");
        result.fold(
          (l) => emit(FailureReadThemes(messageError: "FailureReadThemes")),
          (data) {
            bool result = false;
            (data.first.entries.first.value == "0")
                ? result = false
                : result = true;
            emit(SuccessReadThemes(result: result));
          },
        );
      } catch (e) {
        print(e);
        emit(FailureReadThemes(messageError: "FailureReadThemes e"));
      }
    });

    // on<UpdateThemesEvent>((event, emit) {
    //   try {
    //     // print("event ::: ${event.value}");
    //     // var choose = "";
    //     // (event.value.name == "lightColor") ? choose = "0" : choose = "1";
    //     // final result = _getParameterCases.executeUpdateThemes(choose);
    //   } catch (e) {}
    // });

    on<ChangeThemeEvent>((event, emit) {
      try {
        final result = event.appTheme;

        switch (result) {
          case AppTheme.darkAppTheme:
            final updateTheme = _getParameterCases.executeUpdateThemes("1");
            // print("AppTheme.darkAppTheme ==> klikk");
            emit(SuccessChangeThemes(appTheme: AppTheme.darkAppTheme));
            break;
          case AppTheme.lightAppTheme:
            // print("AppTheme.lightAppTheme ==> klikk");
            final updateTheme = _getParameterCases.executeUpdateThemes("0");

            emit(SuccessChangeThemes(appTheme: AppTheme.lightAppTheme));
            break;
          default:
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
