import 'dart:io';

import 'package:botanicare/features/home/models/plant.dart';

class Room {
  int id;
  String roomName;
  List <Plant> roomPlants;

  Room ({required this.id, required this.roomName, required this.roomPlants});
}