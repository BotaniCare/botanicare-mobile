import 'package:botanicare/core/services/room_provider.dart';
import 'package:botanicare/features/plants/view/plant_list.dart';
import 'package:botanicare/shared/ui/notification_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../assets/constants.dart';
import '../../../core/models/plant.dart';
import '../../plantsForm/viewmodel/add_plant_view_model.dart';
import '../../../core/services/plant_provider.dart';
import '../../../shared/ui/add_button.dart';
import '../../plantsForm/view/add_plant_form.dart';

class PlantScreen extends StatelessWidget {
  const PlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plantProvider = Provider.of<PlantProvider>(context, listen: true);
    final plantList = plantProvider.plants;

    return Scaffold(
      appBar: AppBar(title: Text(Constants.plantScreenTitle)),
      body: plantList.isNotEmpty
          ? PlantsList()
          : ListView(
            children: [
              NotificationText(text: "Füge deine Pflanzen 🪴 hinzu,\nindem du auf das + unten rechts drückst")
          ]),
      floatingActionButton: AddButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                final plantProvider = Provider.of<PlantProvider>(context, listen: false);
                final roomProvider = Provider.of<RoomProvider>(context, listen: true);
                return ChangeNotifierProvider(
                  create: (_) => AddPlantViewModel(
                      isEditing: false,
                      plantProvider: plantProvider,
                      roomProvider: roomProvider,
                      initialPlant: Plant(
                          id: 0, // will be provided in plantProvider correctly
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
