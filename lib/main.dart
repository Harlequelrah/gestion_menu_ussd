import 'package:flutter/material.dart';
import 'package:gestion_menu_ussd/screens/home_screen.dart';
import 'package:gestion_menu_ussd/screens/transfert_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu USSD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const TransferScreen(),
    const Center(child: Text('Profile')),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Menu USSD'),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar:
            BottomNavigationBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: 'Transfert'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil')
        ]));
  }
}
