import 'package:dartz/dartz.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/domain/repositories/transaction_repository.dart';

import '../../data/failure.dart';

class TransactionCases {
  final TransactionRepository repository;

  TransactionCases(this.repository);

  // init transaction
  getInitTransaction() {
    repository.getInitTransaction();
  }

  // create transaction
  Future<Either<Failure, int>> executeCreateNewTransaction(
      Transaction valueTransaction) {
    return repository.getCreateNewTransaction(valueTransaction);
  }

  // read transaction
  // Future<Either<Failure, List<Transaction>>> executeReadTransaction(
  Future<Either<Failure, Map<String, dynamic>>> executeReadTransaction(
      String date) {
    return repository.getReadTransaction(date);
  }

  // delete transaction
  Future<Either<Failure, void>> executeDeleteTransaction(int idTransaction) {
    return repository.getDeleteTransaction(idTransaction);
  }

  // update category
  Future<Either<Failure, int>> executeUpdateCategory(
      int idTransaction, Transaction valueTransaction) {
    return repository.getUpdateTransaction(idTransaction, valueTransaction);
  }

  // // read calculation
  // executeReadCalculation() {
  //   repository.getReadCalculation();
  // }

}
