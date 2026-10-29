import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_tree/shelf_tree.dart';

void main(List<String> args) async {
  // Configure your tree
  final tree = RouterTree(
    '/',
    methods: RouteMethodsIndex(),
    branches: [
      RouterTree('/echo/<message>', methods: RouteMethodsEcho()),
      RouterTree('/<userId>', branches: [RouterTree('/profile', methods: RouteMethodsProfile())]),
    ],
  );

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(tree.handler, ip, port);
  print('Server listening on port ${server.port}');
}

class RouteMethodsIndex extends RouteMethodsWithMiddleware {
  @override
  Response get(Request request) {
    return Response.ok('Welcom to new era!');
  }

  @override
  Middleware middleware() {
    return logRequests();
  }
}

class RouteMethodsEcho extends RouteMethods {
  @override
  Response get(Request request) {
    final message = request.params['message'];
    return Response.ok('its eeeechoooo! Your message: $message');
  }
}

class RouteMethodsProfile extends RouteMethods {
  @override
  Response get(Request request) {
    final userId = request.params['userId'];
    return Response.ok('This is profile. User: $userId');
  }
}
