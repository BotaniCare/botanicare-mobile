import 'dart:convert';

import 'package:botanicare/core/models/plant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../plantsForm/view/add_plant_form.dart';
import '../../../core/services/room_provider.dart';
import '../../plantsForm/viewmodel/add_plant_view_model.dart';
import '../../../core/services/plant_provider.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;

  const PlantCard({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(12),
      color: Theme.of(context).colorScheme.onSurface,

      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: plant.image == null
                ? Center(child: Text("Kein Bild gefunden"))
                : Image.memory(base64Decode(plant.image!.bytes)),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "1x/Woche",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(
                        Icons.water_drop_outlined,
                        size: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "200ml",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        final plantProvider = Provider.of<PlantProvider>(context, listen: false);
                        final roomProvider = Provider.of<RoomProvider>(context, listen: false);
                        return ChangeNotifierProvider(
                          create: (_) => AddPlantViewModel(
                            isEditing: true,
                            initialPlant: plant,
                          ),
                          child: const AddPlantScreen(),
                        );
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(60, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Icon(Icons.edit, size: 18),
              ),
              SizedBox(height: 6),
              ElevatedButton(
                onPressed: () async {
                  final confirmDeletion = await showDialog<bool>(
                    context: context,
                    builder:
                        (con) => AlertDialog(
                          title: Text(
                            "${plant.name} entfernen",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          content: Text(
                            "Willst du ${plant.name} wirklich entfernen?",
                            style: TextStyle(fontSize: 14),
                          ),
                          actions: [
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pop(con, false),
                                  child: Text("Abbrechen"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(con, true),
                                  child: Text("Pflanze löschen"),
                                ),
                              ],
                            ),
                          ],
                        ),
                  );

                  if (confirmDeletion == true && context.mounted) {
                    Provider.of<PlantProvider>(
                      context,
                      listen: false,
                    ).deletePlant(plant.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${plant.name} 🪴 wurde gelöscht."),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(milliseconds: 450),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(60, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Icon(Icons.delete_forever, size: 18),
              ),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
