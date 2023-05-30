import 'package:flutter/material.dart';
import 'package:pure_notifier/pure_builder.dart';

import 'counter.dart';

class Home extends StatefulWidget {
  const Home(
    this.counter, {
    super.key,
    required this.title,
  });

  final Counter counter;
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    widget.counter.addListener(() {
      if (widget.counter.state.status.isFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.counter.state.message),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    widget.counter.dispose();
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
            const Text('You have pushed the button this many times:'),
            const SizedBox(height: 15),
            PureBuilder(
              notifier: widget.counter,
              builder: (_, __) => Text('${widget.counter.state.value}'),
            ),
            const SizedBox(height: 15),
            PureBuilder(
              notifier: widget.counter,
              builder: (_, __) {
                if (widget.counter.state.status.isLoading) {
                  return const SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: widget.counter.increment,
                  child: const Text('Increment'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
