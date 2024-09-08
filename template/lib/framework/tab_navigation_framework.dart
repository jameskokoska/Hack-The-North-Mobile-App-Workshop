import 'package:flutter/material.dart';

class TabNavigationFramework extends StatelessWidget {
  const TabNavigationFramework({
    super.key,
    this.index = 0,
    this.children = const [],
  });

  final int index;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: children,
    );
  }
}
