import 'package:botanicare/features/home/viewmodel/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/add_room_view_model.dart';
import '../viewmodel/plant_provider.dart';
import '../widgets/add_button.dart';
import '../widgets/room_card.dart';
import 'add_room_form.dart';

class RoomSelectionScreen extends StatefulWidget {
  const RoomSelectionScreen({super.key});

  @override
  State<RoomSelectionScreen> createState() => _RoomSelectionScreenState();
}

class _RoomSelectionScreenState extends State<RoomSelectionScreen> {

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: true);
    final plantProvider = Provider.of<PlantProvider>(context, listen: true);

    return Scaffold(
      // ToDo: Reload after adding rooms
      body: ListView.builder(
          itemCount: roomProvider.rooms.length,
          itemBuilder: (BuildContext context, int index) {
            return RoomCard(
              room: roomProvider.rooms[index],
              imageUrl: "https://cdn.pixabay.com/photo/2017/08/06/22/20/interior-2596976_1280.jpg",
            );
          }
      ),
      floatingActionButton: AddButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return ChangeNotifierProvider(
                  create: (_) => AddRoomViewModel(roomProvider: roomProvider, plantProvider: plantProvider),
                  child: const AddRoomForm(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
