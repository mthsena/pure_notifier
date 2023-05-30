import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.title,
    required this.child,
    required this.theme,
  });

  final String title;
  final Widget child;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: theme,
      home: child,
    );
  }
}
