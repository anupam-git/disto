import 'package:http/http.dart' as http;

class OAuthResponseCodesDTO {
  late final String deviceCode;
  late final String userCode;
  late final Uri verificationUri;
  late final int expiresIn;
  late final int interval;

  OAuthResponseCodesDTO.fromResponse(http.Response response) {
    var result = Uri(query: response.body).queryParameters;

    deviceCode = result["device_code"].toString();
    userCode = result["user_code"].toString();
    verificationUri = Uri.parse(result["verification_uri"].toString());
    expiresIn = int.parse(result["expires_in"].toString());
    interval = int.parse(result["interval"].toString());
  }

  @override
  String toString() {
    return "{deviceCode: \"$deviceCode\", userCode: \"$userCode\", verificationUri: ${verificationUri.toString()}, expiresIn: $expiresIn, interval: $interval}";
  }
}
