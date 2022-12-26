import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
        emit(LoadingSelectedIsOutcome());
        emit(SuccessSelectedIsOutcome(result: event.value));
      } catch (e) {
        emit(FailureSelectedIsOutcome(
            messageError: "FailureSelectedIsOutcome e"));
      }
    });

    on<SelectedDateEvent>((event, emit) {
      try {
        emit(LoadingSelectedDate());
        emit(SuccessSelectedDate(result: event.value));
      } catch (e) {
        emit(FailureSelectedDate(messageError: "FailureSelectedDate e"));
      }
    });

    on<SelectedDateHomeEvent>((event, emit) async {
      Map<String, dynamic> result = {};
      try {
        emit(LoadingSelectedDateHome());
        final String selectedDate = event.value;
        result['selectedDate'] = selectedDate;

        final contentTransaction =
            await _getTransactionCases.executeReadTransaction(event.value);

        contentTransaction.fold(
          (l) => emit(FailureSelectedDateHome(
              messageError: 'failed-transaction-read'.tr())),
          (data) {
            result['data'] = data;
            emit(SuccessSelectedDateHome(result: result));
          },
        );
      } catch (e) {
        emit(
            FailureSelectedDateHome(messageError: "FailureSelectedDateHome e"));
      }
    });

    on<ChangeValueTextEditing>((event, emit) {
      try {
        emit(SuccessValueTextEditing(result: event.value));
      } catch (e) {
        log(e.toString());
      }
    });

    on<SaveTransactionNew>((event, emit) async {
      try {
        emit(LoadingSaveTransactionNew());
        final result =
            await _getTransactionCases.executeCreateNewTransaction(event.value);
        result.fold(
          (l) => emit(FailureSaveTransactionNew(
              messageError: 'failed-transaction-saving'.tr())),
          (data) => emit(SuccessSaveTransactionNew(result: data)),
        );
      } catch (e) {
        emit(FailureSaveTransactionNew(
            messageError: 'failed-transaction-saving'.tr()));
      }
    });

    on<ReadTransactionEvent>((event, emit) async {
      try {
        emit(LoadingReadTransaction());
        final contentTransaction =
            await _getTransactionCases.executeReadTransaction(
                event.transactionDateTime); // read content transaction
        contentTransaction.fold(
          (l) => emit(FailureReadTransaction(
              messageError: 'failed-transaction-read'.tr())),
          (data) {
            emit(SuccessReadTransaction(result: data));
          },
        );
      } catch (e) {
        emit(FailureReadTransaction(
            messageError: 'failed-transaction-read'.tr()));
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
                messageError: 'failed-transaction-delete'.tr())),
            (data) => emit(SuccessDeleteTransaction()));
      } catch (e) {
        emit(FailureDeleteTransaction(
            messageError: 'failed-transaction-delete'.tr()));
      }
    });

    on<DeleteAllData>((event, emit) async {
      try {
        emit(LoadingDeleteAllData());
        final result = await _getTransactionCases.executeDeleteAllData();
        result.fold(
          (l) => emit(
              FailureDeleteAllData(messageError: 'failed-clear-data-all'.tr())),
          (data) => emit(
            SuccessDeleteAllData(),
          ),
        );
      } catch (e) {
        emit(FailureDeleteAllData(messageError: 'failed-clear-data-all'.tr()));
      }
    });

    on<UpdateTransactionEvent>((event, emit) async {
      try {
        emit(LoadingUpdateTransaction());

        final result = await _getTransactionCases.executeUpdateTransaction(
            event.idTransaction, event.valueTransaction);
        result.fold(
            (l) => emit(FailureUpdateTransaction(
                messageError: 'failed-transaction-update'.tr())),
            (data) => emit(SuccessUpdateTransaction()));
      } catch (e) {
        emit(FailureUpdateTransaction(
            messageError: 'failed-transaction-update'.tr()));
      }
    });
  }
}
