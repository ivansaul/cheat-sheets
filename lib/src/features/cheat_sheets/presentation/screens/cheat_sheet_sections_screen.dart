import 'package:cheat_sheets/src/constants/constants.dart';
import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/extensions/text_style.dart';
import 'package:cheat_sheets/src/features/cheat_sheets/domain/cheat_sheet.dart';
import 'package:cheat_sheets/src/features/cheat_sheets/presentation/widgets/custom_list_tile.dart';
import 'package:cheat_sheets/src/router/app_routes.dart';
import 'package:cheat_sheets/src/shared/widgets/app_theme_toggle_button.dart';
import 'package:cheat_sheets/src/shared/widgets/markdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CheatSheetSectionsScreen extends StatelessWidget {
  final CheatSheet cheatSheet;
  const CheatSheetSectionsScreen({
    super.key,
    required this.cheatSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBarView(title: cheatSheet.title),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            CustomMarkdownWidget(
              data: cheatSheet.intro,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
            ),
            const Gap(10),
            Expanded(
              child: ListView.builder(
                itemCount: cheatSheet.sections.length,
                itemBuilder: (BuildContext context, int index) {
                  final section = cheatSheet.sections[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      leadingIcon: Assets.notesIconSvg,
                      title: section.title,
                      onTap: () => context.push(
                        AppRoutes.details.path,
                        extra: section,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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
        AppThemeToggleButton(),
        const Gap(10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
