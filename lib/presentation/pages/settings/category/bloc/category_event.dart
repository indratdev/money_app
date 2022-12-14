part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class InitCategory extends CategoryEvent {}

class InitMasterCategory extends CategoryEvent {
  String language;

  InitMasterCategory({required this.language});
}

class ReadCategory extends CategoryEvent {
  int isDefault;

  ReadCategory({required this.isDefault});
}

class ReadOpsCategory extends CategoryEvent {
  int isDefault;

  ReadOpsCategory({required this.isDefault});
}

class ReadIconCategoryMaster extends CategoryEvent {
  int isDefault;

  ReadIconCategoryMaster({required this.isDefault});
}

class ReadIconCategoryDefault extends CategoryEvent {
  int isDefault;

  ReadIconCategoryDefault({required this.isDefault});
}

class ChangeIconCategory extends CategoryEvent {
  Category categoryValue;

  ChangeIconCategory({required this.categoryValue});
}

class SelectedIconEvent extends CategoryEvent {
  String iconName;

  SelectedIconEvent({required this.iconName});
}

class CallbackIconNameEvent extends CategoryEvent {
  String iconName;

  CallbackIconNameEvent({required this.iconName});
}

class CallbackIconCategoryEvent extends CategoryEvent {
  Category value;

  CallbackIconCategoryEvent({required this.value});
}

// add new category
class CreateCategoryEvent extends CategoryEvent {
  Category valueCategory;

  CreateCategoryEvent({required this.valueCategory});
}

class ReadCategoryByIdEvent extends CategoryEvent {
  int idCategory;

  ReadCategoryByIdEvent({required this.idCategory});
}

// update category
class UpdateCategoryEvent extends CategoryEvent {
  int idCategory;
  Category valueCategory;

  UpdateCategoryEvent({
    required this.idCategory,
    required this.valueCategory,
  });
}

// delete category
class DeleteCategoryEvent extends CategoryEvent {
  int idCategory;

  DeleteCategoryEvent({required this.idCategory});
}
