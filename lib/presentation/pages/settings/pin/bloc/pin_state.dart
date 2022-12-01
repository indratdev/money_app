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
