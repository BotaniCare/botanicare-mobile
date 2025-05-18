import 'package:botanicare/shared/ui/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../viewmodel/add_room_view_model.dart';

class AddRoomForm extends StatefulWidget {
  final VoidCallback? onCreated;

  const AddRoomForm({super.key, this.onCreated});

  @override
  State<AddRoomForm> createState() => _AddRoomFormState();
}

class _AddRoomFormState extends State<AddRoomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddRoomViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          vm.isEditing
              ? Constants.formTitleUpdating.replaceFirst("{}", "Raum")
              : Constants.formTitleAdding.replaceFirst("{}", "Raum"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: vm.isEditing ? vm.initialRoom!.roomName : "",
                decoration: InputDecoration(labelText: "Raumname eingeben"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Bitte einen Raumnamen eingeben.";
                  }
                  return null;
                },
                onSaved: (String? value) {
                  vm.newRoomName = value;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  _formKey.currentState!.save();

                  // local validation
                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) return;

                  // server validation
                  final error = await vm.validateForm(vm.newRoomName);

                  if (error != null) {
                    CustomSnackBar.show(context, error, isError: true);
                    return;
                  }

                  // save and back
                  vm.saveForm();
                  //update UI
                  widget.onCreated?.call();
                  Navigator.pop(context, true);
                },
                child: Text(
                  vm.isEditing
                      ? Constants.saveChangesMessage
                      : Constants.saveMessage,
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
