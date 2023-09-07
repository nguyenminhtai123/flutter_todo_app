import 'package:flutter/material.dart';
import 'package:todo_list_app/bloc/todo_bloc.dart';
import 'package:todo_list_app/src/todo_list_container.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Scaffold(
        appBar: AppBar(
          title: const Text('Todo App')
        ),
        body:  Provider<TodoBloc>.value(
          value: TodoBloc(),
          child: const TodoListContainer()
        )
      )
    );
  }
}

