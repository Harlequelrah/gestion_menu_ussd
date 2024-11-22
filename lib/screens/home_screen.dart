import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String operatorChoice;
  const HomeScreen({super.key, required this.operatorChoice});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String operatorChoice;
  @override
  void initState() {
    super.initState();
    operatorChoice = widget.operatorChoice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(operatorChoice),
    ));
  }
}
