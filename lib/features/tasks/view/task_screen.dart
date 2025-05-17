import 'package:botanicare/constants.dart';
import 'package:botanicare/core/services/task_service.dart';
import 'package:botanicare/features/tasks/view/task_card.dart';
import 'package:flutter/material.dart';
import '../../../core/models/room.dart';
import '../../../core/models/task.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskService = TaskService();

    return Scaffold(
      appBar: AppBar(title: Text(Constants.appTitle)),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: taskService.getAllTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Ein Fehler ist aufgetreten: ${snapshot.error}"),
            );
          }

          final roomWithTaskList = snapshot.data!;

          return ListView.builder(
            itemCount: roomWithTaskList.length,
            itemBuilder: (context, index) {
              final room = roomWithTaskList[index]['room'] as Room;
              final taskList = roomWithTaskList[index]['tasks'] as List<Task>;

              if (taskList.isEmpty) {
                return Center(child: Text(Constants.noTasks));
              }

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
                  ...taskList.map((task) {
                    final plant = task.plant;
                    return TaskCard(
                      imageUrl:
                          "https://cdn.pixabay.com/photo/2023/09/15/12/43/living-room-8254772_1280.jpg",
                      plant: plant,
                      taskId: task.id!,
                    );
                  }),
                  SizedBox(height: 7),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

/*Column(
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
                  TaskCard(
                      imageUrl:
                          "https://cdn.pixabay.com/photo/2020/01/16/16/31/cactus-4771078_1280.jpg",
                      task: task,
                    ),

                ],
              ),

            NotificationText(text: "Alle Pflanzen sind gegossen 🥳"),*/

/*
children: [
                    SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.fromLTRB(13, 0, 0, 0),
                          child: Text(
                            "room.roomName",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        TaskCard(
                          imageUrl:
                          "https://cdn.pixabay.com/photo/2023/09/15/12/43/living-room-8254772_1280.jpg",
                        ),

                        SizedBox(height: 7),
                      ],
                    ),
                  ],
*/
