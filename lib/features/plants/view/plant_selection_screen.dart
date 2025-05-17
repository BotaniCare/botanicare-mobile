import 'package:flutter/material.dart';
import 'plant_screen.dart';

class PlantSelectionScreen extends StatelessWidget {
  const PlantSelectionScreen({super.key, required this.navigatorStatePlant});

  final GlobalKey<NavigatorState> navigatorStatePlant;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorStatePlant,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => PlantScreen(),
        );
      },
    );
  }
}