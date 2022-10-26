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
      print("jalannn getCreateCategory: ${Right(result)}");
      return Right(result);
    } on ServerException {
      return Left(const ServerFailure(''));
    } on SocketException {
      return Left(const ConnectionFailure('Failed to connect to the database'));
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
      print("resultresult : $result");

      return Right(result);
    } on ServerException {
      return Left(const ServerFailure(''));
    } on SocketException {
      return Left(const ConnectionFailure('Failed to connect to the database'));
    }
  }

  // @override
  // getReadCalculation() {
  //   try {} catch (e) {
  //     print(e);
  //   }
  // }
}
