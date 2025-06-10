import 'package:flutter/material.dart';

import 'home.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pure Notifier Counter',
      home: Home(
        title: 'Pure Notifier Counter',
      ),
    );
  }
}
