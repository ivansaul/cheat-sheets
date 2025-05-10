import 'package:cheat_sheets/src/shared/services/storage/key_value_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// An implementation of [KeyValueStorageService] using SharedPreferences.
///
/// Only supports values of type:
/// - `int`
/// - `bool`
/// - `double`
/// - `String`
/// - `List<String>`
final class SharedPreferencesStorageService implements KeyValueStorageService {
  final _db = SharedPreferencesAsync();

  @override
  Future<T?> get<T>(String key) async {
    if (T == int) return await _db.getInt(key) as T?;
    if (T == bool) return await _db.getBool(key) as T?;
    if (T == double) return await _db.getDouble(key) as T?;
    if (T == String) return await _db.getString(key) as T?;
    if (T == List<String>) return await _db.getStringList(key) as T?;

    throw UnimplementedError("Unsupported type $T");
  }

  @override
  Future<void> set<T>(String key, T value) async {
    if (![int, bool, double, String, List<String>].contains(T)) {
      throw UnimplementedError("Unsupported type $T");
    }

    if (T == int) await _db.setInt(key, value as int);
    if (T == bool) await _db.setBool(key, value as bool);
    if (T == double) await _db.setDouble(key, value as double);
    if (T == String) await _db.setString(key, value as String);
    if (T == List<String>) await _db.setStringList(key, value as List<String>);
  }

  @override
  Future<void> remove(String key) async {
    await _db.remove(key);
  }
}
