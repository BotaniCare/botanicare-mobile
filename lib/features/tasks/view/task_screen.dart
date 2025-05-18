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
      appBar: AppBar(
        title: Text(
          Constants.appTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
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

          //all tasks
          final taskList =
              roomWithTaskList.expand((entry) {
                final tasks = entry['tasks'];
                return tasks is List<Task> ? tasks : <Task>[];
              }).toList();

          if (taskList.isEmpty) {
            NotificationText(text: Constants.noTasks);
            return (Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  width: 260,
                  height: 45,
                  alignment: Alignment.center,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                  child: Text(Constants.noTasks),
                ),
              ),
            ));
          }

          return ListView.builder(
            //get tasks from a specific room
            itemCount: roomWithTaskList.length,
            itemBuilder: (context, index) {
              final room = roomWithTaskList[index]['room'] as Room;
              final taskListOfRoom = roomWithTaskList[index]['tasks'];

              if (taskListOfRoom == null || taskListOfRoom.isEmpty) {
                return SizedBox();
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
                  ...taskListOfRoom.map((task) {
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
