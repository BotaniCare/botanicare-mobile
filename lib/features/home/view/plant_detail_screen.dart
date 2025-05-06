import 'package:botanicare/features/home/widgets/mini_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/plant.dart';
import '../viewmodel/add_plant_view_model.dart';
import '../viewmodel/plant_provider.dart';
import 'add_plant_form.dart';

class PlantDetailScreen extends StatelessWidget {

  const PlantDetailScreen({super.key, required this.plant});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column (
        children: [
          Expanded(
              child: Stack(
                children: [
                  Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage("https://cdn.pixabay.com/photo/2023/09/15/12/43/living-room-8254772_1280.jpg"),
                              fit: BoxFit.cover
                          )
                      )
                  ),
                  AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                  ),
                ],
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(plant.name,
                  style: TextStyle(
                      fontSize: 25
                  )
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            final plantProvider = Provider.of<PlantProvider>(context, listen: true);
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
                )
              ]
            ),
          ),
          Expanded(
               child: Stack(
               children: [
                 GridView.count(
                   crossAxisCount: 2,
                   childAspectRatio: 2 / 1 ,
                   children: [
                      MiniDetailCard(icon: Icons.grass , title: "Art", description: plant.type),
                      MiniDetailCard(icon: Icons.water_drop, title: "Wasserbedarf", description: "250ml"),
                      MiniDetailCard(icon: Icons.calendar_month, title: "Häufigkeit", description: "1x / Woche"),
                      MiniDetailCard(icon: Icons.sunny, title: "Sonnenlicht", description: plant.sunlight),
                      MiniDetailCard(icon: Icons.sensor_door, title: "Raum", description: plant.room!)
                   ]
                 ),
               ],
               ),
          ),
      ]
    ),
    );
  }
}


// Container
// Grid
    // Card components