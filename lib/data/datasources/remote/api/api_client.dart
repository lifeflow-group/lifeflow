import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/environment.dart';
import '../../../../core/utils/exceptions.dart';
import '../../../../core/utils/logger.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(baseUrl: Environment.apiBaseUrl);
});

class ApiClient {
  final String baseUrl;
  final http.Client _httpClient;
  final logger = AppLogger('ApiClient');

  ApiClient({required this.baseUrl, http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  /// Generic GET request
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final uri = Uri.parse('$baseUrl$path').replace(
          queryParameters: queryParams
              ?.map((key, value) => MapEntry(key, value?.toString())));

      final response = await _httpClient.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return _processResponse(response);
    } catch (e) {
      logger.error('GET request failed: $e');
      rethrow;
    }
  }

  /// Generic POST request
  Future<dynamic> post(String path, {dynamic body}) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('$baseUrl$path'),
        headers: {'Content-Type': 'application/json'},
        body: body != null ? jsonEncode(body) : null,
      );

      return _processResponse(response);
    } catch (e) {
      logger.error('POST request failed: $e');
      rethrow;
    }
  }

  /// Generic PUT request
  Future<dynamic> put(String path, {dynamic body}) async {
    try {
      final response = await _httpClient.put(
        Uri.parse('$baseUrl$path'),
        headers: {'Content-Type': 'application/json'},
        body: body != null ? jsonEncode(body) : null,
      );

      return _processResponse(response);
    } catch (e) {
      logger.error('PUT request failed: $e');
      rethrow;
    }
  }

  /// Generic DELETE request
  Future<dynamic> delete(String path) async {
    try {
      final response = await _httpClient.delete(
        Uri.parse('$baseUrl$path'),
        headers: {'Content-Type': 'application/json'},
      );

      return _processResponse(response, [200, 204]);
    } catch (e) {
      logger.error('DELETE request failed: $e');
      rethrow;
    }
  }

  /// Process and validate API response
  dynamic _processResponse(http.Response response,
      [List<int> validStatuses = const [200, 201]]) {
    if (!validStatuses.contains(response.statusCode)) {
      switch (response.statusCode) {
        case 400:
          throw BadRequestException(response.body);
        case 401:
          throw UnauthorizedException(response.body);
        case 403:
          throw ForbiddenException(response.body);
        case 404:
          throw NotFoundException(response.body);
        case 409:
          throw ConflictException(response.body);
        case 500:
          throw ServerException(response.body);
        default:
          throw ApiException(
              'Request failed with status: ${response.statusCode}');
      }
    }

    // Return null for 204 No Content
    if (response.statusCode == 204) return null;

    // Try to parse response as JSON
    if (response.body.isEmpty) return null;

    try {
      return jsonDecode(response.body);
    } catch (e) {
      logger.error('Failed to parse response body: $e');
      throw ApiException('Failed to parse response body');
    }
  }
}
