import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/room_form.dart';
import '../viewmodel/add_room_view_model.dart';

class AddRoomForm extends StatefulWidget {
  const AddRoomForm({super.key});

  @override
  State<AddRoomForm> createState() => _AddRoomFormState();
}

class _AddRoomFormState extends State<AddRoomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddRoomViewModel>();
    List<RoomDefault> roomsDefault = vm.defaultRooms;

    return Scaffold(
        appBar: AppBar(title: Text("Raum hinzufügen")),
        body:
        Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                ...roomsDefault.map(
                  (room) =>
                  CheckboxListTile(
                      title: Text(room.roomName),
                      value: room.checked,
                      onChanged: (value) {
                        setState(() {
                          room.checked = value!;
                        });
                      }
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Raumname eingeben"),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                      // ToDo: Add Validation
                      vm.saveForm();
                      Navigator.pop(context, true);
                  },
                  child: Text(
                      'Speichern'
                  ),
                ),
                const SizedBox(height: 5),
                const Text("Info: Beim Löschen eines Raums verlieren die enthaltenen Pflanzen ihre Raumzuordnung."),
              ],
            ),
          ),
        )
    );
  }
}
