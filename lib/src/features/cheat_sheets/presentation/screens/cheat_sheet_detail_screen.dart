import 'package:cheat_sheets/src/features/cheat_sheets/domain/cheat_sheet.dart';
import 'package:cheat_sheets/src/shared/widgets/markdown_widget.dart';
import 'package:cheat_sheets/src/shared/widgets/popup_code_style_menu.dart';
import 'package:cheat_sheets/src/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class CheatSheetDetailsScreen extends ConsumerWidget {
  final CheatSheetSection section;
  const CheatSheetDetailsScreen({
    super.key,
    required this.section,
  });

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
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: ref.read(isDarkModeProvider.notifier).toggle,
          icon: Icon(
            isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          ),
        ),
        PopupCodeStyleMenu(
          onSelected: ref.read(codeStyleProvider.notifier).toggle,
        ),
        const Gap(10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
