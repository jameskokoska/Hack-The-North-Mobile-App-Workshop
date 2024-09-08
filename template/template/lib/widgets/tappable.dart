import 'package:flutter/material.dart';

class Tappable extends StatelessWidget {
  const Tappable({
    super.key,
    required this.child,
    this.onPress,
    this.onLongPress,
    this.borderRadius,
    this.color,
    this.disable = false,
  });

  final Widget child;
  final VoidCallback? onPress;
  final VoidCallback? onLongPress;
  final BorderRadius? borderRadius;
  final Color? color;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    if (disable) return child;

    return Material(
      color: color ?? Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
        borderRadius: borderRadius,
        onTap: onPress,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
