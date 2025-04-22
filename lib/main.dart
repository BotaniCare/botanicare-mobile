import 'package:botanicare/features/home/view/home_screen.dart';
import 'package:botanicare/features/home/viewmodel/home_screen_view_model.dart';
import 'package:botanicare/themes/text_theme.dart';
import 'package:botanicare/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const BotaniCareMobileApp());
}

class BotaniCareMobileApp extends StatelessWidget {
  const BotaniCareMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Inter Tight", "Inter");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomeScreenViewModel())
        ],
        child: const Scaffold(body: HomeScreen()),
      )
    );
  }
}