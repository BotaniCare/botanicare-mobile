import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/add_plant_view_model.dart';
import '../widgets/add_button.dart';
import '../widgets/plant_card.dart';
import 'add_plant_form.dart';

class PlantScreen extends StatelessWidget {
  const PlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pflanzen')),
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
      floatingActionButton: AddButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => ChangeNotifierProvider(
                    create: (_) => AddPlantViewModel(),
                    child: const AddPlantScreen(),
                  ),
            ),
          );
        },
      ),
    );
  }
}
