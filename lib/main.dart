import 'package:botanicare/core/services/device_service.dart';
import 'package:botanicare/features/settings/notifier/notifications_notifier.dart';
import 'package:botanicare/features/settings/notifier/theme_notifier.dart';
import 'package:botanicare/features/plants/view/plant_selection_screen.dart';
import 'package:botanicare/themes/text_theme.dart';
import 'package:botanicare/themes/theme.dart';
import 'package:botanicare/features/rooms/view/room_screen.dart';
import 'package:botanicare/features/tasks/view/task_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'data/local/hive_helper.dart';
import 'data/local/models/theme.dart' as local_theme;
import 'features/settings/view/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//for nested navigation
final GlobalKey<NavigatorState> navigatorStateRoom =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> navigatorStatePlants =
    GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Background Message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveHelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final deviceBox = await HiveHelper.openDeviceInfo();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();

  DeviceService.setBox(deviceBox);
  await DeviceService.registerOrRefreshToken();

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
      TaskScreen(),
      //pass navigator state
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
          if (index == 1) {
            navigatorStateRoom.currentState?.popUntil(
              (route) => route.isFirst,
            ); //navigate back to the plant screen
          }
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
