import 'package:botanicare/core/services/room_provider.dart';
import 'package:botanicare/features/plants/view/plant_card.dart';
import 'package:botanicare/features/plants/view/plant_detail_screen.dart';
import 'package:botanicare/features/plants/view/plant_list.dart';
import 'package:botanicare/shared/ui/notification_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../core/models/plant.dart';
import '../../../core/services/plant_api.dart';
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
      body: FutureBuilder<List<Plant>>(
        future: fetchPlants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final plants = snapshot.data!;
            return ListView.builder(
              itemCount: plants.length,
              itemBuilder: (context, index) {
                final post = plants[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlantDetailScreen(plant: plants[index])));
                    },
                    child: PlantCard(
                        plant: plants[index]
                    ),
                  );
              },
            );
          } else {
            return ListView(
                children: [
                  NotificationText(text: "Füge deine Pflanzen 🪴 hinzu,\nindem du auf das + unten rechts drückst")
                ]);
          }
        },
      ),
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
                      initialPlant: Plant(
                          id: 0, // will be provided in plantProvider correctly
                          name: '',
                          type: 'Monstera',
                          waterNeed: 'hoch',
                          sunLight: 'nicht sonnig',
                          isWatered: true,
                          image: null,
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
