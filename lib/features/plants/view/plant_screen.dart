import 'package:botanicare/core/services/room_service.dart';
import 'package:botanicare/features/plants/view/plant_card.dart';
import 'package:botanicare/features/plants/view/plant_detail_screen.dart';
import 'package:botanicare/shared/ui/notification_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../core/models/plant.dart';
import '../../../core/services/plant_service.dart';
import '../../plantsForm/viewmodel/add_plant_view_model.dart';
import '../../../shared/ui/add_button.dart';
import '../../plantsForm/view/add_plant_form.dart';

class PlantScreen extends StatelessWidget {
  PlantScreen({super.key});
  final RoomService roomService = RoomService();

  @override
  Widget build(BuildContext context) {

  return Scaffold(
      appBar: AppBar(title: Text(Constants.plantScreenTitle)),
      body: FutureBuilder<List<Plant>>(
        future: PlantService.getAllPlants(),
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
                  NotificationText(text: Constants.noPlantsCreated)
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
                        ), roomService: roomService,
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
