// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:convert';
import 'package:dart_todo/classes/task.dart';

UListElement todos = querySelector('#todos');
UListElement done = querySelector('#done');
InputElement todo = querySelector('#todo');
SpanElement todosCount = querySelector('#todos-count');
SpanElement doneCount = querySelector('#done-count');
final String API_PATH = 'http://127.0.0.1:9000/todo/v1/tasks';
final int ENTER = 13;

void main() {
  HttpRequest request = new HttpRequest();
  request.open('GET', API_PATH);
  request.send();
  request.onReadyStateChange.listen((e) {
    if (request.readyState == HttpRequest.DONE && request.status == 200) {
      List tasks = JSON.decode(request.responseText);
      tasks.forEach((Map task) {
        appendTask(new Task.fromMap(task));
      });

      if (tasks.length == 0) {
        updateCounters();
      }
    }
  });

  todo.onKeyPress.listen((e) {
    if (e.keyCode == ENTER) {
      if (todo.value.trim().toString().isNotEmpty) {
        Task task = new Task(todo.value, false);
        createRemoteTask(task);
        todo.value = '';
      }
    }
  });
}

/// Appends the new [task] to the DOM
void appendTask(Task task) {
  LIElement li = new LIElement()
    ..innerHtml = task.text + ' - ';

  if (task.done) {
    li.setAttribute('class', 'done');
    li.setAttribute('data-done', 'true');
  } else {
    li.setAttribute('data-done', 'false');
  }

  AnchorElement doneAnchor = new AnchorElement(href: '#!/done/${task.id.toString()}');
  doneAnchor.innerHtml = '[done]';

  AnchorElement deleteAnchor = new AnchorElement(href: '#!/delete/${task.id.toString()}');
  deleteAnchor.innerHtml = '[delete]';

  doneAnchor.onClick.listen((e) => updateTaskStatus(e, task, li));
  deleteAnchor.onClick.listen((e) => deleteTask(e, task, li));

  li.append(doneAnchor);
  li.append(new SpanElement()..innerHtml = '&nbsp;');
  li.append(deleteAnchor);

  if (task.done) {
    done.children.add(li);
  } else {
    todos.children.add(li);
  }

  updateCounters();
}

/// Delete the [task] and remove the [li] container item.
deleteTask(Event e, Task task, LIElement li) {
  e.preventDefault();

  HttpRequest request = new HttpRequest();
  request.open('DELETE', '${API_PATH}/${task.id.toString()}');
  request.setRequestHeader('Content-Type', 'application/json');
  request.send();
  request.onReadyStateChange.listen((e) {
    li.remove();
    updateCounters();
  });
}

/// Update the counters on lists titles
void updateCounters() {
  todosCount.innerHtml = '(${todos.children.length.toString()})';
  doneCount.innerHtml = '(${done.children.length.toString()})';
}

/// Updates the existing [task] when clicking on task link
/// through the event [e]. The relative [li] is updated
/// accordingly.
void updateTaskStatus(Event e, Task task, LIElement li) {
  e.preventDefault();

  if (li.getAttribute('data-done') == 'true') {
    task.done = false;
    li.setAttribute('class', '');
    li.setAttribute('data-done', '');

    todos.children.add(li);
  } else {
    task.done = true;
    li.setAttribute('class', 'done');
    li.setAttribute('data-done', 'true');

    done.children.add(li);
  }

  updateRemoteTask(task);
  updateCounters();
}

/// Creates a new [task] on the server.
void createRemoteTask (Task task) {
  HttpRequest request = new HttpRequest();
  request.open('POST', API_PATH);
  request.setRequestHeader('Content-Type', 'application/json');
  request.send(JSON.encode({
    'text': task.text,
    'done': task.done
  }));
  request.onReadyStateChange.listen((e) {
    if (request.readyState == HttpRequest.DONE && request.status == 200) {
      Task newTask = new Task.fromMap(JSON.decode(request.responseText));
      appendTask(newTask);
    }
  });
}

/// Query the API to update the [task].
void updateRemoteTask(Task task) {
  HttpRequest request = new HttpRequest();
  request.open('PUT', '${API_PATH}/${task.id.toString()}');
  request.setRequestHeader('Content-Type', 'application/json');
  request.send(JSON.encode({
    'text': task.text,
    'done': task.done
  }));
  request.onReadyStateChange.listen((e) {});
}
