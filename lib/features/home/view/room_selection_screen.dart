import 'package:botanicare/features/home/viewmodel/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../assets/constants.dart';
import '../widgets/room_card.dart';

class RoomSelectionScreen extends StatelessWidget {
  const RoomSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: true);
    final roomList = roomProvider.rooms;

    return Scaffold(
      appBar: AppBar(title: Text(Constants.roomScreenTitle)),
      body: ListView(
        children: [
          ...roomList.map(
            (room) => RoomCard(
              room: room,
              imageUrl:
                  room.roomName.toLowerCase() ==
                          Constants.livingroom.toLowerCase()
                      ? "https://cdn.pixabay.com/photo/2016/09/19/17/20/home-1680800_1280.jpg"
                      : room.roomName.toLowerCase() ==
                          Constants.bedroom.toLowerCase()
                      ? "https://cdn.pixabay.com/photo/2021/12/22/16/57/room-6887944_1280.jpg"
                      : room.roomName.toLowerCase() ==
                          Constants.kitchen.toLowerCase()
                      ? "https://cdn.pixabay.com/photo/2017/03/22/17/39/kitchen-2165756_1280.jpg"
                      : room.roomName.toLowerCase() ==
                          Constants.office.toLowerCase()
                      ? "https://cdn.pixabay.com/photo/2017/01/09/12/07/office-1966380_1280.jpg"
                      : room.roomName.toLowerCase() ==
                          Constants.bathroom.toLowerCase()
                      ? "https://cdn.pixabay.com/photo/2022/10/02/14/06/bath-7493560_1280.jpg"
                      : room.roomName.toLowerCase() ==
                          Constants.balcony.toLowerCase()
                      ? "https://cdn.pixabay.com/photo/2016/02/03/12/14/south-tyrol-1176922_1280.jpg"
                      : "https://cdn.pixabay.com/photo/2015/06/29/08/20/leave-room-825317_1280.jpg",
            ),
          ),
          //bottom margin to prevent actionButton overlap
          SizedBox(height: 73),
        ],
      ),
    );
  }
}
