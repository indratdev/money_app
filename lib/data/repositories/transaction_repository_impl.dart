import 'dart:io';

import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:money_app/domain/repositories/transaction_repository.dart';

import '../datasources/local/local_data_source.dart';
import '../exception.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final LocalDataSource localDataSource;

  TransactionRepositoryImpl({required this.localDataSource});

  @override
  getInitTransaction() {}

  @override
  Future<Either<Failure, int>> getCreateNewTransaction(
      Transaction value) async {
    try {
      final result = await localDataSource.createNewTransaction(value);
      print("jalannn getCreateCategory: ${Right(result)}");
      return Right(result);
    } on ServerException {
      return Left(const ServerFailure(''));
    } on SocketException {
      return Left(const ConnectionFailure('Failed to connect to the database'));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getReadTransaction() async {
    try {
      final result = await localDataSource.readTransaction();
      return Right(result);
    } on ServerException {
      return Left(const ServerFailure(''));
    } on SocketException {
      return Left(const ConnectionFailure('Failed to connect to the database'));
    }
  }
}
