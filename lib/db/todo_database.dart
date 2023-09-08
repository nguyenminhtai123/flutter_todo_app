import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_app/db/todo_table.dart';

class TodoDatabase {
  static const DB_NAME = 'todo.db';
  static const DB_VERSION = 1;
  static Database? _database;

  TodoDatabase._internal();
  static final TodoDatabase instance =  TodoDatabase._internal();

  Database? get database => _database;

  static const initScripts = [TodoTable.CREATE_TABLE_QUERY];
  static const migrationScripts = [TodoTable.CREATE_TABLE_QUERY];

  init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: DB_VERSION,
      onCreate: (db, version) async {
        initScripts.forEach((script) async => 
            await db.execute(script)
        );
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        migrationScripts.forEach((script) async => 
          await db.execute(script)
        );
      }, 
    );
  }
}