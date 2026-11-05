import 'dart:io';

import 'package:shelf/shelf_io.dart';
import 'package:shelf_tree/shelf_tree.dart';

void main(List<String> args) async {
  // Configure your tree
  final tree = RouterTree(
    '/',
    methods: RouteMethodsIndex(),
    branches: [
      RouterTree('/echo/<message>', methods: RouteMethodsEcho()),
      RouterTree(
        '/<userId>',
        branches: [
          RouterTree(
            '/profile',
            methods: RouteMethodsProfile(),
            branches: [RouterTree('/settings', methods: RouteMethodsProfileSettings())],
          ),
        ],
      ),
    ],
  );

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(tree.handler, ip, port);
  print('Server listening on port ${server.port}');
}

class RouteMethodsIndex extends RouteMethods {
  @override
  RouteResponse get(RouteRequest request) {
    return RouteResponse(HttpCode.s200, body: 'Welcom to new era!');
  }

  @override
  Middleware get middleware {
    return logRequests();
  }
}

class RouteMethodsEcho extends RouteMethods {
  @override
  RouteResponse get(RouteRequest request) {
    final message = request.params['message'];
    return RouteResponse(HttpCode.s200, body: 'its eeeechoooo! Your message: $message');
  }
}

class RouteMethodsProfile extends RouteMethods {
  @override
  RouteResponse get(RouteRequest request) {
    final userId = request.params['userId'];
    return RouteResponse(HttpCode.s200, body: 'This is profile. User: $userId');
  }
}

class RouteMethodsProfileSettings extends RouteMethods {
  @override
  RouteValidator get validator =>
      RouteValidator(get: RouteMethodValidator(queryKeys: ['includeTheme']));

  @override
  RouteResponse get(RouteRequest request) {
    final userId = request.params['userId'];
    final includeTheme = request.queryParameters['includeTheme'];
    return RouteResponse(
      HttpCode.s200,
      body: 'This is profile. User: $userId | include theme $includeTheme',
    );
  }
}
