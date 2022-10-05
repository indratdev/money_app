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

  // read category
  Future<Either<Failure, List<Category>>> executeReadCategory() {
    return repository.getReadCategory();
  }

  // read category by id
  Future<Either<Failure, Category>> executeReadCategoryById(int idCategory) {
    return repository.getReadCategoryById(idCategory);
  }

  // read icon category default
  Future<Either<Failure, List<Category>>> executeReadIconCategoryDefault() {
    return repository.getReadIconCategoryDefault();
  }

  // create category
  Future<Either<Failure, int>> executeCreateCategory(Category valueCategory) {
    return repository.getCreateCategory(valueCategory);
  }

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
