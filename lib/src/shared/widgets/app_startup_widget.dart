import 'package:cheat_sheets/src/shared/providers/internet_connection_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(internetConnectionProvider, (previous, next) {
      _internetConnectionLister(previous, next, context);
    });

    return child;
  }
}

// TODO: Implement custom toast notifications
void _internetConnectionLister(
  AsyncValue<InternetStatus>? previous,
  AsyncValue<InternetStatus> next,
  BuildContext context,
) {
  if (next.value == InternetStatus.disconnected) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        width: 200,
        content: const Center(
          child: Text(
            "Looks like you’re offline",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 6),
        dismissDirection: DismissDirection.down,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
