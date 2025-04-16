import 'package:botanicare/features/home/view/home_screen.dart';
import 'package:botanicare/features/home/viewmodel/home_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const BotaniCareMobileApp());
}

class BotaniCareMobileApp extends StatelessWidget {
  const BotaniCareMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomeScreenViewModel())
        ],
        child: const HomeScreen(),
      )
    );
  }
}