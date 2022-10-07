class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl =
      "https://book-exchange-backend-production.up.railway.app/v1";

  // receiveTimeout
  static const int receiveTimeout = 10000;

  // connectTimeout
  static const int connectionTimeout = 10000;

  static const String login = '/authentication/login';

  static const String register = '/authentication/register';

  static const String username = '/authentication/username';

  //can define other

}
