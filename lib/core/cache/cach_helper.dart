import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  // إنستانس واحدة من secure storage
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  //! put data (String only in secure storage)
  static Future<void> saveData({
    required String key,
    required String value,
  }) async {
    await _storage.write(key: key, value: value);
  }

  //! get data
  static Future<String?> getData({
    required String key,
  }) async {
    return await _storage.read(key: key);
  }

  //! remove data using specific key
  static Future<void> removeData({
    required String key,
  }) async {
    await _storage.delete(key: key);
  }

  //! check if key exists
  static Future<bool> containsKey({
    required String key,
  }) async {
    return await _storage.containsKey(key: key);
  }

  //! clear all data
  static Future<void> clearData() async {
    await _storage.deleteAll();
  }

  //! get all saved data as a map
  static Future<Map<String, String>> getAllData() async {
    return await _storage.readAll();
  }
}
