import 'package:deffo/token/token_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyToken {
  static Future getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await prefs.getString(TokenString.userid);
    return data;
  }
}
