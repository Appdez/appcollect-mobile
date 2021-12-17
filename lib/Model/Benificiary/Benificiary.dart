


import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import '../Model.dart';
part 'Benificiary.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Benificiary extends Model {
  @HiveField(0)
  final String uuid;

  @HiveField(1)
  @JsonKey(name: 'full_name')
  late final String? fullName;

  @HiveField(2)
  @JsonKey(name: 'age')
  late String? age;

  @HiveField(3)
  @JsonKey(name: 'qualification')
  late String? qualification;

  @HiveField(4)
  @JsonKey(name: 'form_number')
  late String? formNumber;

  @HiveField(5)
  @JsonKey(name: 'zone')
  late String? zone;

  @HiveField(6)
  @JsonKey(name: 'location')
  late String? location;

  @HiveField(7)
  @JsonKey(name: 'district_uuid')
  late String? districtUuid;

  @HiveField(8)
  @JsonKey(name: 'benefit_uuid')
  late String? benefitUuid;

  @HiveField(9)
  @JsonKey(name: 'project_area_uuid')
  late String? projectAreaUuid;

  @HiveField(10)
  @JsonKey(name: 'genre_uuid')
  late String? genreUuid;

  @HiveField(11)
  @JsonKey(name: 'created_at')
  late DateTime createdAt;

  @HiveField(12)
  @JsonKey(name: 'updated_at')
  late DateTime updatedAt;

  Benificiary({
    required this.uuid,
    this.fullName,
    this.age,
    this.qualification,
    this.formNumber,
    this.zone,
    this.location,
    this.districtUuid,
    this.benefitUuid,
    this.projectAreaUuid,
    this.genreUuid,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Benificiary.fromJson(Map<String, dynamic> json) =>
      _$BenificiaryFromJson(json);
  Map<String, dynamic> toJson() => _$BenificiaryToJson(this);
}
