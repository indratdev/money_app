part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class InitCategory extends CategoryEvent {}

class ReadCategory extends CategoryEvent {}

class ReadIconCategoryDefault extends CategoryEvent {}

class SelectedIconEvent extends CategoryEvent {
  String iconName;

  SelectedIconEvent({required this.iconName});
}

class CallbackIconNameEvent extends CategoryEvent {
  String iconName;

  CallbackIconNameEvent({required this.iconName});
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
