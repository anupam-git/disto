import 'package:disto/api/github/github_api_type_enum.dart';
import 'package:http/http.dart' as http;

class GithubHttpClient extends http.BaseClient {
  final http.Client _client;
  final GithubApiType _apiType;
  String? accessToken;

  GithubHttpClient.oauth(this._client) : _apiType = GithubApiType.OAuth;
  GithubHttpClient.gist(
    this._client,
    this.accessToken,
  )   : _apiType = GithubApiType.Gist,
        assert(accessToken != null && accessToken.length > 0);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    switch (_apiType) {
      case GithubApiType.OAuth:
        break;

      case GithubApiType.Gist:
        request.headers["Accept"] = "application/vnd.github.v3+json";
        request.headers["Authorization"] = "token $accessToken";
        break;
    }

    return _client.send(request);
  }
}
