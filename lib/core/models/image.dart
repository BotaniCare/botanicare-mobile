class PlantImage {
  int id;
  String bytes;

  PlantImage({
    required this.id,
    required this.bytes,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'plantPicture': bytes,
  };
}