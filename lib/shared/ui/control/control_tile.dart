import 'package:flutter/material.dart';

/// A highly configurable, tappable row widget with optional leading, title,
/// subtitle, and trailing widgets. Serves as the base for other Control*Tile widgets.
///
/// Follows Material Design and Flutter best practices:
/// - Null-safety, const constructor
/// - Uses theming via Theme.of(context)
/// - Accessible semantics
/// - Exposes padding, density, and enabled state
class ControlTile extends StatelessWidget {
  /// Leading widget, typically an Icon or CircleAvatar.
  final Widget? leading;

  /// Primary content of the tile, usually a Text widget.
  final Widget title;

  /// Secondary content displayed below the title.
  final Widget? subtitle;

  /// Trailing widget, e.g., Switch, Radio, or custom indicator.
  final Widget? trailing;

  /// Called when the tile is tapped. If null, the tile is disabled.
  final VoidCallback? onTap;

  /// Whether the tile is interactive. When false, taps are ignored and colors dimmed.
  final bool enabled;

  /// Reduces the vertical height of the tile when true.
  final bool dense;

  /// Padding for the tile's content. Defaults to Material ListTile values.
  final EdgeInsetsGeometry? padding;

  /// Background color of the tile.
  final Color? tileColor;

  final BorderRadius? borderRadius;

  final double? elevation;

  final EdgeInsetsGeometry? margin;

  /// Creates a ControlTile.
  ///
  /// [title] must not be null.
  const ControlTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.enabled = true,
    this.dense = false,
    this.padding,
    this.tileColor,
    this.borderRadius,
    this.elevation = 1.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      margin: margin,
      elevation: elevation,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: borderRadius ?? BorderRadius.circular(4.0),
        child: Padding(
          padding:
              padding ??
              EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: dense ? 12.0 : 16.0,
              ),
          child: Row(
            // crossAxisAlignment: dense ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leading != null) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: leading!,
                ),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: dense ? MainAxisAlignment.center : MainAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultTextStyle(
                      style:
                          enabled
                              ? theme.textTheme.titleMedium!
                              : theme.textTheme.titleMedium!.copyWith(
                                color: theme.disabledColor,
                              ),
                      child: title,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4.0),
                      DefaultTextStyle(
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color:
                              enabled ? theme.hintColor : theme.disabledColor,
                        ),
                        child: subtitle!,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: trailing!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
