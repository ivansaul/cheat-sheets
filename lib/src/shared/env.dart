import 'package:envied/envied.dart';
import 'package:flutter/foundation.dart';

part 'env.g.dart';

@Envied(path: '.env', name: 'ProductionEnv', obfuscate: true)
@Envied(path: '.env_debug', name: 'DebugEnv', obfuscate: false)
abstract interface class Env {
  // Coupon
  @EnviedField(varName: 'COUPON_BASE_URL')
  static final String couponBaseUrl = switch (kDebugMode) {
    true => _DebugEnv().couponBaseUrl,
    false => _ProductionEnv().couponBaseUrl,
  };

  @EnviedField(varName: 'COUPON_LIST_PATH')
  static final String couponListPath = switch (kDebugMode) {
    true => _DebugEnv().couponListPath,
    false => _ProductionEnv().couponListPath,
  };

  @EnviedField(varName: 'COUPON_PATH')
  static final String couponPath = switch (kDebugMode) {
    true => _DebugEnv().couponPath,
    false => _ProductionEnv().couponPath,
  };

  // Cheatsheets
  @EnviedField(varName: 'API_CHEATSHEET_BASE_URL')
  static final String apiCheatsheetBaseUrl = switch (kDebugMode) {
    true => _DebugEnv().apiCheatsheetBaseUrl,
    false => _ProductionEnv().apiCheatsheetBaseUrl,
  };

  @EnviedField(varName: 'API_CHEATSHEET_LIST_ENDPOINT')
  static final String apiCheatsheetListEndpoint = switch (kDebugMode) {
    true => _DebugEnv().apiCheatsheetListEndpoint,
    false => _ProductionEnv().apiCheatsheetListEndpoint,
  };

  @EnviedField(varName: 'API_CHEATSHEET_DETAIL_ENDPOINT')
  static final String apiCheatsheetDetailEndpoint = switch (kDebugMode) {
    true => _DebugEnv().apiCheatsheetDetailEndpoint,
    false => _ProductionEnv().apiCheatsheetDetailEndpoint,
  };
}
