import 'dart:io';

class RestApiHeader {
  final String token;
  final String contentTypeHeader;

  const RestApiHeader({
    required this.token,
    required this.contentTypeHeader,
  });

  RestApiHeader copyWith({
    String? token,
    String? contentTypeHeader,
  }) {
    return RestApiHeader(
      token: token ?? this.token,
      contentTypeHeader: contentTypeHeader ?? this.contentTypeHeader,
    );
  }

  Map<String, String> toJson() => {
        HttpHeaders.authorizationHeader: token,
        HttpHeaders.contentTypeHeader: contentTypeHeader,
      };
}
