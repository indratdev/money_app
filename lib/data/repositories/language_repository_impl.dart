import 'dart:io';

import 'package:money_app/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:money_app/domain/repositories/language_repositories.dart';

import '../datasources/local/local_data_source.dart';
import '../exception.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final LocalDataSource localDataSource;

  LanguageRepositoryImpl({required this.localDataSource});

  // @override
  // Future<Either<Failure, String>> getReadLanguage() async {
  //   try {
  //     print("getReadLanguage runinggg");

  //     // final result = await localDataSource.readLanguage();

  //     // print("result getReadLanguage :: $result");

  //     // result[TransactionEnum.transaction.name] = transaction;
  //     // result[TransactionEnum.dateselected.name] = date;
  //     // result[TransactionEnum.calculation.name] = calculation;
  //     // print("resultresult : $result");

  //     // return Right(result);
  //   } on ServerException {
  //     return Left(const ServerFailure(''));
  //   } on SocketException {
  //     return Left(const ConnectionFailure('Failed to connect to the database'));
  // }
  // }
}
