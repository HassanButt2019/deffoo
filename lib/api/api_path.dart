import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Apipath {
  static const String BASH_URL = "https://alphawizztest.tk/Deffo/api/";
  static const String login_url = BASH_URL + 'authentication/login';
  static const String resend_otp = BASH_URL + 'authentication/resendOtp';
  static const String get_profile = BASH_URL + 'authentication/getProfile';
  static const String update_profile = BASH_URL + 'authentication/editProfile';
  static const String home_banner = BASH_URL + 'Products/Banner';
  static const String home_category = BASH_URL + 'Products/category';
}
class ApiBaseHelper {
  Future<dynamic> postAPICall(Uri url, var param) async {
    var responseJson;
    try {
      print(
          "API : $url \n parameter : $param   \n ");
      final response = await post(url,
          body: param,headers: {
            'Accept': 'application/json',})
          .timeout(Duration(seconds: 50));
      print(
          "API : $url \n parameter : $param   \n response:  ${response.body.toString()}yuj ");
      responseJson = _response(response);
    } on SocketException {

    } on TimeoutException {

    }
    return responseJson;
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 401:
      case 403:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 500:
      default:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
    }
  }
}
class App {
  static late SharedPreferences localStorage;
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }
}