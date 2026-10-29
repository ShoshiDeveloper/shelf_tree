import 'package:shelf/shelf.dart';

abstract class RouteMethods {
  const RouteMethods();

  Response get(Request request) {
    throw UnimplementedError();
  }

  Response post(Request request) {
    throw UnimplementedError();
  }

  Response put(Request request) {
    throw UnimplementedError();
  }

  Response delete(Request request) {
    throw UnimplementedError();
  }
}

abstract class RouteMethodsWithMiddleware extends RouteMethods {
  const RouteMethodsWithMiddleware();

  Middleware middleware() {
    throw UnimplementedError();
  }
}
