import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  final VoidCallback onPressed;
  const AddButton({super.key, required this.onPressed,});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: widget.onPressed,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: CircleBorder(),
        child: const Icon(Icons.add),
    );
  }
}