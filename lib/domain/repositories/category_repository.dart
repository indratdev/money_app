import 'package:dartz/dartz.dart';
import 'package:money_app/domain/entities/category.dart';

import '../../data/failure.dart';

abstract class CategoryRepository {
  getInitCategory();
  Future<Either<Failure, List<Category>>> getReadCategory();
  getAddCategory();
  getUpdateCategory();
  getDeleteCategory();
}
