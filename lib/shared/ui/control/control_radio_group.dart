import 'package:flutter/material.dart';
import 'control_radio_tile.dart';

/// Model representing a single radio option.
class RadioOption<T> {
  final T value;
  final String label;
  final Widget? subtitle;
  final Widget? leading;

  const RadioOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.leading,
  });
}

/// A group container that wraps multiple [ControlRadioTile]s in a single Card.
///
/// - Applies a single elevation to the entire group.
/// - Supports optional group label, validation error text, and accessibility.
class ControlRadioGroup<T> extends StatelessWidget {
  /// Currently selected value.
  final T? groupValue;

  /// List of options.
  final List<RadioOption<T>> options;

  /// Called when selection changes.
  final ValueChanged<T?> onChanged;

  /// Optional group-level label.
  final Widget? groupLabel;

  final Widget? groupLeading;
  final Widget? groupTrailing;

  /// Optional validation error text shown below options.
  final String? errorText;

  /// Whether the group is interactive.
  final bool enabled;

  /// If true, tapping the tile toggles the radio.
  final bool tapToToggle;

  /// If true, places the radio at the leading edge.
  final bool radioIsLeading;

  /// Elevation of the group Card.
  final double elevation;

  /// Margin around the group Card.
  final EdgeInsetsGeometry margin;

  /// Padding inside the group Card.
  final EdgeInsetsGeometry padding;

  /// Border radius for the group Card.
  final BorderRadius? borderRadius;

  final bool dense;

  const ControlRadioGroup({
    super.key,
    required this.groupValue,
    required this.options,
    required this.onChanged,
    this.groupLabel,
    this.errorText,
    this.enabled = true,
    this.tapToToggle = true,
    this.radioIsLeading = false,
    this.groupLeading,
    this.groupTrailing,
    this.elevation = 2.0,
    this.margin = const EdgeInsets.all(8.0),
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
    this.borderRadius,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle = theme.textTheme.titleMedium!;

    return Semantics(
      container: true,
      label: groupLabel is Text ? (groupLabel as Text).data : null,
      child: Card(
        margin: margin,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (groupLabel != null) ...[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: dense ? 4.0 : 12.0,
                  ),
                  //padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (groupLeading != null) ...[
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: groupLeading!,
                        ),
                      ],
                      Expanded(
                        child: DefaultTextStyle(
                          style: labelStyle,
                          child: groupLabel!,
                        ),
                      ),
                      if (groupTrailing != null) ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: groupTrailing!,
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: margin.vertical / 2),
                const Divider(height: 1),
                SizedBox(height: margin.vertical / 2),
              ],
              ...options.map(
                (option) => ControlRadioTile<T>(
                  key: ValueKey(option.value),
                  title: Text(option.label),
                  subtitle: option.subtitle,
                  leading: option.leading,
                  value: option.value,
                  groupValue: groupValue,
                  onChanged: enabled ? onChanged : (_) {},
                  tapToToggle: tapToToggle,
                  radioIsLeading: radioIsLeading,
                  enabled: enabled,
                  dense: dense,
                  elevation: 0,
                  margin: dense ? EdgeInsets.zero : null,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: dense ? 4.0 : 8.0,
                  ),
                ),
              ),
              if (errorText != null) ...[
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    errorText!,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
