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

class SelectedDateHomeEvent extends TransactionEvent {
  String value;

  SelectedDateHomeEvent({required this.value});
}

class ChangeValueTextEditing extends TransactionEvent {
  String value;

  ChangeValueTextEditing({required this.value});
}

class SaveTransactionNew extends TransactionEvent {
  Transaction value;

  SaveTransactionNew({required this.value});
}

class ReadTransactionEvent extends TransactionEvent {
  String transactionDateTime;

  ReadTransactionEvent({required this.transactionDateTime});
}

class DeleteTransactionEvent extends TransactionEvent {
  int idTransaction;

  DeleteTransactionEvent({
    required this.idTransaction,
  });
}

// update category
class UpdateTransactionEvent extends TransactionEvent {
  int idTransaction;
  Transaction valueTransaction;

  UpdateTransactionEvent({
    required this.idTransaction,
    required this.valueTransaction,
  });
}

class DeleteAllData extends TransactionEvent {}
