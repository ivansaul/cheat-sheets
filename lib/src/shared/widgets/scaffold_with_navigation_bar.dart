import 'package:flutter/material.dart';

class ScaffoldWithNavigationBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.layers_rounded),
            label: 'Cheatsheets',
          ),
          BottomNavigationBarItem(
            icon: Badge(
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
            label: 'Coupons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
