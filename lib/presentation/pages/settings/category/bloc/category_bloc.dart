import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_app/data/repositories/category_repository_impl.dart';
import 'package:money_app/domain/entities/category.dart';
import 'package:money_app/domain/repositories/category_repository.dart';
import 'package:money_app/domain/usecases/category_cases.dart';

import '../../../../../data/constants.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryCases _getCategoryCases;

  CategoryBloc(this._getCategoryCases) : super(CategoryInitial()) {
    on<InitCategory>((event, emit) async {
      try {
        emit(LoadingInitCategory());
        print("....runinggg InitCategory");
        final result = await _getCategoryCases.executeInitCategory();
      } catch (e) {
        emit(FailureInitCategory(
            messageError: "failureInitCategoryMessage.toString()"));
        print(e);
      }
    });

    on<ReadCategory>((event, emit) async {
      print("ReadCategory runinggg...");
      try {
        emit(LoadingReadCategory());
        final result = await _getCategoryCases.executeReadCategory();
        print("resultttttt : $result");
        result.fold((l) => emit(FailureReadCategory(messageError: l.message)),
            (data) => emit(SuccessReadCategory(result: data)));
      } catch (e) {
        emit(FailureReadCategory(
            messageError: "failureReadCategoryMessage.toString()"));
      }
    });

    on<ReadIconCategoryDefault>((event, emit) async {
      print("ReadCategory runinggg...");
      try {
        emit(LoadingReadIconCategoryDefault());
        final result = await _getCategoryCases.executeReadIconCategoryDefault();
        print("resultttttt ReadIconCategoryDefault: $result");
        result.fold(
            (l) =>
                emit(FailureReadIconCategoryDefault(messageError: l.message)),
            (data) => emit(SuccessReadIconCategoryDefault(result: data)));
      } catch (e) {
        emit(FailureReadIconCategoryDefault(
            messageError: "failureReadCategoryMessage.toString()"));
      }
    });

    // selected icon
    on<SelectedIconEvent>((event, emit) async {
      try {
        emit(LoadingSelectedIcon());
        final result = event.iconID;
        print("result SelectedIconEvent : $result");
        emit(SuccessSelectedIcon(resultSelectedIconID: result));
      } catch (e) {
        emit(FailureSelectedIcon(messageError: "Error FailureSelectedIcon "));
      }
    });
  }
}
