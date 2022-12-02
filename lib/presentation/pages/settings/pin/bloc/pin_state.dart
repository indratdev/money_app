part of 'pin_bloc.dart';

abstract class PinState extends Equatable {
  const PinState();

  @override
  List<Object> get props => [];
}

abstract class FailureState extends PinState {
  String messageError;

  FailureState({required this.messageError});

  @override
  List<Object> get props => [messageError];
}

class PinInitial extends PinState {}

class LoadingCheckPinUsed extends PinState {}

class FailureCheckPinUsed extends FailureState {
  FailureCheckPinUsed({required super.messageError});
}

class SuccessCheckPinUsed extends PinState {
  bool result;

  SuccessCheckPinUsed({required this.result});

  @override
  List<Object> get props => [result];
}

// changepasscode
class LoadingChangePasscode extends PinState {}

class FailureChangePasscode extends FailureState {
  FailureChangePasscode({required super.messageError});
}

class SuccessChangePasscode extends PinState {
  Map<String, dynamic> result;

  SuccessChangePasscode({required this.result});

  @override
  List<Object> get props => [result];
}

// RemoveDigitPasscode
class LoadingRemoveDigitPasscode extends PinState {}

class FailureRemoveDigitPasscode extends FailureState {
  FailureRemoveDigitPasscode({required super.messageError});
}

class SuccessRemoveDigitPasscode extends PinState {
  Map<String, dynamic> result;

  SuccessRemoveDigitPasscode({required this.result});

  @override
  List<Object> get props => [result];
}
