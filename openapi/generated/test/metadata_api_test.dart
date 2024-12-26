import 'package:test/test.dart';
import 'package:esp32_api/esp32_api.dart';

/// tests for MetadataApi
void main() {
  final instance = Esp32Api().getMetadataApi();

  group(MetadataApi, () {
    // Récupère les métadonnées de l'ESP32.
    //
    // Récupère des métadonnées (notamment uptime) de l'ESP32.
    //
    //Future<ESP32Metadata> v1MetadataGet() async
    test('test v1MetadataGet', () async {
      // TODO
    });
  });
}
