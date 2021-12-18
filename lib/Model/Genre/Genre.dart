import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import '../Model.dart';
part 'Genre.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class Genre extends Model {
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
  Genre(
      {required this.uuid,
      required this.name,
      required this.createdAt,
      required this.updatedAt});
  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  Map<String, dynamic> toJson() => _$GenreToJson(this);

  ///this method will prevent the override of toString
  String asDropdownString() {
    return '${this.name}';
  }

  ///this method will prevent the override of toString

  ///custom comparing function to check if two users are equal
  bool isEqual(Genre model) {
    return this.uuid == model.uuid;
  }

  @override
  String toString() => name;
}
