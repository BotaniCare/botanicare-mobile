import 'package:flutter/material.dart';

import '../widgets/setting_item.dart';
import '../widgets/setting_list.dart';

class SettingsPreferences extends StatelessWidget {
  const SettingsPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(
          'Präferenzen',
          style: Theme.of(context).textTheme.titleLarge?.apply(
            fontWeightDelta: 600,
          ),
        )
        ),
        body: SettingList(
          scrollable: true,
          scrollDirection: Axis.vertical,
          [
            SettingItem(
              icon: Icons.light_mode, // Example icon
              title: 'Light/Dark Mode',
              action: SettingAction.switchToggle((bool) {print(bool);}),
            ),
          ],
        )
    );
  }
}