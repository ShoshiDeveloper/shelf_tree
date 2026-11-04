import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_tree/src/index.dart';

class RouteMethodValidator {
  const RouteMethodValidator({this.bodyKeys = const [], this.queryKeys = const []});

  /// Route body of the request must include the keys
  final List<String> bodyKeys;

  /// Route query parameters of the request must include the keys
  final List<String> queryKeys;
}

class RouteValidator {
  const RouteValidator({this.get, this.post, this.put, this.delete});

  final RouteMethodValidator? get;
  final RouteMethodValidator? post;
  final RouteMethodValidator? put;
  final RouteMethodValidator? delete;
}

abstract class RouteMethods {
  const RouteMethods();

  RouteValidator? get validator => null;

  FutureOr<Response> direct(Request request) async {
    try {
      final routeRequest = RouteRequest(request, await request.readAsString());
      if (validator != null) await routeRequest.validateByValidator(validator!);

      return (await switch (request.method.toUpperCase()) {
        'GET' => get(routeRequest),
        'POST' => post(routeRequest),
        'PUT' => put(routeRequest),
        'DELETE' => delete(routeRequest),
        _ => RouteResponse.notFound(body: 'Undefiend method'),
      }).response;
    } on RouteException catch (e) {
      return e.response ?? Response.internalServerError();
    } catch (e) {
      return Response.internalServerError(body: e);
    }
  }

  FutureOr<RouteResponse> get(RouteRequest request) {
    throw UnimplementedError();
  }

  FutureOr<RouteResponse> post(RouteRequest request) {
    throw UnimplementedError();
  }

  FutureOr<RouteResponse> put(RouteRequest request) {
    throw UnimplementedError();
  }

  FutureOr<RouteResponse> delete(RouteRequest request) {
    throw UnimplementedError();
  }

  Middleware? get middleware => null;
}
