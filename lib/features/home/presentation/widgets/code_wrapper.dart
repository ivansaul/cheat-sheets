import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeWrapperWidget extends StatefulWidget {
  final Widget child;
  final String text;

  const CodeWrapperWidget({Key? key, required this.child, required this.text}) : super(key: key);

  @override
  State<CodeWrapperWidget> createState() => _PreWrapperState();
}

class _PreWrapperState extends State<CodeWrapperWidget> {
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
