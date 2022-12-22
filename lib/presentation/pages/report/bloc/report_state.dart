part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

abstract class FailureState extends ReportInitial {
  String messageError;

  FailureState({required this.messageError});

  @override
  List<Object> get props => [messageError];
}

// check all year transaction
class LoadingCheckAllYearTransaction extends ReportState {}

class FailureCheckAllYearTransaction extends FailureState {
  FailureCheckAllYearTransaction({required super.messageError});
}

class SuccessCheckAllYearTransaction extends ReportState {
  List<String> result;

  SuccessCheckAllYearTransaction({required this.result});

  @override
  List<Object> get props => [result];
}

// Change Year Transaction
class LoadingChangeYearTransaction extends ReportState {}

class FailureChangeYearTransaction extends FailureState {
  FailureChangeYearTransaction({required super.messageError});
}

class SuccessChangeYearTransaction extends ReportState {
  String valueYear;

  SuccessChangeYearTransaction({required this.valueYear});

  @override
  List<Object> get props => [valueYear];
}

// generate report Yearly
class LoadingGenerateReportByYear extends ReportState {}

class FailureGenerateReportByYear extends FailureState {
  FailureGenerateReportByYear({required super.messageError});
}

class SuccessGenerateReportByYear extends ReportState {
  List<Report> resultReport;

  SuccessGenerateReportByYear({required this.resultReport});

  @override
  List<Object> get props => [resultReport];
}
