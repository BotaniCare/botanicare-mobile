import 'package:botanicare/features/home/view/room_display_plant_screen.dart';
import 'package:flutter/material.dart';

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
