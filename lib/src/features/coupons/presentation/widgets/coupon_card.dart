import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/extensions/nullable.dart';
import 'package:cheat_sheets/src/features/coupons/domain/coupon.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/widgets/sale_price.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/widgets/tags_row.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/widgets/time_ago.dart';
import 'package:cheat_sheets/src/shared/widgets/async_image.dart';
import 'package:cheat_sheets/src/shared/widgets/divider.dart';
import 'package:cheat_sheets/src/shared/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({
    super.key,
    required this.coupon,
    this.onTap,
  });

  final Coupon coupon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(
            color: context.appColor.backgroundSecondary,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coupon.name.toWidget(
                (name) => Text(
                  name,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CouponTagsRow(
                tags: [
                  ...[
                    coupon.category,
                    coupon.subcategory,
                  ].whereType<String>().map((e) => "#$e"),
                ],
              ),
              _BannerView(coupon),
              _LabelsRowView(coupon),
            ],
          ),
        ),
      ),
    );
  }
}

class _BannerView extends StatelessWidget {
  const _BannerView(
    this.coupon,
  );

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AsyncImage(
          url: coupon.image ?? '',
          fit: BoxFit.cover,
          height: 180,
          width: double.infinity,
          borderRadius: BorderRadius.circular(10),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: CouponTimeAgoLabel(
            date: coupon.saleStart ?? DateTime.now(),
          ),
        ),
      ],
    );
  }
}

class _LabelsRowView extends StatelessWidget {
  const _LabelsRowView(
    this.coupon,
  );

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        coupon.store.toWidget(
          (r) => _buildLabel(FontAwesomeIcons.graduationCap, r),
        ),
        if (coupon.store != null) const VDivider(),
        coupon.lectures.toWidget(
          (r) => _buildLabel(
            FontAwesomeIcons.solidClock,
            "${r.toStringAsFixed(1)} hours",
          ),
        ),
        const Spacer(),
        if (coupon.price != null && coupon.salePrice != null)
          CouponSalePrice(
            price: coupon.price!,
            salePrice: coupon.salePrice!,
          ),
      ],
    );
  }

  Widget _buildLabel(IconData icon, String text) {
    return Label(
      icon: icon,
      text: text,
      iconColor: Colors.orange,
      textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
