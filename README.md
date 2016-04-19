# Dart Todo

This project demonstrates how to use Google Dartlang on both client and server to build a REST-api based todo-list application.

## Requirements

To run this project you need the Dart SDK installed on your system. The `dart` and `pub` commands need to be available
in your `$PATH`.

## Building and running the project

From the project root directory, run

```
➜  todo git:(master) pub serve
Loading source assets...
Loading dart_to_js_script_rewriter transformers...
Serving todo web on http://localhost:8080
Build completed successfully
```

And in a separate shell, run the server

```
➜  todo git:(master) dart bin/server.dart
INFO: 2016-04-19 10:04:51.848695: Adding /todo/v1 to set of valid APIs.
FINE: 2016-04-19 10:04:51.880051: Listening on http://0.0.0.0:9000
```

Now open Chromium web browser and open `http://localhost:8080` and start adding your tasks!
