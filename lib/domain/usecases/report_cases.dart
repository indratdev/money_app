import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../repositories/report_repository.dart';

class ReportCases {
  final ReportRepository repository;

  ReportCases(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> executeReadChartDefault(
      String date) {
    return repository.getReadChartDefault(date);
  }
}
