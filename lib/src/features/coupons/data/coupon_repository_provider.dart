import 'package:cheat_sheets/src/features/coupons/data/coupon_repository.dart';
import 'package:cheat_sheets/src/features/coupons/data/coupon_repository_impl.dart';
import 'package:cheat_sheets/src/shared/services/network/network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coupon_repository_provider.g.dart';

@Riverpod()
CouponRepository couponRepositiry(Ref ref) {
  final networkService = ref.watch(networkServiceProvider);
  return CouponRepositoryImpl(networkService: networkService);
}
