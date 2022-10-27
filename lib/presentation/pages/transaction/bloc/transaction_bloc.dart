import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:money_app/data/constants.dart';
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

    //  on<CreateCategoryEvent>((event, emit) async {
    //   try {
    //     emit(LoadingCreateCategory());
    //     final result =
    //         await _getCategoryCases.executeCreateCategory(event.valueCategory);
    //     result.fold(
    //         (l) => emit(
    //             FailureCreateCategory(messageError: "FailureCreateCategory")),
    //         (data) => emit(SuccessCreateCategory(result: data)));
    //   } catch (e) {
    //     emit(FailureCreateCategory(messageError: "FailureCreateCategory e"));
    //   }
    // });

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

    on<ReadTransactionEvent>((event, emit) async {
      try {
        emit(LoadingReadTransaction());

        final contentTransaction =
            await _getTransactionCases.executeReadTransaction(
                event.transactionDateTime); // read content transaction

        print(">> >> result $contentTransaction");
        contentTransaction.fold(
            (l) => emit(FailureReadTransaction(
                messageError: "FailureReadTransaction :: $l")),
            (data) => emit(SuccessReadTransaction(result: data)));
      } catch (e) {
        print(e);
        emit(FailureReadTransaction(messageError: "FailureReadTransaction e"));
      }
    });

    // delete transaction
    on<DeleteTransactionEvent>((event, emit) async {
      try {
        emit(LoadingDeleteTransaction());

        final result = await _getTransactionCases
            .executeDeleteTransaction(event.idTransaction);
        result.fold(
            (l) => emit(FailureDeleteTransaction(
                messageError: "FailureDeleteTransaction")),
            (data) => emit(SuccessDeleteTransaction()));
      } catch (e) {
        print(e);
        emit(FailureDeleteTransaction(
            messageError: "FailureDeleteTransaction e"));
      }
    });

    on<UpdateTransactionEvent>((event, emit) async {
      try {
        emit(LoadingUpdateTransaction());
        final result = await _getTransactionCases.executeUpdateCategory(
            event.idCategory, event.valueCategory);
        result.fold(
            (l) => emit(FailureUpdateTransaction(
                messageError: "FailureUpdateTransaction")),
            (data) => emit(SuccessUpdateTransaction(result: data)));
      } catch (e) {
        emit(FailureUpdateTransaction(
            messageError: "FailureUpdateTransaction e"));
      }
    });
  }
}
