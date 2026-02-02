import 'package:cheat_sheets/src/features/coupons/domain/converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coupon.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Coupon {
  Coupon({
    this.name,
    this.description,
    this.content,
    this.price,
    this.salePrice,
    this.saleStart,
    this.lectures,
    this.views,
    this.rating,
    this.image,
    this.url,
    this.store,
    this.type,
    this.slug,
    this.category,
    this.tags,
    this.subcategory,
    this.language,
  });

  final String? name;
  final String? description;
  final String? content;
  @DoubleConverter()
  final double? price;
  final double? salePrice;
  final DateTime? saleStart;
  final int? lectures;
  final int? views;
  final int? rating;
  final String? image;
  final String? url;
  final String? store;
  @JsonKey(unknownEnumValue: null)
  final CouponType? type;
  final String? slug;
  final String? category;
  final String? tags;
  final String? subcategory;
  final String? language;

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);
}

enum CouponType {
  ad,
  external,
}
