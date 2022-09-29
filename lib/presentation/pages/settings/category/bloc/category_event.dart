part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class InitCategory extends CategoryEvent {}

class ReadCategory extends CategoryEvent {}
