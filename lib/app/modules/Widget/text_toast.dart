import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TextToast {
  static show(String content, {int duration = 1}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: content,
      timeInSecForIosWeb: duration,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }
}
