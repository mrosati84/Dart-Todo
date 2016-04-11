import 'package:rpc/rpc.dart';

class TaskRequest {
  @ApiProperty(required: false)
  int id;

  @ApiProperty(required: true)
  String text;

  @ApiProperty(required: true)
  bool done;
}
