import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../dependencies/header_manager.dart';
import '../environments/environment.dart';
import 'response_data_type_enum.dart';
import 'rest_api_response_model.dart';
import 'upload_file_type_enum.dart';

class RestApiService {
  final url = Environment.env.url;
  final HeaderManager _headerManager = GetIt.instance<HeaderManager>();

  Map<String, String> getHeaders() {
    return _headerManager.headers;
  }

  Future<RestApiResponse> get(
    String route, {
    Map<String, String>? queryParams,
    ResponseDataTypeEnum responseDataType = ResponseDataTypeEnum.json,
  }) async {
    try {
      final uri = Uri.parse("$url$route").replace(queryParameters: queryParams);
      final response = await http.get(uri, headers: getHeaders());
      return _checkHttpResponse(response, responseDataType);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<RestApiResponse> post(
    String route, {
    Map<String, String>? body,
    ResponseDataTypeEnum responseDataType = ResponseDataTypeEnum.json,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$url$route"),
        headers: getHeaders(),
        body: jsonEncode(body),
      );
      return _checkHttpResponse(response, responseDataType);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<RestApiResponse> put(
    String route, {
    Map<String, String>? body,
    ResponseDataTypeEnum responseDataType = ResponseDataTypeEnum.json,
  }) async {
    try {
      final response = await http.put(
        Uri.parse("$url$route"),
        headers: getHeaders(),
        body: jsonEncode(body),
      );
      return _checkHttpResponse(response, responseDataType);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<RestApiResponse> patch(
    String route, {
    Map<String, String>? body,
    ResponseDataTypeEnum responseDataType = ResponseDataTypeEnum.json,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse("$url$route"),
        headers: getHeaders(),
        body: jsonEncode(body),
      );
      return _checkHttpResponse(response, responseDataType);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<RestApiResponse> delete(
    String route, {
    Map<String, String>? body,
    ResponseDataTypeEnum responseDataType = ResponseDataTypeEnum.json,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse("$url$route"),
        headers: getHeaders(),
        body: body != null ? jsonEncode(body) : null,
      );
      return _checkHttpResponse(response, responseDataType);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<RestApiResponse> postFile(
    String route,
    String destination,
    UploadFileType type,
    int? id,
    File file, {
    ResponseDataTypeEnum responseDataType = ResponseDataTypeEnum.json,
  }) async {
    try {
      final formData = d.FormData.fromMap(
        {
          'destination': destination,
          'type': type.value,
          'id': id,
          'thumbnailSize': 350,
        },
      );

      final options = d.BaseOptions(connectTimeout: const Duration(seconds: 30));
      final dio = d.Dio(options);

      formData.files.add(
        MapEntry(
          'file',
          await d.MultipartFile.fromFile(
            file.path,
            contentType: MediaType('image', 'jpeg'),
          ),
        ),
      );

      final response = await dio.post("$url$route", data: formData, options: d.Options(headers: getHeaders()));

      return _checkDioResponse(response, responseDataType);
    } catch (e) {
      return _handleError(e);
    }
  }

  RestApiResponse _checkHttpResponse(http.Response response, ResponseDataTypeEnum dataType) {
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created &&
        response.statusCode != HttpStatus.accepted) {
      return RestApiResponse(
        null,
        message: 'HTTP Error: ${response.statusCode} ${response.body}',
        isSuccess: false,
      );
    }

    dynamic data;
    switch (dataType) {
      case ResponseDataTypeEnum.json:
        data = json.decode(response.body);
        break;
      case ResponseDataTypeEnum.boolean:
      case ResponseDataTypeEnum.string:
        data = response.body;
        break;
    }

    return RestApiResponse(data);
  }

  RestApiResponse _checkDioResponse(d.Response response, ResponseDataTypeEnum dataType) {
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created &&
        response.statusCode != HttpStatus.accepted) {
      return RestApiResponse(
        null,
        message: 'HTTP Error: ${response.statusCode} ${response.data}',
        isSuccess: false,
      );
    }

    dynamic data;
    switch (dataType) {
      case ResponseDataTypeEnum.json:
        data = json.decode(response.data);
        break;
      case ResponseDataTypeEnum.boolean:
      case ResponseDataTypeEnum.string:
        data = response.data;
        break;
    }

    return RestApiResponse(data);
  }

  RestApiResponse _handleError(Object error) {
    if (error is SocketException) {
      //treat SocketException
      if (kDebugMode) {
        print("Socket exception: ${error.toString()}");
      }
      return const RestApiResponse(null, message: "No Internet", isSuccess: false);
    } else if (error is TimeoutException) {
      //treat TimeoutException
      if (kDebugMode) {
        print("Timeout exception: ${error.toString()}");
      }
      return const RestApiResponse(null, message: "Response too slow", isSuccess: false);
    } else {
      if (kDebugMode) {
        print("Unhandled exception: ${error.toString()}");
      }
      return const RestApiResponse(null, message: "Unknown error. Contact support", isSuccess: false);
    }
  }
}
