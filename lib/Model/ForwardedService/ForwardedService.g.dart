// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ForwardedService.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForwardedServiceAdapter extends TypeAdapter<ForwardedService> {
  @override
  final int typeId = 3;

  @override
  ForwardedService read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForwardedService(
      uuid: fields[0] as String,
      name: fields[1] as String,
      createdAt: fields[2] as DateTime,
      updatedAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ForwardedService obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForwardedServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForwardedService _$ForwardedServiceFromJson(Map<String, dynamic> json) {
  return ForwardedService(
    uuid: json['uuid'] as String,
    name: json['name'] as String,
    createdAt: DateTime.parse(json['created_at'] as String),
    updatedAt: DateTime.parse(json['update_at'] as String),
  );
}

Map<String, dynamic> _$ForwardedServiceToJson(ForwardedService instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
      'update_at': instance.updatedAt.toIso8601String(),
    };