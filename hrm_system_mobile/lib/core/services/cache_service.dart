import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late String key;

  CacheService({required this.key});

   Future<String?> readCache() async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      print('Error reading cache: $e');
      return null;
    }
  }

  Future<void> writeCache(String? value) async {
    try {
      await _storage.write(key: key, value: value ?? "");
    } catch (e) {
      print('Error writing to cache: $e');
    }
  }

  // Future<void> clearCache() async {
  //   await _storage.deleteAll();
  // }
}
