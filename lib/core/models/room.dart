import 'package:botanicare/core/models/plant.dart';

class Room {
  final int id;
  final String roomName;
  final List<Plant> plants;

  Room({required this.id, required this.roomName, required this.plants});

  //Json Response to Dart objects
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      roomName: json['roomName'],
      //TODO: fromJson in Plant
      plants: (json['plants'] as List).map((plant) => Plant.fromJson(plant)).toList(),
    );
  }

  //converting Dart object to Json (Map)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomName': roomName,
      //TODO: toJson in Plant
      'plants': plants.map((plant) => plant.toJson()).toList()
    };
  }
}
