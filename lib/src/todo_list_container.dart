import 'package:flutter/material.dart';
import 'package:todo_list_app/src/todo_header.dart';
import 'package:todo_list_app/src/todo_list.dart';

class TodoListContainer extends StatelessWidget {
  const TodoListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Column(
        children: [
          TodoHeader(),
          Expanded(child: TodoList())
        ],
      )
    );
  }
}

