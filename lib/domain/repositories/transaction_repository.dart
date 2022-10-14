import 'package:dartz/dartz.dart';
import 'package:money_app/domain/entities/transaction.dart';

import '../../data/failure.dart';

abstract class TransactionRepository {
  getInitTransaction();
  Future<Either<Failure, int>> getCreateNewTransaction(Transaction value);
  Future<Either<Failure, List<Transaction>>> getReadTransaction(String date);
  getReadCalculation();
}
