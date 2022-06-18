import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServidorHandler {
  Handler get handler {
    final router = Router();
    router.get('/', (Request request) {
      return Response(200,
          body: '<h1>Primeira rota</h1>',
          headers: {'content-type': 'text/html'});
    });
    // http:localhost:3000/ola/mundo
    router.get('/ola/mundo/<usuario>', (
      Request req,
      String usuario,
    ) {
      return Response.ok('Ola mundo de $usuario');
    });
    // http:localhost:3000/query?nome=Enzo
    router.get('/query', (Request req) {
      String? nome = req.url.queryParameters['nome'];
      String? idade = req.url.queryParameters['idade'];
      return Response.ok('Query eh: $nome, idade $idade');
    });

    router.post('/login', (Request req) async {
      var result = await req.readAsString();
      Map json = jsonDecode(result);

      var usuario = json['email'];
      var senha = json['senha'];

      if (usuario == 'enzo.danjour@gmail.com' && senha == 123) {
        var json = jsonEncode({'token': 'token123', 'user_id': 1});
        return Response.ok(json, headers: {
          'content-type': 'application/json',
        });
      } else {
        return Response.forbidden('Acesso negado');
      }
    });

    return router;
  }
}
