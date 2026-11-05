// ignore_for_file: constant_identifier_names

enum HttpMethod {
  GET,
  POST,
  PUT,
  DELETE,
  PATCH,
  OPTIONS,
  HEAD,
  TRACE,
  CONNECT;

  const HttpMethod();

  static HttpMethod fromString(String value) =>
      HttpMethod.values.firstWhere((e) => e.name.toString() == value.toLowerCase());
}
