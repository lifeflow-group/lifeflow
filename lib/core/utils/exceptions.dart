/// Base Exception class for API-related errors
class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}

/// Exception for HTTP 400 Bad Request responses
class BadRequestException extends ApiException {
  BadRequestException([super.message = 'Bad request']);
}

/// Exception for HTTP 401 Unauthorized responses
class UnauthorizedException extends ApiException {
  UnauthorizedException([super.message = 'Unauthorized request']);
}

/// Exception for HTTP 403 Forbidden responses
class ForbiddenException extends ApiException {
  ForbiddenException([super.message = 'Forbidden request']);
}

/// Exception for HTTP 404 Not Found responses
class NotFoundException extends ApiException {
  NotFoundException([super.message = 'Resource not found']);
}

/// Exception for HTTP 409 Conflict responses
class ConflictException extends ApiException {
  ConflictException([super.message = 'Conflict occurred']);
}

/// Exception for HTTP 500+ Server Error responses
class ServerException extends ApiException {
  ServerException([super.message = 'Server error']);
}

/// Exception for network connectivity issues
class NetworkException extends ApiException {
  NetworkException([super.message = 'Network error']);
}

/// Exception for timeouts
class TimeoutException extends ApiException {
  TimeoutException([super.message = 'Request timeout']);
}
