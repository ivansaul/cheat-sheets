import 'package:cheat_sheets/src/features/cheatsheets/domain/cheatsheet.dart';
import 'package:cheat_sheets/src/shared/widgets/app_theme_toggle_button.dart';
import 'package:cheat_sheets/src/shared/widgets/markdown_widget.dart';
import 'package:cheat_sheets/src/shared/widgets/popup_code_style_menu.dart';
import 'package:cheat_sheets/src/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class CheatsheetSectionScreen extends ConsumerWidget {
  const CheatsheetSectionScreen({
    super.key,
    required this.section,
  });

  final SectionSheet section;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final codeStyle = ref.watch(codeStyleProvider);
    return Scaffold(
      appBar: _AppBarView(title: section.title),
      body: CustomMarkdownWidget(
        data: section.content,
        codeStyle: codeStyle,
        padding: const EdgeInsets.only(left: 20, right: 20),
      ),
    );
  }
}

class _AppBarView extends ConsumerWidget implements PreferredSizeWidget {
  final String title;

  const _AppBarView({
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(title),
      actions: [
        const AppThemeToggleButton(),
        PopupCodeStyleMenu(
          onSelected: ref.read(codeStyleProvider.notifier).toggle,
        ),
        const Gap(10),
      ],
    );
  }
}
