import 'package:botanicare/features/home/widgets/plant_view.dart';
import 'package:flutter/material.dart';

class PlantScrollList extends StatelessWidget {
  const PlantScrollList({super.key});

  @override
  Widget build(BuildContext context) {

    final plants = [
      1,
      2,
      3,
      4,
      5
    ];

    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return PlantView(value: "Item ${plants[index]}");
      },
    );
  }
}
