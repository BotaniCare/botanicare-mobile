import 'package:botanicare/core/services/plant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'plant_card.dart';

class PlantsList extends StatelessWidget {
  const PlantsList({super.key});

  @override
  Widget build(BuildContext context) {
    final plants = Provider.of<PlantProvider>(context).plants;

    return ListView.builder(
        itemCount: plants.length,
        itemBuilder: (context, index) {
          return PlantCard(plant: plants[index],
            imageUrl: 'https://cdn.pixabay.com/photo/2023/09/15/12/43/living-room-8254772_1280.jpg');
        }
    );
  }
}