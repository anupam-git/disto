class GHException implements Exception {
  final String message;

  GHException(this.message);

  @override
  String toString() {
    return "GH Exception : $message";
  }
}

class GHOAuthAuthorizationPendingException extends GHException {
  GHOAuthAuthorizationPendingException(String message) : super(message);
}

class GHOAuthSlowDownException extends GHException {
  GHOAuthSlowDownException(String message) : super(message);
}

class GHOAuthExpiredTokenException extends GHException {
  GHOAuthExpiredTokenException(String message) : super(message);
}

class GHOAuthUnsupportedGrantTypeException extends GHException {
  GHOAuthUnsupportedGrantTypeException(String message) : super(message);
}

class GHOAuthIncorrectCredentialsException extends GHException {
  GHOAuthIncorrectCredentialsException(String message) : super(message);
}

class GHOAuthIncorrectDeviceCodeException extends GHException {
  GHOAuthIncorrectDeviceCodeException(String message) : super(message);
}

class GHOAuthAccessDeniedException extends GHException {
  GHOAuthAccessDeniedException(String message) : super(message);
}
