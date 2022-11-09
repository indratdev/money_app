import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:money_app/domain/usecases/parameter_cases.dart';

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
          (data) => emit(SuccessReadThemes(result: data)),
        );
      } catch (e) {
        print(e);
        emit(FailureReadThemes(messageError: "FailureReadThemes e"));
      }
    });
  }
}
