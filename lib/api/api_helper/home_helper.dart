import 'dart:convert';

import 'package:deffo/api/api_path.dart';
import 'package:deffo/api/api_services.dart';
import 'package:deffo/model/response/category_response.dart';
import 'package:deffo/model/response/home_banner_response.dart';

class HomeAPiHelper {
  // home Page Banner
  static Future<HomeBannerResponse> homeBanner() async {
    var responsData = await ApiService.getAPI(path: Apipath.home_banner);
    var data = jsonDecode(responsData.body);
    return HomeBannerResponse.fromJson(data);
  }

  // home Page category
  static Future<CategoryResponse> category() async {
    var responsData = await ApiService.getAPI(path: Apipath.home_category);
    var data = jsonDecode(responsData.body);
    return CategoryResponse.fromJson(data);
  }
}
