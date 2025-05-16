import 'package:botanicare/core/services/plant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'plant_detail_screen.dart';
import 'plant_card.dart';

class PlantsList extends StatelessWidget {
  const PlantsList({super.key});

  @override
  Widget build(BuildContext context) {
    final plants = Provider.of<PlantProvider>(context).plants;

    return ListView.builder(
        itemCount: plants.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlantDetailScreen(plant: plants[index])));
              },
              child: PlantCard(
                  plant: plants[index]
              ),
          );
        }
    );
  }
}