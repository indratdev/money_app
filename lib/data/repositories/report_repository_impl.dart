import 'package:money_app/domain/repositories/report_repository.dart';

import '../datasources/local/local_data_source.dart';

class ReportRepositoryImpl implements ReportRepository {
  final LocalDataSource localDataSource;

  ReportRepositoryImpl({required this.localDataSource});

  @override
  getReadChartDefault(String date) {}
}
