import 'dart:convert';

import 'package:disto/api/api.dart';
import 'package:disto/api/github/github_api_type_enum.dart';
import 'package:disto/api/github/github_http_client.dart';
import 'package:disto/api/github/oauth_response_codes_dto.dart';
import 'package:http/http.dart' as http;

class GithubAPI extends Api {
  final _oauthBaseUrl = Uri.parse("https://github.com/login/");
  final GithubApiType _apiType;
  late final GithubHttpClient _client;

  final _clientID = "aa598098248837980a7e";

  GithubAPI.oauth()
      : _client = new GithubHttpClient.oauth(new http.Client()),
        _apiType = GithubApiType.OAuth;

  GithubAPI.gist(String accessToken)
      : _client = new GithubHttpClient.gist(new http.Client(), accessToken),
        _apiType = GithubApiType.Gist;

  Future<OAuthResponseCodesDTO> getCodes() async {
    _checkApiType(GithubApiType.OAuth);

    http.Response response = await _client.post(
      _oauthBaseUrl.resolve("device/code"),
      body: {
        "client_id": _clientID,
        "scope": "gist",
      },
    );

    checkResponseError(response);

    return OAuthResponseCodesDTO.fromResponse(response);
  }

  void _checkApiType(GithubApiType apiType) {
    if (apiType != _apiType) {
      throw Exception(
          "Cannot make $_apiType request when initialized with $apiType");
    }
  }

  @override
  void checkResponseError(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Http response Success
      // Check for API error response
    } else {
      // Invalid response

      throw Exception(
          "[Code : ${response.statusCode}] ${response.reasonPhrase}");
    }
  }
}
