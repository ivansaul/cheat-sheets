import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/extensions/text_style.dart';
import 'package:cheat_sheets/src/features/cheatsheets/presentation/providers/cheatsheet_providers.dart';
import 'package:cheat_sheets/src/features/cheatsheets/presentation/widgets/custom_list_tile.dart';
import 'package:cheat_sheets/src/router/app_routes.dart';
import 'package:cheat_sheets/src/shared/widgets/async_value_widget.dart';
import 'package:cheat_sheets/src/shared/widgets/markdown_widget.dart';
import 'package:flutter/cupertino.dart';
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
    final asyncValue = ref.watch(cheatsheetControllerProvider(sheetId));
    final notifier = ref.watch(cheatsheetControllerProvider(sheetId).notifier);
    return Scaffold(
      appBar: _AppBarView(title: asyncValue.valueOrNull?.title ?? ""),
      body: AsyncValueWidget(
        asyncValue: asyncValue,
        onRetry: notifier.onRetry,
        data: (cheatsheet) => Padding(
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
                        leadingIcon:
                            const IconSource.icon(CupertinoIcons.layers_fill),
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
              style: context.textTheme.titleLarge?.bold(),
            ),
            TextSpan(
              text: 'cheatsheet',
              style: context.textTheme.titleLarge
                  ?.bold()
                  .foregroundColor(Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
