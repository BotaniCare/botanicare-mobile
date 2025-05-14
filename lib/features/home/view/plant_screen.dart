import 'package:botanicare/assets/constants.dart';
import 'package:botanicare/features/home/viewmodel/room_provider.dart';
import 'package:botanicare/features/home/widgets/plant_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/plant.dart';
import '../viewmodel/add_plant_view_model.dart';
import '../viewmodel/plant_provider.dart';
import '../widgets/add_button.dart';
import 'add_plant_form.dart';

class PlantScreen extends StatelessWidget {
  const PlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plantProvider = Provider.of<PlantProvider>(context, listen: true);
    final plantList = plantProvider.plants;

    return Scaffold(
      appBar: AppBar(title: Text(Constants.plantScreenTitle)),
      body: ListView(
        children: [
          if (plantList.isNotEmpty) ...[
            ...plantList.map(
              (plant) => PlantCard(
                plant: plant,
                imageUrl:
                    "https://cdn.pixabay.com/photo/2019/06/17/08/24/pastel-4279379_1280.jpg",
              ),
            ),
            //bottom margin to prevent actionButton overlap
            SizedBox(height: 73),
          ] else ...[
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.30),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Text(
                    "Füge deine Pflanzen 🪴 hinzu,\nidem du auf das + unten rechts drückst",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
      floatingActionButton: AddButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                final plantProvider = Provider.of<PlantProvider>(
                  context,
                  listen: false,
                );
                final roomProvider = Provider.of<RoomProvider>(
                  context,
                  listen: false,
                );
                return ChangeNotifierProvider(
                  create:
                      (_) => AddPlantViewModel(
                        isEditing: false,
                        plantProvider: plantProvider,
                        roomProvider: roomProvider,
                        initialPlant: Plant(
                          id: 0,
                          // will be provided in plantProvider correctly
                          name: '',
                          type: 'Monstera',
                          waterNeed: 'hoch',
                          sunlight: 'nicht sonnig',
                          roomId: null,
                          isWatered: true,
                        ),
                      ),
                  child: const AddPlantScreen(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
