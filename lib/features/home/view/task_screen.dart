import 'package:botanicare/features/home/view/room_provider.dart';
import 'package:botanicare/features/home/viewmodel/plant_provider.dart';
import 'package:botanicare/features/home/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: true);
    final roomList = roomProvider.rooms;
    return Scaffold(
      appBar: AppBar(title: Text("BotaniCare")),
      body: ListView(
        children:
            roomList.map((room) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.fromLTRB(13, 0, 0, 0),
                    child: Text(
                      room.roomName,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  ...room.roomPlants.map(
                    (plant) => TaskCard(
                      imageUrl:
                          "https://cdn.pixabay.com/photo/2023/09/15/12/43/living-room-8254772_1280.jpg",
                      plantName: plant.name,
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              );
            }).toList(),
      ),
    );
  }
}