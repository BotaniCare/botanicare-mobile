import 'package:flutter/material.dart';

class SettingList extends StatelessWidget {
  const SettingList(this.items, {
    super.key,
    this.scrollable = false,
    this.scrollDirection = Axis.vertical,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    this.title,
});

  final List<Widget> items;
  final bool scrollable;
  final Axis scrollDirection;
  final EdgeInsetsGeometry padding;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    /*if (title != null) {
      return Column(
      children: [
        title!,
        ListView.separated(
          scrollDirection: scrollDirection,
          padding: padding,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return items[index];
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8.0);
          },
        )
      ],
    );
    }
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
    );*/
    final List<Widget> children = [];

    if (title != null) {
      children.add(
        Padding(
          padding: padding,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            child: title!,
          ),
        ),
      );
    }

    for (int i = 0; i < items.length; i++) {
      children.add(items[i]);
      if (i != items.length - 1) {
        children.add(const SizedBox(height: 8));
      }
    }

    if (scrollable) {
      return ListView(
        scrollDirection: scrollDirection,
        padding: padding,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: children,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    }
  }
}