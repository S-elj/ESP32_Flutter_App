// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'esp32_sensor.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ESP32Sensor extends ESP32Sensor {
  @override
  final String? name;
  @override
  final int? value;

  factory _$ESP32Sensor([void Function(ESP32SensorBuilder)? updates]) =>
      (new ESP32SensorBuilder()..update(updates))._build();

  _$ESP32Sensor._({this.name, this.value}) : super._();

  @override
  ESP32Sensor rebuild(void Function(ESP32SensorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ESP32SensorBuilder toBuilder() => new ESP32SensorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ESP32Sensor && name == other.name && value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ESP32Sensor')
          ..add('name', name)
          ..add('value', value))
        .toString();
  }
}

class ESP32SensorBuilder implements Builder<ESP32Sensor, ESP32SensorBuilder> {
  _$ESP32Sensor? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _value;
  int? get value => _$this._value;
  set value(int? value) => _$this._value = value;

  ESP32SensorBuilder() {
    ESP32Sensor._defaults(this);
  }

  ESP32SensorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ESP32Sensor other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ESP32Sensor;
  }

  @override
  void update(void Function(ESP32SensorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ESP32Sensor build() => _build();

  _$ESP32Sensor _build() {
    final _$result = _$v ?? new _$ESP32Sensor._(name: name, value: value);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
