import 'task.dart';

class TodoList {
  List<Task> list;

  TodoList() {
    this.list = new List<Task>();
  }

  void remove(Task task) {
    this.list.remove(task);
  }

  void add(Task task) {
    this.list.add(task);
  }
}
