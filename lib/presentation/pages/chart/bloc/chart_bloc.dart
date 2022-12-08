import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:money_app/data/date_util.dart';
import 'package:money_app/domain/usecases/report_cases.dart';

part 'chart_event.dart';
part 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  final ReportCases _getTransactionCases;

  ChartBloc(this._getTransactionCases) : super(ChartInitial()) {
    on<ReadChartDefaultEvent>((event, emit) async {
      try {
        emit(LoadingReadChartDefault());
        final contentTransaction =
            await _getTransactionCases.executeReadChartDefault(
                event.transactionDateTime, OptionDate.month);

        contentTransaction.fold(
            (l) => emit(
                FailureReadChartDefault(messageError: 'error-read-chart'.tr())),
            (data) => emit(SuccessReadChartDefault(result: data)));
      } catch (e) {
        emit(FailureReadChartDefault(messageError: 'error-read-chart'.tr()));
      }
    });
  }
}
