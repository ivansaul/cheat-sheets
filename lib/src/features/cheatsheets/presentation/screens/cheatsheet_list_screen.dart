import 'package:cheat_sheets/src/features/cheatsheets/presentation/providers/cheatsheet_providers.dart';
import 'package:cheat_sheets/src/features/cheatsheets/presentation/widgets/custom_list_tile.dart';
import 'package:cheat_sheets/src/router/app_routes.dart';
import 'package:cheat_sheets/src/shared/widgets/app_theme_toggle_button.dart';
import 'package:cheat_sheets/src/shared/widgets/async_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';

class CheatsheetListScreen extends ConsumerWidget {
  const CheatsheetListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cheatsheetsAsync = ref.watch(cheatsheetListControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Reference'),
        leading: IconButton(
          onPressed: () => const SettingsRoute().go(context),
          icon: const Icon(
            Icons.settings_rounded,
          ),
        ),
        actions: [
          const AppThemeToggleButton(),
          IconButton(
            onPressed: () => const CheatsheetSearchRoute().go(context),
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 16,
            ),
          ),
          const Gap(10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const Text(
              'Here are some cheat sheets and quick references contributed by open source angels.',
            ),
            const Gap(20),
            Expanded(
              child: AsyncValueWidget(
                asyncValue: cheatsheetsAsync,
                data: (metaList) => ListView.separated(
                  itemCount: metaList.length,
                  separatorBuilder: (_, __) => const Gap(20),
                  itemBuilder: (context, index) {
                    final meta = metaList[index];
                    return CustomListTile(
                      title: meta.title,
                      leadingIcon: meta.icon,
                      backgroundColor: meta.background != null
                          ? HexColor(meta.background!)
                          : Colors.blue,
                      onTap: () =>
                          CheatsheetRoute(sheetId: meta.id).go(context),
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
