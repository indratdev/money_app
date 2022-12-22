import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/report_cases.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportCases _getReportCases;

  ReportBloc(this._getReportCases) : super(ReportInitial()) {
    on<CheckAllYearTransactionEvent>((event, emit) async {
      try {
        print(">>> CheckAllYearTransactionEvent click..");
        emit(LoadingCheckAllYearTransaction());
        final result = await _getReportCases.executeCheckAllYearTrx();
        result.fold(
            (l) => emit(FailureCheckAllYearTransaction(
                messageError: 'report-year-failedLoad'.tr())),
            (data) => emit(SuccessCheckAllYearTransaction(result: data)));
      } catch (e) {
        emit(FailureCheckAllYearTransaction(
            messageError: 'report-year-failedLoad'.tr()));
      }
    });

    on<ChangeYearTransactionEvent>((event, emit) {
      try {
        emit(LoadingChangeYearTransaction());
        final result = event.valueYear;
        emit(SuccessChangeYearTransaction(valueYear: result));
      } catch (e) {
        print("e : $e");
        emit(FailureChangeYearTransaction(messageError: e.toString()));
      }
    });

    on<GenerateReportByYearEvent>((event, emit) async {
      try {
        emit(LoadingGenerateReportByYear());
        final result =
            await _getReportCases.executeGenerateReportYearly(event.year);
        result.fold(
            (l) => emit(FailureGenerateReportByYear(
                  messageError: l.toString(),
                )), (r) {
          print(">>> data dari bloc : $r");
        });
      } catch (e) {
        emit(FailureGenerateReportByYear(messageError: "e : $e"));
      }
    });
  }
}
