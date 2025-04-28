import 'package:botanicare/features/home/view/room_detail_screen.dart';
import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  final String roomName;
  final String imageUrl;

  const RoomCard({super.key, required this.roomName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GestureDetector(

          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => RoomDetailScreen(roomName: roomName)
              )
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
                  roomName,
                  style: TextStyle(
                    color: Colors.white,
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
