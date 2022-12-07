import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
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
          (l) => emit(
              FailureCheckPinUsed(messageError: 'passcode-check-failure'.tr())),
          (data) => emit(
            SuccessCheckPinUsed(result: data),
          ),
        );
      } catch (e) {
        emit(FailureCheckPinUsed(messageError: 'passcode-check-failure'.tr()));
      }
    });

    on<ChangePasscodeEvent>((event, emit) {
      try {
        emit(LoadingChangePasscode());
        final result = _getParameterCases.executeChangePasscode(event.value);
        result.fold(
          (l) => emit(
            FailureChangePasscode(messageError: 'passcode-change-failure'.tr()),
          ),
          (data) => emit(
            SuccessChangePasscode(result: data),
          ),
        );
      } catch (e) {
        emit(FailureChangePasscode(
            messageError: 'passcode-change-failure'.tr()));
      }
    });

    on<ChangePasscodeConfirmationEvent>((event, emit) {
      try {
        emit(LoadingChangePasscode());
        final result = _getParameterCases.executeChangePasscode(event.value);

        result.fold(
            (l) => emit(
                  FailureChangePasscode(
                      messageError: 'passcode-change-failure'.tr()),
                ), (data) {
          emit(
            SuccessChangePasscodeConfirmation(result: data),
          );
        });
      } catch (e) {
        emit(FailureChangePasscode(
            messageError: 'passcode-change-failure'.tr()));
      }
    });

    on<RemoveDigitPasscodeEvent>((event, emit) {
      try {
        emit(LoadingRemoveDigitPasscode());
        final result = _getParameterCases.executeRemoveDigitPasscode();
        result.fold(
          (l) => emit(
            FailureRemoveDigitPasscode(
                messageError: 'passcode-change-failure'.tr()),
          ),
          (data) => emit(
            SuccessRemoveDigitPasscode(result: data),
          ),
        );
      } catch (e) {
        FailureRemoveDigitPasscode(
            messageError: 'passcode-change-failure'.tr());
      }
    });

    on<SavingPasscodeEvent>((event, emit) async {
      try {
        emit(LoadingSavingPasscode());
        final result =
            await _getParameterCases.executeSavingPasscode(event.value);
        result.fold(
            (l) => emit(FailureSavingPasscode(
                messageError: 'passcode-save-failure'.tr())),
            (data) => emit(SuccessSavingPasscode(result: data)));
      } catch (e) {
        emit(FailureSavingPasscode(messageError: 'passcode-save-failure'.tr()));
      }
    });

    // remove passcode devices
    on<RemovePasscodeEvent>((event, emit) async {
      try {
        emit(LoadingRemovePasscode());
        // check passcode is valid
        final isValidPasscode =
            await _getPinCases.executeIsValidPasscode(event.value);

        if (isValidPasscode) {
          final resetPasscode =
              await _getParameterCases.executeSavingPasscode(defaultPasscode);

          resetPasscode.fold(
            (l) => emit(
                FailureRemovePasscode(messageError: 'pin-remove-failed'.tr())),
            (data) => emit(
              SuccessRemovePasscode(result: data),
            ),
          );
        } else {
          emit(FailureRemovePasscode(messageError: 'pin-remove-failed'.tr()));
        }
      } catch (e) {
        emit(FailureRemovePasscode(messageError: 'pin-remove-failed'.tr()));
      }
    });

    on<CheckPasscodeEvent>((event, emit) async {
      try {
        emit(LoadingCheckPasscode());
        // check passcode is valid
        final isValidPasscode =
            await _getPinCases.executeIsValidPasscode(event.value);
        if (isValidPasscode) {
          emit(SuccessCheckPasscode(result: isValidPasscode));
        } else {
          emit(FailureCheckPasscodeStatus(messageError: 'wrong-passcode'.tr()));
        }
      } catch (e) {
        emit(FailureCheckPasscode(messageError: 'passcode-check-failure'.tr()));
      }
    });
  }
}
