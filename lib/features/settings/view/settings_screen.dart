import 'package:botanicare/features/settings/view/settings_location.dart';
import 'package:botanicare/features/settings/view/settings_notification.dart';
import 'package:botanicare/features/settings/view/settings_preferences.dart';
import 'package:botanicare/features/settings/widgets/setting_item.dart';
import 'package:botanicare/features/settings/widgets/setting_list.dart';
import 'package:botanicare/shared/ui/app_info.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        'Einstellungen',
        style: Theme.of(context).textTheme.headlineLarge,
      )
      ),
      bottomSheet: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppInfo(),
          ],
        ),
      ),
      body: SettingList(
        scrollable: true,
        scrollDirection: Axis.vertical,
        [
          SettingItem(
            icon: Icons.notifications_none_rounded, // Example icon
            title: 'Benachrichtigungen',
            subtitle: 'App- & Systembenachrichtigungen',
            action: SettingAction.navigate(SettingsNotification()),
          ),
          SettingItem(
            icon: Icons.location_on,
            title: 'Standort',
            subtitle: 'Standortdienste & Berechtigungen',
            action: SettingAction.navigate(SettingsLocation()),
          ),
          SettingItem(
            icon: Icons.settings_outlined,
            title: 'Präferenzen',
            subtitle: 'Anpassen des Verhaltens',
            action: SettingAction.navigate(SettingsPreferences()),
          ),
          SettingItem(
            icon: Icons.privacy_tip_outlined,
            title: 'Datenschutzrichtlinien',
            subtitle: 'Informationen zum Datenschutz',
            action: SettingAction.url('https://botanicare.de/privacy-policy'),
          ),
          SettingItem(
            icon: Icons.miscellaneous_services_rounded,
            title: 'Nutzungsbedingungen',
            subtitle: 'Informationen zu den AGB',
            action: SettingAction.url('https://botanicare.de/tos'),
          ),
          SettingItem(
            icon: Icons.help_outline_rounded,
            title: 'Support/Hilfe',
            //subtitle: 'General app settings',
            action: SettingAction.url('https://support.botanicare.de/'),
          ),
        ],
      )
    );
  }
}