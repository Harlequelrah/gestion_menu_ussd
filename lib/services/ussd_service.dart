import 'dart:async';
import 'package:ussd_service/ussd_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_data/sim_data.dart';

class UssdServiceManager {
  /// Vérifie les permissions et envoie une requête USSD
  Future<String> sendUssdRequest(int subscriptionId, String ussdCode) async {
    try {
      // Vérifier ou demander la permission téléphonique
      await Permission.phone.request();
      if (!await Permission.phone.isGranted) {
        throw Exception("Permission téléphonique refusée.");
      }

      // Envoyer la requête USSD via le plugin
      String responseMessage = await UssdService.makeRequest(
        subscriptionId,
        ussdCode,
        Duration(seconds: 10),
      );

      return responseMessage;
    } catch (e) {
      // Gestion des erreurs
      rethrow; // Vous pouvez capturer cette erreur plus tard si nécessaire
    }
  }

  /// Récupère la liste des SIMs disponibles
  Future<List<SimCard>> getAvailableSims() async {
    try {
      SimData simData = await SimDataPlugin.getSimData();
      return simData.cards;
    } catch (e) {
      throw Exception("Impossible de récupérer les informations SIM : $e");
    }
  }
}
