import 'package:shelf/shelf.dart';

class RouteException implements Exception {
  const RouteException({this.response});

  final Response? response;
}
