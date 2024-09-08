import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/framework/tab_navigation_framework.dart';
import 'package:template/pages/routes/tabs.dart';
import 'package:template/widgets/tab_navigation.dart';

class NavigationFramework extends StatefulWidget {
  const NavigationFramework({required this.navigationTabs, super.key});
  final List<NavigationTab> navigationTabs;

  @override
  State<NavigationFramework> createState() => _NavigationFrameworkState();
}

class _NavigationFrameworkState extends State<NavigationFramework> {
  int currentTabNavigationIndex = 0;

  changeTabNavigationIndex(int index) {
    setState(() {
      currentTabNavigationIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor:
            Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Scaffold(
        body: TabNavigationFramework(
          index: currentTabNavigationIndex,
          children: widget.navigationTabs
              .map((navigationTab) => navigationTab.page)
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTabNavigationIndex,
          onTap: changeTabNavigationIndex,
          items: [
            for (NavigationTab tab in tabs)
              BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.name,
                tooltip: tab.name,
              )
          ],
        ),
      ),
    );
  }
}
