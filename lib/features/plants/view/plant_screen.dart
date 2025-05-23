import 'package:botanicare/core/services/room_service.dart';
import 'package:botanicare/features/plants/view/plant_card.dart';
import 'package:botanicare/features/plants/view/plant_detail_screen.dart';
import 'package:botanicare/shared/ui/notification_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../core/models/plant.dart';
import '../../../core/services/plant_service.dart';
import '../../plantsForm/viewmodel/add_plant_view_model.dart';
import '../../../shared/ui/add_button.dart';
import '../../plantsForm/view/add_plant_form.dart';

class PlantScreen extends StatefulWidget {
  final RoomService roomService = RoomService();
  final PlantService plantService = PlantService();

  PlantScreen({super.key});

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  late Future<List<Plant>> _plantFuture;

  @override
  void initState() {
    super.initState();
    _plantFuture = PlantService.getAllPlants();
  }

  void _refreshPlants() {
    setState(() {
      _plantFuture = PlantService.getAllPlants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constants.plantScreenTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: FutureBuilder<List<Plant>>(
        future: _plantFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final plants = snapshot.data!;

            if (plants.isEmpty) {
              return (Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: 320,
                    height: 60,
                    alignment: Alignment.center,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                    child: Text(Constants.noPlantsCreated),
                  ),
                ),
              ));
            }

            return ListView.builder(
              itemCount: plants.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                PlantDetailScreen(plant: plants[index]),
                      ),
                    );
                  },
                  child: PlantCard(plant: plants[index]),
                );
              },
            );
          } else {
            return ListView(
              children: [NotificationText(text: Constants.noPlantsCreated)],
            );
          }
        },
      ),
      floatingActionButton: AddButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return ChangeNotifierProvider(
                  create:
                      (_) => AddPlantViewModel(
                        isEditing: false,
                        initialPlant: Plant(
                          id: 0,
                          // will be provided in plantProvider correctly
                          name: '',
                          type: 'Monstera',
                          waterNeed: 'hoch',
                          sunLight: 'nicht sonnig',
                          isWatered: true,
                          image: null,
                        ),
                        roomService: widget.roomService,
                        plantService: widget.plantService,
                      ),
                  child: const AddPlantScreen(),
                );
              },
            ),
          );

          // Only reload if the form actually saved something
          if (result == true && mounted) {
            _refreshPlants(); // Rebuilds the widget and triggers reload (e.g. in initState or build)
          }
        },
      ),
    );
  }
}
