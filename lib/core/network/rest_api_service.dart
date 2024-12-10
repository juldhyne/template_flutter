import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as d;
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
    final uri = Uri.parse("$url$route").replace(queryParameters: queryParams);
    final response = await http.get(uri, headers: getHeaders());
    return _checkHttpResponse(response, responseDataType);
  }

  Future<RestApiResponse> post(
    String route, {
    Map<String, String>? body,
    ResponseDataTypeEnum responseDataType = ResponseDataTypeEnum.json,
  }) async {
    final response = await http.post(
      Uri.parse("$url$route"),
      headers: getHeaders(),
      body: jsonEncode(body),
    );
    return _checkHttpResponse(response, responseDataType);
  }

  Future<RestApiResponse> put(
    String route, {
    Map<String, String>? body,
    ResponseDataTypeEnum responseDataType = ResponseDataTypeEnum.json,
  }) async {
    final response = await http.put(
      Uri.parse("$url$route"),
      headers: getHeaders(),
      body: jsonEncode(body),
    );
    return _checkHttpResponse(response, responseDataType);
  }

  Future<RestApiResponse> patch(
    String route, {
    Map<String, String>? body,
    ResponseDataTypeEnum responseDataType = ResponseDataTypeEnum.json,
  }) async {
    final response = await http.patch(
      Uri.parse("$url$route"),
      headers: getHeaders(),
      body: jsonEncode(body),
    );
    return _checkHttpResponse(response, responseDataType);
  }

  Future<RestApiResponse> delete(
    String route, {
    Map<String, String>? body,
    ResponseDataTypeEnum responseDataType = ResponseDataTypeEnum.json,
  }) async {
    final response = await http.delete(
      Uri.parse("$url$route"),
      headers: getHeaders(),
      body: body != null ? jsonEncode(body) : null,
    );
    return _checkHttpResponse(response, responseDataType);
  }

  Future<RestApiResponse> postFile(
    String route,
    String destination,
    UploadFileType type,
    int? id,
    File file, {
    ResponseDataTypeEnum responseDataType = ResponseDataTypeEnum.json,
  }) async {
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
}
