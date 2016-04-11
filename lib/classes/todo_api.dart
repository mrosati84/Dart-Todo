import 'package:rpc/rpc.dart';
import 'package:todo/classes/task.dart';
import 'package:todo/classes/task_request.dart';
import 'package:todo/classes/todo_list.dart';

TodoList todoList = new TodoList();

@ApiClass(name: 'todo', version: 'v1', description: 'Api class for todo tasks')
class TodoApi {
  /// GET todo/v1/tasks
  @ApiMethod(method: 'GET', path: 'tasks')
  List<Task> tasks() {
    return todoList.list;
  }

  /// POST todo/v1/tasks
  @ApiMethod(method: 'POST', path: 'tasks')
  Task addTask(TaskRequest request) {
    Task task = new Task(request.text, request.done);
    todoList.add(task);
    return task;
  }

  /// DELETE todo/v1/tasks/{id}
  @ApiMethod(method: 'DELETE', path: 'tasks/{id}')
  Task deleteTask(int id) {
    Task found;

    todoList.list.forEach((Task task) {
      if (task.id == id) {
        found = task;
      }
    });

    if (found != null) {
      todoList.remove(found);
    } else {
      throw new NotFoundError("task with id ${id.toString()} not found");
    }

    return found;
  }

  /// PUT todo/v1/tasks/{id}
  @ApiMethod(method: 'PUT', path: 'tasks/{id}')
  Task updateTask(int id, TaskRequest taskRequest) {
    Task found;

    todoList.list.forEach((Task task) {
      if (task.id == id) {
        found = task;
      }
    });

    if (found != null) {
      found.text = taskRequest.text;
      found.done = taskRequest.done;
    } else {
      throw new NotFoundError("task with id ${id.toString()} not found");
    }

    return found;
  }
}
