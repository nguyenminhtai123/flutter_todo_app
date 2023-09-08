// ignore_for_file: constant_identifier_names

import 'package:sqflite/sqflite.dart';
import 'package:todo_list_app/db/todo_database.dart';
import 'package:todo_list_app/model/todo.dart';

class TodoTable {
  static const TABLE_NAME = 'todo';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME (
      id PRIMARY KEY,
      content TEXT
    );
  ''';
  static const DROP_TABLE_QUERY = '''
    DROP TABLE IF EXISTS $TABLE_NAME
  ''';

  Future<int> insertTodo(Todo todo) {
    final Database? db = TodoDatabase.instance.database;
    return db!.insert(
      TABLE_NAME, 
      todo.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ignore: body_might_complete_normally_nullable
  Future<void> deleteTodo(Todo todo) async {
    final Database? db = TodoDatabase.instance.database;
    await db!.delete(
      TABLE_NAME,
      where: 'id = ?',
      whereArgs: [todo.id]
    );
  }

  Future<List<Todo>> selectAllTodo() async {
    final Database? db = TodoDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db!.query('todo');

    return List.generate(maps.length, (index) {
      return Todo.fromData(
        maps[index]['id'],
        maps[index]['content']
      );
    });
  }
}