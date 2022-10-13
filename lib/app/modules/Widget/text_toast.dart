import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class TextToast {
  static show(String content, {int duration = 1}) {
    if (Platform.isLinux || Platform.isWindows) return;
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: content,
      timeInSecForIosWeb: duration,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      // backgroundColor: Get.textTheme.bodyText1!.backgroundColor,
      // textColor: Get.textTheme.bodyText1!.color,
      fontSize: Get.textTheme.bodyText1!.fontSize,
    );
  }
}
