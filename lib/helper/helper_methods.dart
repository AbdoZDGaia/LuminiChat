import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String isUserLoggedInSharePreferenceKey = "ISLOGGEDINKEY";
  static String loggedInUserNameSharePreferenceKey = "USERNAMEKEY";
  static String loggedInUserEmailSharePreferenceKey = "USEREMAILKEY";

  static Future<bool> setIsUserLoggedInSharedPreferences(
      bool isUserLoggedIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool(isUserLoggedInSharePreferenceKey, isUserLoggedIn);
  }

  static Future<bool> setLoggedInUserNameSharePreferences(
      String loggedInUserName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(loggedInUserNameSharePreferenceKey, loggedInUserName);
  }

  static Future<bool> setLoggedInUserEmailSharePreferences(
      String loggedInUserEmail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(
        loggedInUserEmailSharePreferenceKey, loggedInUserEmail);
  }

  static Future<String> getLoggedInUserEmailSharePreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(loggedInUserEmailSharePreferenceKey);
  }

  static Future<String> getLoggedInUserNameSharePreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(loggedInUserNameSharePreferenceKey);
  }

  static Future<bool> getIsUserLoggedInSharedPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(isUserLoggedInSharePreferenceKey);
  }
}
