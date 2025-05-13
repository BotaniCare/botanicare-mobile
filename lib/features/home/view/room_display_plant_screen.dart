import 'package:botanicare/features/home/viewmodel/room_provider.dart';
import 'package:botanicare/features/home/widgets/plant_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/room.dart';
import '../viewmodel/add_plant_view_model.dart';
import '../viewmodel/plant_provider.dart';
import '../widgets/plant_list.dart';
import 'add_plant_form.dart';

class RoomDisplayPlantScreen extends StatelessWidget {
  const RoomDisplayPlantScreen({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: true);
    final plantProvider = Provider.of<PlantProvider>(context, listen: true);
    final plantList = plantProvider.plants;
    final plantsInRoom = roomProvider.getPlantsByRoom(plantList, room.id);

    return Scaffold(
      appBar: AppBar(title: Text(room.roomName)),
      body: ListView(
        children: [
          ...(plantsInRoom.isNotEmpty
              ? plantsInRoom
                  .map(
                    (plant) => PlantCard(
                      plant: plant,
                      imageUrl:
                          "https://cdn.pixabay.com/photo/2022/08/05/18/50/houseplant-7367379_1280.jpg",
                    ),
                  )
                  .toList()
              : [
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.33),
                    Text(
                      "Hier gibt es noch keine Pflanzen :(",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        //TODO: redirect to AddPlantScreen()
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                      ),
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ]),
        ],
      ),
    );
  }
}
