import 'package:http/http.dart' as http;

abstract class Api {
  void checkResponseError(http.Response response);
}
