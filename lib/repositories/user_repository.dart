import 'dart:convert';

import 'package:my_project/models/login_info.dart';
import 'package:my_project/models/user.dart';
import 'package:my_project/templates/repository_template.dart';
import 'package:my_project/utils/secure_storage.dart';

class UserRepository implements RepositoryTemplate<User, LoginInfo> {
  final SecureStorage _secureStorage = SecureStorage();

  @override
  void saveInStorage(User data) {
    _secureStorage.saveInStorage('user', jsonEncode(data.toJson()));
  }

  @override
  Future<User?> getData() async {
    final String? user = await _secureStorage.getData('user');
    if (user != null) {
      final Map<String, dynamic> decodedJsonUser =
      json.decode(user) as Map<String, dynamic>;
      return User.fromJson(decodedJsonUser);
    } else {
      return null;
    }
  }

  @override
  Future<bool> checkData(LoginInfo checkValue) async {
    final User? registerUser = await getData();
    if (registerUser != null) {
      return checkValue.email == registerUser.email &&
          checkValue.password == registerUser.password;
    } else {
      return false;
    }
  }

  @override
  void deleteData() {
    _secureStorage.deleteData('user');
  }
}
