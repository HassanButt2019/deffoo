import 'package:deffo/app_theme.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:flutter/material.dart';

//appbar
class DeffoAppBar extends StatelessWidget {
  final title;

  final action;
  const DeffoAppBar({Key? key, @required this.title, this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
              Color(0xff4E1973),
              Color(0xff603181),
              Color(0xff774F95),
            ])),
      ),
      actions: action,
    );
  }
}

class DeffoTextField extends StatelessWidget {
  final hint;
  final controller;
  final keyboard;
  final maxlines;
  bool? readOnly;
  final maxLength;
  var onTap;
   DeffoTextField({Key? key, this.hint, this.controller, this.keyboard, this.maxLength, this.maxlines,this.readOnly,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        height: 45,
        child: TextField(
          keyboardType: keyboard,
          maxLines: maxlines??1,
          maxLength: maxLength,
          onTap: onTap!=null?onTap:(){

          },
          readOnly: readOnly!=null?readOnly!:false,
          controller: controller,
          decoration: InputDecoration(
              // filled: true,
              contentPadding: EdgeInsets.zero,

              prefix: Text("     "),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.black)),
              label: Text("     $hint")),
        ),
      ),
    );
  }
}

Container button(double width, {text}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: width / 33),
    width: width,
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(vertical: 18),
    child: Text(
      text ?? "Continue",
      style: TextStyle(color: Colors.white),
    ),
    decoration: BoxDecoration(
        color: AppTheme.purple, borderRadius: BorderRadius.circular(8)),
  );
}
