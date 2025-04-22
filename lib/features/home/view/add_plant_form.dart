import 'package:flutter/material.dart';

class AddPlantForm extends StatefulWidget {
  const AddPlantForm({super.key});

  @override
  State<AddPlantForm> createState() => _AddPlantFormState();
}

class _AddPlantFormState extends State<AddPlantForm> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _type;
  String? _waterNeed = 'normal';
  String? _sunlight = 'sonnig';
  String? _room;
  bool _isCustomType = true;

  final List<String> _plantTypesFromDb = ['Ficus', 'Monstera', 'Aloe Vera'];
  final Map<String, String> _waterNeedDefaults = {
    'Ficus': 'normal',
    'Monstera': 'hoch',
    'Aloe Vera': 'gering',
  };

  final List<String> _rooms = ['Wohnzimmer', 'Küche', 'Balkon'];
  final TextEditingController _newRoomController = TextEditingController();

  void _onTypeSelected(String? value) {
    setState(() {
      _type = value;
      _isCustomType = false;
      _waterNeed = _waterNeedDefaults[value] ?? 'normal';
    });
  }

  void _addRoom(String newRoom) {
    setState(() {
      _rooms.add(newRoom);
      _room = newRoom;
      _newRoomController.clear();
    });
  }

  @override
  void dispose() {
    _newRoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pflanze hinzufügen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Bild Upload Placeholder
              Container(
                height: 150,
                color: Colors.grey[300],
                child: const Center(child: Text('Bild hinzufügen (coming soon)')),
              ),
              const SizedBox(height: 16),

              // Name
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name der Pflanze'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Bitte einen Namen eingeben' : null,
                onSaved: (value) => _name = value,
              ),

              const SizedBox(height: 16),

              // Pflanzenart
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Art auswählen'),
                items: _plantTypesFromDb
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: _onTypeSelected,
              ),

              const SizedBox(height: 8),

              // Oder eigene Art eingeben
              TextFormField(
                decoration: const InputDecoration(labelText: 'Eigene Art (optional)'),
                onChanged: (value) {
                  setState(() {
                    _type = value;
                    _isCustomType = true;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Wasserbedarf
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Wasserbedarf'),
                value: _waterNeed,
                items: ['gering', 'normal', 'hoch']
                    .map((level) => DropdownMenuItem(value: level, child: Text(level)))
                    .toList(),
                onChanged: (value) => setState(() => _waterNeed = value),
              ),

              const SizedBox(height: 16),

              // Sonneneinstrahlung
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Sonneneinstrahlung'),
                value: _sunlight,
                items: ['sonnig', 'teilweise sonnig', 'nicht sonnig']
                    .map((sun) => DropdownMenuItem(value: sun, child: Text(sun)))
                    .toList(),
                onChanged: (value) => setState(() => _sunlight = value),
              ),

              const SizedBox(height: 16),

              // Raum Auswahl
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Raum'),
                value: _room,
                items: _rooms
                    .map((room) => DropdownMenuItem(value: room, child: Text(room)))
                    .toList(),
                onChanged: (value) => setState(() => _room = value),
              ),

              // Neuen Raum hinzufügen
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _newRoomController,
                      decoration: const InputDecoration(hintText: 'Neuen Raum hinzufügen'),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (_newRoomController.text.isNotEmpty) {
                        _addRoom(_newRoomController.text);
                      }
                    },
                  )
                ],
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Hier könntest du die Daten an ViewModel oder Datenbank weitergeben
                    print('Name: $_name');
                    print('Art: $_type');
                    print('Wasserbedarf: $_waterNeed');
                    print('Sonne: $_sunlight');
                    print('Raum: $_room');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pflanze gespeichert')),
                    );
                  }
                },
                child: const Text('Speichern'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
