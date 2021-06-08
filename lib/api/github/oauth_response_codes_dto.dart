import 'dart:convert';

class OAuthResponseCodesDTO {
  late final String deviceCode;
  late final String userCode;
  late final Uri verificationUri;
  late final int expiresIn;
  late final int interval;

  OAuthResponseCodesDTO.fromJson(dynamic obj) {
    deviceCode = obj["device_code"].toString();
    userCode = obj["user_code"].toString();
    verificationUri = Uri.parse(obj["verification_uri"].toString());
    expiresIn = int.parse(obj["expires_in"].toString());
    interval = int.parse(obj["interval"].toString());
  }

  @override
  String toString() {
    return "{deviceCode: \"$deviceCode\", userCode: \"$userCode\", verificationUri: ${verificationUri.toString()}, expiresIn: $expiresIn, interval: $interval}";
  }
}
