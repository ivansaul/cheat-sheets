import 'package:cheat_sheets/src/features/coupons/data/coupon_repository.dart';
import 'package:cheat_sheets/src/features/coupons/data/coupon_resources.dart';
import 'package:cheat_sheets/src/features/coupons/data/coupon_responses.dart';
import 'package:cheat_sheets/src/features/coupons/domain/coupon.dart';
import 'package:cheat_sheets/src/shared/exceptions/app_exceptions.dart';
import 'package:cheat_sheets/src/shared/services/network/network_service.dart';
import 'package:cheat_sheets/src/shared/type_aliases.dart';
import 'package:fpdart/fpdart.dart';

class CouponRepositoryImpl implements CouponRepository {
  CouponRepositoryImpl({
    required NetworkService networkService,
  }) : _networkService = networkService;

  final NetworkService _networkService;

  @override
  TaskEither<AppException, Coupon> fetchCoupon(String bySlug) {
    final resource = CouponResource(slug: bySlug);
    return _networkService.request<Coupon, JsonMap>(
      resource,
      Coupon.fromJson,
    );
  }

  @override
  TaskEither<AppException, List<Coupon>> fetchCouponList({
    int page = 1,
    int limit = 10,
    String sortBy = "sale_start",
  }) {
    final resource = CouponListResource(
      page: page,
      limit: limit,
      sortBy: sortBy,
    );
    return _networkService
        .request<CouponListResponse, JsonMap>(
          resource,
          CouponListResponse.fromJson,
        )
        .flatMap(
          (r) => TaskEither.of(
            r.items.where((item) => item.type != "ad").toList(),
          ),
        );
  }
}
