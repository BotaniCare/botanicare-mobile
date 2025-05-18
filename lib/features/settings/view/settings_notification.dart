import 'package:botanicare/constants.dart';
import 'package:botanicare/features/settings/notifier/notifications_notifier.dart';
import 'package:botanicare/shared/ui/control/control_group.dart';
import 'package:botanicare/shared/ui/control/control_switch_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class SettingsNotification extends StatelessWidget {
  const SettingsNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final noti = context.watch<NotificationNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constants.notificationsTitle,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.apply(fontWeightDelta: 600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          ControlGroup(
            children: [
              ControlSwitchTile(
                title: Text(Constants.notificationsAllowed),
                value: noti.allowAll,
                onChanged: (v) => noti.setAllowAll(v),
                tapToToggle: true,
              ),
            ],
          ),
          ControlGroup(
            header: Text(Constants.permissions),
            children: [
              ControlSwitchTile(
                title: Text(Constants.notificationPush),
                value: noti.push,
                enabled: noti.allowAll,
                onChanged: (v) => noti.setPush(v),
                leading: Icon(
                  Icons.folder_outlined,
                  color: Theme.of(context).disabledColor,
                ),
                tapToToggle: true,
              ),
              ControlSwitchTile(
                title: Text(Constants.notificationSMS),
                value: noti.sms,
                enabled: noti.allowAll,
                onChanged: (v) => noti.setSms(v),
                leading: Icon(
                  Icons.sms_outlined,
                  color: Theme.of(context).disabledColor,
                ),
                tapToToggle: true,
              ),
              ControlSwitchTile(
                title: Text(Constants.notificationEmail),
                value: noti.email,
                enabled: noti.allowAll,
                onChanged: (v) => noti.setEmail(v),
                leading: Icon(
                  Icons.email_outlined,
                  color: Theme.of(context).disabledColor,
                ),
                tapToToggle: true,
              ),
            ],
          ),
          ControlGroup(
            header: Text(Constants.notificationReminder),
            children: [
              ControlSwitchTile(
                title: Text(Constants.reminderDailies),
                value: noti.dailyTasks,
                enabled: noti.allowAll,
                onChanged: (v) => noti.setDailyTasks(v),
                leading: Icon(
                  Icons.task_alt,
                  color: Theme.of(context).disabledColor,
                ),
                tapToToggle: true,
              ),
              ControlSwitchTile(
                title: Text(Constants.reminderCritical),
                value: noti.criticalCondition,
                enabled: noti.allowAll,
                onChanged: (v) => noti.setCriticalCondition(v),
                leading: Icon(
                  Icons.warning_amber_rounded,
                  color: Theme.of(context).disabledColor,
                ),
                tapToToggle: true,
              ),
            ],
          ),
          if(kDebugMode) ControlGroup(
            header: Text('Debug'),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: double.maxFinite,
                child: FilledButton(
                    onPressed: () => noti.sendTestMessage(),
                    child: Text('Test Nachricht')
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
