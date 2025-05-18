import 'dart:convert';
import 'dart:typed_data';

import 'package:botanicare/core/services/task_service.dart';
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
  bool showImageError = false;

  @override
  void initState() {
    super.initState();
    final vm = Provider.of<AddPlantViewModel>(context, listen: false);
    vm.loadRooms();
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final viewModel = context.read<AddPlantViewModel>();
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      final image = await pickedFile.readAsBytes();
      viewModel.setImage(base64Encode(image));
    }
  }

  Future<void> _saveForm(BuildContext context) async {
    final vm = context.read<AddPlantViewModel>();

    _formKey.currentState!.save();
    final error = vm.validateForm();

    setState(() {
      showImageError = error != null;
    });

    if (_formKey.currentState!.validate() && error == null) {
      final success = await vm.save();

      if (success) {
        debugPrint("---- Until here");
        _showSnackBar(
          context,
          vm.isEditing
              ? 'Änderungen erfolgreich gespeichert! 🎉'
              : 'Pflanze erfolgreich gespeichert! 🎉',
        );
        //create task for plant

        await TaskService.createPlantTask();
        debugPrint("---- After then");
        if (mounted) {
          Navigator.pop(context, true);
        }
      } else {
        _showSnackBar(
          context,
          'Fehler beim Speichern der Pflanze ❌',
          isError: true,
        );
      }
    } else if (error != null) {
      _showSnackBar(context, error, isError: true);
    }
  }

  void _showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Theme.of(context).colorScheme.error : null,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddPlantViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(vm.isEditing ? 'Pflanze bearbeiten' : 'Pflanze hinzufügen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildImagePicker(context, vm),
              const SizedBox(height: 24),
              _buildTextField(
                'Name',
                initialValue: vm.isEditing ? vm.plant.name : '',
                onSaved: vm.updateName,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Bitte einen Pflanzennamen ein.";
                  }
                  return null;
                },
              ),
              _buildTextField(
                'Art der Pflanze',
                initialValue: vm.isEditing ? vm.plant.type : '',
                onChanged: vm.updateType,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Bitte einen Pflanzenart eingeben.";
                  }
                  return null;
                },
              ),
              if (!vm.isEditing)
                _buildDropdown(
                  "Kürzlich gegossen",
                  ['Ja', 'Nein'],
                  vm.isWatered,
                  vm.updateIsWatered,
                ),
              const SizedBox(height: 16),
              _buildDropdown(
                'Wasserbedarf',
                ['gering', 'normal', 'hoch'],
                vm.plant.waterNeed,
                vm.updateWaterNeed,
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                'Sonneneinstrahlung',
                ['sonnig', 'teilweise sonnig', 'nicht sonnig'],
                vm.plant.sunLight,
                vm.updateSunlight,
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                'Raum',
                vm.rooms.map((r) => r.roomName).toList(),
                vm.roomName,
                vm.updateRoomName,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _saveForm(context),
                child: Text(
                  vm.isEditing ? 'Änderungen speichern' : 'Speichern',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context, AddPlantViewModel vm) {
    final hasImage = vm.plant.image != null;
    final isError = showImageError && !hasImage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _showImageSourceSelector(context),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color:
                  isError
                      ? Theme.of(context).colorScheme.error.withOpacity(0.1)
                      : Theme.of(context).colorScheme.onSurfaceVariant,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color:
                    isError
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.secondary,
                width: 2,
              ),
            ),
            child:
                hasImage
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        Uint8List.fromList(vm.plant.image!.plantPicture),
                        fit: BoxFit.cover,
                      ),
                    )
                    : Center(
                      child: Text(
                        "Bild hinzufügen",
                        style: TextStyle(
                          color:
                              isError
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
          ),
        ),
        if (isError)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 4),
            child: Text(
              "Bitte füge ein Bild hinzu.",
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  void _showImageSourceSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Aus Galerie auswählen'),
                  onTap: () => _pickImage(context, ImageSource.gallery),
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Foto aufnehmen'),
                  onTap: () => _pickImage(context, ImageSource.camera),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildTextField(
    String label, {
    String? initialValue,
    void Function(String)? onChanged,
    void Function(String)? onSaved,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      validator: validator,
      onSaved: onSaved != null ? (val) => onSaved(val!) : null,
      onChanged: onChanged,
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String value,
    void Function(String) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(labelText: label),
      items:
          items
              .map((val) => DropdownMenuItem(value: val, child: Text(val)))
              .toList(),
      onChanged: (val) => onChanged(val!),
    );
  }
}
