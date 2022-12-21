import 'package:money_app/data/datasources/local/db/sqlhelper.dart';
import 'package:money_app/data/date_util.dart';
import 'package:money_app/data/models/calculation_model.dart';
import 'package:money_app/data/models/report_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import '../../../../domain/entities/category.dart';
import '../../../../domain/entities/transaction.dart' as trx;
import '../../../models/category_model.dart';
import '../../../models/transaction_model.dart';

class SqlDatabase {
  static final SqlDatabase instance = SqlDatabase._init();
  static Database? _database;
  static SqlHelper sqlHelper = SqlHelper();
  SqlDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB(sqlHelper.dbName);
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // init tables
    await sqlHelper.initDB(db);

    // insert default data
    _configureDB(db);
  }

  Future _configureDB(Database db) async {
    await sqlHelper.initDefaultDB(db);
  }

  Future closeDB() async {
    final db = await instance.database;

    if (db != null) {
      db.close();
    }
  }

  // create category
  Future<int> createCategory(Category category) async {
    final db = await instance.database;
    final result = await sqlHelper.createCategory(db, instance, category);
    return result;
  }

  //read master category
  Future<List<CategoryModel>> readCategory(int isDefault) async {
    final db = await instance.database;
    final result = await sqlHelper.readCategory(db, instance, isDefault);
    return result;
  }

  //read ops  category
  Future<List<CategoryModel>> readOpsCategory(int isDefault) async {
    final db = await instance.database;
    final result = await sqlHelper.readOpsCategory(db, instance, isDefault);
    return result;
  }

  //read category by id
  Future<CategoryModel> readCategoryById(int idCategory) async {
    final db = await instance.database;
    final result = await sqlHelper.readCategoryById(db, instance, idCategory);
    return result;
  }

  Future<int> updateCategory(int idCategory, Category valueCategory) async {
    final db = await instance.database;
    final result =
        await sqlHelper.updateCategory(db, instance, idCategory, valueCategory);
    return result;
  }

  Future<void> deleteCategory(int idCategory) async {
    final db = await instance.database;
    await sqlHelper.deleteCategoryByID(db, idCategory);
  }

  // delete all data
  Future<void> deleteAllData() async {
    final db = await instance.database;
    return await sqlHelper.deleteAllData(db);
  }

  // create new transaction
  Future<int> createNewTransaction(trx.Transaction value) async {
    final db = await instance.database;
    final result = await sqlHelper.createNewTransaction(db, instance, value);
    return result;
  }

  Future<List<TransactionModel>> readTransaction(String date) async {
    final db = await instance.database;
    final result = await sqlHelper.readTransaction(db, instance, date: date);
    return result;
  }

  Future<List<CalculationModel>> readCalculation(String date) async {
    final db = await instance.database;
    final result = await sqlHelper.readCalculation(db, instance, date: date);
    return result;
  }

  Future<List<ChartCalculationModel>> readChartDefault(
      String date, int isOutcome, OptionDate optionDate) async {
    final db = await instance.database;
    final result = await sqlHelper.readChartDefault(db, instance,
        date: date, optionDate: optionDate, isOutcome: isOutcome);
    return result;
  }

  // delete transaction by id
  Future<void> deleteTransaction(int idTransaction) async {
    final db = await instance.database;
    await sqlHelper.deleteTransactionByID(db, idTransaction);
  }

  // update transaction
  Future<int> updateTransaction(
      int idTransaction, trx.Transaction valueTransaction) async {
    final db = await instance.database;
    final result = await sqlHelper.updateTransaction(
        db, instance, idTransaction, valueTransaction);
    return result;
  }

  //read parameter theme
  Future<List<Map<String, dynamic>>> readParamThemes() async {
    final db = await instance.database;
    final result = await sqlHelper.readParamThemes(db, instance);
    return result;
  }

  Future<int> updateThemes(String value) async {
    final db = await instance.database;
    final result = await sqlHelper.updateParamThemes(db, instance, value);
    return result;
  }

  // read passcode - exist
  Future<bool> readPasscodeExist() async {
    final db = await instance.database;
    final result = await sqlHelper.readParamPasscodeExist(db, instance);
    return result;
  }

  // saving new passcode
  Future<bool> savingNewPasscode(String value) async {
    final db = await instance.database;
    final result = await sqlHelper.savingNewPasscode(db, instance, value);
    return result;
  }

  // read passcode value
  Future<String> readPasscodeValue() async {
    final db = await instance.database;
    return await sqlHelper.readParamPasscodeValue(db, instance);
  }

  // read all year transaction
  Future<List<String>> readAllYearTransaction() async {
    final db = await instance.database;
    return await sqlHelper.readAllYearTransaction(db, instance);
  }

  // generate report yearly
  // Future<List<ReportModel>>
  generateReportYearly(String first, String last, String period) async {
    final db = await instance.database;

    // print("firstDay : $first, lastDay: $last, periode: $period");

    return await sqlHelper.generateReportByYear(db, instance,
        firstDayLastDay: "$first - $last", period: period);
  }
}
