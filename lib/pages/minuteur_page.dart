import 'package:flutter/material.dart';
import 'package:esp32_api/esp32_api.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class MinuteurPage extends StatefulWidget {
  const MinuteurPage({super.key});

  @override
  State<MinuteurPage> createState() => _MinuteurPageState();
}

class _MinuteurPageState extends State<MinuteurPage> {
  final api = Esp32Api().getMinuteurApi();
  final _delayController = TextEditingController(text: '1');
  final _durationController = TextEditingController(text: '1');
  String _status = '';
  bool _isLoading = false;

  // Variables pour le timer
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isBuzzing = false;

  @override
  void dispose() {
    _delayController.dispose();
    _durationController.dispose();
    _timer?.cancel();
    super.dispose();
  }


  Future<void> _activateMinuteur() async {
    final delay = double.tryParse(_delayController.text);
    final duration = double.tryParse(_durationController.text);

    if (delay == null || duration == null) {
      setState(() {
        _status = 'Erreur : Veuillez entrer des nombres valides';
      });
      return;
    }

    if (delay < 0 || duration < 0) {
      setState(() {
        _status = 'Erreur : Les valeurs doivent être positives';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _status = 'Activation du minuteur...';
    });

    try {
      // Conversion en millisecondes
      final delayMs = (delay * 1000).round();
      final durationMs = (duration * 1000).round();

      final response = await api.v1MinuteurActivatePost(
        delay: delayMs,
        duration: durationMs,
      );
      setState(() {
        _status = 'Minuteur activé : sonnera dans ${delay}s pendant ${duration}s';
      });
      // Démarrer le compte à rebours
      _startCountdown(delay.round(), duration.round());

    } catch (e) {
      setState(() {
        _status = _handleError(e);
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  Future<void> _stopMinuteur() async {
    setState(() {
      _isLoading = true;
      _status = 'Arrêt du minuteur...';
    });

    try {
      final response = await api.v1MinuteurStopPost(
      );
      setState(() {
        _status = 'Minuteur arrêté avec succès !';
      });
      // Arrêter le timer
      _timer?.cancel();
      setState(() {
        _remainingSeconds = 0;
        _isBuzzing = false;
      });
    } catch (e) {
      setState(() {
        _status = _handleError(e);
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _startCountdown(int delaySeconds, int durationSeconds) {
    // Annuler le timer existant si présent
    _timer?.cancel();

    setState(() {
      _remainingSeconds = delaySeconds;
      _isBuzzing = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else if (!_isBuzzing) {
          // Le délai est terminé, le buzzer commence
          _isBuzzing = true;
          _remainingSeconds = durationSeconds;
        } else if (_remainingSeconds == 0) {
          // La durée du buzzer est terminée
          timer.cancel();
          _isBuzzing = false;
        } else {
          _remainingSeconds--;
        }
      });
    });
  }

  String _getTimerText() {
    if (_remainingSeconds == 0 && !_isBuzzing) {
      return '';
    }
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    final timeString = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    if (_isBuzzing) {
      return 'Buzzer en cours : $timeString';
    }
    return 'Buzzer dans : $timeString';
  }





  String _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Erreur : Timeout de connexion - Vérifiez que l\'ESP32 est allumé et connécté';
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
        title: const Text('Minuteur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _delayController,
              decoration: const InputDecoration(
                labelText: 'Délai',
                helperText: 'Délai avant activation du buzzer',
                suffixText: 'secondes',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _durationController,
              decoration: const InputDecoration(
                labelText: 'Durée',
                helperText: 'Durée de sonnerie du buzzer',
                suffixText: 'secondes',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _activateMinuteur,
              child: const Text('Activer le buzzer'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _stopMinuteur,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Arrêter le minuteur'),
            ),
            const SizedBox(height: 24),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Text(
                _status,
                style: TextStyle(
                  color: _status.contains('Erreur') ? Colors.red : Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 16),
            if (_remainingSeconds > 0 || _isBuzzing)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isBuzzing ? Colors.red.shade100 : Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _getTimerText(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _isBuzzing ? Colors.red : Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
