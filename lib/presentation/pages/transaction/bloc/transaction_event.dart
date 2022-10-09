part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class SelectedIsOutcomeEvent extends TransactionEvent {
  int value;

  SelectedIsOutcomeEvent({required this.value});
}

class SelectedDateEvent extends TransactionEvent {
  String value;

  SelectedDateEvent({required this.value});
}

class ChangeValueTextEditing extends TransactionEvent {
  String value;

  ChangeValueTextEditing({required this.value});
}
