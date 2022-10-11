import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/domain/usecases/transaction_cases.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionCases _getTransactionCases;

  TransactionBloc(this._getTransactionCases) : super(TransactionInitial()) {
    on<SelectedIsOutcomeEvent>((event, emit) {
      try {
        print("runniggg SelectedIsOutcomeEvent");
        emit(LoadingSelectedIsOutcome());
        emit(SuccessSelectedIsOutcome(result: event.value));
      } catch (e) {
        emit(FailureSelectedIsOutcome(
            messageError: "FailureSelectedIsOutcome e"));
      }
    });

    on<SelectedDateEvent>((event, emit) {
      try {
        print("runniggg SelectedDateEvent");
        emit(LoadingSelectedDate());
        emit(SuccessSelectedDate(result: event.value));
      } catch (e) {
        emit(FailureSelectedDate(messageError: "FailureSelectedDate e"));
      }
    });

    on<ChangeValueTextEditing>((event, emit) {
      try {
        emit(SuccessValueTextEditing(result: event.value));
      } catch (e) {
        print(e.toString());
      }
    });

    on<SaveTransactionNew>((event, emit) async {
      try {
        print("========== jalan ==========");
        emit(LoadingSaveTransactionNew());
        final result =
            await _getTransactionCases.executeCreateNewTransaction(event.value);
        result.fold(
          (l) => emit(FailureSaveTransactionNew(
              messageError: "FailureSaveTransactionNew l")),
          (data) => emit(SuccessSaveTransactionNew(result: data)),
        );
      } catch (e) {
        emit(FailureSaveTransactionNew(
            messageError: "FailureSaveTransactionNew e"));
      }
    });
  }
}
