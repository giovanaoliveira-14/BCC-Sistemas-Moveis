import 'package:flutter/material.dart';

class MenuDeNavegacao extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const MenuDeNavegacao({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        elevation: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 0),
            _buildNavItem(Icons.fitness_center, 1),
            _buildNavItem(Icons.restaurant, 2),
            _buildNavItem(Icons.attach_money, 3),
            _buildNavItem(Icons.person, 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Icon(
        icon,
        size: 30,
        color: selectedIndex == index ? const Color(0xFFF84600) : Colors.grey,
      ),
    );
  }
}
