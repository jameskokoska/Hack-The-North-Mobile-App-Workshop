import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/controllers/todo_controller.dart';

class InitializeControllers extends StatelessWidget {
  const InitializeControllers({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add other controllers here if needed...
        ChangeNotifierProvider<TodoController>(create: (_) => TodoController()),
      ],
      child: child,
    );
  }
}
