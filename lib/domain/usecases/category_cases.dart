import 'package:money_app/domain/repositories/category_repository.dart';

class CategoryCases {
  final CategoryRepository repository;

  CategoryCases(this.repository);

  // init category
  executeInitCategory() {
    repository.getInitCategory();
  }

  // add category
  executeAddCategory() {
    repository.getAddCategory();
  }

  // read category
  executeReadCategory() {
    repository.getReadCategory();
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
