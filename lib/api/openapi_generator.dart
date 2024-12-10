// Openapi Generator last run: : 2024-12-10T17:00:47.139393
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  additionalProperties:
  DioProperties(pubName: 'esp32_api', pubAuthor: 'Vial Eljaafari.'),
  inputSpec: InputSpec(
      path: 'api.yml'
  ),
  typeMappings: {
    'Metadata': 'ESP32Metadata',
    'GenericSensor': 'ESP32Sensor'
  },
  generatorName: Generator.dio,
  runSourceGenOnOutput: true,
  outputDirectory: 'api/generated',

)
class generator {}