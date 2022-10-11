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
}
