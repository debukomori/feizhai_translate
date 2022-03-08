import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

//持久化代码 浮华_du：https://juejin.cn/post/7030702503893139487

class LocalStorage {
  static SharedPreferences? prefs;

  static initSP() async {
    prefs = await SharedPreferences.getInstance();
  }

  static save(String key, String value) {
    prefs?.setString(key, value);
  }

  static savebool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  static get(String key) {
    return prefs?.get(key);
  }

  static remove(String key) {
    prefs?.remove(key);
  }
}
