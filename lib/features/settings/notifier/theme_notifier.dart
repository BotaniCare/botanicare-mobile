import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:botanicare/data/local/models/theme.dart' as local_theme;

class ThemeNotifier with ChangeNotifier {
  final Box<local_theme.Theme> _themeBox;

  // store the raw enums
  local_theme.ThemeModeSetting _themeModeSetting;
  local_theme.ContrastLevel _contrastLevel;

  ThemeNotifier({
    required local_theme.ThemeModeSetting initialMode,
    required local_theme.ContrastLevel initialContrast,
    required Box<local_theme.Theme> themeBox,
  })  : _themeModeSetting = initialMode,
        _contrastLevel = initialContrast,
        _themeBox = themeBox;

  /// Expose Flutter's [ThemeMode] to MaterialApp
  ThemeMode get effectiveThemeMode {
    switch (_themeModeSetting) {
      case local_theme.ThemeModeSetting.light:
        return ThemeMode.light;
      case local_theme.ThemeModeSetting.dark:
        return ThemeMode.dark;
      case local_theme.ThemeModeSetting.system:
      default:
        return ThemeMode.system;
    }
  }

  /// Whether dark mode is toggled on
  bool get isUserDarkModePreferred =>
      _themeModeSetting == local_theme.ThemeModeSetting.dark;

  /// Public getter for the current themeModeSetting
  local_theme.ThemeModeSetting get themeModeSetting => _themeModeSetting;

  /// The raw contrast level enum
  local_theme.ContrastLevel get contrastLevel => _contrastLevel;

  // Updates the theme mode, notifies listeners, *and* writes to Hive
  void updateThemeMode(local_theme.ThemeModeSetting newMode) {
    _themeModeSetting = newMode;
    _saveToHive();
    notifyListeners();
  }

  // Updates the contrast level, notifies listeners, *and* writes to Hive
  void updateContrastLevel(local_theme.ContrastLevel newContrast) {
    _contrastLevel = newContrast;
    _saveToHive();
    notifyListeners();
  }

  // Write the updated Theme object back to Hive at index 0
  void _saveToHive() {
    final updated = local_theme.Theme(
      themeMode: _themeModeSetting,
      contrastLevel: _contrastLevel,
    );
    _themeBox.putAt(0, updated);
  }
}
