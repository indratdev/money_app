import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
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
        result.fold(
          (l) =>
              emit(FailureReadThemes(messageError: 'error-read-themes'.tr())),
          (data) {
            AppTheme result = AppTheme.lightAppTheme;
            (data.first.entries.first.value == "0")
                ? result = AppTheme.lightAppTheme
                : result = AppTheme.darkAppTheme;
            emit(SuccessReadThemes(result: result));
          },
        );
      } catch (e) {
        emit(FailureReadThemes(messageError: 'error-read-themes'.tr()));
      }
    });

    on<ChangeThemeEvent>((event, emit) {
      try {
        final result = event.appTheme;

        switch (result) {
          case AppTheme.darkAppTheme:
            final updateTheme = _getParameterCases.executeUpdateThemes("1");
            emit(SuccessChangeThemes(appTheme: AppTheme.darkAppTheme));
            break;
          case AppTheme.lightAppTheme:
            final updateTheme = _getParameterCases.executeUpdateThemes("0");
            emit(SuccessChangeThemes(appTheme: AppTheme.lightAppTheme));
            break;
          default:
        }
      } catch (e) {
        emit(FailureChangeThemes(messageError: 'error-change-themes'.tr()));
      }
    });
  }
}
