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
}
