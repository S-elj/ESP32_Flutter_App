//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'esp32_sensor.g.dart';

/// ESP32Sensor
///
/// Properties:
/// * [name]
/// * [value]
@BuiltValue()
abstract class ESP32Sensor implements Built<ESP32Sensor, ESP32SensorBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'value')
  int? get value;

  ESP32Sensor._();

  factory ESP32Sensor([void updates(ESP32SensorBuilder b)]) = _$ESP32Sensor;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ESP32SensorBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ESP32Sensor> get serializer => _$ESP32SensorSerializer();
}

class _$ESP32SensorSerializer implements PrimitiveSerializer<ESP32Sensor> {
  @override
  final Iterable<Type> types = const [ESP32Sensor, _$ESP32Sensor];

  @override
  final String wireName = r'ESP32Sensor';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ESP32Sensor object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.value != null) {
      yield r'value';
      yield serializers.serialize(
        object.value,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ESP32Sensor object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ESP32SensorBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.value = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ESP32Sensor deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ESP32SensorBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
