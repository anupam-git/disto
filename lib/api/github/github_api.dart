import 'dart:convert';

import 'package:disto/api/api.dart';
import 'package:dio/dio.dart';
import 'package:disto/api/github/github_api_type_enum.dart';
import 'package:disto/api/github/github_exceptions.dart';
import 'package:disto/api/github/oauth_response_codes_dto.dart';

class GithubAPI extends Api {
  final Dio _dioClient;
  final GithubApiType _apiType;
  String? accessToken;

  final _clientID = "aa598098248837980a7e";

  GithubAPI.oauth()
      : _dioClient = Dio(BaseOptions(baseUrl: "https://github.com/login/")),
        _apiType = GithubApiType.OAuth {
    _init();
  }

  GithubAPI.gist(this.accessToken)
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
        onError: _dioErrorInterceptor,
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

    return handler.next(response);
  }

  void _dioErrorInterceptor(
    DioError e,
    ErrorInterceptorHandler handler,
  ) {
    throw GHException("[Code : ${e.response!.statusCode}] ${e.message}");
  }

  void _checkApiType(GithubApiType apiType) {
    if (apiType != _apiType) {
      throw GHException(
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
}
