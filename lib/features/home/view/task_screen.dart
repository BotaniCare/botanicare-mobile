import 'package:botanicare/features/home/widgets/task_card.dart';
import 'package:flutter/material.dart';

import '../widgets/add_button.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BotaniCare")),
      body: ListView(
        children: [
          TaskCard(
            imageUrl:
                "https://cdn.pixabay.com/photo/2023/09/15/12/43/living-room-8254772_1280.jpg",
          ),
        ],
      ),
    );
  }
}
