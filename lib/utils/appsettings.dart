import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  static SharedPreferences prefs;

  static innitAppSetting() async {
    prefs = await SharedPreferences.getInstance();
  }

  ///userName
  static getUserName() {
    return prefs.getString(keyAppSetting.userName.toString()) ?? "";
  }

  static setUserName(String value) {
    prefs.setString(keyAppSetting.userName.toString(), value);
  }

  ///isLogin
  static getIsLogin() {
    try {
      return prefs.getBool(keyAppSetting.isLogin.toString()) ?? false;
    } catch (error) {
      print(error);
      return false;
    }
  }

  static setIsLogin(bool value) {
    prefs.setBool(keyAppSetting.isLogin.toString(), value);
  }

  ///HoTen
  static getHoTen() {
    return prefs.getString(keyAppSetting.hoTen.toString()) ?? "";
  }

  static setHoTen(String value) {
    prefs.setString(keyAppSetting.hoTen.toString(), value);
  }

  ///SDT
  static getSDT() {
    return prefs.getString(keyAppSetting.sDT.toString()) ?? "";
  }

  static setSDT(String value) {
    prefs.setString(keyAppSetting.sDT.toString(), value);
  }
  ///Email
  static getEmail() {
    return prefs.getString(keyAppSetting.email.toString()) ?? "";
  }

  static setEmail(String value) {
    prefs.setString(keyAppSetting.email.toString(), value);
  }
}

enum keyAppSetting { userName, isLogin,hoTen,sDT,email }
