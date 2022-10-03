import 'package:money_app/data/datasources/local/db/sqldatabase.dart';

import '../../models/category_model.dart';

abstract class LocalDataSource {
  getInitCategory();
  Future<List<CategoryModel>> readCategory(int isDefault);
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
}
