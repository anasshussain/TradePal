import 'package:http/http.dart' as http;
class BrowserClient extends http.BaseClient {
  bool _withCredentials = false;
  bool get withCredentials => _withCredentials;
  set withCredentials(bool value) {
    _withCredentials = value;
  }

  // REQUIRED: BaseClient is abstract and requires send() to be implemented
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // Delegate to a standard client (this should never be called on non-web)
    return http.Client().send(request);
  }
  // OPTIONAL: close() has a default empty implementation in BaseClient
  // We can omit it since BaseClient provides a default
}