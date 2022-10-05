import 'package:dartz/dartz.dart';
import 'package:money_app/domain/entities/category.dart';

import '../../data/failure.dart';

abstract class CategoryRepository {
  getInitCategory();
  Future<Either<Failure, List<Category>>> getReadCategory();
  Future<Either<Failure, Category>> getReadCategoryById(int idCategory);
  Future<Either<Failure, List<Category>>> getReadIconCategoryDefault();

  Future<Either<Failure, int>> getCreateCategory(Category value);
  getUpdateCategory();
  getDeleteCategory();
}
