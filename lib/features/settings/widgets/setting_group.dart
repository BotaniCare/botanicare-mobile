import 'package:flutter/cupertino.dart';

class SettingGroup extends StatelessWidget {
  const SettingGroup({
    super.key,
    required this.items,
    this.scrollDirection = Axis.vertical,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
});

  final List<Widget> items;
  final Axis scrollDirection;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: scrollDirection,
      padding: padding,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return items[index];
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8.0);
      },
    );
  }
}