import 'dart:convert';
import 'dart:typed_data';

import 'package:botanicare/core/services/room_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/models/plant.dart';
import '../../../core/services/plant_service.dart';
import 'mini_detail_card.dart';
import '../../plantsForm/view/add_plant_form.dart';
import '../../plantsForm/viewmodel/add_plant_view_model.dart';


class PlantDetailScreen extends StatelessWidget {
  final RoomService roomService = RoomService();
  final PlantService plantService = PlantService();
  PlantDetailScreen({super.key, required this.plant});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                plant.image != null ? Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:MemoryImage(  Uint8List.fromList(plant.image!.plantPicture)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ) : const SizedBox.shrink(),
                AppBar(elevation: 0, backgroundColor: Colors.transparent),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(plant.name, style: TextStyle(fontSize: 25)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return ChangeNotifierProvider(
                            create:
                                (_) => AddPlantViewModel(
                              isEditing: true,
                              initialPlant: plant,
                              roomService: roomService,
                              plantService: plantService,
                            ),
                            child: const AddPlantScreen(),
                          );
                        },
                      ),
                    );
                    // .then((value) => setState(() {}))
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
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GridView.count(
                  padding: EdgeInsets.all(8.0),
                  //Spaltenanzahl im Grid
                  crossAxisCount: 2,
                  //horizontaler Space zwischen den Spalten
                  crossAxisSpacing: 2,
                  //vertikaler Space zwischen den Zeilen
                  mainAxisSpacing: 2,
                  //breite zu höhe
                  childAspectRatio: 2.0,
                  children: [
                    MiniDetailCard(
                      icon: Icons.grass,
                      title: "Art",
                      description: plant.type,
                    ),
                    MiniDetailCard(
                      icon: Icons.water_drop,
                      title: "Wasserbedarf",
                      description: "250ml",
                    ),
                    MiniDetailCard(
                      icon: Icons.calendar_month,
                      title: "Häufigkeit",
                      description: "1x / Woche",
                    ),
                    MiniDetailCard(
                      icon: Icons.sunny,
                      title: "Sonnenlicht",
                      description: plant.sunLight,
                    ),
                    MiniDetailCard(
                      icon: Icons.sensor_door,
                      title: "Raum",
                      description: "TODO",
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

// Container
// Grid
// Card components
