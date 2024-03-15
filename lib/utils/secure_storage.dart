import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  void saveInStorage(String key, String data) {
    _flutterSecureStorage.write(
      key: key,
      value: data,
    );
  }

  Future<String?> getData(String key) async {
    return await _flutterSecureStorage.read(key: key);
  }

  void deleteData(String key) {
    _flutterSecureStorage.delete(key: key);
  }
}
