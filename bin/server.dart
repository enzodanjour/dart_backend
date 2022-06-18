import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'servidor_handler.dart';

void main() async {
  var sh = ServidorHandler();
  final server = await shelf_io.serve(
    sh.handler,
    'localhost',
    3000,
  );
}
