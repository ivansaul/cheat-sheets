import 'package:cheat_sheets/src/features/coupons/domain/coupon.dart';
import 'package:cheat_sheets/src/shared/exceptions/app_exceptions.dart';
import 'package:fpdart/fpdart.dart';

abstract class CouponRepository {
  TaskEither<AppException, Coupon> fetchCoupon(String bySlug);
  TaskEither<AppException, List<Coupon>> fetchCouponList({
    int page = 1,
    int limit = 10,
    String sortBy = "sale_start",
  });
}
