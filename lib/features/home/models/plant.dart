import 'dart:io';

class Plant {
  int id;
  String name;
  String type;
  String waterNeed;
  String sunlight;
  int? roomId;
  bool isWatered;
  File? image;

  Plant({
    required this.id,
    required this.name,
    required this.type,
    required this.waterNeed,
    required this.sunlight,
    required this.roomId,
    required this.isWatered,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'waterNeed': waterNeed,
      'sunlight': sunlight,
      'room': roomId,
      'imagePath': image,
    };
  }
}