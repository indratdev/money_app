import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/parameter_cases.dart';
import '../../../../domain/usecases/pin_cases.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ParameterCases _getParameterCases;
  final PinCases _getPinCases;

  LoginBloc(
    this._getParameterCases,
    this._getPinCases,
  ) : super(LoginInitial()) {
    on<CheckUsePincode>((event, emit) async {
      try {
        emit(LoadingCheckUsePincode());
        final result = await _getParameterCases.executeCheckPasscodeExist();
        result.fold(
            (l) => emit(FailureCheckUsePincode(
                messageError: 'passcode-check-failure'.tr())),
            (data) => emit(SuccessCheckUsePincode(status: data)));
      } catch (e) {
        emit(FailureCheckUsePincode(
            messageError: 'passcode-check-failure'.tr()));
      }
    });

    // login with passcode
    on<LoginWithPasscodeEvent>((event, emit) async {
      try {
        emit(LoadingLoginWithPasscode());
        final isValidPasscode =
            await _getPinCases.executeIsValidPasscode(event.value);
        (isValidPasscode)
            ? emit(SuccessLoginWithPasscode(status: isValidPasscode))
            : emit(PasscodeFailedLoginWithPasscode());
      } catch (e) {
        emit(FailureLoginWithPasscode(messageError: e.toString()));
      }
    });
  }
}
