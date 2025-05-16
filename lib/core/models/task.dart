import 'package:botanicare/core/models/plant.dart';

class Task {
  final int? id;
  final String description;
  final Plant plant;

  Task({ this.id, required this.description, required this.plant});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      description: json['description'],
      plant: Plant.fromJson(json['plant']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'plant': plant.toJson()
    };
  }
}