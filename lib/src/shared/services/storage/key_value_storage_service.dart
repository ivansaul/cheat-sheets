/// An abstract service for storing and retrieving key-value pairs.
///
/// Supports only the following value types:
/// - `int`
/// - `bool`
/// - `double`
/// - `String`
/// - `List<String>`
///
/// Implementations may use different storage backends (e.g., shared preferences).
abstract class KeyValueStorageService {
  Future<void> set<T>(String key, T value);
  Future<T?> get<T>(String key);
  Future<void> remove(String key);
}
