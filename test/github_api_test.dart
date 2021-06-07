import 'package:disto/api/github/github_api.dart';
import 'package:test/test.dart';

void main() {
  group("GitHub API", () {
    test("Initializing Github Gist API without access token should fail", () {
      expect(() => GithubAPI.gist(""), throwsA(isA<AssertionError>()));
    });

    test("Initializing Github Gist API and making OAuth request should fail",
        () {
      expect(() => GithubAPI.gist("asd").getCodes(), throwsA(isA<Exception>()));
    });

    test("Initializing Github OAuth API and making OAuth request should pass",
        () async {
      var response = await GithubAPI.oauth().getCodes();

      print(response);
    });
  });
}
