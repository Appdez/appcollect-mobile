import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import '../Model.dart';
part 'Benefit.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
class Benefit extends Model {
  @HiveField(0)
  late String? uuid;

  @HiveField(1)
  late String name;

  @HiveField(2)
  @JsonKey(name: 'created_at')
  late DateTime? createdAt;

  @HiveField(3)
  @JsonKey(name: 'updated_at')
  late DateTime? updatedAt;
  Benefit(
      {this.uuid,
      required this.name,
      required this.createdAt,
      required this.updatedAt});
  factory Benefit.fromJson(Map<String, dynamic> json) => _$BenefitFromJson(json);
  Map<String, dynamic> toJson() => _$BenefitToJson(this);

  ///this method will prevent the override of toString
  String asDropdownString() {
    return '${this.name}';
  }

  ///this method will prevent the override of toString

  ///custom comparing function to check if two users are equal
  bool isEqual(Benefit model) {
    return this.uuid == model.uuid;
  }

  @override
  String toString() => name;
}
