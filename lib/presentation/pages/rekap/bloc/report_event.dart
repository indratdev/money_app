part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class CheckAllYearTransactionEvent extends ReportEvent {}

class ChangeYearTransactionEvent extends ReportEvent {
  String valueYear;

  ChangeYearTransactionEvent({required this.valueYear});
}
