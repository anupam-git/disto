class OAuthAuthorizationStatusDTO {
  late final String accessToken;
  late final String tokenType;
  late final String scope;

  OAuthAuthorizationStatusDTO.fromJson(dynamic obj) {
    accessToken = obj["access_token"].toString();
    tokenType = obj["token_type"].toString();
    scope = obj["scope"].toString();
  }

  @override
  String toString() {
    return "{accessToken: \"$accessToken\", tokenType: \"$tokenType\", scope: \"$scope\"}";
  }
}
