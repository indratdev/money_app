import 'package:dartz/dartz.dart';
import 'package:money_app/domain/entities/transaction.dart';

import '../../data/failure.dart';

abstract class TransactionRepository {
  getInitTransaction();
  Future<Either<Failure, int>> getCreateNewTransaction(Transaction value);
  Future<Either<Failure, Map<String, dynamic>>> getReadTransaction(String date);
  Future<Either<Failure, void>> getDeleteTransaction(int idTransaction);
  Future<Either<Failure, int>> getUpdateTransaction(
      int idTransaction, Transaction valueTransaction);
  Future<Either<Failure, void>> getDeleteAllData();
}
