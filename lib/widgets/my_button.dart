import 'package:deffo/app_theme.dart';
import 'package:flutter/material.dart';

class MyButton {
  static Center myLodingButton(Size mysize, {btnText, required lodingbtn}) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 750),
        height: 80,
        width: lodingbtn ? mysize.width * 0.6 : mysize.width * 0.95,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.purple,
            borderRadius: BorderRadius.circular(25),
          ),
          margin: EdgeInsets.only(top: 20),
          child: lodingbtn
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  btnText ?? "continue".toUpperCase(),
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
        ),
      ),
    );
  }
}
