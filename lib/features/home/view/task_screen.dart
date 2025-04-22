import 'package:flutter/material.dart';

import '../widgets/add_button.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Center(child: Text("View your Tasks! 🌿")),
        floatingActionButton: AddButton(onPressed: () {

        }),
    );
  }
}