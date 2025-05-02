import 'package:botanicare/features/home/models/plant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view/add_plant_form.dart';
import '../viewmodel/add_plant_view_model.dart';
import '../viewmodel/plant_provider.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;
  final String imageUrl;

  const PlantCard({super.key, required this.plant, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Theme.of(context).colorScheme.onSurface,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            final plantProvider = Provider.of<PlantProvider>(context, listen: false);
                            return ChangeNotifierProvider(
                              create: (_) => AddPlantViewModel(
                                  isEditing: true,
                                  plantProvider: plantProvider,
                                  initialPlant: plant
                              ),
                              child: const AddPlantScreen(),
                            );
                          },
                        ),
                      );
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
                  icon: Icon(
                    Icons.more_vert,
                    size: 25,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
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
                  plant.name,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.water_drop_outlined,
                      size: 12,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "-",
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
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
