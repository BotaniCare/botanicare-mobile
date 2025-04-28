import 'package:flutter/material.dart';

import '../widgets/plant_card.dart';

class PlantScreen extends StatelessWidget {
  const PlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.8,
        children: List.generate(
          7,
          (index) => PlantCard(
            imageUrl:
                "https://cdn.pixabay.com/photo/2022/08/05/18/50/houseplant-7367379_1280.jpg",
          ),
        ),
      ),
    );
  }
}
