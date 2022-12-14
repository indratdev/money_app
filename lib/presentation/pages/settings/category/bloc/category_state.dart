part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

abstract class FailureState extends CategoryState {
  String messageError;

  FailureState({required this.messageError});

  @override
  List<Object> get props => [messageError];
}

class CategoryInitial extends CategoryState {}

class LoadingInitCategory extends CategoryState {}

class FailureInitCategory extends FailureState {
  FailureInitCategory({required super.messageError});
}

class SuccessInitCategory extends CategoryState {}

// init master category
class LoadingInitMasterCategory extends CategoryState {}

class FailureInitMasterCategory extends FailureState {
  FailureInitMasterCategory({required super.messageError});
}

class SuccessInitMasterCategory extends CategoryState {}

class LoadingReadCategory extends CategoryState {}

class FailureReadCategory extends FailureState {
  FailureReadCategory({required super.messageError});
}

class SuccessReadCategory extends CategoryState {
  final List<Category> result;

  SuccessReadCategory({required this.result});

  @override
  List<Object> get props => [result];
}

// read ops category
class LoadingReadOpsCategory extends CategoryState {}

class FailureReadOpsCategory extends FailureState {
  FailureReadOpsCategory({required super.messageError});
}

class SuccessReadOpsCategory extends CategoryState {
  final List<Category> result;

  SuccessReadOpsCategory({required this.result});

  @override
  List<Object> get props => [result];
}

// master category
class LoadingReadIconCategoryMaster extends CategoryState {}

class FailureReadIconCategoryMaster extends FailureState {
  FailureReadIconCategoryMaster({required super.messageError});
}

class SuccessReadIconCategoryMaster extends CategoryState {
  final List<Category> result;

  SuccessReadIconCategoryMaster({required this.result});

  @override
  List<Object> get props => [result];
}

//
class LoadingReadIconCategoryDefault extends CategoryState {}

class FailureReadIconCategoryDefault extends FailureState {
  FailureReadIconCategoryDefault({required super.messageError});
}

class SuccessReadIconCategoryDefault extends CategoryState {
  final List<Category> result;

  SuccessReadIconCategoryDefault({required this.result});

  @override
  List<Object> get props => [result];
}

//

//
class LoadingSelectedIcon extends CategoryState {}

class FailureSelectedIcon extends FailureState {
  FailureSelectedIcon({required super.messageError});
}

class SuccessSelectedIcon extends CategoryState {
  final String resultSelectedIconName;

  SuccessSelectedIcon({required this.resultSelectedIconName});

  @override
  List<Object> get props => [resultSelectedIconName];
}

//

// callback iconname
class LoadingCallbackIconName extends CategoryState {}

class FailureCallbackIconName extends FailureState {
  FailureCallbackIconName({required super.messageError});
}

class SuccessCallbackIconName extends CategoryState {
  final String resultSelectedIconName;

  SuccessCallbackIconName({required this.resultSelectedIconName});

  @override
  List<Object> get props => [resultSelectedIconName];
}

// create new Category
class LoadingCreateCategory extends CategoryState {}

class FailureCreateCategory extends FailureState {
  FailureCreateCategory({required super.messageError});
}

class SuccessCreateCategory extends CategoryState {
  final int result;

  SuccessCreateCategory({required this.result});

  @override
  List<Object> get props => [result];
}

//

// read new Category by id
class LoadingReadCategoryById extends CategoryState {}

class FailureReadCategoryById extends FailureState {
  FailureReadCategoryById({required super.messageError});
}

class SuccessReadCategoryById extends CategoryState {
  final Category result;

  SuccessReadCategoryById({required this.result});

  @override
  List<Object> get props => [result];
}

//

// update category
class LoadingUpdateCategory extends CategoryState {}

class FailureUpdateCategory extends FailureState {
  FailureUpdateCategory({required super.messageError});
}

class SuccessUpdateCategory extends CategoryState {
  final int result;

  SuccessUpdateCategory({required this.result});

  @override
  List<Object> get props => [result];
}

//

// delete category
class LoadingDeleteCategory extends CategoryState {}

class FailureDeleteCategory extends FailureState {
  FailureDeleteCategory({required super.messageError});
}

class SuccessDeleteCategory extends CategoryState {}

// callback category icon

class LoadingCallbackIconCategory extends CategoryState {}

class FailureCallbackIconCategory extends FailureState {
  FailureCallbackIconCategory({required super.messageError});
}

class SuccessCallbackIconCategory extends CategoryState {
  Category value;

  SuccessCallbackIconCategory({required this.value});

  @override
  List<Object> get props => [value];
}

class SuccessChangeIconCategory extends CategoryState {
  Category categoryValue;

  SuccessChangeIconCategory({required this.categoryValue});

  @override
  List<Object> get props => [categoryValue];
}
