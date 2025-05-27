import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:flutter/material.dart';

class CouponSalePrice extends StatelessWidget {
  const CouponSalePrice({
    super.key,
    required this.price,
    required this.salePrice,
    this.priceStyle,
    this.salePriceStyle,
  });

  final double price;
  final double salePrice;
  final TextStyle? priceStyle;
  final TextStyle? salePriceStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "\$$price",
          style: priceStyle ??
              TextStyle(
                color: context.appColor.grey,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.lineThrough,
                decorationColor: context.appColor.grey,
                decorationThickness: 1,
              ),
        ),
        Text(
          "\$$salePrice",
          style: salePriceStyle ??
              TextStyle(
                color: context.appColor.green,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
