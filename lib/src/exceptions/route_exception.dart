import 'package:shelf_tree/src/index.dart';

class RouteException implements Exception {
  const RouteException({this.response});

  final RouteResponse? response;
}
