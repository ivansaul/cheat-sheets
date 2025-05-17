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
    return MarkdownWidget(
      padding: padding,
      data: data,
      shrinkWrap: shrinkWrap,
      selectable: false,
      config: MarkdownConfig(
        configs: [
          const H1Config(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const H2Config(
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const H3Config(
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const PConfig(
            textStyle: TextStyle(fontSize: 16),
          ),
          CodeConfig(
            style: TextStyle(
              backgroundColor: Colors.grey.withValues(alpha: 0.2),
            ),
          ),
          ListConfig(
            marker: (_, __, ___) => Container(
              margin: const EdgeInsets.only(top: 8),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.onSurface,
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
              color: context.appColor.backgroundSecondary,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            styleNotMatched: GoogleFonts.jetBrainsMono(
              color: context.colorScheme.onSurface,
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
    required this.child,
    required this.text,
  });

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
