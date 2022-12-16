import 'package:dartz/dartz.dart';
import 'package:money_app/domain/repositories/category_repository.dart';

import '../../data/failure.dart';
import '../entities/category.dart';

class CategoryCases {
  final CategoryRepository repository;

  CategoryCases(this.repository);

  // init category
  executeInitCategory() {
    repository.getInitCategory();
  }

  // read master category
  Future<Either<Failure, List<Category>>> executeReadCategory(int isDefault) {
    return repository.getReadCategory();
  }

  // read ops category
  Future<Either<Failure, List<Category>>> executeReadOpsCategory(
      int isDefault) {
    return repository.getReadOpsCategory();
  }

  // read category by id
  Future<Either<Failure, Category>> executeReadCategoryById(int idCategory) {
    return repository.getReadCategoryById(idCategory);
  }

  // read icon category master
  Future<Either<Failure, List<Category>>> executeReadIconCategoryMaster(
      int isDefault) {
    return repository.getReadIconCategoryMaster(isDefault);
  }

  // read icon category default
  Future<Either<Failure, List<Category>>> executeReadIconCategoryDefault(
      int isDefault) {
    return repository.getReadIconCategoryDefault(isDefault);
  }

  // create category
  Future<Either<Failure, int>> executeCreateCategory(Category valueCategory) {
    return repository.getCreateCategory(valueCategory);
  }

  // count master category default
  // Future<Either<Failure, bool>> executeCountMasterCategoryDefault() {
  //   return repository.countMasterCategoryDefault();
  // }

  // update category
  Future<Either<Failure, int>> executeUpdateCategory(
      int idCategory, Category valueCategory) {
    return repository.getUpdateCategory(idCategory, valueCategory);
  }

  // delete category
  Future<Either<Failure, void>> executeDeleteCategory(int idCategory) {
    return repository.getDeleteCategory(idCategory);
  }
}
