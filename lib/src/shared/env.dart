import 'package:envied/envied.dart';
import 'package:flutter/foundation.dart';

part 'env.g.dart';

@Envied(path: '.env', name: 'ProductionEnv', obfuscate: true)
@Envied(path: '.env_debug', name: 'DebugEnv', obfuscate: false)
abstract interface class Env {
  // Coupon
  @EnviedField(varName: 'API_COUPON_BASE_URL')
  static final String apiCouponBaseUrl = switch (kDebugMode) {
    true => _DebugEnv().apiCouponBaseUrl,
    false => _ProductionEnv().apiCouponBaseUrl,
  };

  @EnviedField(varName: 'API_COUPON_LIST_ENDPOINT')
  static final String apiCouponListEndpoint = switch (kDebugMode) {
    true => _DebugEnv().apiCouponListEndpoint,
    false => _ProductionEnv().apiCouponListEndpoint,
  };

  @EnviedField(varName: 'API_COUPON_ENDPOINT')
  static final String apiCouponEndpoint = switch (kDebugMode) {
    true => _DebugEnv().apiCouponEndpoint,
    false => _ProductionEnv().apiCouponEndpoint,
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
