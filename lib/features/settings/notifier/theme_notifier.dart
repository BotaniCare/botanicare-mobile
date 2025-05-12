import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeMode? _userPreferredThemeMode; // null means use system setting

  ThemeNotifier(this._userPreferredThemeMode);

  ThemeMode get effectiveThemeMode {
    // If user has set a preference, use that. Otherwise, MaterialApp's
    // themeMode: ThemeMode.system will handle using the platform brightness.
    if (_userPreferredThemeMode != null) {
      return _userPreferredThemeMode!;
    }
    return ThemeMode.system;
  }

  // This getter is useful for setting the *initial* state of the switch
  bool get isUserDarkModePreferred {
    return _userPreferredThemeMode == ThemeMode.dark;
  }


  void toggleTheme(bool isDarkMode) {
    // Set the user's preference based on the switch state
    _userPreferredThemeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    // Potentially save this preference to persistent storage here (e.g., SharedPreferences)
  }

  // You might also want a way to clear the user preference and revert to system
  void clearUserPreference() {
    _userPreferredThemeMode = null;
    notifyListeners();
  }
}