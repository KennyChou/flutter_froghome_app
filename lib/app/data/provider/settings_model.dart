import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SettingsProvider {
  final _darkMode = false.obs;
  bool get darkMode => _darkMode.value;
  set darkMode(bool value) => _darkMode.value = value;

  final _messageMode = false.obs;
  bool get messageMode => _messageMode.value;
  set messageMode(bool value) => _messageMode.value = value;

  Future<void> init() async {
    var box = await Hive.openBox('settings');
    darkMode = await box.get('darkMode', defaultValue: false);
    messageMode = await box.get('messageMode', defaultValue: true);
    await box.close();
    Get.changeThemeMode(darkMode ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> updateDarkMode(bool value) async {
    var box = await Hive.openBox('settings');
    darkMode = value;
    await box.put('darkMode', darkMode);
    await box.close();
    Get.changeThemeMode(darkMode ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> updateMessageMode(bool value) async {
    var box = await Hive.openBox('settings');
    messageMode = value;
    await box.put('messageMode', messageMode);
    await box.close();
  }
}
