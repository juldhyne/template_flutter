import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class HeaderManager {
  Map<String, String> _headers = {};

  /// Load headers from SharedPreferences
  Future<void> loadHeaders() async {
    final sp = await SharedPreferences.getInstance();
    _headers = {
      'Authorization': sp.getString('authorization') ?? '',
      'Device-Id': sp.getString('deviceId') ?? '',
    };
  }

  /// Get the headers synchronously
  Map<String, String> get headers => _headers;

  /// Update a specific header key if needed
  void updateHeader(String key, String value) {
    _headers[key] = value;
  }
}
