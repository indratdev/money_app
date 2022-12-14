part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

abstract class FailureState extends LoginState {
  String messageError;

  FailureState({required this.messageError});

  @override
  List<Object> get props => [messageError];
}

// check use pincode
class LoadingCheckUsePincode extends LoginState {}

class FailureCheckUsePincode extends FailureState {
  FailureCheckUsePincode({required super.messageError});
}

class SuccessCheckUsePincode extends LoginState {
  bool status;

  SuccessCheckUsePincode({
    required this.status,
  });

  @override
  List<Object> get props => [status];
}

// login with passcode

class LoadingLoginWithPasscode extends LoginState {}

class FailureLoginWithPasscode extends FailureState {
  FailureLoginWithPasscode({required super.messageError});
}

class PasscodeFailedLoginWithPasscode extends LoginState {}

class SuccessLoginWithPasscode extends LoginState {
  bool status;

  SuccessLoginWithPasscode({
    required this.status,
  });

  @override
  List<Object> get props => [status];
}
