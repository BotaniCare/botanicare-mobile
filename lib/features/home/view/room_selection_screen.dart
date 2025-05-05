import 'package:flutter/material.dart';

import '../widgets/room_card.dart';

class RoomSelectionScreen extends StatelessWidget {
  const RoomSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          RoomCard(
            roomName: "Wohnzimmer",
            imageUrl:
                "https://cdn.pixabay.com/photo/2016/09/19/17/20/home-1680800_1280.jpg",
          ),
          RoomCard(
            roomName: "Küche",
            imageUrl:
                "https://cdn.pixabay.com/photo/2024/12/24/10/04/kitchen-9288111_1280.jpg",
          ),
        ],
      ),
    );
  }
}
