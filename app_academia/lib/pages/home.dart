import 'package:flutter/material.dart';
//import 'widgets/botao_duvida.dart';


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
    const ProfileScreen(),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Define o índice da barra de navegação
        onTap:
            _onItemTapped, // Função chamada ao selecionar um item da barra de navegação
        selectedItemColor: Color(0xFFF84600), // Cor do item selecionado
        unselectedItemColor: Colors.grey, // Cor dos itens não selecionados
        type: BottomNavigationBarType.fixed, // Tipo da barra de navegação
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ), // Ícone de página inicial
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: '',
          ), // Ícone de treino
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: '',
          ), // Ícone de nutrição
          BottomNavigationBarItem(
            icon: Icon(Icons.casino),
            label: '',
          ), // Ícone de desafios
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ), // Ícone de perfil
        ],
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
        actions: [
          //BotaoDuvida()
        ], // Sem sombra na AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Seja Bem vindo, Teste!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Você tem uma sequência de\n5 dias!',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFF84600),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Icon(
              Icons.local_fire_department,
              color: Colors.orange,
              size: 40,
            ), // Ícone de motivação
            const SizedBox(height: 5),
            const Text('Continue assim! 😁'),
            const SizedBox(height: 30),
            // Card para visualizar o treino do dia
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: const Text.rich(
                  TextSpan(
                    text: 'Visualize seu treino de ',
                    children: [
                      TextSpan(
                        text: 'hoje',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                trailing: const Text('💪', style: TextStyle(fontSize: 20)),
                onTap: () {}, // Ação ao tocar no item
              ),
            ),
            const SizedBox(height: 16),
            // Card para visualizar o cronograma alimentar
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: const Text.rich(
                  TextSpan(
                    text: 'Visualize seu\n',
                    children: [
                      TextSpan(
                        text: 'cronograma alimentar',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                trailing: const Text('🍉', style: TextStyle(fontSize: 20)),
                onTap: () {}, // Ação ao tocar no item
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Outras telas do app (exemplo de páginas vazias)
class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
       appBar: AppBar(
        backgroundColor: Colors.transparent, // Barra de app transparente
        elevation: 0,
        actions: [
          //BotaoDuvida()
        ], // Sem sombra na AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Seus treinos!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // 📸 IMAGEM AQUI
           // Image.asset(
            //  'assets/minha_imagem.png',
            //  width: 200,
            //  height: 200,
           //   fit: BoxFit.cover,
          //  ),

            const SizedBox(height: 12),

            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(text: 'Hoje seu treino é de '),
                  TextSpan(
                    text: 'pernas ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '🦵'),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // Primeiro Card
    Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 150,
        height: 50,
        color: Colors.blue,
        child: const Center(
          child: Text(
            'Caixa 1',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
    // Espaço entre os Cards
    const SizedBox(width: 8),
    // Segundo Card
    Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 150,
        height: 50,
        color: Colors.green,
        child: const Center(
          child: Text(
            'Caixa 2',
            style: TextStyle(color: Colors.white),
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


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Screen')); // Tela de perfil
  }
}






