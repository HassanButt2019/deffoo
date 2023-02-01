import 'dart:convert';

import 'package:deffo/api/api_path.dart';
import 'package:deffo/api/api_services.dart';
import 'package:deffo/api/privacy.dart';
import 'package:deffo/model/request/get_profile_request.dart';
import 'package:deffo/model/request/login_with_phone_request.dart';
import 'package:deffo/model/request/resend_otp_request.dart';
import 'package:deffo/model/response/UpdateProfileResponse.dart';
import 'package:deffo/model/response/get_profile_response.dart';
import 'package:deffo/model/response/login_with_otp_response.dart';
import 'package:deffo/model/response/resend_otp_response.dart';
import 'package:deffo/utility/utility_hlepar.dart';

class AuthApiHelper {
  // login with otp
  static Future<LoginResponse> login(LoginRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.login_url, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    print(data);
    UtilityHlepar.getToast(data['message']);
    return LoginResponse.fromJson(data);
  }

  // resend otp
  static Future<ResendOtpResponse> resendOtp(ResendOtpRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.resend_otp, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    UtilityHlepar.getToast(data['message']);
    return ResendOtpResponse.fromJson(data);
  }
  static Future<GetPageResponse> getPrivacyPolicy(type) async {
    var responsData = await ApiService.postAPI(path: "https://alphawizztest.tk/Deffo/api/authentication/pageapp",parameters: {"type":type});
    var data = jsonDecode(responsData.body);
    return GetPageResponse.fromJson(data);
  }
  // Get User Profile
  static Future<GetProfileResponse> getProfile(
      var data1,{String url= ""}) async {
    var responsData = await ApiService.postAPI(
        path: url==""?Apipath.get_profile:url, parameters: data1);
    var data = jsonDecode(responsData.body);
    await App.init();
    print(data['profile'][0]['firstname']!=null?data['profile'][0]['firstname']:data['profile'][0]['user_name']);
    if(data['profile'][0]['firstname']!=""&&data['profile'][0]['firstname']!=null){
        App.localStorage.setString("name", data['profile'][0]['firstname']);
    }else{
      App.localStorage.setString("name", data['profile'][0]['user_name']);
    }
    return GetProfileResponse.fromJson(data);
  }
}
