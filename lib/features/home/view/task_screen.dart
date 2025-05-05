import 'package:botanicare/features/home/widgets/task_card.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BotaniCare")),
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
              TaskCard(
                imageUrl:
                    "https://cdn.pixabay.com/photo/2023/09/15/12/43/living-room-8254772_1280.jpg",
              ),
            ],
          ),

          SizedBox(height: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              TaskCard(
                imageUrl:
                    "https://cdn.pixabay.com/photo/2022/08/05/18/50/houseplant-7367379_1280.jpg",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
