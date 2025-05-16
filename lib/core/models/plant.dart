import 'dart:convert';

import 'package:botanicare/core/models/image.dart';
import 'package:botanicare/core/models/task.dart';

List<Plant> plantFromJson(String str) =>
    List<Plant>.from(json.decode(str).map((x) => Plant.fromJson(x)));

String plantToJson(List<Plant> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Plant {
  int id;
  String name;
  String type;
  String waterNeed;
  String sunLight;
  bool isWatered;
  PlantImage? image;
  List<Task>? tasks;

  Plant({
    required this.id,
    required this.name,
    required this.type,
    required this.waterNeed,
    required this.sunLight,
    required this.isWatered,
    required this.image,
    this.tasks,
  });

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
    id: json['id'],
    name: json['name'],
    type: json['type'],
    waterNeed: json['waterNeed'],
    sunLight: json['sunLight'],
    isWatered: json['isWatered'],
    image: json['plantPicture'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'waterNeed': waterNeed,
    'sunlight': sunLight,
    'isWatered': isWatered,
    'plantPicture': image?.toJson(),
  };
}