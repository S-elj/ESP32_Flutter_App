import 'package:test/test.dart';
import 'package:esp32_api/esp32_api.dart';

/// tests for SensorsApi
void main() {
  final instance = Esp32Api().getSensorsApi();

  group(SensorsApi, () {
    // Récupère la valeur actuelle pour le sensor photocell
    //
    //Future<ESP32Sensor> v1SensorsPhotocellGet() async
    test('test v1SensorsPhotocellGet', () async {
      // TODO
    });
  });
}
