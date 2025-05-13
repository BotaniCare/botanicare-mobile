import 'package:botanicare/features/home/models/plant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view/add_plant_form.dart';
import '../viewmodel/add_plant_view_model.dart';
import '../viewmodel/plant_provider.dart';

class MiniDetailCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const MiniDetailCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                size: 21,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
