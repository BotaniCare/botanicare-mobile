import 'dart:convert';

class PlantPicture {
  final int? id;
  final List<int> plantPicture;

  PlantPicture({
    this.id,
    required this.plantPicture,
  });

  factory PlantPicture.fromJson(Map<String, dynamic> json) {
    return PlantPicture(
      id: json['id'],
      plantPicture: base64Decode(json['plantPicture']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plantPicture': base64Encode(plantPicture),
    };
  }
}
