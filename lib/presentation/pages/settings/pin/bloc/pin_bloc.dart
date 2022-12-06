import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/constants.dart';
import '../../../../../domain/usecases/parameter_cases.dart';
import '../../../../../domain/usecases/pin_cases.dart';

part 'pin_event.dart';
part 'pin_state.dart';

class PinBloc extends Bloc<PinEvent, PinState> {
  final ParameterCases _getParameterCases;
  final PinCases _getPinCases;

  PinBloc(
    this._getParameterCases,
    this._getPinCases,
  ) : super(PinInitial()) {
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

    // remove passcode devices
    on<RemovePasscodeEvent>((event, emit) async {
      String valueEncrypt = "";
      String valuePasscode = "";
      bool resultCompare = false;
      try {
        emit(LoadingRemovePasscode());

        final resultEncrypt = await _getPinCases.executeEncryptDecrypt(
            true, event.value); // enkrip data dari ui

        final resultValuePasscode = await _getParameterCases
            .executeReadPasscodeDB(); // get value passcode sql

        resultEncrypt.fold((l) {
          valueEncrypt = "";
        }, (r) {
          valueEncrypt = r;
        });

        resultValuePasscode.fold((l) {
          valuePasscode = "";
        }, (r) {
          valuePasscode = r;
        });

        resultCompare =
            _getPinCases.executeCompareTwoString(valueEncrypt, valuePasscode);

        if (resultCompare) {
          final resetPasscode =
              await _getParameterCases.executeSavingPasscode(defaultPasscode);

          resetPasscode.fold(
              (l) => emit(
                  FailureRemovePasscode(messageError: "FailureRemovePasscode")),
              (data) => emit(SuccessRemovePasscode(result: data)));
        } else {
          emit(FailureRemovePasscode(
              messageError: "Error FailureRemovePasscode"));
        }
      } catch (e) {
        emit(FailureRemovePasscode(messageError: "FailureRemovePasscode e"));
      }
    });
  }
}
