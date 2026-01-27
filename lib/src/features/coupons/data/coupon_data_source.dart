import 'package:cheat_sheets/src/features/coupons/data/coupon_data_source_exception.dart';
import 'package:cheat_sheets/src/features/coupons/domain/coupon.dart';
import 'package:fpdart/fpdart.dart';

abstract class CouponDataSource {
  TaskEither<CouponDataSourceException, Coupon> get(String slug);
  TaskEither<CouponDataSourceException, List<Coupon>> getList({
    int page = 1,
    int limit = 10,
    String sortBy = "sale_start",
  });
}
