import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_tree/shelf_tree.dart';

extension RequestExtension on Request {
  Future<void> validateByValidator(RouteValidator validator) async {
    if (validator.get != null) await _validateRouteMethod(validator.get!);
    if (validator.post != null) await _validateRouteMethod(validator.post!);
    if (validator.put != null) await _validateRouteMethod(validator.put!);
    if (validator.delete != null) await _validateRouteMethod(validator.delete!);
  }

  Future<void> _validateRouteMethod(RouteMethodValidator validator) async {
    if (validator.bodyKeys.isNotEmpty) await _checkKeysInBody(validator.bodyKeys);
    if (validator.queryKeys.isNotEmpty) _checkKeysInQueryParameters(validator.queryKeys);
  }

  void _checkKeysInQueryParameters(List<String> keys) {
    final params = url.queryParameters;

    for (final key in keys) {
      if (!params.containsKey(key)) {
        throw RouteException(
          response: Response.badRequest(body: 'Not found key in the query parameters'),
        );
      }
    }
  }

  Future<void> _checkKeysInBody(List<String> keys) async {
    final body = await this.body;

    for (final key in keys) {
      if (!body.containsKey(key)) {
        throw RouteException(response: Response.badRequest(body: 'Not found key in the body'));
      }
    }
  }

  Future<Map<String, dynamic>> get body async {
    final data = await readAsString();
    if (isEmpty) {
      throw RouteException(response: Response.badRequest(body: 'Not found body in the request'));
    }

    return jsonDecode(data);
  }
}
