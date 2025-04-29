import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String imageUrl;

  const TaskCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(12),
      color: Theme.of(context).colorScheme.onSurface,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Planzenname",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 16,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "1x/Woche",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.water_drop_outlined,
                          size: 16,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "200ml",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Icon(Icons.check_box_outlined);
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.all(16),
              ),
              child: Icon(Icons.water_drop_outlined),
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
