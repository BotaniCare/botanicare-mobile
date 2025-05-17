import 'package:flutter/material.dart';
import 'control_tile.dart';

/// A container widget that groups multiple [ControlTile]s under an optional
/// header and footer. It applies Material Design spacing, dividers, and styling
/// to visually separate logical sections.
///
/// Usage:
/// ```dart
/// ControlGroup(
///   header: Text('General Settings', style: Theme.of(context).textTheme.caption),
///   children: [
///     ControlTile(...),
///     ControlTile(...),
///   ],
///   footer: Text('End of section'),
/// );
/// ```
class ControlGroup extends StatelessWidget {
  /// Optional widget displayed above the group of tiles.
  final Widget? header;

  /// List of [ControlTile] or other widgets to display in this group.
  final List<Widget> children;

  /// Optional widget displayed below the group of tiles.
  final Widget? footer;

  /// Divider between tiles. Defaults to a 1px divider using theme.dividerColor.
  final Widget divider;

  /// Padding around the group content.
  final EdgeInsetsGeometry padding;

  /// Creates a [ControlGroup].
  const ControlGroup({
    super.key,
    this.header,
    required this.children,
    this.footer,
    this.divider = const Divider(height: 1),
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    if (header != null) {
      children.insert(
        0,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.w500,
            ),
            child: header!,
          ),
        ),
      );
    }

    if (footer != null) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: DefaultTextStyle(
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: Theme.of(context).hintColor),
            child: footer!,
          ),
        ),
      );
    }

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
