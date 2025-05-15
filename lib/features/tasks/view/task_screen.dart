import 'package:botanicare/core/services/room_provider.dart';
import 'package:botanicare/core/services/plant_provider.dart';
import 'package:botanicare/features/tasks/view/task_card.dart';
import 'package:botanicare/shared/ui/notification_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/services/task_provider.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: true);
    final roomList = roomProvider.rooms;
    final plantProvider = Provider.of<PlantProvider>(context, listen: true);
    final plantList = plantProvider.plants;
    final taskProvider = Provider.of<TaskProvider>(context, listen: true);
    final taskList = taskProvider.addTask(plantList);
    final plantsWithNoRoom = taskList.where(
      (task) => task.plant.roomId == null,
    );

    return Scaffold(
      appBar: AppBar(title: Text("BotaniCare")),
      body: ListView(
        children: [
          if (taskList.isNotEmpty) ...[
            SizedBox(height: 5),
            ...roomList
                .where(
                  (room) =>
                      taskList.any((task) => task.plant.roomId == room.id),
                )
                .map((room) {
                  final plantsInRoom =
                      taskList
                          .where((task) => task.plant.roomId == room.id)
                          .toList();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
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
                      ...plantsInRoom.map(
                        (task) => TaskCard(
                          imageUrl:
                              "https://cdn.pixabay.com/photo/2023/09/15/12/43/living-room-8254772_1280.jpg",
                          task: task,
                        ),
                      ),
                      SizedBox(height: 7),
                    ],
                  );
                }),
            if (plantsWithNoRoom.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.fromLTRB(13, 0, 0, 0),
                    child: Text(
                      "Pflanzen ohne Raum",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ...plantsWithNoRoom.map(
                    (task) => TaskCard(
                      imageUrl:
                          "https://cdn.pixabay.com/photo/2020/01/16/16/31/cactus-4771078_1280.jpg",
                      task: task,
                    ),
                  ),
                ],
              ),
          ] else ...[
            NotificationText(text: "Alle Pflanzen sind gegossen 🥳")
          ],
        ],
      ),
    );
  }
}
