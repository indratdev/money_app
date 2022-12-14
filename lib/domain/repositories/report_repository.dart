import 'package:dartz/dartz.dart';
import 'package:money_app/data/date_util.dart';
import 'package:money_app/domain/entities/report.dart';

import '../../data/failure.dart';

abstract class ReportRepository {
  Future<Either<Failure, Map<String, dynamic>>> getReadChartDefault(
      String date, OptionDate optionDate);
  Future<Either<Failure, List<String>>> getAllYearTransaction();
  Future<Either<Failure, List<Report>>> generateReportYearly(String year);
}
