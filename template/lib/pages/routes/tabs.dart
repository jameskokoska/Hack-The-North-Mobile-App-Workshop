import 'package:flutter/material.dart';
import 'package:template/pages/home_page.dart';
import 'package:template/pages/task_page.dart';
import 'package:template/widgets/tab_navigation.dart';

List<NavigationTab> tabs = [
  const NavigationTab(
    icon: Icons.home,
    name: "Home",
    page: HomePage(),
  ),
  const NavigationTab(
    icon: Icons.check,
    name: "Tasks",
    page: TaskPage(),
  ),
];
