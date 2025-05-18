import 'package:botanicare/core/services/room_service.dart';
import 'package:flutter/material.dart';
import 'room_selection_screen.dart';

class RoomScreen extends StatelessWidget {
  RoomScreen({super.key, required this.navigatorStateRoom});
  final RoomService roomService= RoomService();

  final GlobalKey<NavigatorState> navigatorStateRoom;

  @override
  Widget build(BuildContext context) {
    //nested navigation: show bottom navigation bar when redirecting to room display plant screen
    return Navigator(
      key: navigatorStateRoom,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => RoomSelectionScreen(roomService: roomService,),
        );
      },
    );
  }
}