import 'package:flutter/material.dart';

class PlantView extends StatelessWidget {

  const PlantView({
    super.key,
    required this.value
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      "Item $value",
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
