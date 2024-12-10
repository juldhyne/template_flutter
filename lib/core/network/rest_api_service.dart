import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'header_manager.dart';

class RestApiService {
  final HeaderManager _headerManager = GetIt.instance<HeaderManager>();

  Map<String, String> getHeaders() {
    return _headerManager.headers;
  }

  Future<http.Response> get(String url, {Map<String, String>? queryParams}) async {
    final uri = Uri.parse(url).replace(queryParameters: queryParams);
    final response = await http.get(uri, headers: getHeaders());
    _checkResponse(response);
    return response;
  }

  Future<http.Response> post(String url, {Map<String, String>? body}) async {
    final response = await http.post(
      Uri.parse(url),
      headers: getHeaders(),
      body: jsonEncode(body),
    );
    _checkResponse(response);
    return response;
  }

  Future<http.Response> put(String url, {Map<String, String>? body}) async {
    final response = await http.put(
      Uri.parse(url),
      headers: getHeaders(),
      body: jsonEncode(body),
    );
    _checkResponse(response);
    return response;
  }

  Future<http.Response> patch(String url, {Map<String, String>? body}) async {
    final response = await http.patch(
      Uri.parse(url),
      headers: getHeaders(),
      body: jsonEncode(body),
    );
    _checkResponse(response);
    return response;
  }

  Future<http.Response> delete(String url, {Map<String, String>? body}) async {
    final response = await http.delete(
      Uri.parse(url),
      headers: getHeaders(),
      body: body != null ? jsonEncode(body) : null,
    );
    _checkResponse(response);
    return response;
  }

  void _checkResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP Error: ${response.statusCode} ${response.body}');
    }
  }
}
