// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Benificiary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BenificiaryAdapter extends TypeAdapter<Benificiary> {
  @override
  final int typeId = 1;

  @override
  Benificiary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Benificiary(
      uuid: fields[0] as String,
      fullName: fields[1] as String?,
      age: fields[2] as String?,
      qualification: fields[3] as String?,
      formNumber: fields[4] as String?,
      zone: fields[5] as String?,
      location: fields[6] as String?,
      districtUuid: fields[7] as String?,
      benefitUuid: fields[8] as String?,
      projectAreaUuid: fields[9] as String?,
      genreUuid: fields[10] as String?,
      createdAt: fields[11] as DateTime,
      updatedAt: fields[12] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Benificiary obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.qualification)
      ..writeByte(4)
      ..write(obj.formNumber)
      ..writeByte(5)
      ..write(obj.zone)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.districtUuid)
      ..writeByte(8)
      ..write(obj.benefitUuid)
      ..writeByte(9)
      ..write(obj.projectAreaUuid)
      ..writeByte(10)
      ..write(obj.genreUuid)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BenificiaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Benificiary _$BenificiaryFromJson(Map<String, dynamic> json) {
  return Benificiary(
    uuid: json['uuid'] as String,
    fullName: json['full_name'] as String?,
    age: json['age'] as String?,
    qualification: json['qualification'] as String?,
    formNumber: json['form_number'] as String?,
    zone: json['zone'] as String?,
    location: json['location'] as String?,
    districtUuid: json['district_uuid'] as String?,
    benefitUuid: json['benefit_uuid'] as String?,
    projectAreaUuid: json['project_area_uuid'] as String?,
    genreUuid: json['genre_uuid'] as String?,
    createdAt: DateTime.parse(json['created_at'] as String),
    updatedAt: DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$BenificiaryToJson(Benificiary instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'full_name': instance.fullName,
      'age': instance.age,
      'qualification': instance.qualification,
      'form_number': instance.formNumber,
      'zone': instance.zone,
      'location': instance.location,
      'district_uuid': instance.districtUuid,
      'benefit_uuid': instance.benefitUuid,
      'project_area_uuid': instance.projectAreaUuid,
      'genre_uuid': instance.genreUuid,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
