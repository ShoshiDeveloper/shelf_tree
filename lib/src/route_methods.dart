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
      if (validator != null) await request.validateByValidator(validator!);

      return await switch (request.method.toUpperCase()) {
        'GET' => get(request),
        'POST' => post(request),
        'PUT' => put(request),
        'DELETE' => delete(request),
        _ => Response.notFound('Undefiend method'),
      };
    } on RouteException catch (e) {
      return e.response ?? Response.internalServerError();
    } catch (e) {
      return Response.internalServerError(body: e);
    }
  }

  FutureOr<Response> get(Request request) {
    throw UnimplementedError();
  }

  FutureOr<Response> post(Request request) {
    throw UnimplementedError();
  }

  FutureOr<Response> put(Request request) {
    throw UnimplementedError();
  }

  FutureOr<Response> delete(Request request) {
    throw UnimplementedError();
  }

  Middleware? get middleware => null;
}
