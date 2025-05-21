import 'package:flutter/material.dart';
import '../components/btn_ajuda.dart';
import '../components/navegacao.dart';

// Páginas
import 'perfil.dart';
import 'treino.dart';

void main() {
  runApp(const MyApp()); // Inicia o app Flutter
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove o banner de depuração
      title: 'Fitness App', // Título do aplicativo
      theme: ThemeData(
        primarySwatch: Colors.orange, // Define a cor primária do tema
      ),
      home: const HomePage(), // Define a página inicial do app
    );
  }
}

// Página principal do app
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState(); // Estado da página principal
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Índice da página selecionada na barra de navegação

  // Lista de páginas para navegação
  final List<Widget> _pages = [
    const HomeScreen(),
    const WorkoutScreen(),
    const NutritionScreen(),
    const ChallengeScreen(),
    const MeuPerfil(),
  ];

  // Função que é chamada quando um item da barra de navegação é selecionado
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Atualiza o índice da página selecionada
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Cor de fundo da página
      body: IndexedStack(
        index: _selectedIndex, // Exibe a página baseada no índice selecionado
        children: _pages, // Páginas que serão exibidas
      ),
      bottomNavigationBar: MenuDeNavegacao(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// Tela inicial com um exemplo de conteúdo
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Barra de app transparente
        elevation: 0,
        actions: [BotaoDuvida()], // Sem sombra na AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Seja bem vindo, Teste!',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Você tem uma sequência de\n5 dias!',
              style: TextStyle(
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
            ), // Ícone de motivação
            const SizedBox(height: 5),
            const Text('Continue assim! 😁'),
            const SizedBox(height: 30),

            // Card para visualizar o treino do dia
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  // FAZER O TREINO APARECER QUANDO CLICAR AQUI
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TreinoDoDiaScreen(),
                    ),
                  );
                },
                child: SizedBox(
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Texto expansível que pode quebrar linha
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: 'Visualize seu treino de ',
                              children: [
                                TextSpan(
                                  text: 'hoje ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: '➔'),
                              ],
                            ),
                            style: const TextStyle(fontSize: 20),
                            softWrap: true, // Permite quebra de linha
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('💪', style: TextStyle(fontSize: 35)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Card para visualizar o cronograma alimentar
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  // FAZER O TREINO APARECER QUANDO CLICAR AQUI
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CronogramaAlimentar(),
                    ),
                  );
                },
                child: SizedBox(
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Texto expansível que pode quebrar linha
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: 'Visualize seu ',
                              children: [
                                TextSpan(
                                  text: 'cronograma alimentar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: '➔'),
                              ],
                            ),
                            style: const TextStyle(fontSize: 19),
                            softWrap: true, // Permite quebra de linha
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('🍉', style: TextStyle(fontSize: 35)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TreinoDoDiaScreen extends StatelessWidget {
  const TreinoDoDiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Treino do Dia')),
      body: const Center(
        child: Text('Treino do Dia', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class CronogramaAlimentar extends StatelessWidget {
  const CronogramaAlimentar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cronograma Alimentar')),
      body: const Center(
        child: Text('Cronograma Alimentar', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Nutrition Screen')); // Tela de nutrição
  }
}

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Challenge Screen')); // Tela de desafios
  }
}
