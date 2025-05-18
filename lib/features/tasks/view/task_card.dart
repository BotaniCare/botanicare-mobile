import 'dart:async';
import 'dart:typed_data';

import 'dart:convert';
import 'dart:developer';
import 'package:botanicare/core/services/plant_service.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../core/models/plant.dart';
import '../../../core/services/task_service.dart';

class TaskCard extends StatefulWidget {
  final String imageUrl;
  final Plant plant;
  final int taskId;
  final VoidCallback? onDelete;

  const TaskCard({
    super.key,
    required this.imageUrl,
    required this.plant,
    required this.taskId,
    this.onDelete,
  });

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
              child: SizedBox(
                width: 80,
                height: 85,
                child:
                    widget.plant.image != null
                        ? Image.memory(
                          Uint8List.fromList(widget.plant.image!.plantPicture),
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        )
                        : Icon(
                          Icons.image_not_supported_outlined,
                          size: 16,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.plant.name,
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
                          Icons.grass,
                          size: 16,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        SizedBox(width: 6),
                        Text(
                          widget.plant.type,
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
                          Icons.calendar_month_outlined,
                          size: 16,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        SizedBox(width: 6),
                        Text(
                          widget.plant.waterDate ?? "tt.mm.jjjj",
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
                  //change isWatered locally
                  widget.plant.isWatered = !widget.plant.isWatered;
                });

                try {
                  //update isWatered in db
                  PlantService.updatePlant(widget.plant);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          Constants.wateredPlantSnackBarMessage.replaceFirst(
                            "{}",
                            widget.plant.name,
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                } catch (e) {
                  log("error when updating isWatered in db: $e");
                }

                //show checkmark icon for a while
                await Future.delayed(const Duration(milliseconds: 300));

                await TaskService.deleteTask(widget.plant.id, widget.taskId);
                if (context.mounted) {
                  //update UI
                  widget.onDelete?.call();
                }
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.all(16),
              ),
              child: Icon(
                widget.plant.isWatered
                    ? Icons.check_outlined
                    : Icons.water_drop_outlined,
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
