import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/extensions/padding.dart';
import 'package:cheat_sheets/src/extensions/text_style.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/providers/coupon_list_controller.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/widgets/coupon_card.dart';
import 'package:cheat_sheets/src/router/app_routes.dart';
import 'package:cheat_sheets/src/shared/widgets/async_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CouponListScreen extends HookConsumerWidget {
  const CouponListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offset = useState(0.0);
    final scrollController = useScrollController();
    final couponListAsync = ref.watch(couponListControllerProvider);
    final notifier = ref.read(couponListControllerProvider.notifier);

    useEffect(() {
      void listener() {
        offset.value = scrollController.offset;
        final position = scrollController.position;
        if (position.pixels >= position.maxScrollExtent - 600) {
          notifier.fetchNextPage();
        }
      }

      scrollController.addListener(listener);
      return () => scrollController.removeListener(listener);
    }, [scrollController]);

    return Scaffold(
      appBar: _AppBar(
        title: "Coupons",
        offset: offset.value,
      ),
      body: AsyncValueWidget(
        asyncValue: couponListAsync,
        data: (listCoupon) => CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Text(
                "Coupons",
                style: GoogleFonts.notoSans().copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ).paddingOnly(left: 15),
            ),
            const SliverGap(20),
            SliverList.separated(
              itemCount: listCoupon.length,
              separatorBuilder: (_, __) => const Gap(15),
              itemBuilder: (context, index) {
                final coupon = listCoupon[index];
                return Option.fromNullable(coupon.slug).fold(
                  () => const SizedBox.shrink(),
                  (slug) => CouponCard(
                    coupon: coupon,
                    onTap: () => CouponRoute(slug: slug).go(context),
                  ).paddingH(15),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    required this.title,
    required this.offset,
  });

  final String title;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: offset < preferredSize.height
          ? context.colorScheme.surface
          : context.appColor.backgroundSecondary,
      title: offset < preferredSize.height
          ? null
          : Text(
              title,
              style: context.textTheme.titleMedium?.bold(),
            ).animate().fadeIn(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
