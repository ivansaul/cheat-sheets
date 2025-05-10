import 'package:cheat_sheets/src/shared/services/storage/key_value_storage_service.dart';
import 'package:cheat_sheets/src/shared/services/storage/share_preference_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'key_value_storage_service_provider.g.dart';

@Riverpod(keepAlive: true)
KeyValueStorageService keyValueStorageService(Ref ref) {
  return SharedPreferencesStorageService();
}
