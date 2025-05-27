import 'package:cheat_sheets/src/features/coupons/domain/coupon.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coupon_responses.g.dart';

@JsonSerializable()
class CouponListResponse {
  CouponListResponse({
    required this.items,
    required this.currentPage,
    required this.totalPages,
  });

  final List<Coupon> items;

  final int currentPage;
  final int totalPages;

  factory CouponListResponse.fromJson(Map<String, dynamic> json) =>
      _$CouponListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CouponListResponseToJson(this);
}
