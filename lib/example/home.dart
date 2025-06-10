import 'package:flutter/material.dart';

import '../pure_notifier.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final counter = PureNotifier(0);

  void increment() {
    counter.execute(() async {
      await Future.delayed(Durations.extralong4);
      if (counter.state.value >= 2) throw const PureFailure('Max reached.');
      return counter.state.value + 1;
    });
  }

  void decrement() {
    counter.execute(() async {
      await Future.delayed(Durations.extralong4);
      if (counter.state.value <= 0) throw const PureFailure('Min reached.');
      return counter.state.value - 1;
    });
  }

  @override
  void initState() {
    super.initState();
    counter.addListener(() {
      if (counter.state.status.isFailure) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(counter.state.message),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListenableBuilder(
          listenable: counter,
          builder: (context, child) {
            final widget = switch (counter.state.status) {
              PureStatus.loading => const CircularProgressIndicator(),
              _ => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('You have pushed the button this many times:'),
                    const SizedBox(height: 15),
                    Text(
                      '${counter.state.value}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filledTonal(
                          onPressed: decrement,
                          icon: const Text('-'),
                        ),
                        const SizedBox(width: 24),
                        IconButton.filledTonal(
                          onPressed: increment,
                          icon: const Text('+'),
                        ),
                      ],
                    ),
                  ],
                ),
            };
            return widget;
          },
        ),
      ),
    );
  }
}
