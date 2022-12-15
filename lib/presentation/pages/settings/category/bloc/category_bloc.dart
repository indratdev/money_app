import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:money_app/domain/entities/category.dart';
import 'package:money_app/domain/usecases/category_cases.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryCases _getCategoryCases;

  CategoryBloc(this._getCategoryCases) : super(CategoryInitial()) {
    on<InitCategory>((event, emit) async {
      try {
        emit(LoadingInitCategory());
        await _getCategoryCases.executeInitCategory();
      } catch (e) {
        emit(FailureInitCategory(messageError: 'error-init-category'.tr()));
      }
    });

    // read master category
    on<ReadCategory>((event, emit) async {
      try {
        emit(LoadingReadCategory());
        final result =
            await _getCategoryCases.executeReadCategory(event.isDefault);

        result.fold((l) => emit(FailureReadCategory(messageError: l.message)),
            (data) => emit(SuccessReadCategory(result: data)));
      } catch (e) {
        emit(FailureReadCategory(messageError: 'error-read-category'.tr()));
      }
    });

// read ops category
    on<ReadOpsCategory>((event, emit) async {
      try {
        emit(LoadingReadOpsCategory());
        final result =
            await _getCategoryCases.executeReadOpsCategory(event.isDefault);

        result.fold(
            (l) => emit(FailureReadOpsCategory(messageError: l.message)),
            (data) => emit(SuccessReadOpsCategory(result: data)));
      } catch (e) {
        emit(FailureReadOpsCategory(messageError: 'error-read-category'.tr()));
      }
    });

    on<ReadIconCategoryDefault>((event, emit) async {
      try {
        emit(LoadingReadIconCategoryDefault());
        final result = await _getCategoryCases
            .executeReadIconCategoryDefault(event.isDefault);
        result.fold(
            (l) =>
                emit(FailureReadIconCategoryDefault(messageError: l.message)),
            (data) => emit(SuccessReadIconCategoryDefault(result: data)));
      } catch (e) {
        emit(FailureReadIconCategoryDefault(
            messageError: 'error-read-category'.tr()));
      }
    });

    // selected icon
    on<SelectedIconEvent>((event, emit) async {
      try {
        emit(LoadingSelectedIcon());
        emit(SuccessSelectedIcon(resultSelectedIconName: event.iconName));
      } catch (e) {
        emit(FailureSelectedIcon(messageError: 'icon-selected-failure'.tr()));
      }
    });

    on<CallbackIconNameEvent>((event, emit) {
      try {
        emit(LoadingCallbackIconName());
        emit(SuccessCallbackIconName(resultSelectedIconName: event.iconName));
      } catch (e) {
        emit(FailureCallbackIconName(
            messageError: 'icon-selected-failure'.tr()));
      }
    });

    on<CallbackIconCategoryEvent>((event, emit) {
      try {
        emit(LoadingCallbackIconCategory());
        emit(SuccessCallbackIconCategory(value: event.value));
      } catch (e) {
        emit(FailureCallbackIconCategory(
            messageError: 'icon-selected-failure'.tr()));
      }
    });

    on<CreateCategoryEvent>((event, emit) async {
      try {
        emit(LoadingCreateCategory());
        final result =
            await _getCategoryCases.executeCreateCategory(event.valueCategory);
        result.fold(
            (l) => emit(
                FailureCreateCategory(messageError: 'error-add-category'.tr())),
            (data) => emit(SuccessCreateCategory(result: data)));
      } catch (e) {
        emit(FailureCreateCategory(messageError: 'error-add-category'.tr()));
      }
    });

    on<ReadCategoryByIdEvent>((event, emit) async {
      try {
        emit(LoadingReadCategoryById());
        final result =
            await _getCategoryCases.executeReadCategoryById(event.idCategory);
        result.fold(
            (l) => emit(FailureReadCategoryById(
                messageError: 'error-read-category'.tr())),
            (data) => emit(SuccessReadCategoryById(result: data)));
      } catch (e) {
        emit(FailureReadCategoryById(messageError: 'error-read-category'.tr()));
      }
    });

    on<UpdateCategoryEvent>((event, emit) async {
      try {
        emit(LoadingUpdateCategory());
        final result = await _getCategoryCases.executeUpdateCategory(
            event.idCategory, event.valueCategory);
        result.fold(
            (l) => emit(FailureUpdateCategory(
                messageError: 'error-update-category'.tr())),
            (data) => emit(SuccessUpdateCategory(result: data)));
      } catch (e) {
        emit(FailureUpdateCategory(messageError: 'error-update-category'.tr()));
      }
    });

    on<DeleteCategoryEvent>((event, emit) async {
      try {
        emit(LoadingDeleteCategory());
        if (event.idCategory == 0 || event.idCategory < 1) {
          emit(FailureDeleteCategory(
              messageError: 'error-delete-category'.tr()));
        } else {
          final result =
              await _getCategoryCases.executeDeleteCategory(event.idCategory);
          result.fold(
              (l) => emit(FailureDeleteCategory(
                  messageError: 'error-delete-category'.tr())),
              (r) => emit(SuccessDeleteCategory()));
        }
      } catch (e) {
        emit(FailureDeleteCategory(messageError: 'error-delete-category'.tr()));
      }
    });

    on<ChangeIconCategory>((event, emit) {
      try {
        emit(SuccessChangeIconCategory(categoryValue: event.categoryValue));
      } catch (e) {
        print(e);
      }
    });
  }
}
