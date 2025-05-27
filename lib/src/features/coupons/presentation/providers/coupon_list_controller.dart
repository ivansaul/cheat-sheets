import 'dart:async';

import 'package:cheat_sheets/src/features/coupons/data/coupon_repository_provider.dart';
import 'package:cheat_sheets/src/features/coupons/domain/coupon.dart';
import 'package:cheat_sheets/src/shared/exceptions/app_exceptions.dart';
import 'package:cheat_sheets/src/shared/utils/debouncer.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coupon_list_controller.g.dart';

@Riverpod()
class CouponListController extends _$CouponListController {
  int _currentPage = 1;
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Future<List<Coupon>> build() async {
    ref.onDispose(() => _currentPage = 1);
    return _init();
  }

  Future<void> fetchNextPage() async {
    _debouncer.run(() async {
      final previousState = await future;
      final response = await _fetchCoupons().run();
      if (response.isRight()) _currentPage++;
      state = response.fold(
        (l) => AsyncError(l, StackTrace.current),
        (r) => AsyncData([...previousState, ...r]),
      );
    });
  }

  Future<void> onRefresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<List<Coupon>> _init() async {
    final response = await _fetchCoupons().run();
    if (response.isRight()) _currentPage++;
    return response.getOrElse((l) => throw l);
  }

  TaskEither<AppException, List<Coupon>> _fetchCoupons() {
    final repo = ref.watch(couponRepositiryProvider);
    return repo.fetchCouponList(page: _currentPage);
  }
}
