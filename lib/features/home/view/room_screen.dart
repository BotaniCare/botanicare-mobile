import 'package:flutter/material.dart';

import '../widgets/add_button.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Center(child: Text("View your Plants! 🌿")),
      floatingActionButton: AddButton(onPressed: () {

      }),
    );
  }
}