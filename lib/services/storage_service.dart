import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService._singletonConstructor();
  static final StorageService service = StorageService._singletonConstructor();
  late SharedPreferences _sharedPreferences;
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> addKey(String vendorId) async {
    return _sharedPreferences.setString('auth-token', vendorId);
  }

  Future<bool> addCustomKey(String key, String val) async {
    return _sharedPreferences.setString(key, val);
  }

  Future<bool> removeKey() {
    return _sharedPreferences.remove('auth-token');
  }

  String? getKey() => _sharedPreferences.getString('auth-token');
  Object? getCustomKey(String customKey) => _sharedPreferences.get(customKey);
}