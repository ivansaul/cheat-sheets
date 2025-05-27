import 'package:cheat_sheets/src/features/coupons/data/coupon_repository_provider.dart';
import 'package:cheat_sheets/src/features/coupons/domain/coupon.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coupon_controller.g.dart';

@Riverpod()
class CouponController extends _$CouponController {
  @override
  Future<Coupon> build(String bySlug) async {
    return _init(bySlug);
  }

  Future<Coupon> _init(String bySlug) async {
    final repo = ref.watch(couponRepositiryProvider);
    final result = await repo.fetchCoupon(bySlug).run();

    return result.getOrElse((l) => throw l);
  }
}
