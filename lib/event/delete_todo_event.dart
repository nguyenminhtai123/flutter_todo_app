import 'package:todo_list_app/base/base_event.dart';
import 'package:todo_list_app/model/todo.dart';

class DeleteTodoEvent  extends BaseEvent{
  Todo todo;

  DeleteTodoEvent(this.todo);
}