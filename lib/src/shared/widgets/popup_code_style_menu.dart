import 'package:cheat_sheets/src/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class PopupCodeStyleMenu extends StatelessWidget {
  final void Function(CodeStyleEnum codeStyle)? onSelected;
  const PopupCodeStyleMenu({
    super.key,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CodeStyleEnum>(
      tooltip: 'Code Styles',
      icon: const Icon(Icons.palette),
      onSelected: onSelected?.call,
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
    );
  }
}
