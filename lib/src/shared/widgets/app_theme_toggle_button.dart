import 'package:cheat_sheets/src/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppThemeToggleButton extends ConsumerWidget {
  const AppThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeControllerProvider).valueOrNull;
    final themeNotifier = ref.watch(themeModeControllerProvider.notifier);
    return switch (theme) {
      ThemeMode.light => IconButton(
          onPressed: () => themeNotifier.setTheme(ThemeMode.dark),
          icon: const Icon(Icons.dark_mode_rounded),
        ),
      ThemeMode.dark => IconButton(
          onPressed: () => themeNotifier.setTheme(ThemeMode.light),
          icon: const Icon(Icons.light_mode_rounded),
        ),
      _ => const SizedBox(),
    };
  }
}
