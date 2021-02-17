import 'dart:io';

abstract class NetworkDataSource {
  Future get(
    String url, {
    Map<String, String> headers,
  });

  Future post(
    Uri url, {
    Map<String, String> headers,
    Map<String, String> body,
  });

  Future put(
    Uri url, {
    Map<String, String> headers,
    body,
  });
}

class RemoteDataSourceException extends HttpException {
  final int statusCode;

  RemoteDataSourceException(this.statusCode, String message) : super(message);

  @override
  String toString() =>
      'RemoteDataSourceException{statusCode=$statusCode, message=$message}';
}
