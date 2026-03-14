import 'package:cheat_sheets/src/i18n/app_localizations_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScaffoldWithNavigationBar extends ConsumerWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = ref.watch(localizationsProvider).requireValue;
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onDestinationSelected,
        selectedItemColor: Colors.blue,
        selectedIconTheme: const IconThemeData(
          color: Colors.blue,
          size: 24,
        ),
        unselectedIconTheme: const IconThemeData(
          size: 20,
        ),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.layers_rounded),
            label: loc.navigation.sheets,
          ),
          BottomNavigationBarItem(
            icon: const Badge(
              offset: Offset(10, -3),
              backgroundColor: Colors.blue,
              label: Text(
                'BETA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 7,
                ),
              ),
              child: Icon(Icons.attach_money_rounded),
            ),
            label: loc.navigation.coupons,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_rounded),
            label: loc.navigation.settings,
          ),
        ],
      ),
    );
  }
}
