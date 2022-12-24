part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class CheckUsePincode extends LoginEvent {}

class LoginWithPasscodeEvent extends LoginEvent {
  String value;

  LoginWithPasscodeEvent({
    required this.value,
  });
}
