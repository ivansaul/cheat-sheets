import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/extensions/text_style.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CouponTimeAgoLabel extends HookWidget {
  const CouponTimeAgoLabel({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final timeAgoValue = useStream(timeAgoStream(date));

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
  String timeAgo(DateTime date) {
    final utcDate = DateTime.utc(
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
      date.second,
    );

    final diff = DateTime.now().toUtc().difference(utcDate);

    if (diff.inMinutes < 1) return "now";
    if (diff.inMinutes < 2) return "1 minute ago";
    if (diff.inMinutes < 60) return "${diff.inMinutes} minutes ago";
    if (diff.inHours < 2) return "${diff.inHours} hour ago";
    if (diff.inHours < 24) return "${diff.inHours} hours ago";
    if (diff.inDays < 2) return "${diff.inDays} day ago";
    return "${diff.inDays} days ago";
  }

  Stream<String> timeAgoStream(DateTime date) async* {
    yield timeAgo(date);
    yield* Stream.periodic(
      const Duration(minutes: 1),
      (_) => timeAgo(date),
    );
  }
}
