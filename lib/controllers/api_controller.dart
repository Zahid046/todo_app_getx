import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:todo_app_getx/constants/values.dart';
import 'package:todo_app_getx/helper/utility.dart';
import 'package:todo_app_getx/models/environment.dart';

class ApiController {
  Future<dynamic> commonPostWithoutToken({
    required String url,
    required Map<String, dynamic> body,
    int? timer,
  }) async {
    final http.Client client = http.Client();
    final Uri uri = Uri.parse(Environment.apiUrl + url);
    http.Response response;
    String error = 'An Error Occurred';
    try {
      response = await client.post(
        uri,
        body: body,
        headers: {},
      ).timeout(
        Duration(seconds: timer ?? 30),
        onTimeout: () {
          error = 'Connection time out';
          errorSnackBar('Error', error, kSnackbarDuration);
          throw TimeoutException('Connection time out');
        },
      );

      ll('response : ${response.body}');
      return jsonDecode(response.body);
    } on SocketException {
      error = 'No internet connection';
      errorSnackBar('Error', error, kSnackbarDuration);
      return null;
    } catch (e) {
      log(e.toString());
      errorSnackBar('Error', error, kSnackbarDuration);
      return null;
    } finally {
      client.close();
    }
  }

  //* info:: common get without token
  Future<dynamic> commonGetWithoutToken({
    required String url,
    int? timer,
  }) async {
    final http.Client client = http.Client();
    final Uri uri = Uri.parse(Environment.apiUrl + url);
    ll('url: $uri');

    http.Response response;
    String error = 'An Error Occurred';
    try {
      response = await client.get(uri).timeout(
        Duration(seconds: timer ?? 30),
        onTimeout: () {
          error = 'Connection time out';
          errorSnackBar('Error', error, kSnackbarDuration);
          throw TimeoutException('Connection time out');
        },
      );

      // ll('response : ${response.body}');
      return jsonDecode(response.body);
    } on SocketException {
      error = 'No internet connection';
      errorSnackBar('Error', error, kSnackbarDuration);
      return null;
    } catch (e) {
      log(e.toString());
      errorSnackBar('Error', error, kSnackbarDuration);
      return null;
    } finally {
      client.close();
    }
  }

  //* info:: common get
  Future<dynamic> commonGet({
    required String? token,
    required String url,
    int? timer,
  }) async {
    final http.Client client = http.Client();
    final Uri uri = Uri.parse(Environment.apiUrl + url);

    http.Response response;
    String error = 'An Error Occurred';
    try {
      response = await client.get(uri, headers: {'Authorization': 'Bearer $token'}).timeout(
        Duration(seconds: timer ?? 30),
        onTimeout: () {
          error = 'Connection time out';
          errorSnackBar('Error', error, kSnackbarDuration);
          throw TimeoutException('Connection time out');
        },
      );

      ll('response : ${response.body}');
      return jsonDecode(response.body);
    } on SocketException {
      error = 'No internet connection';
      errorSnackBar('Error', error, kSnackbarDuration);
      return null;
    } catch (e) {
      log(e.toString());
      errorSnackBar('Error', error, kSnackbarDuration);
      return null;
    } finally {
      client.close();
    }
  }

  //* info:: common post with body and token
  Future<dynamic> commonPost({
    required String? token,
    required String url,
    required Map<String, dynamic> body,
    int? timer,
  }) async {
    final http.Client client = http.Client();
    final Uri uri = Uri.parse(Environment.apiUrl + url);
    http.Response response;
    String error = 'An Error Occurred';
    try {
      response = await client.post(uri, headers: {'Authorization': 'Bearer $token', 'app-role': 'customer'}, body: body).timeout(
        Duration(seconds: timer ?? 30),
        onTimeout: () {
          error = 'Connection time out';
          errorSnackBar('Error', error, kSnackbarDuration);
          throw TimeoutException('Connection time out');
        },
      );

      ll('response : ${response.body}');
      return jsonDecode(response.body);
    } on SocketException {
      error = 'No internet connection';
      errorSnackBar('Error', error, kSnackbarDuration);
      return null;
    } catch (e) {
      log(e.toString());
      errorSnackBar('Error', error, kSnackbarDuration);
      return null;
    } finally {
      client.close();
    }
  }

  // dio post type of request
  Future<dynamic> commonPostWithDio({
    required String? token,
    required String url,
    required Map<String, dynamic> body,
    int? timer,
  }) async {
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] = 'Bearer $token';
    dio.options.headers['app-role'] = 'customer';
    String error = 'An Error Occurred';
    try {
      var response = await dio.post(Environment.apiUrl + url, data: body).timeout(
        Duration(seconds: timer ?? 30),
        onTimeout: () {
          error = 'Connection time out';
          errorSnackBar('Error', error, kSnackbarDuration);
          throw TimeoutException('Connection time out');
        },
      );

      ll('response : ${response.data}');
      return response.data;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        error = 'No internet connection';
        errorSnackBar('Error', error, kSnackbarDuration);
        return null;
      } else {
        log(e.toString());
        errorSnackBar('Error', error, kSnackbarDuration);
        return null;
      }
    } finally {
      //client.close();
    }
  }
}
