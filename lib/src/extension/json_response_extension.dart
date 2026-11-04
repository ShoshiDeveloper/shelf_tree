import 'dart:convert';

import 'package:shelf_tree/shelf_tree.dart';

extension JsonResponse on Response {
  static Response json(
    Object? body, {
    int statusCode = 200,
    Map<String, Object>? headers,
    Map<String, Object>? context,
  }) {
    return Response(
      statusCode,
      body: jsonEncode(body),
      headers: {...?headers, 'Content-Type': 'application/json; charset=utf-8'},
      context: context,
    );
  }
}
