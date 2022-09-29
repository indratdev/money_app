import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_app/data/repositories/category_repository_impl.dart';
import 'package:money_app/domain/repositories/category_repository.dart';
import 'package:money_app/domain/usecases/category_cases.dart';

import '../../../../../data/constants.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryCases _getCategoryCases;

  CategoryBloc(this._getCategoryCases) : super(CategoryInitial()) {
    on<InitCategory>((event, emit) async {
      emit(LoadingInitCategory());
      try {
        print("....runinggg InitCategory");
        final result = await _getCategoryCases.executeInitCategory();
      } catch (e) {
        emit(FailureInitCategory(
            messageError: "failureInitCategoryMessage.toString()"));
        print(e);
      }
    });
    on<ReadCategory>((event, emit) {
      emit(LoadingReadCategory());

      try {
        final result = _getCategoryCases.executeReadCategory();
      } catch (e) {
        emit(FailureReadCategory(
            messageError: "failureReadCategoryMessage.toString()"));
      }
    });
  }
}
