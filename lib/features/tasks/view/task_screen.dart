import 'package:botanicare/constants.dart';
import 'package:botanicare/core/services/task_service.dart';
import 'package:botanicare/features/tasks/view/task_card.dart';
import 'package:flutter/material.dart';
import '../../../core/models/room.dart';
import '../../../core/models/task.dart';
import '../../../shared/ui/notification_text.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late Future<List<Map<String, dynamic>>> _taskFuture;

  //only at onCreate
  @override
  void initState() {
    super.initState();
    TaskService.createPlantTask();
    _taskFuture = TaskService.getAllTasks();
  }

  //refresh Tasks after deleting
  void _refreshTasks() {
    setState(() {
      _taskFuture = TaskService.getAllTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Constants.appTitle)),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _taskFuture,
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

          //get only tasks of room
          final taskList = roomWithTaskList.expand((entry) => entry['task'] as List<Task>).toList();
          if (taskList.isEmpty) {
            NotificationText(text: Constants.noTasks);
            return Center(
              child: Text(Constants.noTasks),
            );
          }

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
                      onDelete: _refreshTasks,
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
