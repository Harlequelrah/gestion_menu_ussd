import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_data/sim_data.dart';
import 'package:gestion_menu_ussd/screens/home_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  Future<int?> _selectSim(BuildContext context) async {
    try {
      // Demander les permissions nécessaires
      await Permission.phone.request();
      if (!await Permission.phone.isGranted) {
        throw Exception("Permission téléphonique non accordée.");
      }

      // Récupérer les informations SIM
      SimData simData = await SimDataPlugin.getSimData();

      // Afficher une boîte de dialogue pour sélectionner une SIM
      return showDialog<int>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Choisissez une SIM'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: simData.cards.map((simCard) {
                return ListTile(
                  title: Text(simCard.carrierName ?? "SIM inconnue"),
                  subtitle: Text("ID: ${simCard.subscriptionId}"),
                  onTap: () {
                    Navigator.of(context).pop(simCard.subscriptionId);
                  },
                );
              }).toList(),
            ),
          );
        },
      );
    } catch (e) {
      // Gérer les erreurs
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
      return null;
    }
  }

  void _navigateToHomeScreen(
      BuildContext context, String operatorChoice) async {
    final subscriptionId = await _selectSim(context);
    if (subscriptionId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
              operatorChoice: operatorChoice, subscriptionId: subscriptionId),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Bienvenue dans le menu USSD',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _navigateToHomeScreen(context, 'MOOV'),
            child: const Text('MOOV'),
          ),
          ElevatedButton(
            onPressed: () => _navigateToHomeScreen(context, 'YAS'),
            child: const Text('YAS'),
          ),
        ],
      ),
    );
  }
}
