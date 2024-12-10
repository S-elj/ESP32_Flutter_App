import 'package:test/test.dart';
import 'package:esp32_api/esp32_api.dart';

/// tests for MinuteurApi
void main() {
  final instance = Esp32Api().getMinuteurApi();

  group(MinuteurApi, () {
    // Démare un minuteur
    //
    // Envoie une requête pour activer le minteur après un délai (`delay`) et pendant une durée spécifiée (`duration`).
    //
    //Future<Success> v1MinuteurActivatePost(int delay, int duration) async
    test('test v1MinuteurActivatePost', () async {
      // TODO
    });

    // Arrête le minuteur
    //
    // Cette requête arrête le minuteur immédiatement, cela inclut arrêter un buzzer planifier.
    //
    //Future<Success> v1MinuteurStopPost() async
    test('test v1MinuteurStopPost', () async {
      // TODO
    });
  });
}
