import 'package:flutter/material.dart';

class PlantCard extends StatelessWidget {
  final String imageUrl;

  const PlantCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 1,
                right: 1,
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "bearbeiten") {
                      //edit functionality - redirect to edit form
                    } else if (value == "löschen") {
                      //delete functionality
                    }
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: "bearbeiten",
                          child: Text("Bearbeiten"),
                        ),
                        PopupMenuItem(value: "löschen", child: Text("Löschen")),
                      ],
                  icon: Icon(Icons.more_vert, size: 25, color: Colors.white),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(11, 11, 11, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pflanzi',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.water_drop_outlined,
                      size: 12,
                      color: Colors.green,
                    ),
                    SizedBox(width: 2),
                    Text(
                      ' -',
                      style: TextStyle(fontSize: 11, color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
