import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_app/domain/usecases/parameter_cases.dart';

import '../themes_screen.dart';

part 'themes_event.dart';
part 'themes_state.dart';

class ThemesBloc extends Bloc<ThemesEvent, ThemesState> {
  final ParameterCases _getParameterCases;
  ThemesBloc(this._getParameterCases) : super(ThemesInitial()) {
    on<ReadThemesEvent>((event, emit) async {
      try {
        final result = await _getParameterCases.executeReadThemes();
        print("ReadThemesEvent ... $result");
        result.fold(
          (l) => emit(FailureReadThemes(messageError: "FailureReadThemes")),
          // (data) => emit(SuccessReadThemes(result: data)),
          (data) {
            bool result = false;
            (data == "0") ? result = false : result = true;
            emit(SuccessReadThemes(result: result));
          },
        );
      } catch (e) {
        print(e);
        emit(FailureReadThemes(messageError: "FailureReadThemes e"));
      }
    });

    on<UpdateThemesEvent>((event, emit) {
      try {
        String valueThemes = "";
        (event.value.name == "lightColor") ? valueThemes = 
        final result = _getParameterCases.executeUpdateThemes(event.value);
      } catch (e) {}
    });
  }
}
