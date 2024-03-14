import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_project/models/login_info.dart';

import 'package:my_project/models/user.dart';

class SecureStorage {
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  void saveUser(User user) {
    _flutterSecureStorage.write(
      key: 'user',
      value: jsonEncode(user.toJson()),
    );
  }

  Future<User?> getUser() async {
    final String? user = await _flutterSecureStorage.read(key: 'user');
    if (user != null) {
      final Map<String, dynamic> decodedJsonUser =
        json.decode(user) as Map<String, dynamic>;
      return User.fromJson(decodedJsonUser);
    } else {
      return null;
    }
  }

  Future<bool> checkUser(LoginInfo loginInfo) async {
    final User? registerUser = await getUser();
    if (registerUser != null) {
      return loginInfo.email == registerUser.email &&
          loginInfo.password == registerUser.password;
    } else {
      return false;
    }
  }

  void deleteUser() {
    _flutterSecureStorage.delete(key: 'user');
  }
}
