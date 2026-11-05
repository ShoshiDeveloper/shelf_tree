enum HttpCode(final int code) {
  // Information

  /// Continue
  i100(100),

  /// Switching Protocols
  i101(101),

  /// Processing
  i102(102),

  /// Early Hints
  i103(103),

  /// Upload Resumption Supported (Temporary)
  i104(104),

  // Success

  /// OK
  s200(200),

  /// Created
  s201(201),

  /// Accepted
  s202(202),

  /// Non-Authoritative Information
  s203(203),

  /// No Content
  s204(204),

  /// Reset Content
  s205(205),

  /// Partial Content
  s206(206),

  /// Multi-Status
  s207(207),

  /// Already Reported
  s208(208),

  /// IM Used
  s226(226),

  // Redirections

  /// Multiple Choices
  r300(300),

  /// Moved Permanently
  r301(301),

  /// Found
  r302(302),

  /// See Other
  r303(303),

  /// Not Modified
  r304(304),

  /// Use Proxy (Deprecated)
  r305(305),

  /// Unused (Reserved)
  r306(306),

  /// Temporary Redirect
  r307(307),

  /// Permanent Redirect
  r308(308),

  // Client Errors

  /// Bad Request
  ce400(400),

  /// Unauthorized
  ce401(401),

  /// Payment Required
  ce402(402),

  /// Forbidden
  ce403(403),

  /// Not Found
  ce404(404),

  /// Method Not Allowed
  ce405(405),

  /// Not Acceptable
  ce406(406),

  /// Proxy Authentication Required
  ce407(407),

  /// Request Timeout
  ce408(408),

  /// Conflict
  ce409(409),

  /// Gone
  ce410(410),

  /// Length Required
  ce411(411),

  /// Precondition Failed
  ce412(412),

  /// Content Too Large
  ce413(413),

  /// URI Too Long
  ce414(414),

  /// Unsupported Media Type
  ce415(415),

  /// Range Not Satisfiable
  ce416(416),

  /// Expectation Failed
  ce417(417),

  /// I'm a Teapot (Unused / Reserved)
  ce418(418),

  /// Misdirected Request
  ce421(421),

  /// Unprocessable Content
  ce422(422),

  /// Locked
  ce423(423),

  /// Failed Dependency
  ce424(424),

  /// Too Early
  ce425(425),

  /// Upgrade Required
  ce426(426),

  /// Precondition Required
  ce428(428),

  /// Too Many Requests
  ce429(429),

  /// Request Header Fields Too Large
  ce431(431),

  /// Unavailable For Legal Reasons
  ce451(451),

  // Server Errors

  /// Internal Server Error
  se500(500),

  /// Not Implemented
  se501(501),

  /// Bad Gateway
  se502(502),

  /// Service Unavailable
  se503(503),

  /// Gateway Timeout
  se504(504),

  /// HTTP Version Not Supported
  se505(505),

  /// Variant Also Negotiates
  se506(506),

  /// Insufficient Storage
  se507(507),

  /// Loop Detected
  se508(508),

  /// Not Extended (Obsolete)
  se510(510),

  /// Network Authentication Required
  se511(511),
}
