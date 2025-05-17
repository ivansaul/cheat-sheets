import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchableWidget extends HookWidget {
  const SearchableWidget({
    super.key,
    this.hintText,
    this.focusNode,
    this.autoFocus = false,
    this.keyboardType,
    this.textCapitalization,
    this.onChanged,
  });

  final String? hintText;
  final FocusNode? focusNode;
  final bool autoFocus;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    useListenable(controller);
    return SearchBar(
      autoFocus: autoFocus,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      controller: controller,
      hintText: hintText,
      focusNode: focusNode,
      hintStyle: const WidgetStatePropertyAll(
        TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      elevation: const WidgetStatePropertyAll(0),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      constraints: const BoxConstraints(
        minHeight: 40,
        maxHeight: 40,
      ),
      leading: const Icon(
        FontAwesomeIcons.magnifyingGlass,
        color: Colors.grey,
        size: 16,
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 10),
      ),
      trailing: [
        if (controller.text.isNotEmpty)
          GestureDetector(
            onTap: () {
              controller.clear();
              onChanged?.call('');
            },
            child: const Icon(
              Icons.cancel,
              color: Colors.grey,
              size: 20,
            ),
          ).animate().fadeIn(duration: 50.ms).scale(),
      ],
      onChanged: onChanged,
    );
  }
}
