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

  Task.fromMap(taskMap) {
    this.id = taskMap['id'];
    this.text = taskMap['text'];
    this.done = taskMap['done'];
  }
}
