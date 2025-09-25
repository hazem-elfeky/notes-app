import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  Future<void> saveUserData({
    required String id,
    required String username,
    required String email,
  }) async {
    await _prefs.setString('id', id);
    await _prefs.setString('username', username);
    await _prefs.setString('email', email);
    await _prefs.setString('step', '1');
  }

  String? getUserId() => _prefs.getString('id');
  String? getUsername() => _prefs.getString('username');
  String? getUserEmail() => _prefs.getString('email');
  String? getStep() => _prefs.getString('step');

  bool get isLoggedIn => getStep() == '1';

  Future<void> clearUserData() async {
    await _prefs.remove('id');
    await _prefs.remove('username');
    await _prefs.remove('email');
    await _prefs.remove('step');
  }

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) => _prefs.getString(key);

  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) => _prefs.getBool(key);

  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) => _prefs.getInt(key);

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
