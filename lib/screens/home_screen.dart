import 'package:flutter/material.dart';
import 'package:gestion_menu_ussd/services/ussd_service.dart';

class HomeScreen extends StatefulWidget {
  final String operatorChoice;
  final int subscriptionId;

  const HomeScreen({
    super.key,
    required this.operatorChoice,
    required this.subscriptionId,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String operatorChoice;
  late int subscriptionId;
  late String _responseMessage;
  late bool _isLoading;
  late UssdServiceManager _ussdService;

  @override
  void initState() {
    super.initState();
    operatorChoice = widget.operatorChoice;
    subscriptionId = widget.subscriptionId;
    _responseMessage = "";
    _isLoading = false;
    _ussdService = UssdServiceManager();
  }

  void _sendUssdCode(String ussdCode) async {
    setState(() {
      _isLoading = true;
    });

    try {
      String response = await _ussdService.sendUssdRequest(
        subscriptionId,
        ussdCode,
      );
      setState(() {
        _responseMessage = response;
      });
    } catch (e) {
      setState(() {
        _responseMessage = "Erreur : ${e.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: const Icon(
              Icons.person,
              color: Colors.black87,
              size: 30,
            ),
          ),
        ),
        title: Image.asset(
            operatorChoice == 'MOOV'
                ? 'assets/logo_moov.png'
                : 'assets/logo_togocel.jpg',
            height: 50),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black87),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Colors.black87,
                    Colors.deepPurple,
                    Colors.blue,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sirus Romane Conti',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '+228 91361029',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.white54,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '70 356 173 FCFA',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.account_balance_wallet,
                                color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              "solde crédit",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 1.5,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildFeatureButton(
                  icon: Icons.account_balance_wallet,
                  label: 'Solde',
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () {
                    _sendUssdCode('*444#'); // Code USSD pour consulter le solde
                  },
                ),
                _buildFeatureButton(
                  icon: Icons.send,
                  label: 'Transfert',
                  gradient: const LinearGradient(
                    colors: [Colors.green, Colors.yellow],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () {
                    // Ajoutez ici le code USSD pour le transfert
                  },
                ),
                // Ajoutez d'autres boutons avec des actions similaires
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureButton({
    required IconData icon,
    required String label,
    required LinearGradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
