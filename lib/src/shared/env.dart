import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  // Coupon
  @EnviedField(varName: 'COUPON_BASE_URL')
  static final String couponBaseUrl = _Env.couponBaseUrl;

  @EnviedField(varName: 'COUPON_LIST_PATH')
  static final String couponListPath = _Env.couponListPath;

  @EnviedField(varName: 'COUPON_PATH')
  static final String couponPath = _Env.couponPath;

  // Cheatsheets
  @EnviedField(varName: 'API_CHEATSHEET_BASE_URL')
  static final String apiCheatsheetBaseUrl = _Env.apiCheatsheetBaseUrl;

  @EnviedField(varName: 'API_CHEATSHEET_LIST_ENDPOINT')
  static final String apiCheatsheetListEndpoint =
      _Env.apiCheatsheetListEndpoint;

  @EnviedField(varName: 'API_CHEATSHEET_DETAIL_ENDPOINT')
  static final String apiCheatsheetDetailEndpoint =
      _Env.apiCheatsheetDetailEndpoint;
}
