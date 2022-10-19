import '../repositories/report_repository.dart';

class ReportCases {
  final ReportRepository repository;

  ReportCases(this.repository);

  executeReadChartDefault(String date) {
    return repository.getReadChartDefault(date);
  }
}
