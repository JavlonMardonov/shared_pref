import 'package:shared_preferences/shared_preferences.dart';

class TokenDataSource {
  static const _name = 'user_name';
  static const _email = 'user_email';
  static const _password = 'user_password';

  Future<void> saveUserInfo(
      String? name, String? email, String? password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_name, name ?? "");
    await prefs.setString(_email, email ?? "");
    await prefs.setString(_password, password ?? "");
  }

  Future<Map<String, String?>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_name);
    final email = prefs.getString(_email);
    final password = prefs.getString(_password);

    return {"name": name, "email": email, "password": password};
  }

  Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_name);
    await prefs.remove(_email);
    await prefs.remove(_password);
  }
}
