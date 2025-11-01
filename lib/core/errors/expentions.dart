import 'package:dio/dio.dart';

import 'error_model.dart';

//! ServerException
class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException(this.errorModel);
}

//! CacheException
class CacheExeption implements Exception {
  final String errorMessage;
  CacheExeption({required this.errorMessage});
}

class BadCertificateException extends ServerException {
  BadCertificateException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  ConnectionTimeoutException(super.errorModel);
}

class BadResponseException extends ServerException {
  BadResponseException(super.errorModel);
}

class ReceiveTimeoutException extends ServerException {
  ReceiveTimeoutException(super.errorModel);
}

class ConnectionErrorException extends ServerException {
  ConnectionErrorException(super.errorModel);
}

class SendTimeoutException extends ServerException {
  SendTimeoutException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.errorModel);
}

class ForbiddenException extends ServerException {
  ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  NotFoundException(super.errorModel);
}

class CofficientException extends ServerException {
  CofficientException(super.errorModel);
}

class CancelException extends ServerException {
  CancelException(super.errorModel);
}

class UnknownException extends ServerException {
  UnknownException(super.errorModel);
}

/// 🔧 Safe builder for ErrorModel
ErrorModel _safeErrorModel(
    DioException e, {
      int? defaultStatus,
      String? defaultMessage,
    }) {
  final data = e.response?.data;
  if (data != null) {
    try {
      return ErrorModel.fromJson(data);
    } catch (_) {
      return ErrorModel(
        status: e.response?.statusCode ?? defaultStatus ?? 500,
        errorMessage: defaultMessage ?? e.message ?? "Unexpected Error",
      );
    }
  }
  return ErrorModel(
    status: e.response?.statusCode ?? defaultStatus ?? 500,
    errorMessage: defaultMessage ?? e.message ?? "No response from server",
  );
}

handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      throw ConnectionErrorException(
        _safeErrorModel(e, defaultMessage: "Connection Error"),
      );

    case DioExceptionType.badCertificate:
      throw BadCertificateException(
        _safeErrorModel(e, defaultMessage: "Bad Certificate"),
      );

    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(
        _safeErrorModel(e, defaultMessage: "Connection Timeout"),
      );

    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(
        _safeErrorModel(e, defaultMessage: "Receive Timeout"),
      );

    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(
        _safeErrorModel(e, defaultMessage: "Send Timeout"),
      );

    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
          throw BadResponseException(_safeErrorModel(e));
        case 401:
          throw UnauthorizedException(_safeErrorModel(e));
        case 403:
          throw ForbiddenException(_safeErrorModel(e));
        case 404:
          throw NotFoundException(_safeErrorModel(e));
        case 409:
          throw CofficientException(_safeErrorModel(e));
        case 504:
          throw BadResponseException(
            ErrorModel(status: 504, errorMessage: "Gateway Timeout"),
          );
        default:
          throw BadResponseException(
            _safeErrorModel(e, defaultMessage: "Bad Response"),
          );
      }

    case DioExceptionType.cancel:
      throw CancelException(
        ErrorModel(status: 499, errorMessage: "Request Cancelled"),
      );

    case DioExceptionType.unknown:
      throw UnknownException(
        ErrorModel(status: 500, errorMessage: "Unknown Error"),
      );
  }
}
