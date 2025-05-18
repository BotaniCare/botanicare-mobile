import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'control_tile.dart';

class ControlNavigator extends StatelessWidget {
  /// The title widget (required).
  final Widget title;

  /// Optional subtitle widget.
  final Widget? subtitle;

  /// Optional leading icon/avatar.
  final Widget? leading;

  /// Enabled state; when false, content and tile are disabled.
  final bool enabled;

  /// Additional padding for the tile.
  final EdgeInsetsGeometry? padding;

  /// Target URL
  final String? href;

  /// Target page
  final Widget? page;

  /// Creates a [ControlNavigator].
  const ControlNavigator(
    this.href, {
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.enabled = true,
    this.padding,
  }) : page = null;

  /// Creates a [ControlNavigator].
  const ControlNavigator.href(
    this.href, {
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.enabled = true,
    this.padding,
  }) : page = null;

  /// Creates a [ControlNavigator].
  const ControlNavigator.page(
    this.page, {
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.enabled = true,
    this.padding,
  }) : href = null;

  @override
  Widget build(BuildContext context) {
    Widget trailingWidget;
    VoidCallback? onTapHandler;

    if (href != null) {
      trailingWidget = Icon(Icons.open_in_new, size: 18.0, color: enabled ? null : Theme.of(context).disabledColor);
      onTapHandler = () async {
        if (href == null) return;
        final Uri uri = Uri.parse(href!);
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          debugPrint('Could not launch $uri');
        }
      };
    } else {
      trailingWidget = Icon(Icons.arrow_forward_ios, size: 18.0, color: enabled ? null : Theme.of(context).disabledColor);
      onTapHandler = () {
        if (page == null) return;
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => page!));
      };
    }

    return ControlTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      dense: subtitle == null,
      trailing: IgnorePointer(child: trailingWidget),
      onTap: onTapHandler,
      enabled: enabled,
      padding: padding,
    );
  }
}
