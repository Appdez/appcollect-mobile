import '../Model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ProjectArea.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class ProjectArea extends Model {
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
  ProjectArea(
      {required this.uuid,
      required this.name,
      required this.createdAt,
      required this.updatedAt});
  factory ProjectArea.fromJson(Map<String, dynamic> json) => _$ProjectAreaFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectAreaToJson(this);

  ///this method will prevent the override of toString
  String asDropdownString() {
    return '${this.name}';
  }

  ///this method will prevent the override of toString

  ///custom comparing function to check if two users are equal
  bool isEqual(ProjectArea model) {
    return this.uuid == model.uuid;
  }

  @override
  String toString() => name;
}
