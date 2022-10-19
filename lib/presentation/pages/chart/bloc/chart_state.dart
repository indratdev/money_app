part of 'chart_bloc.dart';

abstract class ChartState extends Equatable {
  const ChartState();

  @override
  List<Object> get props => [];
}

abstract class FailureState extends ChartState {
  String messageError;

  FailureState({required this.messageError});

  @override
  List<Object> get props => [messageError];
}

class ChartInitial extends ChartState {}

class LoadingReadChartDefault extends ChartState {}

class FailureReadChartDefault extends FailureState {
  FailureReadChartDefault({required super.messageError});
}

class SuccessReadChartDefault extends ChartState {
  // List<Transaction> result;
  Map<String, dynamic> result;

  SuccessReadChartDefault({required this.result});

  @override
  List<Object> get props => [result];
}
