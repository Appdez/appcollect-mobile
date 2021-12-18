import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import '../Model.dart';
part 'District.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class District extends Model {
  @HiveField(0)
  final String uuid;

  @HiveField(1)
  final String name;

  @HiveField(2)
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @HiveField(3)
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  District(
      {required this.uuid,
      required this.name,
      required this.createdAt,
      required this.updatedAt});
  factory District.fromJson(Map<String, dynamic> json) => _$DistrictFromJson(json);
  Map<String, dynamic> toJson() => _$DistrictToJson(this);

  ///this method will prevent the override of toString
  String asDropdownString() {
    return '${this.name}';
  }

  ///this method will prevent the override of toString

  ///custom comparing function to check if two users are equal
  bool isEqual(District model) {
    return this.uuid == model.uuid;
  }

  @override
  String toString() => name;
}
