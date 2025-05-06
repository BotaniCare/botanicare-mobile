import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/plant.dart';
import '../viewmodel/add_plant_view_model.dart';
import '../viewmodel/plant_provider.dart';
import '../widgets/plant_list.dart';
import '../widgets/add_button.dart';
import 'add_plant_form.dart';

class PlantScreen extends StatelessWidget {
  const PlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pflanzen')),
      body: PlantsList(),
      floatingActionButton: AddButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                final plantProvider = Provider.of<PlantProvider>(context, listen: false);
                return ChangeNotifierProvider(
                  create: (_) => AddPlantViewModel(
                      isEditing: false,
                      plantProvider: plantProvider,
                      initialPlant: Plant(
                          id: 0, // will be provided in plantProvider correctly
                          name: '',
                          type: 'Monstera',
                          waterNeed: 'hoch',
                          sunlight: 'nicht sonnig',
                          roomId: ''
                      )
                  ),
                  child: const AddPlantScreen(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
