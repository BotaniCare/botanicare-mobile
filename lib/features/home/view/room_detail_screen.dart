import 'package:botanicare/features/home/widgets/plant_card.dart';
import 'package:flutter/material.dart';

class RoomDetailScreen extends StatelessWidget {
  const RoomDetailScreen({super.key, required this.roomName});

  final String roomName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              PlantCard(
                imageUrl:
                    "https://cdn.pixabay.com/photo/2023/09/15/12/43/living-room-8254772_1280.jpg",
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlantCard(
                imageUrl:
                    "https://cdn.pixabay.com/photo/2012/04/26/21/52/flowerpot-43272_1280.jpg",
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlantCard(
                imageUrl:
                    "https://cdn.pixabay.com/photo/2022/03/07/21/56/tulips-7054614_1280.jpg",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
