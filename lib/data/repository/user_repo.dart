import 'dart:convert';

import 'package:fit_fusion/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<bool> saveUser(UserModel user) async {
    final pref = await SharedPreferences.getInstance();
    final res = await pref.setString('user', json.encode(user.toJson()));
    await pref.setBool('login', true);
    return res;
  }

  Future<UserModel?> getUser() async {
    final pref = await SharedPreferences.getInstance();
    final userJson = pref.getString('user');

    if (userJson != null) {
      return UserModel.fromJson(json.decode(userJson));
    } else {
      return null;
    }
  }

  Future<bool> getLogin() async {
    final pref = await SharedPreferences.getInstance();
    final res = pref.getBool('login');
    if (res != null) {
      return res;
    } else {
      pref.setBool('login', false);
      return false;
    }
  }

  Future<bool> saveAudioPref(bool value) async {
    final pref = await SharedPreferences.getInstance();
    final res = await pref.setBool('audio', value);
    return res;
  }

  Future<bool> getAudioPref() async {
    final pref = await SharedPreferences.getInstance();
    final res = pref.getBool('audio');

    return res!;
  }
}
