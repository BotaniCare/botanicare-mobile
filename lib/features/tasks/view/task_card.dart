import 'dart:async';

import 'package:botanicare/core/services/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/models/task.dart';

class TaskCard extends StatefulWidget {
  final String imageUrl;
  final Task task;

  const TaskCard({super.key, required this.imageUrl, required this.task});
  @override
  TaskCardState createState() => TaskCardState();
}

class TaskCardState extends State<TaskCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(12),
      color: Theme.of(context).colorScheme.onSurface,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: Image.network(
                widget.imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.plant.name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 16,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "1x/Woche",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.water_drop_outlined,
                          size: 16,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "200ml",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  widget.task.plant.isWatered = !widget.task.plant.isWatered;
                });
                await Future.delayed(const Duration(seconds: 1));
                Provider.of<TaskProvider>(context, listen: false).deleteTask(widget.task.id);
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.all(16),
              ),
              child: Icon(
                widget.task.plant.isWatered ? Icons.check_outlined : Icons.water_drop_outlined,
                size: 18,
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
