import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/bloc/todo_bloc.dart';
import 'package:todo_list_app/event/delete_todo_event.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var bloc = Provider.of<TodoBloc>(context);
    bloc.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoBloc>(
      builder: (context, bloc, child) => StreamBuilder(
        stream: bloc.todoListStream,
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.active: 
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      snapshot.data![index].content!,
                      style: const TextStyle(fontSize: 20),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        bloc.event.add(DeleteTodoEvent(snapshot.data![index]));
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red.shade300
                      )
                    ),
                  );
                }
              );

            case ConnectionState.waiting:
              return const Center(
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Text(
                    'Empty',
                    style: TextStyle(fontSize: 20)
                  )
                )
              );

            case ConnectionState.none: 

            default: 
              return const Center(
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(),
                )
              );
          }
        } 
      ),
    );
  }
}