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
        emit(SuccessSelectedIcon(resultSelectedIconName: event.iconName));
      } catch (e) {
        emit(FailureSelectedIcon(messageError: "Error FailureSelectedIcon "));
      }
    });

    on<CallbackIconNameEvent>((event, emit) {
      try {
        emit(LoadingCallbackIconName());
        emit(SuccessCallbackIconName(resultSelectedIconName: event.iconName));
      } catch (e) {
        emit(FailureCallbackIconName(
            messageError: "Error FailureCallbackIconName"));
      }
    });

    on<CreateCategoryEvent>((event, emit) async {
      try {
        emit(LoadingCreateCategory());
        final result =
            await _getCategoryCases.executeCreateCategory(event.valueCategory);
        result.fold(
            (l) => emit(
                FailureCreateCategory(messageError: "FailureCreateCategory")),
            (data) => emit(SuccessCreateCategory(result: data)));
      } catch (e) {
        emit(FailureCreateCategory(messageError: "FailureCreateCategory e"));
      }
    });

    on<ReadCategoryByIdEvent>((event, emit) async {
      try {
        emit(LoadingReadCategoryById());
        final result =
            await _getCategoryCases.executeReadCategoryById(event.idCategory);
        result.fold(
            (l) => emit(FailureReadCategoryById(
                messageError: "FailureReadCategoryById")),
            (data) => emit(SuccessReadCategoryById(result: data)));
      } catch (e) {
        emit(
            FailureReadCategoryById(messageError: "FailureReadCategoryById e"));
      }
    });

    on<UpdateCategoryEvent>((event, emit) async {
      try {
        emit(LoadingUpdateCategory());
        final result = await _getCategoryCases.executeUpdateCategory(
            event.idCategory, event.valueCategory);
        result.fold(
            (l) => emit(
                FailureUpdateCategory(messageError: "FailureUpdateCategory")),
            (data) => emit(SuccessUpdateCategory(result: data)));
      } catch (e) {
        emit(FailureUpdateCategory(messageError: "FailureUpdateCategory e"));
      }
    });

    on<DeleteCategoryEvent>((event, emit) async {
      try {
        emit(LoadingDeleteCategory());
        final result =
            await _getCategoryCases.executeDeleteCategory(event.idCategory);
        result.fold(
            (l) => emit(
                FailureDeleteCategory(messageError: "FailureDeleteCategory")),
            (r) => emit(SuccessDeleteCategory()));
      } catch (e) {
        emit(FailureDeleteCategory(messageError: "FailureDeleteCategory e"));
      }
    });
  }
}
