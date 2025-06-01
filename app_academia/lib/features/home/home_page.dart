import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_academia/features/workout/workout_page.dart';
import 'package:app_academia/features/nutrition/nutrition_page.dart';
import 'package:app_academia/features/profile/profile_page.dart';
import 'package:app_academia/core/widgets/menu.dart';
import 'package:app_academia/core/widgets/button_help.dart';
import 'package:app_academia/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _userName = '';
  int _sequenciaDias = 0;

  @override
  void initState() {
    super.initState();
    _carregarNomeUsuario();
    _calcularSequenciaTreinos();
  }

  Future<void> _carregarNomeUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_nome') ?? 'Usuário';
    });
  }

  Future<void> _calcularSequenciaTreinos() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId == null) return;

    final datas = await ApiService.listarDatasTreino(userId);
    if (datas.isEmpty) {
      setState(() {
        _sequenciaDias = 0;
      });
      return;
    }

    final datasConvertidas = datas.map((e) => DateTime.parse(e)).toList();
    datasConvertidas.sort();

    int maxSeq = 0;
    int atualSeq = 1;

    for (int i = 1; i < datasConvertidas.length; i++) {
      final diff = datasConvertidas[i].difference(datasConvertidas[i - 1]).inDays;
      if (diff == 1) {
        atualSeq++;
      } else if (diff > 1) {
        maxSeq = atualSeq > maxSeq ? atualSeq : maxSeq;
        atualSeq = 1;
      }
    }
    maxSeq = atualSeq > maxSeq ? atualSeq : maxSeq;

    setState(() {
      _sequenciaDias = maxSeq;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(
        userName: _userName,
        sequenciaDias: _sequenciaDias,
        onNavigateTo: _onItemTapped,
      ),
      const WorkoutPage(),
      const NutritionPage(),
      const WorkoutPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: MenuDeNavegacao(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String userName;
  final int sequenciaDias;
  final void Function(int) onNavigateTo;

  const HomeScreen({
    super.key,
    required this.userName,
    required this.sequenciaDias,
    required this.onNavigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [BotaoDuvida()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
              'Seja bem-vindo, $userName! 👋',
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              sequenciaDias > 0
                  ? 'Você tem uma sequência de\n$sequenciaDias dia(s)!'
                  : 'Você ainda não registrou treinos.',
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFFF84600),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Icon(
              Icons.local_fire_department,
              color: Color(0xFFF84600),
              size: 90,
            ),
            const SizedBox(height: 5),
            const SizedBox(height: 30),

            _buildCard(
              context,
              icon: '💪',
              text: 'Visualize seu treino de hoje ➔',
              onTap: () => onNavigateTo(1),
            ),
            const SizedBox(height: 16),
            _buildCard(
              context,
              icon: '🍉',
              text: 'Visualize seu cronograma alimentar ➔',
              onTap: () => onNavigateTo(2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String icon, required String text, required VoidCallback onTap}) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 19),
                  ),
                ),
                const SizedBox(width: 10),
                Text(icon, style: const TextStyle(fontSize: 35)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
