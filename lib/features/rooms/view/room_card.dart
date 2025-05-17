import 'package:botanicare/core/services/room_service.dart';
import 'package:botanicare/features/rooms/view/room_display_plant_screen.dart';
import 'package:botanicare/core/services/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../core/models/room.dart';
import '../../../core/services/plant_provider.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  final String imagePath;

  const RoomCard({super.key, required this.room, required this.imagePath});

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
              () =>
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RoomDisplayPlantScreen(room: room),
                ),
              ),
          child: Stack(
            children: [
              Image.asset(
                imagePath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(.6),
              ),

              Builder(
                builder: (context) {
                  return Container(
                    height: 150,
                    width: double.infinity,
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        foregroundColor:
                        Theme
                            .of(context)
                            .colorScheme
                            .onPrimary,
                        backgroundColor: Colors.grey.shade400,
                        padding: EdgeInsets.all(10),
                      ),
                      child: Icon(Icons.edit, size: 23),
                    ),
                  );
                },
              ),

              Builder(
                builder: (context) {
                  return Container(
                    height: 150,
                    width: double.infinity,
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.fromLTRB(0, 55, 0, 0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if(room.plantList.isNotEmpty){
                          final confirmDeletion = await showDialog<bool>(
                            context: context,
                            builder:
                                (con) =>
                                AlertDialog(
                                  title: Text(
                                    Constants.alertDialogTitle.replaceFirst(
                                        "{}", room.roomName),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color:
                                      Theme
                                          .of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                  ),
                                  content: Text(
                                    Constants.alertDialogContent.replaceFirst(
                                      "{}",
                                      room.roomName,
                                    ),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  actions: [
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed:
                                              () => Navigator.pop(con, false),
                                          child: Text(Constants.cancelDeletion),
                                        ),
                                        TextButton(
                                          onPressed:
                                              () => Navigator.pop(con, true),
                                          child: Text(
                                              Constants.confirmRoomDeletion),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                          );

                          if (confirmDeletion == true && context.mounted) {
                            final RoomService roomService= RoomService();
                            roomService.deleteRoom(room.roomName);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  Constants.deletionSnackBarMessage.replaceFirst(
                                      "{}", room.roomName),
                                ),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(milliseconds: 450),
                              ),
                            );
                          }
                        } else {
                          await showDialog<void>(
                            context: context,
                            builder: (con) => AlertDialog(
                              title: Text(
                                "${room.roomName} kann nicht gelöscht werden",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(con).colorScheme.primary,
                                ),
                              ),
                              content: Text(
                                "Bitte lösche erst die Pflanzen in ${room.roomName}, um diesen Raum löschen zu können",
                                style: TextStyle(fontSize: 14),
                              ),
                              actions: [
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(con),
                                      child: Text("Verstanden"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        backgroundColor: (room.plantList.isEmpty) ? Theme.of(context).colorScheme.primary : Colors.grey.shade400,
                        padding: EdgeInsets.all(10),
                      ),
                      child: Icon(Icons.delete_forever, size: 23),
                    ),
                  );
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
                    color: Theme
                        .of(context)
                        .colorScheme
                        .onSurface,
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
