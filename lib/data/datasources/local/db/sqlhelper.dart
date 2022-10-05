import 'package:money_app/data/datasources/local/db/sqldatabase.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/category.dart';
import '../../../models/category_model.dart';

class SqlHelper {
  final String dbName = 'dbmoney.db';
  final String tableTransaction = 'th_transaction';
  final String tableMasterCategory = 'm_category';
  // final String tableOpsCategory = 'ops_category';

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
      iconName TEXT NULL,
      createdTime TEXT NULL,
      modifieldTime TEXT NULL,
      isDefault INTEGER
      )
      ''');

    // create table ops category
    // await db.execute('''
    // CREATE TABLE $tableOpsCategory    (
    //   id INTEGER PRIMARY KEY AUTOINCREMENT,
    //   isIncome INTEGER,
    //   name TEXT NOT NULL,
    //   iconName TEXT NULL,
    //   isActive INTEGER,
    //   isDefault INTEGER,
    //   createdTime TEXT NULL,
    //   modifieldTime TEXT NULL
    //   )
    //   ''');
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
      Database? db, SqlDatabase instance, int isDefault) async {
    final db = await instance.database;
    // const orderBy = 'createdTime ASC';

    String query = "";
    if (isDefault == 0) {
      query =
          "select id, name, iconName, createdTime, modifieldTime, isDefault from $tableMasterCategory ;";
    } else {
      query =
          "select id, name, iconName, createdTime, modifieldTime, isDefault from $tableMasterCategory where isDefault = 1 ;";
    }

    if (db != null) {
      final result = await db.rawQuery(''' $query ''');

      return result.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('DB is NULL');
    }
  }

  // read category by id
  Future<CategoryModel> readCategoryById(
      Database? db, SqlDatabase instance, int idCategory) async {
    final db = await instance.database;

    String query =
        "select id, name, iconName, createdTime, modifieldTime, isDefault from $tableMasterCategory where id = $idCategory ;";

    if (db != null) {
      final result = await db.rawQuery(''' $query ''');

      return result.map((e) => CategoryModel.fromJson(e)).toList().first;
    } else {
      throw Exception('DB is NULL');
    }
  }

  Future<int> createCategory(
      Database? db, SqlDatabase instance, Category category) async {
    final db = await instance.database;
    int result = 0;
    if (db != null) {
      result = await db.rawInsert('''
      INSERT INTO $tableMasterCategory (name, iconName,createdTime, modifieldTime, isDefault)
      VALUES
      (
        '${category.name}'
        ,'${category.iconName}'
        ,'${category.createdTime}'
        ,'${category.modifieldTime}'
        ,'${category.isDefault}'
        );
      ''');
    }
    return result;
  }

  // insertOpsCategory(
  // Database db, String tableOpsCategory, String createTime) async {
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
  // }

  inserMasterCategory(Database db, String tableMasterCategory) async {
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Bunga', 'collect-interest', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Utang', 'debt', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Penagihan Hutang', 'debt-collection', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Pendidikan', 'education', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Tagihan Listrik', 'electricity-bill', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Kebugaran', 'fitness', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Makanan', 'food', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Uang Menyenangkan', 'fun-money', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Tagihan Gas', 'gas-bill', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Sumbangan Hadiah', 'gifts-donations', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Perawatan Rumah', 'home-maitenance', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Layanan Rumah', 'home-services', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Peralatan Rumah Tangga', 'houseware', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Asuransi', 'insurances', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Tagihan Internet', 'internet-bill', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Investasi', 'investment', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Meminjamkan', 'loan', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Dandan', 'makeup', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Pemeriksaan Kesehatan', 'medical-checkup', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Tagihan Lainnya', 'other-bill', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Biaya Lainnya', 'other-expense', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Penghasilan Lain', 'other-income', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Membayar Bunga', 'pay-interest', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Barang Pribadi', 'personal-items', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Hewan Peliharaan', 'pets', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Tagihan Telepon', 'phone-bill', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Persewaan', 'rental', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Pembayaran Kembali', 'repayment', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Gaji', 'salary', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Layanan Streaming', 'streaming-service', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Transfer', 'transfer', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Angkutan', 'transportation', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Tagihan Tv', 'tv-bill', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Pemeliharaan Kendaraan', 'vehicle-maintenance', NULL, NULL, 1) ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterCategory (name, iconName, createdTime, modifieldTime, isDefault) VALUES ('Tagihan Air', 'water-bill', NULL, NULL, 1) ''');
  }
}