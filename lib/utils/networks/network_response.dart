import 'dart:convert';
import 'package:http/http.dart' as http;

import 'network_datasource.dart';

class NetworkResponse extends NetworkDataSource {
  Future get(
    String url, {
    Map<String, String> headers,
  }) async {
    final response = await http.get(url, headers: headers);
    final body = response.body;
    final statusCode = response.statusCode;
    if (body == null) {
      throw RemoteDataSourceException(statusCode, 'Response body is null');
    }
    final decoded = json.decode(body);
    if (statusCode < 200 || statusCode >= 300) {
      throw RemoteDataSourceException(statusCode, decoded['message']);
    }
    return decoded;
  }

  Future post(
    Uri url, {
    Map<String, String> headers,
    Map<String, String> body,
  }) =>
      _helper(
        'POST',
        url,
        headers: headers,
        body: body,
      );

  static Future _helper(
    String method,
    Uri url, {
    Map<String, String> headers,
    Map<String, String> body,
  }) async {
    final request = http.Request(method, url);
    if (body != null) {
      request.bodyFields = body;
    }
    if (headers != null) {
      request.headers.addAll(headers);
    }
    final streamedResponse = await request.send();

    final statusCode = streamedResponse.statusCode;
    final decoded = json.decode(await streamedResponse.stream.bytesToString());

    if (statusCode < 200 || statusCode >= 300) {
      throw RemoteDataSourceException(statusCode, decoded['message']);
    }

    return decoded;
  }

  Future put(
    Uri url, {
    Map<String, String> headers,
    body,
  }) =>
      _helper(
        'PUT',
        url,
        headers: headers,
        body: body,
      );
}
