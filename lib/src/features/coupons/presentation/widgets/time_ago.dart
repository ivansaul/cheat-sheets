import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/extensions/text_style.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/widgets/badge.dart';
import 'package:cheat_sheets/src/i18n/app_localizations.dart';
import 'package:cheat_sheets/src/i18n/app_localizations_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CouponTimeAgoLabel extends HookConsumerWidget {
  const CouponTimeAgoLabel({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = ref.watch(localizationsProvider).requireValue;
    final timeAgoValue = useStream(timeAgoStream(date, loc));

    return CouponBadge(
      color: Colors.black.withValues(alpha: 0.5),
      child: Text(
        timeAgoValue.data ?? '',
        style: context.textTheme.labelMedium
            ?.foregroundColor(Colors.white)
            .semibold(),
      ),
    );
  }
}

extension _Utils on CouponTimeAgoLabel {
  String timeAgo(DateTime date, Translations loc) {
    final utcDate = DateTime.utc(
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
      date.second,
    );

    final diff = DateTime.now().toUtc().difference(utcDate);

    if (diff.inMinutes < 60) {
      return loc.coupons.time.minutesAgo(m: diff.inMinutes);
    }
    if (diff.inHours < 24) return loc.coupons.time.hoursAgo(h: diff.inHours);
    return loc.coupons.time.daysAgo(d: diff.inDays);
  }

  Stream<String> timeAgoStream(DateTime date, Translations loc) async* {
    yield timeAgo(date, loc);
    yield* Stream.periodic(
      const Duration(minutes: 1),
      (_) => timeAgo(date, loc),
    );
  }
}
