import 'package:botanicare/shared/ui/notification_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../core/models/room.dart';
import '../../../core/services/room_service.dart';
import '../../../shared/ui/add_button.dart';
import '../../roomForm/view/add_room_form.dart';
import '../../roomForm/viewmodel/add_room_view_model.dart';
import 'room_card.dart';

class RoomSelectionScreen extends StatefulWidget {
  final RoomService roomService;

  const RoomSelectionScreen({super.key, required this.roomService});

  @override
  State<RoomSelectionScreen> createState() => _RoomSelectionScreenState();
}

class _RoomSelectionScreenState extends State<RoomSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Constants.roomScreenTitle)),
      body: FutureBuilder<List<Room>>(
        future: RoomService.getAllRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final rooms = snapshot.data!;
            return ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final roomName = rooms[index].roomName.toLowerCase();
                return RoomCard(
                  room: rooms[index],
                  imagePath:
                      roomName == Constants.livingroom.toLowerCase()
                          ? Constants.livingroomImage
                          : roomName == Constants.bedroom.toLowerCase()
                          ? Constants.bedroomImage
                          : roomName == Constants.kitchen.toLowerCase()
                          ? Constants.kitchenImage
                          : roomName == Constants.office.toLowerCase()
                          ? Constants.officeImage
                          : roomName == Constants.bathroom.toLowerCase()
                          ? Constants.bathroomImage
                          : roomName == Constants.balcony.toLowerCase()
                          ? Constants.balconyImage
                          : Constants.defaultImage,
                );
              },
            );
          } else {
            return ListView(
              children: [NotificationText(text: Constants.noRoomsCreated)],
            );
          }
        },
      ),
      floatingActionButton: AddButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return ChangeNotifierProvider(
                  create:
                      (_) => AddRoomViewModel(
                        isEditing: false,
                        roomService: widget.roomService,
                      ),
                  child: const AddRoomForm(),
                );
              },
            ),
          );

          // Only reload if the form actually saved something
          if (result == true && mounted) {
            setState(
              () {},
            ); // Rebuilds the widget and triggers reload (e.g. in initState or build)
          }
        },
      ),
    );
  }
}
