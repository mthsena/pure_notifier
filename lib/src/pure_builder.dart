import 'package:flutter/material.dart';

import '../pure_notifier.dart';

class PureBuilder<T> extends StatefulWidget {
  const PureBuilder({
    super.key,
    required this.notifier,
    required this.builder,
    this.child,
  });

  final PureNotifier<T> notifier;
  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;

  @override
  State<PureBuilder<T>> createState() => _PureBuilderState<T>();
}

class _PureBuilderState<T> extends State<PureBuilder<T>> {
  late PureNotifier<T> notifier;
  late Widget Function(BuildContext context, Widget? child) builder;
  late Widget? child;

  void initialize() {
    notifier = widget.notifier;
    builder = widget.builder;
    child = widget.child;
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void didUpdateWidget(covariant PureBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: builder,
      child: child,
    );
  }
}
