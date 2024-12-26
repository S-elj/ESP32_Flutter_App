import 'package:flutter/material.dart';
import 'sensors_page.dart';
import 'minuteur_page.dart';
import 'metadata_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ESP32 Controller'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MetadataPage()),
                );
              },
              child: const Text('Informations machine'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SensorsPage()),
                );
              },
              child: const Text('Capteurs'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MinuteurPage()),
                );
              },
              child: const Text('Alarme'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}