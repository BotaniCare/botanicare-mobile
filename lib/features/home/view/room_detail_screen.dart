import 'package:flutter/material.dart';
import '../widgets/plant_list.dart';

class RoomDetailScreen extends StatelessWidget {
  const RoomDetailScreen({super.key, required this.roomName});

  final String roomName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PlantsList()
    );
    }
}
