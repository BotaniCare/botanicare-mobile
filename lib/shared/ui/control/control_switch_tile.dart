import 'package:flutter/material.dart';
import 'control_tile.dart';

/// A [ControlTile] variant that displays a trailing [Switch].
///
/// This tile is entirely controlled by external state:
/// - [value] determines the switch position.
/// - [onChanged] is called when the switch or the tile (if [tapToToggle] is true) is tapped.
class ControlSwitchTile extends StatelessWidget {
  /// The title widget (required).
  final Widget title;

  /// Optional subtitle widget.
  final Widget? subtitle;

  /// Optional leading icon/avatar.
  final Widget? leading;

  /// Whether the switch is on or off.
  final bool value;

  /// Called when the switch state changes.
  final ValueChanged<bool> onChanged;

  /// If true, tapping the entire tile toggles the switch.
  final bool tapToToggle;

  /// Switch `activeColor` for customization.
  final Color? activeColor;

  /// Enabled state; when false, switch and tile are disabled.
  final bool enabled;

  /// Additional padding for the tile.
  final EdgeInsetsGeometry? padding;

  /// Creates a [ControlSwitchTile].
  ///
  /// [title], [value], and [onChanged] must not be null.
  const ControlSwitchTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    required this.value,
    required this.onChanged,
    this.tapToToggle = false,
    this.activeColor,
    this.enabled = true,
    this.padding,
  });

  void _handleTap() {
    if (!enabled) return;
    onChanged(!value);
  }

  @override
  Widget build(BuildContext context) {
    var trailing =
        tapToToggle
            ? IgnorePointer(
              child: Switch(
                value: value,
                onChanged: enabled ? (_) => () : null,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            )
            : Switch(
              value: value,
              onChanged:
                  enabled
                      ? (_) {
                        _handleTap();
                      }
                      : null,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );

    return ControlTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      dense: subtitle == null,
      trailing: trailing,
      onTap: tapToToggle ? _handleTap : null,
      enabled: enabled,
      padding: padding,
    );
  }
}
