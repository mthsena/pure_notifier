import 'package:flutter/material.dart';

import 'pure_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String title;

  const MyApp({
    super.key,
    this.title = 'Pure Notifier Counter',
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: CounterPage(
        title: title,
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  final String title;

  const CounterPage({
    super.key,
    required this.title,
  });

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  late Counter counter;

  @override
  void initState() {
    super.initState();
    counter = Counter(0, context);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 32,
              height: 32,
              child: PureBuilder(
                notifier: counter,
                builder: (context, child) {
                  if (counter.isLoading) return const CircularProgressIndicator();
                  return Text(
                    '${counter.value}',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PureBuilder(
                  notifier: counter,
                  builder: (context, child) => IconButton.filledTonal(
                    onPressed: counter.isLoading ? null : counter.decrementSync,
                    icon: const Text('-'),
                  ),
                ),
                Text(
                  'Sync',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                PureBuilder(
                  notifier: counter,
                  builder: (context, child) => IconButton.filledTonal(
                    onPressed: counter.isLoading ? null : counter.incrementSync,
                    icon: const Text('+'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PureBuilder(
                  notifier: counter,
                  builder: (context, child) => IconButton.filledTonal(
                    onPressed: counter.isLoading ? null : counter.decrementAsync,
                    icon: const Text('-'),
                  ),
                ),
                Text(
                  'Async',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                PureBuilder(
                  notifier: counter,
                  builder: (context, child) => IconButton.filledTonal(
                    onPressed: counter.isLoading ? null : counter.incrementAsync,
                    icon: const Text('+'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final class Counter extends PureNotifier<int> {
  final BuildContext context;

  Counter(
    super.initialValue,
    this.context,
  ) {
    addListener(() {
      if (isFailure) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.toString()),
          ),
        );
      }
    });
  }

  void incrementSync() {
    updateSync(value + 1);
  }

  void decrementSync() {
    updateSync(value - 1);
  }

  void incrementAsync() {
    updateAsync(_getIncrement);
  }

  void decrementAsync() {
    updateAsync(_getDecrement);
  }

  Future<int> _getIncrement() async {
    await Future.delayed(const Duration(seconds: 3));
    if (value >= 2) throw Exception('2 max reached.');
    return value + 1;
  }

  Future<int> _getDecrement() async {
    await Future.delayed(const Duration(seconds: 3));
    if (value <= 0) throw Exception('0 min reached.');
    return value - 1;
  }
}
