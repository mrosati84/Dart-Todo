import 'dart:io';
import 'dart:async';
import 'package:rpc/rpc.dart';
import 'package:logging/logging.dart';
import 'package:dart_todo/classes/todo_api.dart';
import 'package:dart_todo/classes/todo_logger.dart';

final ApiServer _apiServer = new ApiServer(prettyPrint: true);
final int port = 9000;

Future main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  _apiServer.addApi(new TodoApi());

  HttpServer server = await HttpServer.bind(InternetAddress.ANY_IP_V4, port);
  server.listen(_apiServer.httpRequestHandler);

  log.fine('Listening on http://${InternetAddress.ANY_IP_V4.address}:${port}');
}
