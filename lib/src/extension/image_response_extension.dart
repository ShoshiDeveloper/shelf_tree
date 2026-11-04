import 'dart:typed_data';

import 'package:shelf/shelf.dart';

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

extension ImageResponse on Response {
  static Response image(
    Uint8List bytes, {
    ImageContentType contentType = ImageContentType.png,
    int statusCode = 200,
    Map<String, Object>? headers,
    Map<String, Object>? context,
  }) {
    return Response(
      statusCode,
      body: bytes,
      headers: {...?headers, 'Content-Type': contentType.mimeType},
      context: context,
    );
  }
}
