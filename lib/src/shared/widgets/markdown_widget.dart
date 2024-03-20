import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/themes/darcula.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/all.dart';

class CustomMarkdownWidget extends StatelessWidget {
  final String data;
  final Map<String, TextStyle> codeStyle;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  const CustomMarkdownWidget({
    super.key,
    required this.data,
    this.codeStyle = darculaTheme,
    this.shrinkWrap = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = context.colors.grey100.withOpacity(0.5);
    return MarkdownWidget(
      padding: padding,
      data: data,
      shrinkWrap: shrinkWrap,
      selectable: false,
      config: MarkdownConfig(
        configs: [
          H1Config(
            style: context.textTheme.heading1Bold,
          ),
          H2Config(
            style: context.textTheme.heading2Bold,
          ),
          H3Config(
            style: context.textTheme.heading3Bold,
          ),
          PConfig(
            textStyle: context.textTheme.body1Regular,
          ),
          CodeConfig(
            style: TextStyle(
              backgroundColor: context.colors.grey100,
            ),
          ),
          ListConfig(
            marker: (_, __, ___) => Container(
              margin: const EdgeInsets.only(top: 8),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.brandBlack,
              ),
            ),
          ),
          PreConfig(
            theme: codeStyle,
            language: 'dart',
            textStyle: GoogleFonts.jetBrainsMono(),
            wrapper: (child, code, _) => _CodeWrapperWidget(
              text: code,
              child: child,
            ),
            decoration: BoxDecoration(
              color: context.colors.grey50,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: borderColor,
                  spreadRadius: 3,
                  blurRadius: 5,
                ),
              ],
            ),
            styleNotMatched: GoogleFonts.jetBrainsMono(
              color: context.colors.brandBlack,
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeWrapperWidget extends StatefulWidget {
  final Widget child;
  final String text;

  const _CodeWrapperWidget({
    Key? key,
    required this.child,
    required this.text,
  }) : super(key: key);

  @override
  State<_CodeWrapperWidget> createState() => _PreWrapperState();
}

class _PreWrapperState extends State<_CodeWrapperWidget> {
  late Widget _switchWidget;
  bool hasCopied = false;

  @override
  void initState() {
    super.initState();
    _switchWidget = const Icon(
      Icons.copy_rounded,
      size: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _switchWidget,
              ),
              onTap: () async {
                if (hasCopied) return;
                await Clipboard.setData(ClipboardData(text: widget.text));
                _switchWidget = const Icon(
                  Icons.check,
                  size: 16,
                );
                _refresh();
                Future.delayed(
                  const Duration(seconds: 2),
                  () {
                    hasCopied = false;
                    _switchWidget = const Icon(
                      Icons.copy_rounded,
                      size: 16,
                    );
                    _refresh();
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }

  void _refresh() {
    if (mounted) setState(() {});
  }
}
