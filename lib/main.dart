import 'package:botanicare/features/home/viewmodel/task_screen_view_model.dart';
import 'package:botanicare/features/settings/notifier/theme_notifier.dart';
import 'package:botanicare/themes/text_theme.dart';
import 'package:botanicare/themes/theme.dart';
import 'package:botanicare/features/home/view/plant_screen.dart';
import 'package:botanicare/features/home/view/room_screen.dart';
import 'package:botanicare/features/settings/view/settings_screen.dart';
import 'package:botanicare/features/home/view/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorStateRoom =
    GlobalKey<NavigatorState>();

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(null),
      child: const BotaniCareMobileApp(),
    )
  );
}

class BotaniCareMobileApp extends StatelessWidget {
  const BotaniCareMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        // Retrieves the default theme for the platform
        // TextTheme textTheme = Theme.of(context).textTheme;

        // Use with Google Fonts package to use downloadable fonts
        TextTheme textTheme = createTextTheme(context, "Inter Tight", "Inter");
        MaterialTheme theme = MaterialTheme(textTheme);
        return MaterialApp(
          title: 'BotaniCare',
          themeMode: themeNotifier.effectiveThemeMode,
          theme: theme.light(), // Your light theme
          darkTheme: theme.dark(), // Your dark theme
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => TaskScreenViewModel()),
            ],
            child: const Scaffold(body: BotaniCareHome()),
          ),
        );
      },
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

  final List<Widget> _pages = [
    TasksScreen(),
    PlantScreen(),
    RoomScreen(navigatorStateRoom: navigatorStateRoom),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
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
