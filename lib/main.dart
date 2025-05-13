import 'package:botanicare/features/home/viewmodel/room_provider.dart';
import 'package:botanicare/themes/text_theme.dart';
import 'package:botanicare/themes/theme.dart';
import 'package:botanicare/features/home/view/plant_screen.dart';
import 'package:botanicare/features/home/view/room_screen.dart';
import 'package:botanicare/features/home/view/settings_screen.dart';
import 'package:botanicare/features/home/view/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/home/viewmodel/task_provider.dart';
import 'features/home/viewmodel/task_screen_view_model.dart';
import 'features/home/viewmodel/plant_provider.dart';

final GlobalKey<NavigatorState> navigatorStateRoom =
    GlobalKey<NavigatorState>();

void main() {
  runApp(const BotaniCareMobileApp());
}

class BotaniCareMobileApp extends StatelessWidget {
  const BotaniCareMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    // TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Inter Tight", "Inter");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'BotaniCare',
      themeMode: ThemeMode.system,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TaskScreenViewModel()),
          ChangeNotifierProvider(create: (context) => PlantProvider()),
          ChangeNotifierProvider(create: (context) => RoomProvider()),
          ChangeNotifierProvider(create: (context) => TaskProvider()),
        ],
        child: const Scaffold(body: BotaniCareHome()),
      ),
    );
  }
}

class BotaniCareHome extends StatefulWidget {
  const BotaniCareHome({super.key});

  @override
  BotaniCareHomeState createState() => BotaniCareHomeState();
}

class BotaniCareHomeState extends State<BotaniCareHome> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      TasksScreen(),
      PlantScreen(),
      RoomScreen(navigatorStateRoom: navigatorStateRoom),
      SettingsScreen(),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: (index) {
          if (index == 2) {
            navigatorStateRoom.currentState?.popUntil(
              (route) => route.isFirst,
            ); //um wieder auf erste Seite von Räume zu kommen
          }
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Aufgaben',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'Pflanzen',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.weekend), label: 'Räume'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Einstellungen',
          ),
        ],
      ),
    );
  }
}
