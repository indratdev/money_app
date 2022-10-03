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

  // add category
  executeAddCategory() {
    repository.getAddCategory();
  }

  // update category
  executeUpdateCategory() {
    repository.getUpdateCategory();
  }

  // delete category
  executeDeleteCategory() {
    repository.getDeleteCategory();
  }
}
