import 'package:flutter/material.dart';
import 'package:template/framework/route_framework.dart';
import 'package:template/widgets/tappable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? analysis;
  @override
  void initState() {
    //Run this immediately after the UI is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateAnalysis();
    });

    super.initState();
  }

  updateAnalysis() async {
    // TODO display the analysis in the UI from Gemini
    // Finish implementing todoController.analyzeTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          "Home",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Tappable(
              borderRadius: BorderRadius.circular(20),
              onPress: () => updateAnalysis(),
              child: const Text(
                "✨",
                style: TextStyle(fontSize: 60),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutCubicEmphasized,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: analysis == null
                      ? const CircularProgressIndicator()
                      : Tappable(
                          borderRadius: BorderRadius.circular(20),
                          onPress: () => pushRoute(context, "/tasks"),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              analysis ?? "",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
