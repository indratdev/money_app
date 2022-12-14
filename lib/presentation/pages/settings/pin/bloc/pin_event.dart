part of 'pin_bloc.dart';

abstract class PinEvent extends Equatable {
  const PinEvent();

  @override
  List<Object> get props => [];
}

class CheckPinUsed extends PinEvent {}

class ChangePasscodeEvent extends PinEvent {
  int value;

  ChangePasscodeEvent({required this.value});
}

class ChangePasscodeConfirmationEvent extends PinEvent {
  int value;

  ChangePasscodeConfirmationEvent({required this.value});
}

class RemoveDigitPasscodeEvent extends PinEvent {}

class SavingPasscodeEvent extends PinEvent {
  String value;

  SavingPasscodeEvent({required this.value});
}

class RemovePasscodeEvent extends PinEvent {
  String value;

  RemovePasscodeEvent({required this.value});
}

class CheckPasscodeEvent extends PinEvent {
  String value;

  CheckPasscodeEvent({required this.value});
}
