import 'package:flutter/material.dart';

import '../widgets/setting_item.dart';
import '../widgets/setting_list.dart';

class SettingsNotification extends StatelessWidget {
  const SettingsNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(
          'Benachrichtigungen',
          style: Theme.of(context).textTheme.titleLarge?.apply(
            fontWeightDelta: 600,
          ),
        )
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingList(
                title: Text('Generelles'),
                [
                  SettingItem(
                    icon: Icons.notifications_active_outlined, // Example icon
                    title: 'Benachrichtigungen erlaubt',
                    action: SettingAction.switchToggle((bool) {print(bool);}),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SettingList(
                title: Text('Generelles'),
                [
                  SettingItem(
                    icon: Icons.notifications_active_outlined, // Example icon
                    title: 'Benachrichtigungen erlaubt',
                    action: SettingAction.switchToggle((bool) {print(bool);}),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}