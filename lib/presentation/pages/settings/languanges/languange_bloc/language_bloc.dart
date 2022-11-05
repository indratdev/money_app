import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<ReadLanguangeEvent>((event, emit) {
      try {
        print("ReadLanguangeEvent Runningg.....");
      } catch (e) {
        print("Error :: $e");
      }
    });
  }
}
