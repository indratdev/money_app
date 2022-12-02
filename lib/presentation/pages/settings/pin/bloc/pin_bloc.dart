import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/usecases/parameter_cases.dart';

part 'pin_event.dart';
part 'pin_state.dart';

class PinBloc extends Bloc<PinEvent, PinState> {
  final ParameterCases _getParameterCases;

  @override
  Future<void> close() {
    // dispose
    return super.close();
  }

  PinBloc(this._getParameterCases) : super(PinInitial()) {
    on<CheckPinUsed>((event, emit) async {
      try {
        final result = await _getParameterCases.executeCheckPasscodeExist();
        print(">>>haisnya ::: $result");
      } catch (e) {}
    });

    on<ChangePasscodeEvent>((event, emit) {
      try {
        emit(LoadingChangePasscode());
        final result = _getParameterCases.executeChangePasscode(event.value);

        result.fold(
          (l) => emit(
            FailureChangePasscode(messageError: "Error FailureChangePasscode"),
          ),
          (data) => emit(
            SuccessChangePasscode(result: data),
          ),
        );
      } catch (e) {
        emit(FailureChangePasscode(messageError: "FailureChangePasscode e"));
      }
    });

    on<RemoveDigitPasscodeEvent>((event, emit) {
      try {
        emit(LoadingRemoveDigitPasscode());
        final result = _getParameterCases.executeRemoveDigitPasscode();
        result.fold(
          (l) => emit(
            FailureRemoveDigitPasscode(
                messageError: "Error FailureChangePasscode"),
          ),
          (data) => emit(
            SuccessRemoveDigitPasscode(result: data),
          ),
        );
      } catch (e) {
        FailureRemoveDigitPasscode(
            messageError: "Error FailureRemoveDigitPasscode e");
      }
    });
  }
}
