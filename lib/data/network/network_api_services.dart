import 'dart:async';
import 'dart:convert'; // For jsonDecode
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:taskapp/data/local_storage_services/local_storage_methods_services.dart';
import 'package:taskapp/data/network/baseApiServices.dart';
import 'package:taskapp/data/response/app_exception.dart';

class NetworkApiServices extends BaseApiservices {
  Future<Map<String, dynamic>> getRequest(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    // final token = tokenManager.token;
    final token = LocalStorageMethods.instance.getUserApiToken();
    print('GetToken $token');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
      ).timeout(const Duration(seconds: 10));

      // Handling the HTTP response
      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    } on TimeoutException {
      throw TimeoutException('Time out try again');
    } catch (e) {
      throw Exception('Unexpected Error: $e');
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> postRequest(String url, var data) async {
    dynamic responseJson;
    if (kDebugMode) {
      print("Request Data: $data");
    }
    // final token = tokenManager.token;

    final token = LocalStorageMethods.instance.getUserApiToken();
    print('PostToken $token');
    try {
      final response = await http
          .post(Uri.parse(url),
              headers: token != null
                  ? {
                      'Content-Type': 'application/json',
                      'Authorization': 'Bearer $token',
                    }
                  : {
                      'Content-Type': 'application/json',
                    },
              body: jsonEncode(data))
          .timeout(const Duration(seconds: 15));

      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    } on TimeoutException {
      throw TimeoutException('Time out try again');
    } catch (e) {
      throw Exception(' $e');
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> putRequest(String url, var data) async {
    dynamic responseJson;
    if (kDebugMode) {
      print("PUT Request Data: $data");
    }
    final token = LocalStorageMethods.instance.getUserApiToken();

    print('PutToken $token');
    try {
      final response = await http
          .put(Uri.parse(url),
              headers: token != null
                  ? {
                      'Content-Type': 'application/json',
                      'Authorization': 'Bearer $token',
                    }
                  : {
                      'Content-Type': 'application/json',
                    },
              body: jsonEncode(data))
          .timeout(const Duration(seconds: 15));

      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    } on TimeoutException {
      throw TimeoutException('Time out try again');
    } catch (e) {
      throw Exception(' $e');
    }
    return responseJson;
  }

  static dynamic returnResponse(http.Response response) {
    print("HTTP Status Code: ${response.statusCode}");
    print("HTTP Response Body: ${response.body}"); // Log the error details
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body);
      case 401:
        throw UnauthorizedException(response.body);
      case 422:
        throw Exception('email alreday taken');
      default:
        throw Exception(
            'Error: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }
}
