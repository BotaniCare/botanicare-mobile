import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Define different types of actions a setting item can perform.
enum SettingActionType {
  navigate,
  url,
  switchToggle,
}

// A sealed class (or similar structure like a discriminated union)
// would be ideal here, but we'll use a basic class for demonstration.
class SettingAction {
  final SettingActionType? type;
  final Widget? pageWidget;
  final String? url;
  final ValueChanged<bool>? onSwitchToggle; // For switchToggle type
  final bool? defaultValue; // For switchToggle type

  const SettingAction.navigate(this.pageWidget) :
        type = SettingActionType.navigate,
        url = null,
        onSwitchToggle = null,
        defaultValue = null;

  const SettingAction.url(this.url) :
        type = SettingActionType.url,
        pageWidget = null,
        onSwitchToggle = null,
        defaultValue = null;

  const SettingAction.switchToggle(this.onSwitchToggle, {this.defaultValue}) :
        type = SettingActionType.switchToggle,
        url = null,
        pageWidget = null;
}

class SettingItem extends StatefulWidget {
  const SettingItem({
    Key? key,
    this.icon,
    required this.title,
    this.subtitle,
    this.action,
  }) : super(key: key);

  final IconData? icon;
  final String title;
  final String? subtitle;
  final SettingAction? action;

  @override
  _SettingItemState createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  late bool _switchValue;

  @override
  void initState() {
    super.initState();
    if (widget.action?.type == SettingActionType.switchToggle) {
      _switchValue = widget.action?.defaultValue ?? false;
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $uri');
      // Optionally show a message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget trailingWidget;
    VoidCallback? onTapHandler;

    switch (widget.action?.type) {
      case SettingActionType.navigate:
        trailingWidget = const Icon(Icons.arrow_forward_ios, size: 18.0);
        onTapHandler = () {
          if (widget.action?.pageWidget != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                // Directly use the provided pageWidget in the builder
                builder: (_) => widget.action!.pageWidget!,
              ),
            );
          }
        };
        break;
      case SettingActionType.url:
        trailingWidget = const Icon(Icons.open_in_new, size: 18.0);
        onTapHandler = () {
          var url = widget.action?.url;
          print(url);
          if (url != null) {
            _launchUrl(url);
          }
        };
        break;
      case SettingActionType.switchToggle:
        trailingWidget = IgnorePointer(
          child: Switch(
            value: _switchValue,
            onChanged: (bool newValue) {},
          ),
        );
        onTapHandler = () {
          if (widget.action?.onSwitchToggle != null) {
            final newValue = !_switchValue;
            setState(() {
              _switchValue = newValue;
            });
            widget.action!.onSwitchToggle!(newValue);
          } else {
            setState(() {
              _switchValue = !_switchValue;
            });
          }
        };
        break;
      default:
        trailingWidget = const SizedBox.shrink();
        onTapHandler = null;
        break;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 1.0,
      child: InkWell(
        onTap: onTapHandler,
        borderRadius: BorderRadius.circular(4.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: widget.subtitle != null ? 12.0 : 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 24.0),
                const SizedBox(width: 16.0),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (widget.subtitle != null) ...[
                      const SizedBox(height: 4.0),
                      Text(
                        widget.subtitle!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              trailingWidget,
            ],
          ),
        ),
      ),
    );
  }
}