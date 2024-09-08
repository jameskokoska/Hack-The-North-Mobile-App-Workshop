import 'package:flutter/material.dart';

Future<T?> openBottomSheet<T>(
    BuildContext context, PopupFramework popupFramework) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => popupFramework,
  );
}

class PopupFramework extends StatelessWidget {
  const PopupFramework(
      {required this.title, required this.children, super.key});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ...children,
          // Add space for soft keyboard
          SizedBox(height: MediaQuery.viewInsetsOf(context).bottom)
        ],
      ),
    );
  }
}
