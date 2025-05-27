import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/extensions/nullable.dart';
import 'package:cheat_sheets/src/extensions/padding.dart';
import 'package:cheat_sheets/src/extensions/text_style.dart';
import 'package:cheat_sheets/src/features/coupons/domain/coupon.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/providers/coupon_controller.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/widgets/badge.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/widgets/sale_price.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/widgets/tags_row.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/widgets/time_ago.dart';
import 'package:cheat_sheets/src/shared/utils/link.dart';
import 'package:cheat_sheets/src/shared/utils/markdown.dart';
import 'package:cheat_sheets/src/shared/widgets/async_image.dart';
import 'package:cheat_sheets/src/shared/widgets/async_value_widget.dart';
import 'package:cheat_sheets/src/shared/widgets/label.dart';
import 'package:cheat_sheets/src/shared/widgets/markdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class CouponScreen extends ConsumerWidget {
  const CouponScreen({
    super.key,
    required this.slug,
  });

  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final couponDetailAsync = ref.watch(couponControllerProvider(slug));
    final courseUrl = couponDetailAsync.valueOrNull?.url;
    return Scaffold(
      appBar: AppBar(
        actions: [
          courseUrl.toWidget(
            (r) => _GetCourseButton(r),
          ),
          const Gap(20),
        ],
      ),
      body: AsyncValueWidget(
        asyncValue: couponDetailAsync,
        data: (coupon) => ListView(
          children: [
            const Gap(20),
            coupon.name.toWidget(
              (r) => Text(
                r,
                style: context.textTheme.titleLarge?.bold(),
              ),
            ),
            const Gap(10),
            _BadgeRowView(coupon),
            const Gap(20),
            _BannerView(coupon),
            const Gap(15),
            CouponTagsRow(
              tags: [
                ...[
                  coupon.category,
                  coupon.subcategory,
                ].whereType<String>()
              ],
            ),
            const Gap(10),
            coupon.content.toWidget(
              (r) => CustomMarkdownWidget(
                shrinkWrap: true,
                data: htmlToMarkdown(r),
              ),
            ),
          ],
        ),
      ).paddingH(15),
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
          borderRadius: BorderRadius.circular(15),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: CouponTimeAgoLabel(
            date: coupon.saleStart ?? DateTime.now(),
          ),
        ),
      ],
    );
  }
}

class _GetCourseButton extends StatelessWidget {
  const _GetCourseButton(
    this.url,
  );

  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openLink(url),
      child: const CouponBadge(
        child: Label(
          icon: FontAwesomeIcons.upRightFromSquare,
          text: "Get course",
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _BadgeRowView extends StatelessWidget {
  const _BadgeRowView(
    this.coupon,
  );

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        coupon.store.toWidget(
          (r) => badge(FontAwesomeIcons.graduationCap, r),
        ),
        coupon.language.toWidget(
          (r) => badge(FontAwesomeIcons.globe, r),
        ),
        coupon.lectures.toWidget(
          (r) => badge(FontAwesomeIcons.solidClock, "$r hours"),
        ),
        coupon.views.toWidget(
          (r) => badge(FontAwesomeIcons.solidEye, "$r"),
        ),
        if (coupon.price != null && coupon.salePrice != null)
          CouponBadge(
            child: CouponSalePrice(
              price: coupon.price!,
              salePrice: coupon.salePrice!,
            ),
          ),
      ],
    );
  }

  Widget badge(IconData icon, String text) => CouponBadge(
        child: Label(icon: icon, text: text),
      );
}
