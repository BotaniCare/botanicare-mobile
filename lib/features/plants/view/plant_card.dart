import 'dart:convert';
import 'dart:typed_data';

import 'package:botanicare/core/models/plant.dart';
import 'package:botanicare/core/services/room_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../core/services/plant_service.dart';
import '../../plantsForm/view/add_plant_form.dart';
import '../../plantsForm/viewmodel/add_plant_view_model.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;
  final RoomService roomService = RoomService();
  final PlantService plantService = PlantService();
  final VoidCallback? onDelete;

  PlantCard({super.key, required this.plant, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(12),
      color: Theme.of(context).colorScheme.onSurface,

      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child:
                plant.image != null
                    ? Image.memory(
                      Uint8List.fromList(plant.image!.plantPicture),
                      width: 50,
                      fit: BoxFit.cover, // Optional
                    )
                    : Icon(
                      Icons.image_not_supported_outlined,
                      size: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.name,
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
                        plant.type,
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
                        plant.waterDate ?? "tt.mm.jjjj",
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

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return ChangeNotifierProvider(
                          create:
                              (_) => AddPlantViewModel(
                                isEditing: true,
                                initialPlant: plant,
                                roomService: roomService,
                                plantService: plantService,
                              ),
                          child: const AddPlantScreen(),
                        );
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(60, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Icon(Icons.edit, size: 18),
              ),
              SizedBox(height: 6),
              ElevatedButton(
                onPressed: () async {
                  final confirmDeletion = await showDialog<bool>(
                    context: context,
                    builder:
                        (con) => AlertDialog(
                          title: Text(
                            Constants.alertDialogTitle.replaceFirst(
                              "{}",
                              plant.name,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          content: Text(
                            Constants.alertDialogContent.replaceFirst(
                              "{}",
                              plant.name,
                            ),
                            style: TextStyle(fontSize: 14),
                          ),
                          actions: [
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pop(con, false),
                                  child: Text(Constants.cancelDeletion),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(con, true),
                                  child: Text(Constants.confirmPlantDeletion),
                                ),
                              ],
                            ),
                          ],
                        ),
                  );

                  if (confirmDeletion == true && context.mounted) {
                    await PlantService.deletePlant(plant.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          Constants.deletionSnackBarMessage.replaceFirst(
                            "{}",
                            plant.name,
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(milliseconds: 450),
                      ),
                    );

                    onDelete?.call();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(60, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Icon(Icons.delete_forever, size: 18),
              ),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
