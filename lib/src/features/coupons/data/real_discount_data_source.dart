import 'package:cheat_sheets/src/features/coupons/data/coupon_data_source.dart';
import 'package:cheat_sheets/src/features/coupons/data/coupon_data_source_exception.dart';
import 'package:cheat_sheets/src/features/coupons/data/coupon_resources.dart';
import 'package:cheat_sheets/src/features/coupons/data/coupon_responses.dart';
import 'package:cheat_sheets/src/features/coupons/domain/coupon.dart';
import 'package:cheat_sheets/src/shared/services/network/network_service.dart';
import 'package:fpdart/fpdart.dart';

final class RealDiscountDataSource implements CouponDataSource {
  RealDiscountDataSource({
    required NetworkService networkService,
  }) : _networkService = networkService;

  final NetworkService _networkService;

  @override
  TaskEither<CouponDataSourceException, Coupon> get(String bySlug) {
    final resource = CouponResource(slug: bySlug);
    final task = _networkService
        .request(resource)
        .mapLeft((error) => error.toCouponDataSourceException())
        .flatMap(
          (res) => TaskEither.tryCatch(
            () async => Coupon.fromJson(res.data),
            (error, st) => CouponDataSourceException.parsing(
              error: error,
              stackTrace: st,
            ),
          ),
        );
    return task;
  }

  @override
  TaskEither<CouponDataSourceException, List<Coupon>> getList({
    int page = 1,
    int limit = 10,
    String sortBy = "sale_start",
  }) {
    final resource = CouponListResource(
      limit: limit,
      page: page,
      sortBy: sortBy,
    );
    final task = _networkService
        .request(resource)
        .mapLeft((error) => error.toCouponDataSourceException())
        .flatMap(
          (res) => TaskEither.tryCatch(
            () async => CouponListResponse.fromJson(res.data).items,
            (error, st) => CouponDataSourceException.parsing(
              error: error,
              stackTrace: st,
            ),
          ),
        )
        .map((r) => r.where((coupon) => coupon.type != CouponType.ad).toList());
    return task;
  }
}
