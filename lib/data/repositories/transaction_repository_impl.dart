import 'dart:io';

import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:money_app/domain/repositories/transaction_repository.dart';

import '../datasources/local/local_data_source.dart';
import '../exception.dart';

enum TransactionEnum {
  transaction,
  dateselected,
  calculation,
}

enum TransactionType {
  income,
  expenses,
}

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

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the database'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getReadTransaction(
      String date) async {
    try {
      Map<String, dynamic> result = {};

      final transaction = await localDataSource.readTransaction(date);
      final calculation = await localDataSource.readCalculation(date);

      result[TransactionEnum.transaction.name] = transaction;
      result[TransactionEnum.dateselected.name] = date;
      result[TransactionEnum.calculation.name] = calculation;

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the database'));
    }
  }

  @override
  Future<Either<Failure, void>> getDeleteTransaction(int idTransaction) async {
    try {
      final result = await localDataSource.deleteTransaction(idTransaction);
      return right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the database'));
    }
  }

  // delete all data
  @override
  Future<Either<Failure, void>> getDeleteAllData() async {
    try {
      final result = await localDataSource.deleteAllData();
      return right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the database'));
    }
  }

  @override
  Future<Either<Failure, int>> getUpdateTransaction(
      int idTransaction, Transaction valueTransaction) async {
    try {
      final result = await localDataSource.updateTransaction(
          idTransaction, valueTransaction);

      return right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the database'));
    }
  }
}
