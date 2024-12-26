import 'package:flutter/material.dart';
import 'package:esp32_api/esp32_api.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class SensorsPage extends StatefulWidget {
  const SensorsPage({super.key});
  @override
  State<SensorsPage> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  final api = Esp32Api().getSensorsApi();
  Timer? _refreshTimer;
  ESP32Sensor? _sensorData;
  String _error = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchSensorData();
    // Rafraîchir les données toutes les 2 secondes
    _refreshTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _fetchSensorData();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchSensorData() async {
    if (_isLoading) return; // Éviter les requêtes simultanées

    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final response = await api.v1SensorsPhotocellGet();
      setState(() {
        _sensorData = response.data;
      });
    } catch (e) {
      setState(() {
        _error = _handleError(e);
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Erreur : Timeout de connexion - Vérifiez que l\'ESP32 est allumé';
        case DioExceptionType.sendTimeout:
          return 'Erreur : Timeout d\'envoi - La requête a pris trop de temps';
        case DioExceptionType.receiveTimeout:
          return 'Erreur : Timeout de réception - Pas de réponse de l\'ESP32';
        case DioExceptionType.badCertificate:
          return 'Erreur : Problème de certificat';
        case DioExceptionType.badResponse:
          return 'Erreur : Réponse invalide (${error.response?.statusCode})';
        case DioExceptionType.cancel:
          return 'Erreur : Requête annulée';
        case DioExceptionType.connectionError:
          return 'Erreur : Impossible de se connecter à l\'ESP32 - Vérifiez l\'adresse IP';
        case DioExceptionType.unknown:
          if (error.message?.contains('SocketException') ?? false) {
            return 'Erreur : Impossible de se connecter à l\'ESP32 - Vérifiez la connexion réseau';
          }
          return 'Erreur inconnue : ${error.message}';
      }
    }
    return 'Erreur : ${error.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capteurs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _fetchSensorData,
            tooltip: 'Rafraîchir manuellement',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Capteur de lumière',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (_isLoading && _sensorData == null)
                const CircularProgressIndicator()
              else if (_error.isNotEmpty)
                Text(
                  _error,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                )
              else if (_sensorData != null)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${_sensorData!.value}',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Dernière mise à jour : ${_getFormattedTime(DateTime.now().millisecondsSinceEpoch)}',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                        if (_sensorData?.name != null)
                          Text(
                            'Capteur : ${_sensorData!.name}',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                      ],
                    ),
                  ),
              if (_isLoading && _sensorData != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 8),
                      Text('Actualisation...'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getFormattedTime(int? timestamp) {
    if (timestamp == null) return 'Non disponible';
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}';
  }
}