import 'package:flutter/material.dart';
import 'package:esp32_api/esp32_api.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class MetadataPage extends StatefulWidget {
  const MetadataPage({super.key});
  @override
  State<MetadataPage> createState() => _MetadataPageState();
}

class _MetadataPageState extends State<MetadataPage> {
  final api = Esp32Api().getMetadataApi();
  Timer? _refreshTimer;
  ESP32Metadata? _metadata;
  String _error = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchMetadata();
    // Rafraîchir les données toutes les 5 secondes
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _fetchMetadata();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  String _formatUptime(int? milliseconds) {
    if (milliseconds == null) return 'Non disponible';

    final seconds = milliseconds ~/ 1000;
    final minutes = seconds ~/ 60;
    final hours = minutes ~/ 60;
    final days = hours ~/ 24;

    final remainingHours = hours % 24;
    final remainingMinutes = minutes % 60;
    final remainingSeconds = seconds % 60;

    final parts = <String>[];

    if (days > 0) {
      parts.add('$days ${days == 1 ? "jour" : "jours"}');
    }
    if (remainingHours > 0) {
      parts.add('$remainingHours ${remainingHours == 1 ? "heure" : "heures"}');
    }
    if (remainingMinutes > 0) {
      parts.add('$remainingMinutes ${remainingMinutes == 1 ? "minute" : "minutes"}');
    }
    if (remainingSeconds > 0) {
      parts.add('$remainingSeconds ${remainingSeconds == 1 ? "seconde" : "secondes"}');
    }

    return parts.join(', ');
  }

  Future<void> _fetchMetadata() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final response = await api.v1MetadataGet();
      setState(() {
        _metadata = response.data;
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

  Widget _buildInfoCard(String title, String? value, IconData icon) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.blue),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value ?? 'Non disponible',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Métadonnées'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _fetchMetadata,
            tooltip: 'Rafraîchir',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchMetadata,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_isLoading && _metadata == null)
                const Center(child: CircularProgressIndicator())
              else if (_error.isNotEmpty)
                Center(
                  child: Text(
                    _error,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                )
              else if (_metadata != null) ...[
                  _buildInfoCard(
                    'Nom',
                    _metadata!.name,
                    Icons.device_hub,
                  ),
                  const SizedBox(height: 8),
                  _buildInfoCard(
                    'Description',
                    _metadata!.description,
                    Icons.description,
                  ),
                  const SizedBox(height: 8),
                  _buildInfoCard(
                    'Version',
                    _metadata!.version,
                    Icons.info,
                  ),
                  const SizedBox(height: 8),
                  _buildInfoCard(
                    'Temps de fonctionnement',
                    _formatUptime(_metadata!.uptime),
                    Icons.timer,
                  ),
                ],
              if (_isLoading && _metadata != null)
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
}