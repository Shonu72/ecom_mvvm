import 'package:dio/dio.dart';
import 'package:ecom_mvvm/core/utils/constants.dart';
import 'package:ecom_mvvm/core/utils/exception.dart';
import 'package:ecom_mvvm/core/utils/failure.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RequestType { get, post, put }

class Helper {
  static toast(String text) {
    return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

// save user data in local storage
  static saveUser({required String key, required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static saveApiToken({required String key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("apiToken", key);
  }

  static Future<bool?> getUser({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

// validation
  static validateField(String value) {
    if (value.isEmpty || value == 'null') {
      return "field required";
    }
    return null;
  }

// send request to server
  static Future<Response> sendRequest(RequestType type, String endpoint,
      {Map<String, dynamic>? data}) async {
    final dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';

    try {
      Response response;
      switch (type) {
        case RequestType.get:
          response = await dio.get('${ApiString.baseUrl}$endpoint');
          break;
        case RequestType.post:
          response =
              await dio.post('${ApiString.baseUrl}$endpoint', data: data);
          break;
        case RequestType.put:
          response = await dio.put('${ApiString.baseUrl}$endpoint', data: data);
          break;
        default:
          throw ServerException(
              message: 'Unsupported HTTP method type : $type');
      }
      debugPrint('Response received: ${response.statusCode}, ${response.data}');

      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            'DioException response: ${e.response?.statusCode}, ${e.response?.data}');

        throw ServerException(
            message: 'Server error: ${e.response?.statusMessage}');
      } else {
        debugPrint('DioException without response: ${e.message}');

        throw ServerException(message: 'Connection error: ${e.message}');
      }
    } catch (e) {
      debugPrint('Unexpected error: $e');

      throw ServerException(message: 'Unexpected error: $e');
    }
  }

// handle error
  static String convertFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return "Unknown error occurred";
  }

// request permission
  static Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();

    if (statuses[Permission.location]!.isDenied) {
      Helper.toast("Location required ");
    }
  }
}
