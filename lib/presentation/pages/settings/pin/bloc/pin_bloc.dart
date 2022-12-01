import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/usecases/parameter_cases.dart';

part 'pin_event.dart';
part 'pin_state.dart';

class PinBloc extends Bloc<PinEvent, PinState> {
  final ParameterCases _getParameterCases;
  PinBloc(this._getParameterCases) : super(PinInitial()) {
    on<CheckPinUsed>((event, emit) async {
      try {
        final result = await _getParameterCases.executeCheckPasscodeExist();
        print(">>>haisnya ::: $result");
      } catch (e) {}
    });
  }
}
