import 'package:dio/dio.dart';

class GHException implements DioError {
  GHException({
    required this.requestOptions,
    this.response,
    this.type = DioErrorType.other,
    this.error,
  });

  @override
  var error;

  @override
  RequestOptions requestOptions;

  @override
  Response? response;

  @override
  StackTrace? stackTrace;

  @override
  DioErrorType type;

  @override
  String get message => (error?.toString() ?? '');
}

class GHOAuthAuthorizationPendingException extends GHException {
  GHOAuthAuthorizationPendingException({
    required RequestOptions requestOptions,
    Response? response,
    DioErrorType type = DioErrorType.other,
    dynamic error,
  }) : super(
          requestOptions: requestOptions,
          response: response,
          type: type,
          error: error,
        );
}

class GHOAuthSlowDownException extends GHException {
  GHOAuthSlowDownException({
    required RequestOptions requestOptions,
    Response? response,
    DioErrorType type = DioErrorType.other,
    dynamic error,
  }) : super(
          requestOptions: requestOptions,
          response: response,
          type: type,
          error: error,
        );
}

class GHOAuthExpiredTokenException extends GHException {
  GHOAuthExpiredTokenException({
    required RequestOptions requestOptions,
    Response? response,
    DioErrorType type = DioErrorType.other,
    dynamic error,
  }) : super(
          requestOptions: requestOptions,
          response: response,
          type: type,
          error: error,
        );
}

class GHOAuthUnsupportedGrantTypeException extends GHException {
  GHOAuthUnsupportedGrantTypeException({
    required RequestOptions requestOptions,
    Response? response,
    DioErrorType type = DioErrorType.other,
    dynamic error,
  }) : super(
          requestOptions: requestOptions,
          response: response,
          type: type,
          error: error,
        );
}

class GHOAuthIncorrectCredentialsException extends GHException {
  GHOAuthIncorrectCredentialsException({
    required RequestOptions requestOptions,
    Response? response,
    DioErrorType type = DioErrorType.other,
    dynamic error,
  }) : super(
          requestOptions: requestOptions,
          response: response,
          type: type,
          error: error,
        );
}

class GHOAuthIncorrectDeviceCodeException extends GHException {
  GHOAuthIncorrectDeviceCodeException({
    required RequestOptions requestOptions,
    Response? response,
    DioErrorType type = DioErrorType.other,
    dynamic error,
  }) : super(
          requestOptions: requestOptions,
          response: response,
          type: type,
          error: error,
        );
}

class GHOAuthAccessDeniedException extends GHException {
  GHOAuthAccessDeniedException({
    required RequestOptions requestOptions,
    Response? response,
    DioErrorType type = DioErrorType.other,
    dynamic error,
  }) : super(
          requestOptions: requestOptions,
          response: response,
          type: type,
          error: error,
        );
}
