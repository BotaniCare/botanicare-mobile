import 'package:botanicare/features/home/widgets/room_card.dart';
import 'package:flutter/material.dart';

import 'room_selection_screen.dart';

class RoomScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorStateRoom;

  const RoomScreen({super.key, required this.navigatorStateRoom});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorStateRoom,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const RoomSelectionScreen(),
        );
      },
    );
  }
}
