import 'package:botanicare/shared/ui/control/control_group.dart';
import 'package:flutter/material.dart';

class SettingsLocation extends StatelessWidget {
  const SettingsLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Standort',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.apply(fontWeightDelta: 600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  ControlGroup(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Straße und Hausnummer',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Stadt',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Postleitzahl',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Stock',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ), // Add some spacing above buttons
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Align buttons to the right
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      // Handle Cancel action
                      Navigator.of(context).pop(); // Example: Go back
                      print('Abgebrochen');
                    },
                    child: const Text('Abbrechen'), // Cancel
                  ),
                  const SizedBox(width: 8), // Spacing between buttons
                  FilledButton(
                    onPressed: () {
                      // Handle Submit/Save action
                      // Add your form validation and data saving logic here
                      print('Gespeichert');
                    },
                    child: const Text('Speichern'), // Save or Submit
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
