import 'package:dartz/dartz.dart';
import 'package:money_app/domain/repositories/parameter_repository.dart';

import '../../data/failure.dart';

class ParameterCases {
  final ParameterRepository repository;

  ParameterCases(this.repository);

  // // init category
  // executeInitCategory() {
  //   repository.getInitCategory();
  // }

  // read category
  Future<Either<Failure, String>> executeReadThemes() {
    return repository.getReadThemes();
  }

  // update category
  Future<Either<Failure, String>> executeUpdateThemes(String value) {
    return repository.getUpdateThemes(value);
  }

  // // read category by id
  // Future<Either<Failure, Category>> executeReadCategoryById(int idCategory) {
  //   return repository.getReadCategoryById(idCategory);
  // }

  // // read icon category default
  // Future<Either<Failure, List<Category>>> executeReadIconCategoryDefault(
  //     int isDefault) {
  //   return repository.getReadIconCategoryDefault(isDefault);
  // }

  // // create category
  // Future<Either<Failure, int>> executeCreateCategory(Category valueCategory) {
  //   return repository.getCreateCategory(valueCategory);
  // }

  // // update category
  // Future<Either<Failure, int>> executeUpdateCategory(
  //     int idCategory, Category valueCategory) {
  //   return repository.getUpdateCategory(idCategory, valueCategory);
  // }

  // // delete category
  // Future<Either<Failure, void>> executeDeleteCategory(int idCategory) {
  //   return repository.getDeleteCategory(idCategory);
  // }
}
