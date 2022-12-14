import 'package:dartz/dartz.dart';
import 'package:money_app/data/date_util.dart';
import 'package:money_app/domain/entities/report.dart';

import '../../data/failure.dart';
import '../repositories/report_repository.dart';

class ReportCases {
  final ReportRepository repository;

  ReportCases(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> executeReadChartDefault(
      String date, OptionDate optionDate) {
    return repository.getReadChartDefault(date, optionDate);
  }

  Future<Either<Failure, List<String>>> executeCheckAllYearTrx() {
    return repository.getAllYearTransaction();
  }

  Future<Either<Failure, List<Report>>> executeGenerateReportYearly(
      String year) {
    return repository.generateReportYearly(year);
  }
}
