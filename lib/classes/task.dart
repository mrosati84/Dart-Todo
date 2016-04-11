import 'package:todo/classes/task_request.dart';
import 'dart:math';

class Task {
  int id;
  String text;
  bool done;

  Task(String text, bool done) {
    Random rng = new Random();
    this.id = rng.nextInt(10000);
    this.text = text;
    this.done = done;
  }

  Task.fromRequest(TaskRequest request) {
    Random rng = new Random();
    this.id = rng.nextInt(10000);
    this.text = request.text;
    this.done = request.done;
  }

  void updateWithRequest(TaskRequest request) {
    this.text = request.text;
    this.done = request.done;
  }
}
