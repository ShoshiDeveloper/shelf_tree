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
      if (validator != null) await routeRequest.validateByValidator(validator!, routeRequest);

      return (await switch (routeRequest.method) {
        HttpMethod.GET => get(routeRequest),
        HttpMethod.POST => post(routeRequest),
        HttpMethod.PUT => put(routeRequest),
        HttpMethod.DELETE => delete(routeRequest),
        _ => RouteResponse.notFound(body: 'Undefiend method'),
      }).response;
    } on RouteException catch (e) {
      return e.response?.response ?? RouteResponse.internalServerError().response;
    } catch (e, st) {
      /// TODO: add modes for hide e and st in production
      return RouteResponse.internalServerError(body: '$e\n$st').response;
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
