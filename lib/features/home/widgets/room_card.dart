import 'package:botanicare/features/home/view/room_display_plant_screen.dart';
import 'package:botanicare/features/home/viewmodel/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/room.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  final String imageUrl;

  const RoomCard({super.key, required this.room, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GestureDetector(
          onTap:
              () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RoomDisplayPlantScreen(room: room),
                ),
              ),
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(.6),
              ),

              Builder(
                builder: (context) {
                  if (room.id > 2) {
                    return Container(
                      height: 150,
                      width: double.infinity,
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          padding: EdgeInsets.all(10),
                        ),
                        child: Icon(Icons.edit, size: 23),
                      ),
                    );
                  }
                  return Container();
                },
              ),

              Builder(
                builder: (context) {
                  if (room.id > 2) {
                    return Container(
                      height: 150,
                      width: double.infinity,
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.fromLTRB(0, 55, 0, 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          final confirmDeletion = await showDialog<bool>(
                            context: context,
                            builder:
                                (con) => AlertDialog(
                                  title: Text(
                                    "${room.roomName} entfernen",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  content: Text(
                                    "Willst du diesen Raum wirklich löschen?",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  actions: [
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed:
                                              () => Navigator.pop(con, false),
                                          child: Text("Abbrechen"),
                                        ),
                                        TextButton(
                                          onPressed:
                                              () => Navigator.pop(con, true),
                                          child: Text("Raum löschen"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                          );

                          if (confirmDeletion == true && context.mounted) {
                            Provider.of<RoomProvider>(
                              context,
                              listen: false,
                            ).deleteRoom(room.id);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${room.roomName} 🛋️ wurde gelöscht.",
                                ),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(milliseconds: 450),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          padding: EdgeInsets.all(10),
                        ),
                        child: Icon(Icons.delete_forever, size: 23),
                      ),
                    );
                  }
                  return Container();
                },
              ),

              Container(
                height: 150,
                width: double.infinity,
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(12),
                child: Text(
                  room.roomName,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
