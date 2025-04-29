import 'package:flutter/material.dart';

import '../widgets/add_button.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BotaniCare")),
      body: Center(child: Text("Hallo!")),
      floatingActionButton: AddButton(onPressed: () {}),
    );
  }
}
