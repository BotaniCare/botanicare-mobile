import 'package:botanicare/features/settings/view/settings_location.dart';
import 'package:botanicare/features/settings/view/settings_notification.dart';
import 'package:botanicare/features/settings/view/settings_preferences.dart';
import 'package:botanicare/shared/ui/app_info.dart';
import 'package:botanicare/shared/ui/control/control_group.dart';
import 'package:botanicare/shared/ui/control/control_navigator.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Einstellungen',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      bottomSheet: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [AppInfo()],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          ControlGroup(
            children: [
              ControlNavigator.page(
                SettingsNotification(),
                title: Text('Benachrichtigungen'),
                subtitle: Text('App- & Systembenachrichtigungen'),
                leading: Icon(Icons.notifications_none_rounded),
              ),
              ControlNavigator.page(
                SettingsLocation(),
                title: Text('Standort'),
                subtitle: Text('Standortdienste & Berechtigungen'),
                leading: Icon(Icons.location_on),
              ),
              ControlNavigator.page(
                SettingsPreferences(),
                title: Text('Präferenzen'),
                subtitle: Text('Barriere- & Darstellungsanpassungen'),
                leading: Icon(Icons.settings_outlined),
              ),
            ],
          ),
          ControlGroup(
            header: Text('Nützliche Infos'),
            children: [
              ControlNavigator.href(
                'https://botanicare.de/privacy-policy',
                title: Text('Datenschutzrichtlinien'),
                subtitle: Text('Informationen zum Datenschutz'),
                leading: Icon(Icons.privacy_tip_outlined),
              ),
              ControlNavigator.href(
                'https://botanicare.de/tos',
                title: Text('Nutzungsbedingungen'),
                subtitle: Text('Informationen zu den AGBs'),
                leading: Icon(Icons.miscellaneous_services_rounded),
              ),
              ControlNavigator.href(
                'https://support.botanicare.de/',
                title: Text('Support/Hilfe'),
                leading: Icon(Icons.help_outline_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
