import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_flutter/core/const/shared_preferences.dart';
import 'package:template_flutter/core/network/rest_api_header_model.dart';

class HeaderManager {
  RestApiHeader _headers = const RestApiHeader(
    token: '',
    contentTypeHeader: 'application/json',
  );

  /// Load headers from SharedPreferences
  Future<void> loadHeaders() async {
    final sp = await SharedPreferences.getInstance();
    _headers = _headers.copyWith(token: sp.getString(keySessionToken));
  }

  /// Get the headers synchronously
  Map<String, String> get headers => _headers.toJson();

  /// Update a specific header key if needed
  void updateHeaderToken(String token) {
    _headers = _headers.copyWith(token: token);
  }
}
