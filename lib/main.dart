import 'package:botanicare/features/home/view/home_screen.dart';
import 'package:botanicare/features/home/view/plant_screen.dart';
import 'package:botanicare/features/home/view/room_screen.dart';
import 'package:botanicare/features/home/view/settings_screen.dart';
import 'package:botanicare/features/home/view/task_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BotaniCareMobileApp());
}


class BotaniCareMobileApp extends StatelessWidget {
  const BotaniCareMobileApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BotaniCare',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BotaniCareHome(),
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
    HomeScreen(),
    PlantScreen(),
    TasksScreen(),
    RoomScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BotaniCare'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'Plants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.weekend),
            label: 'Rooms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
