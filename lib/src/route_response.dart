import 'dart:convert';
import 'dart:typed_data';

import 'package:shelf_tree/shelf_tree.dart';

enum ImageContentType {
  png('image/png'),
  jpeg('image/jpeg'),
  webp('image/webp'),
  gif('image/gif'),
  svg('image/svg+xml'),
  avif('image/avif'),
  bmp('image/bmp'),
  ico('image/x-icon');

  const ImageContentType(this.mimeType);

  final String mimeType;
}

class RouteResponse {
  const RouteResponse(this.statusCode, {this.body, this.headers, this.encoding, this.context});
  factory RouteResponse.ok({
    String? body,
    HttpCode statusCode = HttpCode.s200,
    Map<String, Object>? headers,
    Map<String, Object>? context,
  }) {
    return RouteResponse(statusCode, body: body, headers: headers, context: context);
  }

  factory RouteResponse.json(
    Object? body, {
    HttpCode statusCode = HttpCode.s200,
    Map<String, Object>? headers,
    Map<String, Object>? context,
  }) {
    return RouteResponse(
      statusCode,
      body: jsonEncode(body),
      headers: {...?headers, 'Content-Type': 'application/json; charset=utf-8'},
      context: context,
    );
  }

  factory RouteResponse.image(
    Uint8List bytes, {
    ImageContentType contentType = ImageContentType.png,
    HttpCode statusCode = HttpCode.s200,
    Map<String, Object>? headers,
    Map<String, Object>? context,
  }) {
    return RouteResponse(
      statusCode,
      body: bytes,
      headers: {...?headers, 'Content-Type': contentType.mimeType},
      context: context,
    );
  }

  factory RouteResponse.notFound({String? body}) {
    return RouteResponse(HttpCode.ce404, body: body ?? 'Not found');
  }

  factory RouteResponse.internalServerError({String? body}) {
    return RouteResponse(HttpCode.se500, body: body ?? 'Internal Server Error');
  }

  final HttpCode statusCode;
  final Map<String, Object>? headers;
  final Map<String, Object>? context;
  final Encoding? encoding;
  final Object? body;

  Response get response =>
      Response(statusCode.code, body: body, context: context, encoding: encoding, headers: headers);
}
