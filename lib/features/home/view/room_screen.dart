import 'package:botanicare/features/home/widgets/room_card.dart';
import 'package:flutter/material.dart';

import 'RoomSelectionScreen.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const RoomSelectionScreen());
      },
    );
    /*return Scaffold(
      body: ListView(
        children: [
          RoomCard(roomName: "Kitchen", imageUrl: "https://cdn.pixabay.com/photo/2024/12/24/10/04/kitchen-9288111_1280.jpg",),
          RoomCard(roomName: "Living Room", imageUrl: "https://cdn.pixabay.com/photo/2016/09/19/17/20/home-1680800_1280.jpg",),
        ],
      )
    );*/
  }
}
