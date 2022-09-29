import 'package:money_app/data/datasources/local/local_data_source.dart';
import 'package:money_app/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final LocalDataSource localDataSource;

  CategoryRepositoryImpl({required this.localDataSource});

  @override
  getInitCategory() {
    try {
      print("CategoryRepositoryImpl runingg");
      final result = localDataSource.getInitCategory();
    } catch (e) {
      print(e);
    }
  }

  @override
  getAddCategory() async {
    try {
      print("CategoryRepositoryImpl (getAddCategory) runingg");
      final result = await localDataSource.readCategory();
      return result;
    } catch (e) {
      print(e);
    }
  }

  @override
  getDeleteCategory() {
    // TODO: implement getDeleteCategory
    throw UnimplementedError();
  }

  @override
  getReadCategory() {
    // TODO: implement getReadCategory
    throw UnimplementedError();
  }

  @override
  getUpdateCategory() {
    // TODO: implement getUpdateCategory
    throw UnimplementedError();
  }
}
