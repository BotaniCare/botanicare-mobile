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
      appBar: AppBar(title: Text('Pflanzen')),
      body: ListView(
        children: [
          ...plantList.map(
            (plant) => PlantCard(
              plant: plant,
              imageUrl:
                  "https://cdn.pixabay.com/photo/2019/06/17/08/24/pastel-4279379_1280.jpg",
            ),
          ),
          //bottom margin to prevent actionButton overlap
          if (plantList.isNotEmpty) SizedBox(height: 70),
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
                return Consumer<RoomProvider>(
                  builder: (context, roomProvider, _) {
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
                              roomId: 0,
                              isWatered: false,
                            ),
                          ),
                      child: const AddPlantScreen(),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
