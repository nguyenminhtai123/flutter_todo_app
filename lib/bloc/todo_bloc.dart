// ignore_for_file: override_on_non_overriding_member, unnecessary_overrides

import 'dart:async';
import 'dart:math';
import 'package:todo_list_app/base/base_bloc.dart';
import 'package:todo_list_app/base/base_event.dart';
import 'package:todo_list_app/db/todo_table.dart';
import 'package:todo_list_app/event/add_todo_event.dart';
import 'package:todo_list_app/event/delete_todo_event.dart';
import 'package:todo_list_app/model/todo.dart';

class TodoBloc extends BaseBloc {

  // ignore: prefer_final_fields
  TodoTable _todoTable = TodoTable();
  
  final StreamController<List<Todo>> _todoListStreamController = 
    StreamController<List<Todo>>();
  Stream<List<Todo>> get todoListStream => _todoListStreamController.stream;

  final _randomInt = Random();
  List<Todo> _todoListData = [];

  initData() async {
      _todoListData = await _todoTable.selectAllTodo();
      if (_todoListData == null) {
        return;
      }

      _todoListStreamController.sink.add(_todoListData);
  }

  _addTodo(Todo todo) async {
    await _todoTable.insertTodo(todo);

    _todoListData.add(todo);
    _todoListStreamController.sink.add(_todoListData);

  }

  _deleteTodo(Todo todo) async {
    await _todoTable.deleteTodo(todo);

    _todoListData.remove(todo);
    _todoListStreamController.sink.add(_todoListData);

  }

  @override
  void dispatchEvent(BaseEvent event) {
    if (event is AddTodoEvent) {
      Todo todo =  Todo.fromData(
        _randomInt.nextInt(1000000), 
        event.content, 
      );
      _addTodo(todo);
    } else if (event is DeleteTodoEvent) {
      _deleteTodo(
        event.todo
      );
    }
  }

  @override
  void dispose()  {
    super.dispose();
  }
}