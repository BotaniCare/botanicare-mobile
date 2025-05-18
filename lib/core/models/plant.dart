import 'dart:convert';
import 'package:botanicare/core/models/image.dart';
import 'package:botanicare/core/models/task.dart';

List<Plant> plantFromJson(String str) =>
    List<Plant>.from(json.decode(str).map((x) => Plant.fromJson(x)));

String plantToJsonAdding(List<Plant> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJsonAdding())));

class Plant {
  int id;
  String name;
  String type;
  String waterNeed;
  String sunLight;
  bool isWatered;
  PlantPicture? image;
  List<Task>? tasks;
  String? waterDate;

  Plant({
    required this.id,
    required this.name,
    required this.type,
    required this.waterNeed,
    required this.sunLight,
    required this.isWatered,
    required this.image,
    this.tasks,
    this.waterDate,
  });

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
    id: json['id'] ?? 0,
    name: json['name'] ?? "",
    type: json['type'] ?? "",
    waterNeed: json['waterNeed'] ?? "",
    sunLight: json['sunLight'] ?? "",
    isWatered: json['isWatered'] ?? false,
    image:
        json['plantPicture'] != null
            ? PlantPicture.fromJson(json['plantPicture'])
            : null,
    waterDate: json['waterDate'],
  );

  Map<String, dynamic> toJsonEditing() => {
    'id': id,
    'name': name,
    'type': type,
    'waterNeed': waterNeed,
    'sunlight': sunLight,
    'isWatered': isWatered,
    'plantPicture': image?.toJson(),
  };

  Map<String, dynamic> toJsonAdding() => {
    'name': name,
    'type': type,
    'waterNeed': waterNeed,
    'sunlight': sunLight,
    'isWatered': isWatered,
    'plantPicture': image?.toJson(),
  };
}
