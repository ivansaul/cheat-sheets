import 'package:envied/envied.dart';
import 'package:flutter/foundation.dart';

part 'env.g.dart';

@Envied(path: '.env', name: 'ProductionEnv', obfuscate: true)
@Envied(path: '.env_debug', name: 'DebugEnv', obfuscate: false)
abstract interface class Env {
  static T _getEnvValue<T>(T debugValue, T prodValue) {
    return kDebugMode ? debugValue : prodValue;
  }

  static final _debugEnv = _DebugEnv();
  static final _prodEnv = _ProductionEnv();

  // Coupon
  @EnviedField(varName: 'API_COUPON_BASE_URL')
  static final String apiCouponBaseUrl = _getEnvValue(
    _debugEnv.apiCouponBaseUrl,
    _prodEnv.apiCouponBaseUrl,
  );

  @EnviedField(varName: 'API_COUPON_LIST_ENDPOINT')
  static final String apiCouponListEndpoint = _getEnvValue(
    _debugEnv.apiCouponListEndpoint,
    _prodEnv.apiCouponListEndpoint,
  );

  @EnviedField(varName: 'API_COUPON_ENDPOINT')
  static final String apiCouponEndpoint = _getEnvValue(
    _debugEnv.apiCouponEndpoint,
    _prodEnv.apiCouponEndpoint,
  );

  // Cheatsheets
  @EnviedField(varName: 'API_CHEATSHEET_BASE_URL')
  static final String apiCheatsheetBaseUrl = _getEnvValue(
    _debugEnv.apiCheatsheetBaseUrl,
    _prodEnv.apiCheatsheetBaseUrl,
  );

  @EnviedField(varName: 'API_CHEATSHEET_LIST_ENDPOINT')
  static final String apiCheatsheetListEndpoint = _getEnvValue(
    _debugEnv.apiCheatsheetListEndpoint,
    _prodEnv.apiCheatsheetListEndpoint,
  );

  @EnviedField(varName: 'API_CHEATSHEET_DETAIL_ENDPOINT')
  static final String apiCheatsheetDetailEndpoint = _getEnvValue(
    _debugEnv.apiCheatsheetDetailEndpoint,
    _prodEnv.apiCheatsheetDetailEndpoint,
  );
}
