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
