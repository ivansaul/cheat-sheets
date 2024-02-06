import 'package:cheat_sheets/config/theme/theme_provider.dart';
import 'package:cheat_sheets/shared/constants/constants.dart';
import 'package:cheat_sheets/shared/providers/app_info_provider.dart';
import 'package:cheat_sheets/shared/utils/open_link.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15.0),
              child: Text(
                'General',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ListTile(
              title: const Text('Theme'),
              subtitle: Text(isDarkMode ? 'Dark' : 'Light'),
              onTap: () => _showDialogTheme(context, ref),
            ),
            // TODO: Implement Code Style
            // ListTile(
            //   title: const Text('Code Style'),
            //   subtitle: const Text('One Dark'),
            //   onTap: () {},
            // ),
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
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ListTile(
              title: const Text('Author'),
              subtitle: const Text('@ivansaul'),
              onTap: () => openLink(ConstantLinks.authorGithubLink),
            ),
            ListTile(
              title: const Text('Special Thanks'),
              subtitle: const Text('@Fechin/reference'),
              onTap: () => openLink(ConstantLinks.specialThanksLink),
            ),
            ListTile(
              title: const Text('Contribute'),
              onTap: () => openLink(ConstantLinks.projectGithubLink),
            ),
            ListTile(
              title: const Text('Report an issue'),
              onTap: () => openLink(ConstantLinks.reportIssueLink),
            ),
            const Spacer(),
            Align(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => openLink(ConstantLinks.projectGithubLink),
                    icon: const Icon(FontAwesomeIcons.github),
                  ),
                  IconButton(
                    onPressed: () => openLink(ConstantLinks.discordChatLink),
                    icon: const Icon(FontAwesomeIcons.discord),
                  ),
                ],
              ),
            ),
            const Gap(10),
            Align(
              child: Text(
                appInfoAsync.when(
                  data: (state) => '${state.appName} v${state.version} (${state.buildNumber})',
                  error: (_, __) => 'loading',
                  loading: () => 'loading',
                ),
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
        title: Text(
          'Theme',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Light', style: Theme.of(context).textTheme.titleSmall),
              leading: const Icon(Icons.light_mode_rounded),
              onTap: () {
                if (isDarkMode) {
                  ref.read(isDarkModeProvider.notifier).toggle();
                }
                context.pop();
              },
            ),
            ListTile(
              title: Text('Dark', style: Theme.of(context).textTheme.titleSmall),
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
            child: const Text('CANCEL'),
          )
        ],
      );
    },
  );
}
