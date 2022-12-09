import 'package:money_app/data/datasources/local/db/sqldatabase.dart';
import 'package:money_app/data/date_util.dart';
import 'package:money_app/data/models/calculation_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/category.dart';
import '../../../../domain/entities/transaction.dart' as trx;
import '../../../constants.dart';
import '../../../models/category_model.dart';
import '../../../models/transaction_model.dart';

class SqlHelper {
  final String dbName = 'dbmoney.db';
  final String tableTransaction = 'th_transaction';
  final String tableMasterCategory = 'm_category';
  final String tableMasterColors = 'm_colors';
  final String tableMasterParameter = 'm_parameter';

  // init tables
  initDB(Database db) async {
    //create table transaction
    await db.execute('''
    CREATE TABLE $tableTransaction    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
	    isOutcome INTEGER,
      idCategory INTEGER,
      title TEXT NULL,
      description TEXT NULL,
      amount REAL,
	    idWallet INTEGER,
      createdTime TEXT NULL,
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

    // create table master colors
    await db.execute('''
       CREATE TABLE $tableMasterColors    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      hex_code TEXT NULL,
      int_code INTEGER NULL,
      rgb_code TEXT NULL
      )
      ''');

    // create table master parameter
    await db.execute('''
    CREATE TABLE $tableMasterParameter    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      value TEXT NULL,
      actived INTEGER,
      description TEXT NULL
      )
      ''');
  }

  // init default value tables
  initDefaultDB(Database db) {
    // var createTime = DateTime.now().toString();

    // inserMasterCategory(
    //     db, tableMasterCategory); // insert default master category

    inserMasterColors(db, tableMasterColors); // insert default master category

    insertMasterParameter(db, tableMasterParameter); // insert master parameter
  }

  // read all category
  Future<List<CategoryModel>> readCategory(
      Database? db, SqlDatabase instance, int isDefault) async {
    final db = await instance.database;

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

  Future<int> updateCategory(Database? db, SqlDatabase instance, int idCategory,
      Category valueCategory) async {
    final db = await instance.database;
    int result = 0;

    if (db != null) {
      return result = await db.rawUpdate('''UPDATE $tableMasterCategory
          SET
          name = ?
          , iconName = ?
          , createdTime = ?
          , modifieldTime = ?
          , isDefault = ?
          WHERE id = ?''', [
        valueCategory.name,
        valueCategory.iconName,
        valueCategory.createdTime,
        valueCategory.modifieldTime,
        valueCategory.isDefault,
        '$idCategory'
      ]);
    }
    return result;
  }

  Future<void> deleteCategoryByID(Database? db, int idCategory) async {
    if (db != null) {
      await db.rawDelete('''
      DELETE FROM $tableMasterCategory WHERE id = ? ''', [idCategory]);
    }
  }

  Future<void> deleteAllData(Database? db) async {
    if (db != null) {
      await db.rawDelete(''' DELETE FROM $tableTransaction ; ''');
      await db.rawDelete(
          ''' DELETE FROM $tableMasterCategory where isDefault != 1; ''');
    }
  }

  Future<int> createNewTransaction(Database? db, SqlDatabase instance,
      trx.Transaction valueTransaction) async {
    final db = await instance.database;
    int result = 0;
    if (db != null) {
      result = await db.rawInsert('''
      INSERT INTO $tableTransaction (isOutcome, idCategory, title, description, amount, idWallet, createdTime, isModifield, modifieldTrxTime)
      VALUES
      (
        '${valueTransaction.isOutcome}'
        ,'${valueTransaction.idCategory}'
        ,'${valueTransaction.title}'
        ,'${valueTransaction.description}'
        ,'${valueTransaction.amount}'
        ,'${valueTransaction.idWallet}'
        ,'${valueTransaction.createdTime}'
        ,'${valueTransaction.isModifield}'
        ,'${valueTransaction.modifieldTrxTime}'
        );
      ''');
    }
    return result;
  }

  // Future<List<TransactionModel>>
  Future<List<TransactionModel>> readTransaction(
      Database? db, SqlDatabase instance,
      {required String date}) async {
    String query = """select tr.id 
            ,tr.isOutcome
            ,tr.idCategory
            ,tr.title
            ,tr.description
            ,tr.amount
            ,tr.idWallet
            ,tr.createdTime
            ,tr.isModifield
            ,tr.modifieldTrxTime
            ,mc.name as categoryName
            ,mc.iconName as categoryIconName            
          from $tableTransaction tr join $tableMasterCategory mc on tr.idCategory = mc.id where tr.createdTime like '%$date%'
          ;""";
    if (db != null) {
      final result = await db.rawQuery(''' $query ''');
      final datas = result.map((e) => TransactionModel.fromJson(e)).toList();
      return datas;
    } else {
      throw Exception('DB is NULL');
    }
  }

  Future<List<CalculationModel>> readCalculation(
      Database? db, SqlDatabase instance,
      {required String date}) async {
    String query = """ 
     SELECT
      CAST(IFNULL(sum(income),0.0) as double) as income,
      CAST(IFNULL(sum(expense),0.0) as double) as expense,
      CAST(IFNULL(sum(income) ,0.0)- IFNULL(sum(expense) ,0.0) as double) as profit
    from (
          SELECT
            IFNULL(amount,0.0) as income
            , IFNULL(0.0,0.0) as expense
            from th_transaction
            where 
            isOutcome = 0
            and createdTime like '%$date%'
          UNION ALL
          SELECT
            IFNULL(0,0.0) as income
            , IFNULL(amount,0.0) as expense
            from th_transaction
            where 
            isOutcome = 1
            and createdTime like '%$date%'
          ) 
      """;

    if (db != null) {
      final result = await db.rawQuery(''' $query ''');

      final datas = result.map((e) => CalculationModel.fromJson(e)).toList();
      return datas;
    } else {
      throw Exception('DB is NULL');
    }
  }

  Future<List<ChartCalculationModel>> readChartDefault(
    Database? db,
    SqlDatabase instance, {
    required String date,
    required OptionDate optionDate,
    required int isOutcome,
  }) async {
    String dateSub = "";

    switch (optionDate) {
      case OptionDate.month:
        dateSub = date.substring(0, 7);
        break;
      default:
        dateSub = date.substring(0, 7);
    }

    String query = """     
        select 
      A.categoryName as categoryName
      , A.amount as amount
      , A.persentase as persentase
      , B.int_code  as colors
    from
    (
      select 
        row_number() over (order by ct.name) as row_num
        ,ct.name as categoryName
        , sum(trx.amount) as amount 
        , round(sum(trx.amount) * 100.0 / sum(sum(trx.amount)) over(),2) as persentase 
      from $tableTransaction trx
      join $tableMasterCategory ct on ct.id = trx.idCategory
        where 
          trx.idCategory <> 0
          and trx.isOutcome = $isOutcome
          and trx.createdTime like '%$dateSub%'
          group by ct.name
    ) A
    join
    (
      select 
        row_number() over (order by name) as row_num
        , id
        , name
        , hex_code
        , int_code
        , rgb_code
        
      from $tableMasterColors
    ) B
    on  A.row_num=B.row_num
    ORDER BY A.persentase
    """;

    if (db != null) {
      final result = await db.rawQuery(''' $query ''');
      final datas =
          result.map((e) => ChartCalculationModel.fromJson(e)).toList();
      return datas;
    } else {
      throw Exception('DB is NULL');
    }
  }

  // delete transaction
  Future<void> deleteTransactionByID(Database? db, int idTransaction) async {
    if (db != null) {
      await db.rawDelete('''
      DELETE FROM $tableTransaction WHERE id = ? ''', [idTransaction]);
    }
  }

  // update transaction
  Future<int> updateTransaction(Database? db, SqlDatabase instance,
      int idTransaction, trx.Transaction valueTransaction) async {
    final db = await instance.database;
    int result = 0;

    if (db != null) {
      result = await db.rawUpdate('''UPDATE $tableTransaction
          SET
          isOutcome = ?
          , idCategory = ?
          , title = ?
          , description = ?
          , amount = ?
          , idWallet = ?
          , createdTime = ?
          , isModifield = ?
          , modifieldTrxTime = ?          
          WHERE id = ?''', [
        valueTransaction.isOutcome,
        valueTransaction.idCategory,
        valueTransaction.title,
        valueTransaction.description,
        valueTransaction.amount,
        valueTransaction.idWallet,
        valueTransaction.createdTime,
        valueTransaction.isModifield,
        valueTransaction.modifieldTrxTime,
        '$idTransaction'
      ]);
    }
    return result;
  }

  // --- parameter ---
  // read parameter themes
  Future<List<Map<String, dynamic>>> readParamThemes(
      Database? db, SqlDatabase instance) async {
    final db = await instance.database;

    String query = """select value from $tableMasterParameter 
        where name = 'isDark' limit 1 ;""";

    if (db != null) {
      final result = await db.rawQuery(''' $query ''');
      return result;
    } else {
      throw Exception('DB is NULL');
    }
  }

  // read passcode exist
  Future<bool> readParamPasscodeExist(
      Database? db, SqlDatabase instance) async {
    final db = await instance.database;

    String query =
        """ select value from $tableMasterParameter where name = 'user_passcode' limit 1; """;

    if (db != null) {
      final result = await db.rawQuery(''' $query''');
      return (result.first.values.first.toString() == defaultPasscode) // 00000
          ? false
          : true;
    } else {
      throw Exception('DB is null');
    }
  }

  // read passcode value
  Future<String> readParamPasscodeValue(
      Database? db, SqlDatabase instance) async {
    final db = await instance.database;

    String query =
        """ select value from $tableMasterParameter where name = 'user_passcode' limit 1; """;

    if (db != null) {
      final result = await db.rawQuery(''' $query''');
      // return (result.first.values.first.toString() ==
      //         'wGDY8UmGNMtA9Gj17JoeQQ==') // 00000
      //     ? false
      //     : true;
      return result.first.values.first.toString();
    } else {
      throw Exception('DB is null');
    }
  }

  // update parameter themes
  Future<int> updateParamThemes(
      Database? db, SqlDatabase instance, String valueParam) async {
    final db = await instance.database;
    int result = 0;
    print("valueParam : $valueParam");

    if (db != null) {
      result = await db.rawUpdate("""UPDATE $tableMasterParameter
          SET
          value = ?
          WHERE name = 'isDark' """, [valueParam]);
    }
    return result;
  }

  // read passcode exist
  Future<bool> savingNewPasscode(
    Database? db,
    SqlDatabase instance,
    String valuePasscode,
  ) async {
    final db = await instance.database;
    int result = 0;

    if (db != null) {
      result = await db.rawUpdate("""UPDATE $tableMasterParameter
          SET
          value = ?
          WHERE name = 'user_passcode'
          and actived = 1
          """, [valuePasscode]);
    }
    return (result == 1) ? true : false;
  }

  // -- end paramter ----------------------------------------------------------

  insertMasterParameter(Database db, String tableMasterParamter) async {
    await db.rawInsert(
        ''' INSERT INTO $tableMasterParameter (name, value, actived, description) VALUES ('isDark', '0', 1, 'Default Themes of Application');   ''');
    await db.rawInsert(
        ''' INSERT INTO $tableMasterParameter (name, value, actived, description) VALUES ('user_passcode', 'wGDY8UmGNMtA9Gj17JoeQQ==', 1, 'User Passcode');   ''');
  }

  inserMasterColors(Database db, String tableMasterColors) async {
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('maroon', '800000', 8388608, '(128,0,0)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('brown', 'A52A2A', 10824234, '(165,42,42)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('crimson', 'DC143C', 14423100, '(220,20,60)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('tomato', 'FF6347', 16737095, '(255,99,71)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('indian red', 'CD5C5C', 13458524, '(205,92,92)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('dark salmon', 'E9967A', 15308410, '(233,150,122)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('salmon', 'FA8072', 16416882, '(250,128,114)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('orange red', 'FF4500', 16729344, '(255,69,0)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('dark orange', 'FF8C00', 16747520, '(255,140,0)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('gold', 'FFD700', 16766720, '(255,215,0)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('dark golden rod', 'B8860B', 12092939, '(184,134,11)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('golden rod', 'DAA520', 14329120, '(218,165,32)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('pale golden rod', 'EEE8AA', 15657130, '(238,232,170)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('dark khaki', 'BDB76B', 12433259, '(189,183,107)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('khaki', 'F0E68C', 15787660, '(240,230,140)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('olive', '808000', 8421376, '(128,128,0)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('yellow', 'FFFF00', 16776960, '(255,255,0)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('yellow green', '9ACD32', 10145074, '(154,205,50)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('dark olive green', '556B2F', 5597999, '(85,107,47)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('olive drab', '6B8E23', 7048739, '(107,142,35)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('lawn green', '7CFC00', 8190976, '(124,252,0)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('dark green', '6400', 25600, '(0,100,0)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('forest green', '228B22', 2263842, '(34,139,34)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('lime green', '32CD32', 3329330, '(50,205,50)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('light green', '90EE90', 9498256, '(144,238,144)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('dark sea green', '8FBC8F', 9419919, '(143,188,143)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('medium spring green', '00FA9A', 64154, '(0,250,154)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('spring green', '00FF7F', 65407, '(0,255,127)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('sea green', '2E8B57', 3050327, '(46,139,87)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('medium aquamarine', '66CDAA', 6737322, '(102,205,170)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('medium sea green', '3CB371', 3978097, '(60,179,113)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('light sea green', '20B2AA', 2142890, '(32,178,170)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('dark slate gray', '2F4F4F', 3100495, '(47,79,79)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('dark cyan', '008B8B', 35723, '(0,139,139)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('aqua', '00FFFF', 65535, '(0,255,255)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('light cyan', 'E0FFFF', 14745599, '(224,255,255)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('dark turquoise', '00CED1', 52945, '(0,206,209)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('turquoise', '40E0D0', 4251856, '(64,224,208)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('pale turquoise', 'AFEEEE', 11529966, '(175,238,238)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('aquamarine', '7FFFD4', 8388564, '(127,255,212)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('powder blue', 'B0E0E6', 11591910, '(176,224,230)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('cadet blue', '5F9EA0', 6266528, '(95,158,160)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('steel blue', '4682B4', 4620980, '(70,130,180)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('cornflower blue', '6495ED', 6591981, '(100,149,237)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('deep sky blue', '00BFFF', 49151, '(0,191,255)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('dodger blue', '1E90FF', 2003199, '(30,144,255)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('light blue', 'ADD8E6', 11393254, '(173,216,230)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('sky blue', '87CEEB', 8900331, '(135,206,235)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('light sky blue', '87CEFA', 8900346, '(135,206,250)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('midnight blue', '191970', 1644912, '(25,25,112)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('medium blue', '0000CD', 205, '(0,0,205)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('blue', '0000FF', 255, '(0,0,255)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('royal blue', '41690', 267920, '(65,105,225)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('blue violet', '8A2BE2', 9055202, '(138,43,226)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('indigo', '4B0082', 4915330, '(75,0,130)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('slate blue', '6A5ACD', 6970061, '(106,90,205)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('medium slate blue', '7B68EE', 8087790, '(123,104,238)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('medium purple', '9370DB', 9662683, '(147,112,219)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('dark magenta', '8B008B', 9109643, '(139,0,139)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('dark violet', '9400D3', 9699539, '(148,0,211)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('medium orchid', 'BA55D3', 12211667, '(186,85,211)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('purple', '800080', 8388736, '(128,0,128)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('thistle', 'D8BFD8', 14204888, '(216,191,216)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('plum', 'DDA0DD', 14524637, '(221,160,221)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('violet', 'EE82EE', 15631086, '(238,130,238)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('fuchsia', 'FF00FF', 16711935, '(255,0,255)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('orchid', 'DA70D6', 14315734, '(218,112,214)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('medium violet red', 'C71585', 13047173, '(199,21,133)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('pale violet red', 'DB7093', 14381203, '(219,112,147)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('deep pink', 'FF1493', 16716947, '(255,20,147)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('hot pink', 'FF69B4', 16738740, '(255,105,180)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('light pink', 'FFB6C1', 16758465, '(255,182,193)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('pink', 'FFC0CB', 16761035, '(255,192,203)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('beige', 'F5F5DC', 16119260, '(245,245,220)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('blanched almond', 'FFEBCD', 16772045, '(255,235,205)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('light yellow', 'FFFFE0', 16777184, '(255,255,224)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('saddle brown', '8B4513', 9127187, '(139,69,19)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('sienna', 'A0522D', 10506797, '(160,82,45)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('chocolate', 'D2691E', 13789470, '(210,105,30)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('peru', 'CD853F', 13468991, '(205,133,63)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('sandy brown', 'F4A460', 16032864, '(244,164,96)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('burly wood', 'DEB887', 14596231, '(222,184,135)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('tan', 'D2B48C', 13808780, '(210,180,140)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('rosy brown', 'BC8F8F', 12357519, '(188,143,143)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('moccasin', 'FFE4B5', 16770229, '(255,228,181)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('misty rose', 'FFE4E1', 16770273, '(255,228,225)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('lavender blush', 'FFF0F5', 16773365, '(255,240,245)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('linen', 'FAF0E6', 16445670, '(250,240,230)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('old lace', 'FDF5E6', 16643558, '(253,245,230)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('papaya whip', 'FFEFD5', 16773077, '(255,239,213)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('sea shell', 'FFF5EE', 16774638, '(255,245,238)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('light slate gray', '778899', 7833753, '(119,136,153)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('light steel blue', 'B0C4DE', 11584734, '(176,196,222)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('lavender', 'E6E6FA', 15132410, '(230,230,250)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('floral white', 'FFFAF0', 16775920, '(255,250,240)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('alice blue', 'F0F8FF', 15792383, '(240,248,255)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('ghost white', 'F8F8FF', 16316671, '(248,248,255)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('honey dew', 'F0FFF0', 15794160, '(240,255,240)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('ivory', 'FFFFF0', 16777200, '(255,255,240)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('azure', 'F0FFFF', 15794175, '(240,255,255)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('snow', 'FFFAFA', 16775930, '(255,250,250)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('black', '0', 0, '(0,0,0)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('dark gray / dark grey', 'A9A9A9', 11119017, '(169,169,169)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('gainsboro', 'DCDCDC', 14474460, '(220,220,220)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('white smoke', 'F5F5F5', 16119285, '(245,245,245)') ''');
    await db.rawInsert(
        '''  INSERT INTO $tableMasterColors (name, hex_code, int_code, rgb_code) VALUES ('white', 'FFFFFF', 16777215, '(255,255,255)') ''');
  }

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
