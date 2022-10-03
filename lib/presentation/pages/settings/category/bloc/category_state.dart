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
