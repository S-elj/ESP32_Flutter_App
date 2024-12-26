
import 'package:flutter/material.dart';
import 'package:esp32_api/esp32_api.dart';

class SensorsPage extends StatefulWidget {
  const SensorsPage({super.key});

  @override
  State<SensorsPage> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  final api = Esp32Api().getSensorsApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capteurs'),
      ),
      body: Center(
        child: Text('Page des capteurs - À implémenter'),
      ),
    );
  }
}