import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/add_plant_view_model.dart';
import '../widgets/add_button.dart';
import 'add_plant_form.dart';

class PlantScreen extends StatelessWidget {
  const PlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Center(child: Text("View your Plants! 🌿")),
        floatingActionButton: AddButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider(
                    create: (_) => AddPlantViewModel(),
                    child: const AddPlantScreen(),
                  ),
                ),
            );
        }),
    );
  }
}