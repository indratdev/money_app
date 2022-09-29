import 'package:money_app/data/datasources/local/db/sqldatabase.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/category_model.dart';

class SqlHelper {
  final String dbName = 'dbmoney.db';
  final String tableTransaction = 'th_transaction';
  final String tableMasterCategory = 'm_category';
  final String tableOpsCategory = 'ops_category';

  // init tables
  initDB(Database db) async {
    //create table transaction
    await db.execute('''
    CREATE TABLE $tableTransaction    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idCategory INTEGER,
      iconName TEXT NULL,
      title TEXT NULL,
      description TEXT NULL,
      amount REAL,
      createdTime TEXT NULL,
      createdTrxTime TEXT NULL,
      isModifield INTEGER,
      modifieldTrxTime TEXT NULL  
      )
      ''');

    // create table master category
    await db.execute('''
    CREATE TABLE $tableMasterCategory    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      iconName TEXT NULL
      )
      ''');

    // create table ops category
    await db.execute('''
    CREATE TABLE $tableOpsCategory    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      isIncome INTEGER,
      name TEXT NOT NULL,
      iconName TEXT NULL,
      isActive INTEGER,
      isDefault INTEGER,
      createdTime TEXT NULL,
      modifieldTime TEXT NULL  
      )
      ''');
  }

  // init default value tables
  initDefaultDB(Database db) {
    // var createTime = DateTime.now().toString();

    // insert default master category
    inserMasterCategory(db, tableMasterCategory);

    // insert default ops category
    // insertOpsCategory(db, tableOpsCategory, createTime);
  }

  // read all category
  Future<List<CategoryModel>> readCategory(
      Database? db, SqlDatabase instance) async {
    final db = await instance.database;
    // const orderBy = 'createdTime ASC';

    if (db != null) {
      final result = await db.rawQuery(
          ''' select isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime from $tableOpsCategory; ''');

      return result.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('DB is NULL');
    }
  }

  insertOpsCategory(
      Database db, String tableOpsCategory, String createTime) async {
    // await db.rawInsert(
    //     ''' INSERT INTO $tableOpsCategory (isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime) VALUES (1, 'GAJI', 'sackDollar', 1, 1, '$createTime', '');   ''');
    // await db.rawInsert(
    //     ''' INSERT INTO $tableOpsCategory (isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime) VALUES (1, 'TABUNGAN', 'piggyBank', 1, 1, '$createTime', '');   ''');
    // await db.rawInsert(
    //     ''' INSERT INTO $tableOpsCategory (isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime) VALUES (1, 'DEPOSITO', 'buildingColumns', 1, 1, '$createTime', '');   ''');
    // await db.rawInsert(
    //     ''' INSERT INTO $tableOpsCategory (isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime) VALUES (1, 'PENDAPATAN LAINNYA', 'boxesStacked', 1, 1, '$createTime', '');   ''');
    // await db.rawInsert(
    //     ''' INSERT INTO $tableOpsCategory (isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime) VALUES (0, 'MAKANAN & MINUMAN', 'champagneGlasses', 1, 1, '$createTime', '');   ''');
    // await db.rawInsert(
    //     ''' INSERT INTO $tableOpsCategory (isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime) VALUES (0, 'TRANSPORTASI', 'car', 1, 1, '$createTime', '');   ''');
    // await db.rawInsert(
    //     ''' INSERT INTO $tableOpsCategory (isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime) VALUES (0, 'RENTAL', 'cars', 1, 1, '$createTime', '');   ''');
    // await db.rawInsert(
    //     ''' INSERT INTO $tableOpsCategory (isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime) VALUES (0, 'PEMBAYARAN', 'fileInvoiceDollar', 1, 1, '$createTime', '');   ''');
    // await db.rawInsert(
    //     ''' INSERT INTO $tableOpsCategory (isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime) VALUES (0, 'ASURANSI', 'handHoldingHeart', 1, 1, '$createTime', '');   ''');
    // await db.rawInsert(
    //     ''' INSERT INTO $tableOpsCategory (isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime) VALUES (0, 'PEMELIHARAAN KENDARAAN', 'screwdriverWrench', 1, 1, '$createTime', '');   ''');
    // await db.rawInsert(
    //     ''' INSERT INTO $tableOpsCategory (isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime) VALUES (0, 'PENGELUARAN LAINNYA', 'boxesStacked', 1, 1, '$createTime', '');   ''');
    // await db.rawInsert(
    //     ''' INSERT INTO $tableOpsCategory (isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime) VALUES (0, 'FITNESS', 'dumbbell', 1, 1, '$createTime', '');   ''');
    // await db.rawInsert(
    //     ''' INSERT INTO $tableOpsCategory (isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime) VALUES (0, 'MAKEUP', 'heart', 1, 1, '$createTime', '');   ''');
    // await db.rawInsert(
    //     ''' INSERT INTO $tableOpsCategory (isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime) VALUES (0, 'HADIAH', 'gifts', 1, 1, '$createTime', '');   ''');
    // await db.rawInsert(
    //     ''' INSERT INTO $tableOpsCategory (isIncome, name, iconName,isActive, isDefault, createdTime, modifieldTime) VALUES (0, 'REKREASI', 'umbrellaBeach', 1, 1, '$createTime', '');   ''');
  }

  inserMasterCategory(Database db, String tableMasterCategory) async {
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('collect interest', 'collect-interest'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('debt', 'debt'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('debt collection', 'debt-collection'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('education', 'education'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('electricity bill', 'electricity-bill'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('fitness', 'fitness'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('food', 'food'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('fun money', 'fun-money'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('gas bill', 'gas-bill'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('gifts donations', 'gifts-donations'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('home maitenance', 'home-maitenance'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('home services', 'home-services'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('houseware', 'houseware'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('insurances', 'insurances'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('internet bill', 'internet-bill'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('investment', 'investment'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('loan', 'loan'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('makeup', 'makeup'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('medical checkup', 'medical-checkup'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('other bill', 'other-bill'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('other expense', 'other-expense'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('other income', 'other-income'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('pay interest', 'pay-interest'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('personal items', 'personal-items'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('pets', 'pets'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('phone bill', 'phone-bill'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('rental', 'rental'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('repayment', 'repayment'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('salary', 'salary'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('streaming service', 'streaming-service'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('transfer', 'transfer'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('transportation', 'transportation'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('tv bill', 'tv-bill'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('vehicle maintenance', 'vehicle-maintenance'); ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName) VALUES ('water bill', 'water-bill'); ''');
  }
}
