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
  late Future<List<Room>> _roomFuture;

  @override
  void initState() {
    super.initState();
    _roomFuture = RoomService.getAllRooms();
  }

  void _refreshRooms() {
    setState(() {
      _roomFuture = RoomService.getAllRooms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constants.roomScreenTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: FutureBuilder<List<Room>>(
        future: _roomFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final rooms = snapshot.data!;
            if (rooms.isEmpty) {
              return (Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: 320,
                    height: 60,
                    alignment: Alignment.center,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                    child: Text(Constants.noRoomsCreated),
                  ),
                ),
              ));
            }

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
                  onDelete: _refreshRooms,
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
                  child: AddRoomForm(),
                );
              },
            ),
          );

          // Only reload if the form actually saved something
          if (result == true && mounted) {
            _refreshRooms(); // Rebuilds the widget and triggers reload (e.g. in initState or build)
          }
        },
      ),
    );
  }
}
