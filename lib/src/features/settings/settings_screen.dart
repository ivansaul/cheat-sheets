import 'package:cheat_sheets/src/constants/constants.dart';
import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/extensions/text_style.dart';
import 'package:cheat_sheets/src/shared/providers/app_info_provider.dart';
import 'package:cheat_sheets/src/theme/theme_provider.dart';
import 'package:cheat_sheets/src/utils/open_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final appInfoAsync = ref.watch(appInfoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15.0),
              child: Text(
                'General',
                style: context.textTheme.heading3Bold,
              ),
            ),
            ListTile(
              title: const Text('Theme'),
              subtitle: Text(isDarkMode ? 'Dark' : 'Light'),
              onTap: () => _showDialogTheme(context, ref),
            ),
            // TODO: Implement Code Style
            // TODO: Implement Language settings
            ListTile(
              title: const Text('Language'),
              subtitle: const Text('English'),
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 1.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15.0),
              child: Text(
                'More Options',
                style: context.textTheme.heading3Bold,
              ),
            ),
            ListTile(
              title: const Text('Author'),
              subtitle: const Text('@ivansaul'),
              onTap: () => openLink(Links.authorGithub),
            ),
            ListTile(
              title: const Text('Special Thanks'),
              subtitle: const Text('@Fechin/reference'),
              onTap: () => openLink(Links.fechinReference),
            ),
            ListTile(
              title: const Text('Contribute'),
              onTap: () => openLink(Links.projectGithub),
            ),
            ListTile(
              title: const Text('Report an issue'),
              onTap: () => openLink(Links.reportIssue),
            ),
            const Gap(40),
            Align(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => openLink(Links.projectGithub),
                    icon: const Icon(FontAwesomeIcons.github),
                  ),
                  IconButton(
                    onPressed: () => openLink(Links.discordChat),
                    icon: const Icon(FontAwesomeIcons.discord),
                  ),
                ],
              ),
            ),
            const Gap(10),
            Align(
              child: Text(
                appInfoAsync.when(
                  data: (state) =>
                      '${state.appName} v${state.version} (${state.buildNumber})',
                  error: (_, __) => 'loading',
                  loading: () => 'loading',
                ),
                style: context.textTheme.body2Regular
                    .tsColor(context.colors.grey200),
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}

_showDialogTheme(BuildContext context, WidgetRef ref) {
  final isDarkMode = ref.watch(isDarkModeProvider);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: context.colors.brandWhite,
        title: Text(
          'Theme',
          style: context.textTheme.heading3Bold,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                'Light',
                style: context.textTheme.body2Regular,
              ),
              leading: const Icon(Icons.light_mode_rounded),
              onTap: () {
                if (isDarkMode) {
                  ref.read(isDarkModeProvider.notifier).toggle();
                }
                context.pop();
              },
            ),
            ListTile(
              title: Text(
                'Dark',
                style: context.textTheme.body2Regular,
              ),
              leading: const Icon(Icons.dark_mode_rounded),
              onTap: () {
                if (!isDarkMode) {
                  ref.read(isDarkModeProvider.notifier).toggle();
                }
                context.pop();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'CANCEL',
              style: context.textTheme.body2Regular
                  .tsColor(context.colors.brandBlue),
            ),
          )
        ],
      );
    },
  );
}
