import 'package:flutter/material.dart';
import 'control_tile.dart';

/// A [ControlTile] variant that displays a trailing [Radio].
///
/// This tile is entirely controlled by external state:
/// - [value] determines the radio state.
/// - [onChanged] is called when the switch or the tile (if [tapToToggle] is true) is tapped.
class ControlRadioTile<T> extends StatelessWidget {
  /// The title widget (required).
  final Widget title;

  /// Optional subtitle widget.
  final Widget? subtitle;

  /// Optional leading icon/avatar.
  final Widget? leading;

  /// Value represented by this radio option.
  final T value;

  /// Called when the user selects this option (value passed).
  final ValueChanged<T?> onChanged;

  /// Currently selected value in the group.
  final T? groupValue;

  /// If true, tapping the entire tile toggles the switch.
  final bool tapToToggle;

  /// Enabled state; when false, switch and tile are disabled.
  final bool enabled;

  final bool radioIsLeading;

  /// Additional padding for the tile.
  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? margin;

  final double? elevation;

  final bool dense;

  /// Creates a [ControlRadioTile].
  ///
  /// [title], [value], and [onChanged] must not be null.
  const ControlRadioTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.tapToToggle = false,
    this.enabled = true,
    this.radioIsLeading = false,
    this.padding,
    this.margin,
    this.elevation,
    this.dense = false,
  });

  void _handleTap() {
    if (!enabled) return;
    if (value != groupValue) {
      onChanged(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final widget =
        tapToToggle
            ? IgnorePointer(
              child: Radio<T>(
                value: value,
                groupValue: groupValue,
                onChanged: enabled ? (_) => () : null,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            )
            : Radio<T>(
              value: value,
              groupValue: groupValue,
              onChanged:
                  enabled
                      ? (_) {
                        _handleTap();
                      }
                      : null,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
    final leadingWidget =
        radioIsLeading
            ? Row(
              spacing: 16.0,
              children: leading != null ? [widget, leading!] : [widget],
            )
            : leading;
    final trailingWidget = !radioIsLeading ? widget : null;

    return ControlTile(
      leading: leadingWidget,
      title: title,
      subtitle: subtitle,
      dense: dense || subtitle == null,
      trailing: trailingWidget,
      onTap: tapToToggle ? _handleTap : null,
      enabled: enabled,
      margin: margin,
      padding: padding,
      elevation: elevation,
    );
  }
}
