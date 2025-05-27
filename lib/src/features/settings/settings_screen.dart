import 'package:cheat_sheets/src/constants/constants.dart';
import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/extensions/nullable.dart';
import 'package:cheat_sheets/src/extensions/string.dart';
import 'package:cheat_sheets/src/extensions/text_style.dart';
import 'package:cheat_sheets/src/shared/providers/app_info_provider.dart';
import 'package:cheat_sheets/src/shared/utils/link.dart';
import 'package:cheat_sheets/src/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeControllerProvider).valueOrNull;
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
                style: context.textTheme.titleMedium?.bold(),
              ),
            ),
            ListTile(
              title: const Text('Theme'),
              subtitle: themeMode.fold(
                () => const Text('Loading...'),
                (mode) => Text(mode.name.capitalize()),
              ),
              onTap: () => _showDialogTheme(context, ref),
            ),
            // TODO: Implement Code Style
            // TODO: Implement Language settings
            ListTile(
              title: const Text('Language'),
              subtitle: const Text('English'),
              onTap: () {},
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15.0),
              child: Text(
                'More Options',
                style: context.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w900),
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
                style: context.textTheme.labelMedium,
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
  final themeModeNotifier = ref.read(themeModeControllerProvider.notifier);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Theme',
          style: context.textTheme.titleMedium?.bold(),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Light'),
              leading: const Icon(Icons.light_mode_rounded),
              onTap: () {
                themeModeNotifier.setTheme(ThemeMode.light);
                context.pop();
              },
            ),
            ListTile(
              title: const Text('Dark'),
              leading: const Icon(Icons.dark_mode_rounded),
              onTap: () {
                themeModeNotifier.setTheme(ThemeMode.dark);
                context.pop();
              },
            ),
            ListTile(
              title: const Text('System'),
              leading: const Icon(Icons.auto_awesome_rounded),
              onTap: () {
                themeModeNotifier.setTheme(ThemeMode.system);
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
