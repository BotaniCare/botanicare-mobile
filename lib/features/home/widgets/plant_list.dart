import 'package:botanicare/features/home/viewmodel/plant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/plant_card.dart';

class PlantsList extends StatelessWidget {
  const PlantsList({super.key});

  @override
  Widget build(BuildContext context) {
    final plants = Provider.of<PlantProvider>(context).plants;

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: plants.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            return PlantCard(
              plant: plants[index],
              imageUrl: "https://cdn.pixabay.com/photo/2022/08/05/18/50/houseplant-7367379_1280.jpg",
            );
          },
        );
      },
    );
  }
}