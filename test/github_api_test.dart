import 'package:disto/api/github/github_api.dart';
import 'package:disto/api/github/github_exceptions.dart';
import 'package:test/test.dart';

void main() {
  group("GitHub API : ", () {
    test("Initializing Github Gist API without access token should fail", () {
      expect(() => GithubApi.gist(""), throwsA(isA<AssertionError>()));
    });

    test("Initializing Github Gist API and making OAuth request should fail",
        () {
      expect(() => GithubApi.gist("asd").getCodes(), throwsA(isA<Exception>()));
    });

    test("Initializing Github OAuth API and making OAuth request should pass",
        () async {
      var api = GithubApi.oauth();
      await api.getCodes();
    });

    test(
        "Getting authorization status without authorizing should raise GHOAuthAuthorizationPendingException",
        () async {
      var api = GithubApi.oauth();
      var codesResponse = await api.getCodes();

      print("Interval : ${codesResponse.interval}");

      await Future.delayed(Duration(seconds: codesResponse.interval + 1));

      expect(
          () async =>
              await api.getAuthorizationStatus(codesResponse.deviceCode),
          throwsA(isA<GHOAuthAuthorizationPendingException>()));
    });

    test(
        "Polling authorization status before interval should raise GHOAuthSlowDownException",
        () async {
      var api = GithubApi.oauth();
      var codesResponse = await api.getCodes();

      expect(
          () async =>
              await api.getAuthorizationStatus(codesResponse.deviceCode),
          throwsA(isA<GHOAuthAuthorizationPendingException>()));
      expect(
          () async =>
              await api.getAuthorizationStatus(codesResponse.deviceCode),
          throwsA(isA<GHOAuthSlowDownException>()));
    });
  });
}
