import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/parameter_cases.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ParameterCases _getParameterCases;
  LoginBloc(this._getParameterCases) : super(LoginInitial()) {
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
  }
}
