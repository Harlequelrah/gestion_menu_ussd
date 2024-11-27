import 'package:flutter/material.dart';
import 'package:gestion_menu_ussd/screens/contacts_screen.dart';
import 'package:gestion_menu_ussd/screens/historique_screen.dart';
import 'package:gestion_menu_ussd/screens/landing_screen.dart';
import 'package:gestion_menu_ussd/screens/call_screen.dart';

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
        colorScheme: ColorScheme(
          brightness: Brightness.dark, // Définit si c'est un thème clair ou sombre
          primary: Colors.deepPurple, // Variante plus claire ou plus foncée
          secondary: Colors.lightBlue,
          surface: Colors.grey[850]!, // Couleur de surface
          error: Colors.red, // Couleur d'erreur
          onPrimary: Colors.white, // Texte sur la couleur principale
          onSecondary: Colors.white, // Texte sur la couleur secondaire
          onSurface: Colors.white, // Texte sur la surface
          onError: Colors.white, // Texte d'erreur
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black54,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple, // Couleur de fond de l'AppBar
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.red, // Fond du BottomNavigationBar
          selectedItemColor: Colors.purple, // Couleur des éléments sélectionnés
          unselectedItemColor:
              Colors.lightBlue, // Couleur des éléments non sélectionnés
        ),
      ),
      home: const MainPage(),
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
    const LandingScreen(),
    const HistoryScreen(),
    const ContactScreen(),
    const CallScreen(),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Historique'),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_phone), label: 'Contacts'),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Appel')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
