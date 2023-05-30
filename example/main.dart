import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/counter.dart';
import 'src/home.dart';

void main() {
  const title = 'Pure Notifier Counter';
  final theme = ThemeData(useMaterial3: true);
  final counter = Counter();
  final home = Home(counter, title: title);
  final app = App(title: title, theme: theme, child: home);
  runApp(app);
}
