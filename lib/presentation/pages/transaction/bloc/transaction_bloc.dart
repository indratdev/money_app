import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_app/domain/usecases/transaction_cases.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionCases _getTransactionCases;
  TransactionBloc(this._getTransactionCases) : super(TransactionInitial()) {
    on<TransactionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
