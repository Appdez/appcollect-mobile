


import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import '../Model.dart';
import '../Benefit/Benefit.dart';
import '../ProjectArea/ProjectArea.dart';
part 'Benificiary.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Benificiary extends Model {
  @HiveField(0)
  final String uuid;

  @HiveField(1)
  @JsonKey(name: 'full_name')
  final String fullName;

  @HiveField(2)
  @JsonKey(name: 'age')
  final int age;

  @HiveField(3)
  @JsonKey(name: 'qualification')
  final String qualification;

  @HiveField(4)
  @JsonKey(name: 'form_number')
  final int formNumber;

  @HiveField(5)
  @JsonKey(name: 'zone')
  final String zone;

  @HiveField(6)
  @JsonKey(name: 'location')
  final String location;

  @HiveField(7)
  @JsonKey(name: 'district_uuid')
  final String districtUuid;

  @HiveField(8)
  @JsonKey(name: 'benefits')
  final List<Benefit> benefits;

  @HiveField(9)
  @JsonKey(name: 'project_areas')
  final List<ProjectArea> projectAreas;

  @HiveField(10)
  @JsonKey(name: 'genre_uuid')
  final String genreUuid;

  @HiveField(11)
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @HiveField(12)
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  Benificiary({
    required this.uuid,
    required this.fullName,
    required this.age,
    required this.qualification,
    required this.formNumber,
    required this.zone,
    required this.location,
    required this.districtUuid,
    required this.benefits,
    required this.projectAreas,
    required this.genreUuid,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Benificiary.fromJson(Map<String, dynamic> json) =>
      _$BenificiaryFromJson(json);
  Map<String, dynamic> toJson() => _$BenificiaryToJson(this);
}
