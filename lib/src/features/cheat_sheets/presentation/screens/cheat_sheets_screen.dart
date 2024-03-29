import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/features/cheat_sheets/presentation/providers/cheat_sheets_provider.dart';
import 'package:cheat_sheets/src/features/cheat_sheets/presentation/widgets/custom_list_tile.dart';
import 'package:cheat_sheets/src/router/app_routes.dart';
import 'package:cheat_sheets/src/shared/screens/error_screen.dart';
import 'package:cheat_sheets/src/shared/screens/loading_screen.dart';
import 'package:cheat_sheets/src/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';

class CheatSheetsScreen extends ConsumerWidget {
  const CheatSheetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(cheatSheetsProvider);
    final isDarkMode = ref.watch(isDarkModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Reference'),
        leading: IconButton(
          onPressed: () => context.push(AppRoutes.settings.path),
          icon: const Icon(
            Icons.settings_rounded,
          ),
        ),
        actions: [
          IconButton(
            onPressed: ref.read(isDarkModeProvider.notifier).toggle,
            icon: Icon(
              isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            ),
          ),
          const Gap(10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Text(
              'Here are some cheat sheets and quick references contributed by open source angels.',
              style: context.textTheme.body2Medium,
            ),
            const Gap(20),
            Expanded(
              child: dataAsync.when(
                loading: () => const LoadingScreen(),
                error: (error, _) => ErrorScreen(error: error.toString()),
                data: (cheatSheets) => ListView.builder(
                  itemCount: cheatSheets.length,
                  itemBuilder: (context, index) {
                    final cheatSheet = cheatSheets[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: CustomListTile(
                        title: cheatSheet.title,
                        leadingIcon: cheatSheet.icon,
                        backgroundColor: HexColor(cheatSheet.background),
                        onTap: () => context.push(
                          AppRoutes.sections.path,
                          extra: cheatSheet,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
