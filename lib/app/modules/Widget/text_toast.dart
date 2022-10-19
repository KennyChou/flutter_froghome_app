import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';

import 'package:get/get.dart';

class TextToast {
  static show(String title, String content, {int duration = 1}) {
    if (Get.isSnackbarOpen) {
      Get.back();
    }
    Get.showSnackbar(
      GetSnackBar(
        titleText: Text(title),
        messageText: Text(
          content,
          style: const TextStyle(fontSize: 16),
        ),
        duration: Duration(seconds: duration),
        snackPosition: SnackPosition.TOP,
        borderRadius: 10.0,
        margin: const EdgeInsets.all(20),
        backgroundColor: DBService.settings.darkMode
            ? Colors.black
            : Colors.white.withAlpha(192),
        animationDuration: const Duration(milliseconds: 150),
      ),
    );
  }
}
