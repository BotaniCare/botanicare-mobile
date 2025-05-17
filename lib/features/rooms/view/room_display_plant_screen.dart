import 'package:botanicare/core/services/room_provider.dart';
import 'package:botanicare/features/plants/view/plant_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../core/models/plant.dart';
import '../../../core/models/room.dart';
import '../../../core/services/plant_provider.dart';
import '../../../core/services/plant_service.dart';
import '../../../core/services/room_service.dart';
import '../../../shared/ui/notification_text.dart';
import '../../plants/view/plant_detail_screen.dart';
import '../../plantsForm/view/add_plant_form.dart';
import '../../plantsForm/viewmodel/add_plant_view_model.dart';

class RoomDisplayPlantScreen extends StatelessWidget {
  RoomDisplayPlantScreen({super.key, required this.room});
  final RoomService roomService= RoomService();
  final PlantService plantService= PlantService();

  final Room room;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(room.roomName)),
      body: FutureBuilder<List<Plant>>(
        future: RoomService.getAllPlantsFromRoom(room.roomName),
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
                  NotificationText(text: Constants.noPlantsCreated),
                  SizedBox(height: 10),
                  ElevatedButton(
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
                                ),
                                roomService: roomService,
                                plantService: plantService,
                                roomName: room.roomName
                              ),
                              child: const AddPlantScreen(),
                            );
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor:
                      Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Icon(Icons.add),
                  ),
                ]);
          }
        },
      ),
    );
  }
}
