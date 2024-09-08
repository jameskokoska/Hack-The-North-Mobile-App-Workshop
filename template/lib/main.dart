import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/framework/navigation_framework.dart';
import 'package:template/framework/route_framework.dart';
import 'package:template/pages/routes/tabs.dart';
import 'package:template/controllers/todo_controller.dart';

late TodoController todoController;
late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  // Initialize controllers here
  todoController = TodoController();

  // TODO Get an API key here:
  // https://aistudio.google.com/app/apikey
  const String gemeiniKey = "";
  Gemini.init(apiKey: gemeiniKey);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo Application",
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF246295)),
        useMaterial3: true,
      ),
      home: NavigationFramework(
        navigationTabs: tabs,
      ),
    );
  }
}
