import 'package:flutter/material.dart';

import '../widgets/setting_list.dart';

class SettingsLocation extends StatelessWidget {
  const SettingsLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(
          'Standort',
          style: Theme.of(context).textTheme.titleLarge?.apply(
            fontWeightDelta: 600,
          ),
        )
        ),
        body: SettingList(
          scrollable: true,
          scrollDirection: Axis.vertical,
          [],
        )
    );
  }
}