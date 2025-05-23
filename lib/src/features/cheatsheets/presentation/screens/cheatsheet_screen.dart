import 'package:cheat_sheets/src/constants/constants.dart';
import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/extensions/text_style.dart';
import 'package:cheat_sheets/src/features/cheatsheets/presentation/providers/cheatsheet_providers.dart';
import 'package:cheat_sheets/src/features/cheatsheets/presentation/widgets/custom_list_tile.dart';
import 'package:cheat_sheets/src/router/app_routes.dart';
import 'package:cheat_sheets/src/shared/screens/error_screen.dart';
import 'package:cheat_sheets/src/shared/screens/loading_screen.dart';
import 'package:cheat_sheets/src/shared/widgets/app_theme_toggle_button.dart';
import 'package:cheat_sheets/src/shared/widgets/markdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class CheatsheetScreen extends ConsumerWidget {
  const CheatsheetScreen({
    super.key,
    required this.sheetId,
  });

  final String sheetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cheatsheetAsync = ref.watch(cheatsheetControllerProvider(sheetId));
    return cheatsheetAsync.when(
      loading: () => const LoadingScreen(),
      error: (e, __) => ErrorScreen(message: e.toString()),
      data: (cheatsheet) => Scaffold(
        appBar: _AppBarView(title: cheatsheet.title),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              if (cheatsheet.intro != null)
                CustomMarkdownWidget(
                  data: cheatsheet.intro!,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                ),
              const Gap(10),
              Expanded(
                child: ListView.builder(
                  itemCount: cheatsheet.sections.length,
                  itemBuilder: (BuildContext context, int index) {
                    final section = cheatsheet.sections[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CustomListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        leadingIcon: Assets.notesIconSvg,
                        title: section.title,
                        onTap: () =>
                            CheatsheetDetailRoute(section).push(context),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBarView extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const _AppBarView({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title ',
              style: context.textTheme.titleLarge?.tsBold(),
            ),
            TextSpan(
              text: 'cheatsheet',
              style:
                  context.textTheme.titleLarge?.tsBold().tsColor(Colors.grey),
            ),
          ],
        ),
      ),
      actions: [
        const AppThemeToggleButton(),
        const Gap(10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
