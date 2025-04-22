import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("View your Plants! 🌿")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}