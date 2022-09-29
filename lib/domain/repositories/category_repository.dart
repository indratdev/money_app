import '../../data/models/category_model.dart';

abstract class CategoryRepository {
  getInitCategory();
  Future<List<CategoryModel>> getReadCategory();
  getAddCategory();
  getUpdateCategory();
  getDeleteCategory();
}
