class Endpoints {
  Endpoints._();

  static const String baseUrl = 'https://reqres.in/api';

  // Timeout values are in milliseconds.
  static const int receiveTimeoutMs = 15000;

  static const int connectionTimeoutMs = 15000;

  static const String users = '/users';
}
