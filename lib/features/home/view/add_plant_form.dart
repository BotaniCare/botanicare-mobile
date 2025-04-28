import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      Provider.of<AddPlantViewModel>(context, listen: false).setImage(imageFile);
    }
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
              const Text(
                "Bild der Pflanze",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => SafeArea(
                      child: Wrap(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: const Text('Aus Galerie auswählen'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.gallery);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: const Text('Foto aufnehmen'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.camera);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: vm.plantImage != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(vm.plantImage!, fit: BoxFit.cover),
                  )
                      : const Center(child: Text("Bild hinzufügen")),
                ),
              ),
              const SizedBox(height: 24),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (val) => val == null || val.isEmpty ? 'Name erforderlich' : null,
                onSaved: (val) => vm.name = val,
              ),
              const SizedBox(height: 16),

              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  return vm.plantTypesFromDb.where((String option) {
                    return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  vm.setType(selection);
                  setState(() => _isCustomType = false);
                },
                fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      labelText: 'Art aus Datenbank',
                    ),
                    onEditingComplete: onEditingComplete,
                  );
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

