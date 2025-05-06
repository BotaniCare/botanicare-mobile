import 'package:botanicare/features/home/view/plant_screen.dart';
import 'package:flutter/material.dart';

class PlantSelectionScreen extends StatelessWidget {
  const PlantSelectionScreen({super.key, required this.navigatorStateRoom});

  final GlobalKey<NavigatorState> navigatorStateRoom;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorStateRoom,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const PlantScreen(),
        );
      },
    );
  }
}