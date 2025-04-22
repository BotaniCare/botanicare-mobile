import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/add_plant_view_model.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newRoomController = TextEditingController();
  bool _isCustomType = true;

  @override
  void dispose() {
    _newRoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddPlantViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Pflanze hinzufügen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (val) => val == null || val.isEmpty ? 'Name erforderlich' : null,
                onSaved: (val) => vm.name = val,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Art aus Datenbank'),
                items: vm.plantTypesFromDb
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) {
                  vm.setType(value);
                  setState(() => _isCustomType = false);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Eigene Art (optional)'),
                onChanged: (val) {
                  vm.type = val;
                  setState(() => _isCustomType = true);
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: vm.waterNeed,
                decoration: const InputDecoration(labelText: 'Wasserbedarf'),
                items: ['gering', 'normal', 'hoch']
                    .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                    .toList(),
                onChanged: (val) => setState(() => vm.waterNeed = val),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: vm.sunlight,
                decoration: const InputDecoration(labelText: 'Sonneneinstrahlung'),
                items: ['sonnig', 'teilweise sonnig', 'nicht sonnig']
                    .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                    .toList(),
                onChanged: (val) => setState(() => vm.sunlight = val),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: vm.room,
                decoration: const InputDecoration(labelText: 'Raum'),
                items: vm.rooms
                    .map((room) => DropdownMenuItem(value: room, child: Text(room)))
                    .toList(),
                onChanged: (val) => setState(() => vm.room = val),
              ),
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
                      vm.addRoom(_newRoomController.text);
                      _newRoomController.clear();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    vm.savePlant();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pflanze gespeichert')),
                    );
                    Navigator.pop(context);
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
