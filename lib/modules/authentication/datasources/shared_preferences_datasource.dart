import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/const/shared_preferences.dart';

class SharedPreferencesDatasource {
  SharedPreferencesDatasource();

  Future<String?> getSessionToken() async {
    try {
      // Get authenticated user based on shared preferences token
      final sharedPreferences = await SharedPreferences.getInstance();

      return sharedPreferences.getString(keySessionToken);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  Future<void> setSessionToken({required String token}) async {
    try {
      // Get authenticated user based on shared preferences token
      final sharedPreferences = await SharedPreferences.getInstance();

      await sharedPreferences.setString(keySessionToken, token);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> clearSessionToken() async {
    try {
      // Get authenticated user based on shared preferences token
      final sharedPreferences = await SharedPreferences.getInstance();

      await sharedPreferences.remove(keySessionToken);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
