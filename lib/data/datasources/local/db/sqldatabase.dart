import 'package:money_app/data/datasources/local/db/sqlhelper.dart';
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
    print('lokasi db : $dbPath');
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

  //read all
  Future<List<CategoryModel>> readCategory(int isDefault) async {
    final db = await instance.database;
    // const orderBy = 'createdTime ASC';
    final result = await sqlHelper.readCategory(db, instance, isDefault);
    print("==result readCategory : $result");
    return result;
  }

  //read all
  Future<CategoryModel> readCategoryById(int idCategory) async {
    final db = await instance.database;
    final result = await sqlHelper.readCategoryById(db, instance, idCategory);
    print("==result readCategoryById : $result");
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

// // read all master category
//   Future<List<CategoryMasterModel>> readAllCategoryMaster() async {
//     final db = await instance.database;

//     if (db != null) {
//       final result = await db.rawQuery(
//           ''' select id, name, iconName from $tableMasterCategory; ''');

//       // print('===> $result');
//       return result.map((e) => CategoryMasterModel.fromJson(e)).toList();
//     } else {
//       throw Exception('DB is NULL');
//     }
//   }

  // read note by id
  // Future<NotesModel?> readNoteByID(int id) async {
  //   final db = await instance.database;

  //   if (db != null) {
  //     final result =
  //         await db.query(tableNotes, where: 'id = ?', whereArgs: [id]);

  //     if (result.isNotEmpty) {
  //       return NotesModel.fromJson(result.first);
  //     }
  //     return null;
  //   } else {
  //     throw Exception('DB is NULL');
  //   }
  // }

  // delete data table note
  // Future<int> deleteTableNotes() async {
  //   final db = await instance.database;

  //   if (db != null) {
  //     return await db.rawDelete(''' DELETE FROM $tableOpsCategory''');
  //   }
  //   return 0;
  // }

  // Future<int> updateNote(int id, NotesModel note) async {
  //   final db = await instance.database;
  //   int result = 0;

  //   if (db != null) {
  //     return result = await db.rawUpdate('''UPDATE $tableNotes
  //         SET
  //         title = ?
  //         , content = ?
  //         , noteColor = ?
  //         , createdTime = ?
  //         , modifieldTime = ?
  //         WHERE id = ?''', [
  //       note.title,
  //       note.content,
  //       note.noteColor,
  //       '${note.createdTime}',
  //       '${note.modifieldTime}',
  //       '$id'
  //     ]);
  //     // return result = await db
  //     //     .update(tableNotes, note.toJson(), where: 'id = ?', whereArgs: [id]);
  //   }

  //   return result;
  // }

  // delete note by id
  // Future<void> deleteNoteByID(int id) async {
  //   final db = await instance.database;

  //   if (db != null) {
  //     // ('DELETE FROM Test WHERE name = ?', ['another name']);
  //     await db.rawDelete('''
  //     DELETE FROM $tableNotes WHERE id = ? ''', [id]);
  //     // return result;
  //   }
  // }
}
