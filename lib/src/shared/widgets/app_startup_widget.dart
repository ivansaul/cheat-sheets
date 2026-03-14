import 'package:cheat_sheets/src/constants/constants.dart';
import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/extensions/nullable.dart';
import 'package:cheat_sheets/src/extensions/text_style.dart';
import 'package:cheat_sheets/src/shared/providers/app_startup_provider.dart';
import 'package:cheat_sheets/src/shared/providers/internet_connection_provider.dart';
import 'package:cheat_sheets/src/shared/utils/link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({
    super.key,
    required this.onLoaded,
  });

  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(internetConnectionProvider, (previous, next) {
      _internetConnectionLister(previous, next, context);
    });

    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      skipLoadingOnRefresh: false,
      loading: () => const _AppStartupLoadingWidget(),
      data: (_) => onLoaded(context),
      error: (error, stackTrace) => _AppStartupErrorWidget(
        error: error,
        stackTrace: stackTrace,
        onRetry: () => ref.invalidate(appStartupProvider),
      ),
    );
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

class _AppStartupLoadingWidget extends StatelessWidget {
  const _AppStartupLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _AppStartupErrorWidget extends StatelessWidget {
  const _AppStartupErrorWidget({
    required this.error,
    this.stackTrace,
    required this.onRetry,
  });

  final Object error;
  final StackTrace? stackTrace;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Oops!",
              style: context.textTheme.headlineMedium?.bold(),
            ),
            const Gap(20),
            SvgPicture.asset(
              "assets/images/error-help.svg",
              height: 200,
              fit: BoxFit.fitHeight,
            ),
            const Gap(20),
            Text(
              "Something went wrong during app startup",
              style: context.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const Gap(10),
            Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                onRetry.toWidget(
                  (retry) => GestureDetector(
                    onTap: retry,
                    child: const Chip(
                      padding: EdgeInsets.zero,
                      avatar: Icon(Icons.refresh_rounded),
                      label: Text("Retry"),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => openLink(Links.reportIssue),
                  child: const Chip(
                    padding: EdgeInsets.zero,
                    avatar: Icon(FontAwesomeIcons.github),
                    label: Text("Report Issue"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
