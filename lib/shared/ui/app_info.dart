import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Error loading package info: ${snapshot.error}');
          return Text('Could not load app info.');
        } else if (!snapshot.hasData) {
          return Text('No app info available.');
        } else {
          final packageInfo = snapshot.data!;
          final versionInfo = 'Version ${packageInfo.version} (${packageInfo.buildNumber})';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  packageInfo.appName,
                  style: Theme.of(context).textTheme.bodyMedium?.merge(TextStyle(color: Theme.of(context).hintColor)),
                ),
                SizedBox(height: 3),
                Text(
                  versionInfo,
                  style: Theme.of(context).textTheme.bodySmall?.merge(TextStyle(color: Theme.of(context).hintColor)),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}