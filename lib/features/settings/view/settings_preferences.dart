import 'package:botanicare/constants.dart';
import 'package:botanicare/data/local/models/theme.dart' as local_theme;
import 'package:botanicare/features/settings/notifier/theme_notifier.dart';
import 'package:botanicare/shared/ui/control/control_group.dart';
import 'package:botanicare/shared/ui/control/control_radio_group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPreferences extends StatelessWidget {
  const SettingsPreferences({super.key});

  void _showInfoDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1️⃣ Obtain the notifier and its current values
    final themeNotifier = context.watch<ThemeNotifier>();
    final currentMode = themeNotifier.themeModeSetting; // raw enum
    final currentContrast = themeNotifier.contrastLevel; // raw enum

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constants.preferencesTitle,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.apply(fontWeightDelta: 600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          ControlGroup(
            header: Text(Constants.preferencesAccessibility),
            children: [
              ControlRadioGroup<String>(
                enabled: false,
                groupLabel: Text(Constants.preferencesLanguage),
                groupLeading: Icon(Icons.language),
                groupTrailing: IconButton(
                  style: ButtonStyle(
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.help_outline_outlined,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  onPressed: () {
                    _showInfoDialog(
                      context,
                      Constants.preferencesLanguageDialogTitle,
                      Constants.preferencesLanguageDialogDesc,
                    );
                  },
                ),
                groupValue: 'de',
                dense: true,
                options: <RadioOption<String>>[
                  RadioOption(value: 'de', label: 'Deutsch'),
                  RadioOption(value: 'en', label: 'English (Englisch)'),
                  RadioOption(value: 'de-SW', label: 'Schwäbisch'),
                ],
                onChanged: (m) => print(m),
                tapToToggle: true,
              ),
            ],
          ),
          ControlGroup(
            header: Text(Constants.preferencesDisplay),
            children: [
              ControlRadioGroup<local_theme.ThemeModeSetting>(
                groupLabel: Text(Constants.preferencesColorscheme),
                groupLeading: Icon(Icons.color_lens_outlined),
                groupTrailing: IconButton(
                  style: ButtonStyle(
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.help_outline_outlined,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  onPressed: () {
                    _showInfoDialog(
                      context,
                      Constants.preferencesColorschemeDialogTitle,
                      Constants.preferencesColorschemeDialogDesc,
                    );
                  },
                ),
                groupValue: currentMode,
                dense: true,
                options: const [
                  RadioOption(
                    value: local_theme.ThemeModeSetting.system,
                    label: 'Automatisch (System)',
                  ),
                  RadioOption(
                    value: local_theme.ThemeModeSetting.light,
                    label: 'Hell',
                  ),
                  RadioOption(
                    value: local_theme.ThemeModeSetting.dark,
                    label: 'Dunkel',
                  ),
                ],
                onChanged: (newMode) {
                  if (newMode != null) {
                    themeNotifier.updateThemeMode(newMode);
                  }
                },
                tapToToggle: true,
              ),
              ControlRadioGroup<local_theme.ContrastLevel>(
                groupLabel: Text(Constants.preferencesContrast),
                groupLeading: Icon(Icons.contrast_outlined),
                groupTrailing: IconButton(
                  style: ButtonStyle(
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.help_outline_outlined,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  onPressed: () {
                    _showInfoDialog(
                      context,
                      Constants.preferencesContrastDialogTitle,
                      Constants.preferencesContrastDialogDesc,
                    );
                  },
                ),
                groupValue: currentContrast,
                dense: true,
                options: const [
                  RadioOption(
                    value: local_theme.ContrastLevel.low,
                    label: 'Normal',
                  ),
                  RadioOption(
                    value: local_theme.ContrastLevel.medium,
                    label: 'Medium',
                  ),
                  RadioOption(
                    value: local_theme.ContrastLevel.high,
                    label: 'Hoch',
                  ),
                ],
                onChanged: (newLevel) {
                  if (newLevel != null) {
                    themeNotifier.updateContrastLevel(newLevel);
                  }
                },
                tapToToggle: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
