
import 'package:flutter/material.dart';
import 'package:esp32_api/esp32_api.dart';

class MetadataPage extends StatefulWidget {
  const MetadataPage({super.key});

  @override
  State<MetadataPage> createState() => _MetadataPageState();
}

class _MetadataPageState extends State<MetadataPage> {
  final api = Esp32Api().getMetadataApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Métadonnées'),
      ),
      body: Center(
        child: Text('Page des métadonnées - À implémenter'),
      ),
    );
  }
}