import 'package:botanicare/features/home/viewmodel/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/room_card.dart';

class RoomSelectionScreen extends StatelessWidget {
  const RoomSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: true);
    final roomList = roomProvider.rooms;

    return Scaffold(
      appBar: AppBar(title: Text('Räume')),
      body: ListView(
        children: [
          ...roomList.map(
            (room) => RoomCard(
              room: room,
              imageUrl:
                  room.id == 0
                      ? "https://cdn.pixabay.com/photo/2016/09/19/17/20/home-1680800_1280.jpg"
                      : room.id == 1
                      ? "https://cdn.pixabay.com/photo/2021/12/22/16/57/room-6887944_1280.jpg"
                      : room.id == 2
                      ? "https://cdn.pixabay.com/photo/2017/03/22/17/39/kitchen-2165756_1280.jpg"
                      : "https://cdn.pixabay.com/photo/2017/08/02/01/01/living-room-2569325_1280.jpg",
            ),
          ),
          //bottom margin to prevent actionButton overlap
          SizedBox(height: 73),
        ],
      ),
    );
  }
}
