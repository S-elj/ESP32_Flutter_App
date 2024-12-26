import 'package:flutter/material.dart';
import 'package:esp32_api/esp32_api.dart';
class MinuteurPage extends StatefulWidget {
  const MinuteurPage({super.key});

  @override
  State<MinuteurPage> createState() => _MinuteurPageState();
}

class _MinuteurPageState extends State<MinuteurPage> {
  final api = Esp32Api().getMinuteurApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minuteur'),
      ),
      body: Center(
        child: Text('Page du minuteur - À implémenter'),
      ),
    );
  }
}
