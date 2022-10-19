import 'package:dartz/dartz.dart';

import '../../data/failure.dart';

abstract class ReportRepository {
  Future<Either<Failure, Map<String, dynamic>>> getReadChartDefault(
      String date);
}
