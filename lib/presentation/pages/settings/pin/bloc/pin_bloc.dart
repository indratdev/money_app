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
        result.fold(
            (l) =>
                emit(FailureCheckPinUsed(messageError: "FailureCheckPinUsed")),
            (data) => emit(SuccessCheckPinUsed(result: data)));
      } catch (e) {
        emit(FailureCheckPinUsed(messageError: "FailureCheckPinUsed e"));
      }
    });

    on<ChangePasscodeEvent>((event, emit) {
      try {
        print(">>> ChangePasscodeEvent Running...");
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

    on<ChangePasscodeConfirmationEvent>((event, emit) {
      try {
        print(">>> ChangePasscodeEvent Running...");
        emit(LoadingChangePasscode());
        final result = _getParameterCases.executeChangePasscode(event.value);

        result.fold(
            (l) => emit(
                  FailureChangePasscode(
                      messageError: "Error FailureChangePasscode"),
                ), (data) {
          print(">>> gassss: $data");
          emit(
            SuccessChangePasscodeConfirmation(result: data),
          );
        });
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

    on<SavingPasscodeEvent>((event, emit) async {
      try {
        emit(LoadingSavingPasscode());
        final result =
            await _getParameterCases.executeSavingPasscode(event.value);
        result.fold(
            (l) => emit(
                FailureSavingPasscode(messageError: "FailureSavingPasscode")),
            (data) => emit(SuccessSavingPasscode(result: data)));
      } catch (e) {
        emit(FailureSavingPasscode(messageError: "FailureSavingPasscode e"));
      }
    });
  }
}
