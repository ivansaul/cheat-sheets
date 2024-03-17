import 'package:cheat_sheets/config/theme/theme_provider.dart';
import 'package:cheat_sheets/features/home/domain/cheat_sheet_model.dart';
import 'package:cheat_sheets/features/home/presentation/widgets/code_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:markdown_widget/markdown_widget.dart';

class DetailsScreen extends ConsumerWidget {
  final Section section;
  const DetailsScreen({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final codeStyle = ref.watch(codeStyleProvider);
    final border = isDarkMode ? HexColor('#20273A') : Colors.grey[200]!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${section.title} ',
        ),
        actions: [
          IconButton(
            onPressed: ref.read(isDarkModeProvider.notifier).toggle,
            icon: Icon(
              isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            ),
          ),
          PopupMenuButton<CodeStyleEnum>(
            tooltip: 'Code Styles',
            icon: const Icon(Icons.palette),
            onSelected: (codeStyle) =>
                ref.read(codeStyleProvider.notifier).toggle(codeStyle),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<CodeStyleEnum>(
                  value: CodeStyleEnum.darcula,
                  child: Text('Darcula'),
                ),
                const PopupMenuItem<CodeStyleEnum>(
                  value: CodeStyleEnum.atomOneLight,
                  child: Text('Atom One Light'),
                ),
                const PopupMenuItem<CodeStyleEnum>(
                  value: CodeStyleEnum.atomOneDark,
                  child: Text('Atom One Dark'),
                ),
                const PopupMenuItem<CodeStyleEnum>(
                  value: CodeStyleEnum.vsCode,
                  child: Text('VS Code'),
                ),
                const PopupMenuItem<CodeStyleEnum>(
                  value: CodeStyleEnum.xCode,
                  child: Text('XCode'),
                ),
                const PopupMenuItem<CodeStyleEnum>(
                  value: CodeStyleEnum.idea,
                  child: Text('Idea'),
                ),
                const PopupMenuItem<CodeStyleEnum>(
                  value: CodeStyleEnum.nord,
                  child: Text('Nord'),
                ),
              ];
            },
          ),
          const Gap(10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: MarkdownWidget(
          padding: const EdgeInsets.all(10),
          data: section.content,
          selectable: false,
          config: MarkdownConfig(
            configs: [
              const H1Config(),
              const H2Config(),
              const H3Config(),
              const PConfig(),
              CodeConfig(
                style: TextStyle(
                  backgroundColor:
                      isDarkMode ? HexColor('#383D46') : HexColor('#E8ECEF'),
                ),
              ),
              PreConfig(
                theme: codeStyle,
                language: 'dart',
                textStyle: GoogleFonts.jetBrainsMono(),
                wrapper: (child, code, _) => CodeWrapperWidget(
                  text: code,
                  child: child,
                ),
                decoration: BoxDecoration(
                  color: isDarkMode ? HexColor('#1E293B') : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: border),
                  boxShadow: [
                    BoxShadow(
                      color: border,
                      spreadRadius: 3,
                      blurRadius: 5,
                    ),
                  ],
                ),
                styleNotMatched: GoogleFonts.jetBrainsMono(
                  color: isDarkMode ? Colors.white : HexColor('#1E293B'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
