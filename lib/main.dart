import 'package:botanicare/features/settings/notifier/notifications_notifier.dart';
import 'package:botanicare/features/settings/notifier/theme_notifier.dart';
import 'package:botanicare/core/services/room_provider.dart';
import 'package:botanicare/features/plants/view/plant_selection_screen.dart';
import 'package:botanicare/themes/text_theme.dart';
import 'package:botanicare/themes/theme.dart';
import 'package:botanicare/features/rooms/view/room_screen.dart';
import 'package:botanicare/features/settings/view/settings_screen.dart';
import 'package:botanicare/features/tasks/view/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'core/services/task_provider.dart';
import 'core/services/plant_provider.dart';
import 'data/local/hive_helper.dart';
import 'data/local/models/theme.dart' as local_theme;

final GlobalKey<NavigatorState> navigatorStateRoom =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> navigatorStatePlants =
    GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  final themeBox = await HiveHelper.openThemeBox();

  local_theme.Theme savedTheme;
  if (themeBox.isNotEmpty) {
    savedTheme = themeBox.getAt(0)!;
  } else {
    savedTheme = local_theme.Theme.initial();
    await themeBox.add(savedTheme);
  }

  final notificationNotifier = await NotificationNotifier.create();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create:
              (_) => ThemeNotifier(
                initialMode: savedTheme.themeMode,
                initialContrast: savedTheme.contrastLevel,
                themeBox: themeBox,
              ),
        ),

        ChangeNotifierProvider<NotificationNotifier>.value(
          value: notificationNotifier,
        ),

        ChangeNotifierProvider(create: (context) => TaskProvider()),

        ChangeNotifierProvider(create: (context) => PlantProvider()),

        ChangeNotifierProvider(create: (context) => RoomProvider()),

        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],
      child: const BotaniCareMobileApp(),
    ),
  );
}

class BotaniCareMobileApp extends StatelessWidget {
  const BotaniCareMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to ThemeNotifier to rebuild on themeMode changes:
    final themeNotifier = context.watch<ThemeNotifier>();

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Inter Tight", "Inter");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: Constants.appTitle,
      themeMode: themeNotifier.effectiveThemeMode,
      theme: theme.light(),
      darkTheme: theme.dark(),
      home: const Scaffold(body: BotaniCareHome()),
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
    final List<Widget> pages = [
      TasksScreen(),
      PlantSelectionScreen(navigatorStatePlant: navigatorStatePlants),
      RoomScreen(navigatorStateRoom: navigatorStateRoom),
      SettingsScreen(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: (index) {
          //if navigation bar item is room
          if (index == 2) {
            navigatorStateRoom.currentState?.popUntil(
              (route) => route.isFirst,
            ); //navigate back to the room selection screen
          }
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: Constants.taskScreenTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: Constants.plantScreenTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.weekend),
            label: Constants.roomScreenTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: Constants.settingsScreenTitle,
          ),
        ],
      ),
    );
  }
}
