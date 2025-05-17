import 'package:botanicare/constants.dart';
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
          Constants.settingsScreenTitle,
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
                title: Text(Constants.notificationsTitle),
                subtitle: Text(Constants.notificationsSubtitle),
                leading: Icon(Icons.notifications_none_rounded),
              ),
              ControlNavigator.page(
                SettingsPreferences(),
                title: Text(Constants.preferencesTitle),
                subtitle: Text(Constants.preferencesSubtitle),
                leading: Icon(Icons.settings_outlined),
              ),
            ],
          ),
          ControlGroup(
            header: Text(Constants.groupMoreInfoTitle),
            children: [
              ControlNavigator.href(
                'https://botanicare.de/privacy-policy',
                title: Text(Constants.privacyTitle),
                subtitle: Text(Constants.privacySubtitle),
                leading: Icon(Icons.privacy_tip_outlined),
              ),
              ControlNavigator.href(
                'https://botanicare.de/tos',
                title: Text(Constants.termsTitle),
                subtitle: Text(Constants.termsSubtitle),
                leading: Icon(Icons.miscellaneous_services_rounded),
              ),
              ControlNavigator.href(
                'https://support.botanicare.de/',
                title: Text(Constants.supportTitle),
                leading: Icon(Icons.help_outline_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
