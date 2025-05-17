class PlantImage {
  int id;
  String bytes;

  PlantImage({
    required this.id,
    required this.bytes,
  });

  Map<String, dynamic> toJsonAdding(String plantname) => {
    "fileName": "$plantname.jpg",
    "fileType": "image/jpeg",
    "data": bytes
  };

  Map<String, dynamic> toJsonEditing(String plantname) => {
    "id": id,
    "fileName": "$plantname.jpg",
    "fileType": "image/jpeg",
    "data": bytes
  };
}