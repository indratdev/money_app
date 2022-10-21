part of 'chart_bloc.dart';

abstract class ChartEvent extends Equatable {
  const ChartEvent();

  @override
  List<Object> get props => [];
}

class ReadChartDefaultEvent extends ChartEvent {
  String transactionDateTime;
  OptionDate optionDate;

  ReadChartDefaultEvent({
    required this.transactionDateTime,
    this.optionDate = OptionDate.month,
  });
}
