class BaseApiservices {
  static const String baseUrl = 'http://test.innovabe.com/api/v1';
  static const String login = '$baseUrl/auth/login';

  static const String signup = '$baseUrl/auth/register';
  static const String logout = '$baseUrl/auth/logout';

  static const String createtask = '$baseUrl/todo';
  static const String fetchtask = '$baseUrl/todo';
  static const String updatetask = '$baseUrl/todo/';
}
