import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:money_app/data/date_util.dart';
import 'package:money_app/data/models/report_model.dart';
import 'package:money_app/data/repositories/transaction_repository_impl.dart';
import 'package:money_app/domain/entities/report.dart';
import 'package:money_app/domain/repositories/report_repository.dart';

import '../datasources/local/local_data_source.dart';
import '../failure.dart';
import '../exception.dart';

class ReportRepositoryImpl implements ReportRepository {
  final LocalDataSource localDataSource;
  final DateOperation dateOperation = DateOperation();

  ReportRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Map<String, dynamic>>> getReadChartDefault(
      String date, OptionDate optionDate) async {
    try {
      Map<String, dynamic> result = {};

      final chartCalcutaionExpense =
          await localDataSource.readChartDefault(date, 1, optionDate);
      final chartCalcutaionIncome =
          await localDataSource.readChartDefault(date, 0, optionDate);

      result[TransactionEnum.dateselected.name] = date;
      result[TransactionType.income.name] = chartCalcutaionIncome;
      result[TransactionType.expenses.name] = chartCalcutaionExpense;

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the database'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllYearTransaction() async {
    try {
      final result = await localDataSource.readAllYearTransaction();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the database'));
    }
  }

  // @override
  // generateReportYearly(String year) async {
  //   try {
  //     var resultQuery;
  //     final resultYear = dateOperation.getFirstLastDay(int.parse(year));
  //     resultYear.forEach((key, value) async {
  //       final String firstDay = dateOperation
  //           .formatedddMMMyyyy(value[OptionFirstLast.first].toString());
  //       final String lastDay = DateUtil()
  //           .formatedddMMMyyyy(value[OptionFirstLast.last].toString());
  //       final String periode =
  //           DateUtil().formatedyyyyMM(value[OptionFirstLast.first].toString());

  //       resultQuery = await localDataSource.generatedTransactionByYear(
  //           firstDay, lastDay, periode);

  //       // print(">>> resultQuery : $resultQuery");

  //       // print("key: $key, ==> ${value[OptionFirstLast.first]} ");
  //     });

  //     print(">>> resultQuery : $resultQuery");

  //     // print(">>> result ::: $resultYear");
  //   } catch (e) {
  //     print("Error : $e");
  //   }
  // }

  @override
  Future<Either<Failure, List<ReportModel>>> generateReportYearly(
      String year) async {
    try {
      final result = await localDataSource.generatedTransactionByYear(year);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the database'));
    }
  }
}
