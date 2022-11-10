import 'package:dartz/dartz.dart';

import '../../data/failure.dart';

abstract class ParameterRepository {
  // getInitCategory();
  Future<Either<Failure, List<Map<String, dynamic>>>> getReadThemes();
  // Future<Either<Failure, String>> getUpdateThemes(String value);
  // Future<Either<Failure, Category>> getReadCategoryById(int idCategory);
  // Future<Either<Failure, List<Category>>> getReadIconCategoryDefault(
  //     int isDefault);

  // Future<Either<Failure, int>> getCreateCategory(Category value);
  // Future<Either<Failure, int>> getUpdateCategory(
  //     int idCategory, Category valueCategory);
  // Future<Either<Failure, void>> getDeleteCategory(int idCategory);
}
