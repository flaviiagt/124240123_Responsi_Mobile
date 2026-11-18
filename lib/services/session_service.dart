import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const _keyEmail = 'email';

  static Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail); 
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyEmail);
  }
}

class AuthService {
  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw ArgumentError('Email dan password wajib diisi');
    }
    await SessionService.saveEmail(email);
  }
}
