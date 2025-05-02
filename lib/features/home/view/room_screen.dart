import 'package:flutter/material.dart';
import 'room_selection_screen.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const RoomSelectionScreen());
      },
    );
  }
}
