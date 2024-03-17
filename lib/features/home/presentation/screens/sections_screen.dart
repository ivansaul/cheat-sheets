import 'package:cheat_sheets/config/router/app_routes.dart';
import 'package:cheat_sheets/config/theme/theme_provider.dart';
import 'package:cheat_sheets/features/home/domain/cheat_sheet_model.dart';
import 'package:cheat_sheets/features/home/presentation/widgets/custom_list_tile.dart';
import 'package:cheat_sheets/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:markdown_widget/markdown_widget.dart';

class SectionsScreen extends ConsumerWidget {
  final CheatSheetModel cheatSheet;
  const SectionsScreen({
    super.key,
    required this.cheatSheet,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${cheatSheet.title} ',
                style: TextStyle(
                  color: HexColor(isDarkMode ? '#CBD5E1' : '#334155'),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              TextSpan(
                text: 'cheatsheet',
                style: TextStyle(
                  color: HexColor(isDarkMode ? '#64748B' : '#94A3B8'),
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(isDarkModeProvider.notifier).toggle();
            },
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
            MarkdownWidget(
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
                      leadingIcon: ConstantIcons.notes,
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
