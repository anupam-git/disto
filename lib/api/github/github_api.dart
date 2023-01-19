import 'package:disto/api/api.dart';
import 'package:dio/dio.dart';
import 'package:disto/api/github/github_api_type_enum.dart';
import 'package:disto/api/github/github_exceptions.dart';
import 'package:disto/api/github/oauth_authorization_status_dto.dart';
import 'package:disto/api/github/oauth_response_codes_dto.dart';

class GithubApi extends Api {
  final Dio _dioClient;
  final GithubApiType _apiType;
  String? accessToken;

  final _clientID = "aa598098248837980a7e";

  GithubApi.oauth()
      : _dioClient = Dio(BaseOptions(baseUrl: "https://github.com/login/")),
        _apiType = GithubApiType.OAuth {
    _init();
  }

  GithubApi.gist(this.accessToken)
      : _dioClient = Dio(BaseOptions(baseUrl: "https://api.github.com/")),
        _apiType = GithubApiType.Gist,
        assert(accessToken != null && accessToken.length > 0) {
    _init();
  }

  void _init() {
    _dioClient.interceptors.add(
      InterceptorsWrapper(
        onRequest: _dioRequestInterceptor,
        onResponse: _dioResponseInterceptor,
      ),
    );
  }

  void _dioRequestInterceptor(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers[Headers.acceptHeader] = "application/vnd.github.v3+json";

    switch (_apiType) {
      case GithubApiType.Gist:
        options.headers["Authorization"] = "token $accessToken";
        break;

      case GithubApiType.OAuth:
        // No extra headers required for OAuth API
        break;
    }

    return handler.next(options);
  }

  void _dioResponseInterceptor(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    // Http response Success
    // Check for API error response

    if (response.data["error"] != null) {
      switch (response.data["error"]) {
        case "authorization_pending":
          throw GHOAuthAuthorizationPendingException(
              requestOptions: response.requestOptions);

        case "slow_down":
          throw GHOAuthSlowDownException(
              requestOptions: response.requestOptions);

        case "expired_token":
          throw GHOAuthExpiredTokenException(
              requestOptions: response.requestOptions);

        case "unsupported_grant_type":
          throw GHOAuthUnsupportedGrantTypeException(
              requestOptions: response.requestOptions);

        case "incorrect_client_credentials":
          throw GHOAuthIncorrectCredentialsException(
              requestOptions: response.requestOptions);

        case "incorrect_device_code":
          throw GHOAuthIncorrectDeviceCodeException(
              requestOptions: response.requestOptions);

        case "access_denied":
          throw GHOAuthAccessDeniedException(
              requestOptions: response.requestOptions);

        default:
          throw GHException(requestOptions: response.requestOptions);
      }
    }

    return handler.next(response);
  }

  void _checkApiType(GithubApiType apiType) {
    if (apiType != _apiType) {
      throw Exception(
          "Cannot make $_apiType request when initialized with $apiType");
    }
  }

  Future<OAuthResponseCodesDTO> getCodes() async {
    _checkApiType(GithubApiType.OAuth);

    Response response = await _dioClient.post(
      "/device/code",
      data: {
        "client_id": _clientID,
        "scope": "gist",
      },
    );

    return OAuthResponseCodesDTO.fromJson(response.data);
  }

  Future<OAuthAuthorizationStatusDTO> getAuthorizationStatus(
      String deviceCode) async {
    _checkApiType(GithubApiType.OAuth);

    Response response = await _dioClient.post(
      "/oauth/access_token",
      data: {
        "client_id": _clientID,
        "device_code": deviceCode,
        "grant_type": "urn:ietf:params:oauth:grant-type:device_code",
      },
    );

    return OAuthAuthorizationStatusDTO.fromJson(response.data);
  }

  Future<Response> getPrivateGists() async {
    _checkApiType(GithubApiType.Gist);

    Response response = await _dioClient.post("/gists");

    return response;
  }
}
