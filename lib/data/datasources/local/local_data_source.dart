import 'package:money_app/data/datasources/local/db/sqldatabase.dart';
import 'package:money_app/domain/entities/category.dart';

import '../../models/category_model.dart';

abstract class LocalDataSource {
  getInitCategory();
  Future<List<CategoryModel>> readCategory(int isDefault);
  Future<CategoryModel> readCategoryById(int idCategory);
  Future<int> createCategory(Category value);
}

class LocalDataSourceImpl implements LocalDataSource {
  final dbprovider = SqlDatabase.instance;

  @override
  getInitCategory() {
    final result = dbprovider.database;
  }

  @override
  Future<List<CategoryModel>> readCategory(int isDefault) async {
    return await dbprovider.readCategory(isDefault);
  }

  @override
  Future<CategoryModel> readCategoryById(int idCategory) async {
    return await dbprovider.readCategoryById(idCategory);
  }

  @override
  Future<int> createCategory(Category value) async {
    return await dbprovider.createCategory(value);
  }
}