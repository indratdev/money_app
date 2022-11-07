part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

abstract class FailureState extends TransactionState {
  String messageError;

  FailureState({required this.messageError});

  @override
  List<Object> get props => [messageError];
}

class TransactionInitial extends TransactionState {}

// selected isoutcome
class LoadingSelectedIsOutcome extends TransactionState {}

class FailureSelectedIsOutcome extends FailureState {
  FailureSelectedIsOutcome({required super.messageError});
}

class SuccessSelectedIsOutcome extends TransactionState {
  int result;

  SuccessSelectedIsOutcome({required this.result});

  @override
  List<Object> get props => [result];
}

// selected date
class LoadingSelectedDate extends TransactionState {}

class FailureSelectedDate extends FailureState {
  FailureSelectedDate({required super.messageError});
}

class SuccessSelectedDate extends TransactionState {
  String result;

  SuccessSelectedDate({required this.result});

  @override
  List<Object> get props => [result];
}

class SuccessValueTextEditing extends TransactionState {
  String result;

  SuccessValueTextEditing({required this.result});

  @override
  List<Object> get props => [result];
}

// create transaction new
class LoadingSaveTransactionNew extends TransactionState {}

class FailureSaveTransactionNew extends FailureState {
  FailureSaveTransactionNew({required super.messageError});
}

class SuccessSaveTransactionNew extends TransactionState {
  final int result;

  SuccessSaveTransactionNew({required this.result});

  @override
  List<Object> get props => [result];
}

// create init transaction
class LoadingReadTransaction extends TransactionState {}

class FailureReadTransaction extends FailureState {
  FailureReadTransaction({required super.messageError});
}

class SuccessReadTransaction extends TransactionState {
  // List<Transaction> result;
  Map<String, dynamic> result;

  SuccessReadTransaction({required this.result});

  @override
  List<Object> get props => [result];
}

// delete transaction
class LoadingDeleteTransaction extends TransactionState {}

class FailureDeleteTransaction extends FailureState {
  FailureDeleteTransaction({required super.messageError});
}

class SuccessDeleteTransaction extends TransactionState {}

// update transaction
class LoadingUpdateTransaction extends TransactionState {}

class FailureUpdateTransaction extends FailureState {
  FailureUpdateTransaction({required super.messageError});
}

class SuccessUpdateTransaction extends TransactionState {}

// delete all data
class LoadingDeleteAllData extends TransactionState {}

class FailureDeleteAllData extends FailureState {
  FailureDeleteAllData({required super.messageError});
}

class SuccessDeleteAllData extends TransactionState {}
