import 'package:cheat_sheets/src/features/coupons/data/coupon_data_source.dart';
import 'package:cheat_sheets/src/features/coupons/data/coupon_data_source_exception.dart';
import 'package:cheat_sheets/src/features/coupons/data/coupon_repository.dart';
import 'package:cheat_sheets/src/features/coupons/domain/coupon.dart';
import 'package:cheat_sheets/src/shared/exceptions/app_exceptions.dart';
import 'package:fpdart/fpdart.dart';

class CouponRepositoryImpl implements CouponRepository {
  CouponRepositoryImpl({
    required CouponDataSource dataSource,
  }) : _dataSource = dataSource;

  final CouponDataSource _dataSource;

  @override
  TaskEither<AppException, Coupon> get(String bySlug) {
    return _dataSource.get(bySlug).mapLeft((error) => error.toAppException());
  }

  @override
  TaskEither<AppException, List<Coupon>> getList({
    int page = 1,
    int limit = 10,
    String sortBy = "sale_start",
  }) {
    return _dataSource
        .getList(
          page: page,
          limit: limit,
          sortBy: sortBy,
        )
        .mapLeft((error) => error.toAppException());
  }
}
