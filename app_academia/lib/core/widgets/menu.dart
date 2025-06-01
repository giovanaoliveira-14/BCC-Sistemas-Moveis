import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:app_academia/services/auth_service.dart';

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
            _buildNavItem(context, Icons.home, 'Home', 0),
            _buildNavItem(context, Icons.fitness_center, 'Treino', 1),
            _buildNavItem(context, Icons.restaurant, 'Alimentação', 2),
            _buildNavItem(context, Icons.person, 'Perfil', 4),
            _buildLogoutItem(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 26,
            color: isSelected ? const Color(0xFFF84600) : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? const Color(0xFFF84600) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          title: 'Deseja sair?',
          desc: 'Você tem certeza que deseja fazer logout?',
          btnCancelOnPress: () {},
          btnOkText: 'Sim, sair',
          btnOkOnPress: () async {
            await ApiService.logout();
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          },
        ).show();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.logout, size: 26, color: Colors.red),
          Text('Sair', style: TextStyle(fontSize: 12, color: Colors.red)),
        ],
      ),
    );
  }
}
