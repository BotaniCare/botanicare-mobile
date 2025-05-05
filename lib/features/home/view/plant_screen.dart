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
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.fromLTRB(13, 0, 0, 0),
                child: Text(
                  "Wohnzimmer",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              PlantCard(
                imageUrl:
                    "https://cdn.pixabay.com/photo/2023/09/15/12/43/living-room-8254772_1280.jpg",
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(13, 0, 0, 0),
            child: Text(
              "Küche",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlantCard(
                imageUrl:
                    "https://cdn.pixabay.com/photo/2012/04/26/21/52/flowerpot-43272_1280.jpg",
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlantCard(
                imageUrl:
                    "https://cdn.pixabay.com/photo/2022/03/07/21/56/tulips-7054614_1280.jpg",
              ),
            ],
          ),
        ],
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
