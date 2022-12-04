import 'package:money_app/data/datasources/local/db/sqldatabase.dart';
import 'package:money_app/data/date_util.dart';
import 'package:money_app/data/models/transaction_model.dart';
import 'package:money_app/domain/entities/category.dart';
import 'package:money_app/domain/entities/transaction.dart';

import '../../models/calculation_model.dart';
import '../../models/category_model.dart';

abstract class LocalDataSource {
  getInitCategory();
  Future<List<CategoryModel>> readCategory(int isDefault);
  Future<CategoryModel> readCategoryById(int idCategory);
  Future<int> createCategory(Category value);
  Future<int> updateCategory(int idCategory, Category valueCategory);
  Future<void> deleteCategory(int idCategory);
  Future<int> createNewTransaction(Transaction value);
  Future<List<TransactionModel>> readTransaction(String date);
  Future<List<CalculationModel>> readCalculation(String date);
  Future<List<ChartCalculationModel>> readChartDefault(
      String date, int isOutcome, OptionDate optionDate);
  Future<void> deleteTransaction(int idTransaction);
  Future<int> updateTransaction(
      int idTransaction, Transaction valueTransaction);
  Future<void> deleteAllData();
  Future<bool> readPasscode();

  // parameter
  Future<List<Map<String, dynamic>>> readParamThemes();
  Future<int> updateParamThemes(String value);
  Future<bool> savingPasscode(String value);
  // Future<bool> updateParamThemes(String value);
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

  @override
  Future<int> updateCategory(int idCategory, Category valueCategory) async {
    return await dbprovider.updateCategory(idCategory, valueCategory);
  }

  @override
  Future<void> deleteCategory(int idCategory) async {
    await dbprovider.deleteCategory(idCategory);
  }

  // delete all data
  @override
  Future<void> deleteAllData() async {
    return await dbprovider.deleteAllData();
  }

  @override
  Future<void> deleteTransaction(int idTransaction) async {
    await dbprovider.deleteTransaction(idTransaction);
  }

  @override
  Future<int> createNewTransaction(Transaction value) async {
    return await dbprovider.createNewTransaction(value);
  }

  @override
  Future<List<TransactionModel>> readTransaction(String date) async {
    return await dbprovider.readTransaction(date);
  }

  @override
  Future<List<CalculationModel>> readCalculation(String date) async {
    return await dbprovider.readCalculation(date);
  }

  @override
  Future<List<ChartCalculationModel>> readChartDefault(
      String date, int isOutcome, OptionDate optionDate) async {
    return await dbprovider.readChartDefault(date, isOutcome, optionDate);
  }

  @override
  Future<int> updateTransaction(
      int idTransaction, Transaction valueTransaction) async {
    return await dbprovider.updateTransaction(idTransaction, valueTransaction);
  }

  @override
  Future<List<Map<String, dynamic>>> readParamThemes() async {
    return await dbprovider.readParamThemes();
  }

  @override
  Future<int> updateParamThemes(String value) async {
    return await dbprovider.updateThemes(value);
  }

  @override
  Future<bool> readPasscode() async {
    return await dbprovider.readPasscodeExist();
  }

  @override
  Future<bool> savingPasscode(String value) async {
    return await dbprovider.savingNewPasscode(value);
  }
}
