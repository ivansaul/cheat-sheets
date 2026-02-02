import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/extensions/nullable.dart';
import 'package:cheat_sheets/src/extensions/padding.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/providers/coupon_list_controller.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/widgets/coupon_card.dart';
import 'package:cheat_sheets/src/router/app_routes.dart';
import 'package:cheat_sheets/src/shared/widgets/async_value_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
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
      body: AsyncValueWidget(
        asyncValue: couponListAsync,
        onRetry: notifier.onRetry,
        data: (listCoupon) => RefreshIndicator.adaptive(
          onRefresh: notifier.onRefresh,
          displacement: context.navigationBarHeight,
          child: CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: _NavigationHeaderDelegate(
                  context: context,
                  title: "Coupons",
                ),
              ),
              const SliverGap(20),
              SliverList.separated(
                itemCount: listCoupon.length + 1,
                separatorBuilder: (_, __) => const Gap(15),
                itemBuilder: (context, index) {
                  if (index == listCoupon.length) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    ).paddingOnly(bottom: 20);
                  }

                  final coupon = listCoupon[index];
                  return coupon.slug.toWidget(
                    (r) => CouponCard(
                      coupon: coupon,
                      onTap: () => CouponRoute(slug: r).go(context),
                    ).paddingH(15),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationHeaderDelegate extends SliverPersistentHeaderDelegate {
  _NavigationHeaderDelegate({
    required this.context,
    required this.title,
  });

  final BuildContext context;
  final String title;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    SystemChrome.setSystemUIOverlayStyle(
      context.brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
    );

    final offset = maxExtent - shrinkOffset;

    return Stack(
      children: [
        Container(
          alignment: AlignmentDirectional.bottomStart,
          height: maxExtent,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ).paddingOnly(left: 15),
        ),
        Container(
          alignment: AlignmentDirectional.bottomCenter,
          color: offset < minExtent
              ? context.appColor.backgroundSecondary
              : context.colorScheme.onSecondary,
          height: minExtent,
          width: double.infinity,
          child: offset < minExtent
              ? Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ).paddingOnly(bottom: 5).animate().fadeIn()
              : null,
        ),
      ],
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => context.navigationBarHeight * 0.8;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
