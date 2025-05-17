import 'package:botanicare/core/services/room_provider.dart';
import 'package:botanicare/features/plants/view/plant_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/models/room.dart';
import '../../../core/services/plant_provider.dart';

class RoomDisplayPlantScreen extends StatelessWidget {
  const RoomDisplayPlantScreen({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: true);
    final plantProvider = Provider.of<PlantProvider>(context, listen: true);
    final plantList = plantProvider.plants;

    return Scaffold(
        appBar: AppBar(title: Text(room.roomName)),
        body: Center(child: Text("To Do"),)
      /*ListView(
        children: [
          ...(plantsInRoom.isNotEmpty
              ? plantsInRoom
                  .map(
                    (plant) => PlantCard(
                      plant: plant,
                    ),
                  )
                  .toList()
              : [
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.33),
                    Text(
                      Constants.emptyRoomMessage,
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
      ),*/
    );
  }
}