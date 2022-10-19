import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:money_app/data/repositories/transaction_repository_impl.dart';
import 'package:money_app/domain/repositories/report_repository.dart';

import '../datasources/local/local_data_source.dart';
import '../failure.dart';
import '../exception.dart';

class ReportRepositoryImpl implements ReportRepository {
  final LocalDataSource localDataSource;

  ReportRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Map<String, dynamic>>> getReadChartDefault(
      String date) async {
    try {
      Map<String, dynamic> result = {};

      result[TransactionEnum.dateselected.name] = date;

      return Right(result);
    } on ServerException {
      return Left(const ServerFailure(''));
    } on SocketException {
      return Left(const ConnectionFailure('Failed to connect to the database'));
    }
  }
}
