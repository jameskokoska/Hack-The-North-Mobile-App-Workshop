import 'package:flutter/material.dart';

class NavigationTab {
  const NavigationTab({
    required this.icon,
    required this.name,
    required this.page,
  });

  final IconData icon;
  final String name;
  final Widget page;
}
