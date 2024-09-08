import 'package:flutter/material.dart';
import 'package:template/pages/routes/routes.dart';

Route<dynamic> routeFramework(
    {required Widget child, required RouteSettings? settings}) {
  return PageRouteBuilder(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 150),
    reverseTransitionDuration: const Duration(milliseconds: 150),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(begin: const Offset(0, 0.06), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeOut));
      return SlideTransition(
        position: animation.drive(tween),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return child;
    },
  );
}

Route<dynamic>? onGenerateRoute(RouteSettings? settings) {
  if (settings?.name == null) {
    return routeFramework(child: const Placeholder(), settings: settings);
  }

  return routeFramework(
      child: routes[settings?.name] ?? const Placeholder(), settings: settings);
}

Future<dynamic> pushRoute(BuildContext context, String name) async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (routes.containsKey(name)) {
    return await Navigator.pushNamed(context, name);
  } else {
    return null;
  }
}
