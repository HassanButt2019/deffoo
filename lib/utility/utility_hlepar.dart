import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:progressive_image/progressive_image.dart';
Logger log = Logger();
class UtilityHlepar {
  // get Flutter toast MSG
  static getToast(msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      // backgroundColor: Colors.red,
      // textColor: Colors.white,
      // fontSize: 16.0
    );
  }

  // check if not null data
  static String convertNA(data) {
    var convertNA = data;
    if (convertNA == "" || convertNA == null) {
      convertNA = "N/A";
    }
    return convertNA ?? "N/A";
  }

  // for loding img
  static ProgressiveImage convertIMG(img, {height, width, fit}) {
    return ProgressiveImage(
      placeholder: AssetImage('assets/loding/loding_banner_1.png'),
      thumbnail: NetworkImage(img),
      image: NetworkImage(img),
      height: height ?? 50,
      width: width ?? 50,
      fit: fit ?? BoxFit.cover,
    );
  }



 static getLog(message){
    log.d(message);
  }

}
