import 'dart:convert';

import 'package:shelf_tree/shelf_tree.dart';

class RouteRequest {
  const RouteRequest(this._request, this.body);

  static Future<RouteRequest> fromRequest(Request request) async {
    return RouteRequest(request, await request.readAsString());
  }

  final Request _request;
  final String body;

  Map<String, dynamic> get bodyAsJson => jsonDecode(body);
  Map<String, dynamic> get params => _request.params;
  Map<String, dynamic> get headers => _request.headers;
  Map<String, dynamic> get context => _request.context;
  HttpMethod get method => HttpMethod.fromString(_request.method);

  Uri get url => _request.url;
  Map<String, dynamic> get queryParameters => _request.url.queryParameters;

  Future<void> validateByValidator(RouteValidator validator) async {
    final routeValidator = switch (method) {
      HttpMethod.GET => validator.get,
      HttpMethod.POST => validator.post,
      HttpMethod.PUT => validator.put,
      HttpMethod.DELETE => validator.delete,
      HttpMethod.PATCH => throw UnimplementedError(),
      HttpMethod.OPTIONS => throw UnimplementedError(),
      HttpMethod.HEAD => throw UnimplementedError(),
      HttpMethod.TRACE => throw UnimplementedError(),
      HttpMethod.CONNECT => throw UnimplementedError(),
    };

    if (routeValidator != null) await _validateRouteMethod(routeValidator);
  }

  Future<void> _validateRouteMethod(RouteMethodValidator validator) async {
    if (validator.bodyKeys.isNotEmpty) await _checkKeysInBody(validator.bodyKeys);
    if (validator.queryKeys.isNotEmpty) _checkKeysInQueryParameters(validator.queryKeys);
  }

  void _checkKeysInQueryParameters(List<String> keys) {
    for (final key in keys) {
      if (!queryParameters.containsKey(key)) {
        throw RouteException(
          response: RouteResponse(HttpCode.ce400, body: 'Not found key in the query parameters'),
        );
      }
    }
  }

  Future<void> _checkKeysInBody(List<String> keys) async {
    for (final key in keys) {
      if (!bodyAsJson.containsKey(key)) {
        throw RouteException(
          response: RouteResponse(HttpCode.ce400, body: 'Not found key in the body'),
        );
      }
    }
  }
}
