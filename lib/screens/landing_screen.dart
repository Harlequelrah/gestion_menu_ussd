import 'package:flutter/material.dart';
import 'package:gestion_menu_ussd/screens/home_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Bienvenue dans le menu USSD',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen(operatorChoice:'MOOV')));
            },
            child: const Text('MOOV')),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const HomeScreen(operatorChoice: 'YAS')));
            }, child: const Text('YAS')),
      ],
    ));
  }
}
