// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'esp32_metadata.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ESP32Metadata extends ESP32Metadata {
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? version;
  @override
  final int? uptime;

  factory _$ESP32Metadata([void Function(ESP32MetadataBuilder)? updates]) =>
      (new ESP32MetadataBuilder()..update(updates))._build();

  _$ESP32Metadata._({this.name, this.description, this.version, this.uptime})
      : super._();

  @override
  ESP32Metadata rebuild(void Function(ESP32MetadataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ESP32MetadataBuilder toBuilder() => new ESP32MetadataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ESP32Metadata &&
        name == other.name &&
        description == other.description &&
        version == other.version &&
        uptime == other.uptime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, uptime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ESP32Metadata')
          ..add('name', name)
          ..add('description', description)
          ..add('version', version)
          ..add('uptime', uptime))
        .toString();
  }
}

class ESP32MetadataBuilder
    implements Builder<ESP32Metadata, ESP32MetadataBuilder> {
  _$ESP32Metadata? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  int? _uptime;
  int? get uptime => _$this._uptime;
  set uptime(int? uptime) => _$this._uptime = uptime;

  ESP32MetadataBuilder() {
    ESP32Metadata._defaults(this);
  }

  ESP32MetadataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _description = $v.description;
      _version = $v.version;
      _uptime = $v.uptime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ESP32Metadata other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ESP32Metadata;
  }

  @override
  void update(void Function(ESP32MetadataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ESP32Metadata build() => _build();

  _$ESP32Metadata _build() {
    final _$result = _$v ??
        new _$ESP32Metadata._(
            name: name,
            description: description,
            version: version,
            uptime: uptime);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
