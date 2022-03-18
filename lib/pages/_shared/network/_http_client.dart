import 'dart:convert' show utf8;

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

class _HttpException extends Equatable implements Exception {
  const _HttpException(this.status, this.message);

  final int status;
  final String? message;

  @override
  List<Object?> get props => [status, message];
}

class HttpClient {
  Future<String> get(String endpoint) async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode >= 400) {
      throw _HttpException(
        response.statusCode,
        response.reasonPhrase,
      );
    }
    return utf8.decode(response.bodyBytes);
  }
}
