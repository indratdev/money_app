import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_app/domain/usecases/report_cases.dart';

part 'chart_event.dart';
part 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  final ReportCases _getTransactionCases;

  ChartBloc(this._getTransactionCases) : super(ChartInitial()) {
    on<ReadChartDefaultEvent>((event, emit) async {
      try {
        emit(LoadingReadChartDefault());
        print("!!!!! date : ${event.transactionDateTime}");

        final contentTransaction = await _getTransactionCases
            .executeReadChartDefault(event.transactionDateTime); // read

        print(">> >> result $contentTransaction");
        contentTransaction.fold(
            (l) => emit(FailureReadChartDefault(
                messageError: "FailureReadChartDefault :: $l")),
            (data) => emit(SuccessReadChartDefault(result: data)));
      } catch (e) {
        print(e);
        emit(
            FailureReadChartDefault(messageError: "FailureReadChartDefault e"));
      }
    });
  }
}
